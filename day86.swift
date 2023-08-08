Project 26, part two

Back when the original iPad launched Apple showed off one of those “Jony Ive in an infinitely white room” videos, where 
Jony had this to say: “it’s true: when something exceeds your ability to understand how it works, it sort of becomes 
\magical – and that’s exactly what the iPad is.”

When our apps run, they usually take up the full amount of screen space – they literally take over the iPad, as if the 
user were holding a device specifically crafted for our app and nothing else. If iOS forced us to display system elements 
around our app, or if iPads had lots of buttons scattered around the front of its display, that illusion would be broken.

Today you’re going to see just how important this is: we’ll use Core Motion to let the user tip their iPad to control 
the game. And because our code takes over the full iPad screen, the end result just feels amazing – one huge piece of 
glass that the player can bounce around as if it were an old wooden toy.

Today you have two topics to work through, and you’ll learn about reading the accelerometer using Core Motion and 
combining bitmasks using |, while also getting more practice with SKAction sequences, and more.



---------- Tilt to move: CMMotionManager

We're going to control this game using the accelerometer that comes as standard on all iPads, but it has a problem: 
it doesn't come as standard on any Macs, which means we either resign ourselves to testing only on devices or we put 
in a little hack. This course isn't calling Giving Up with Swift, so we're going to add a hack – in the simulator you'll 
be able to use touch, and on devices you'll have to use tilting.

To get started, add this property so we can reference the player throughout the game:

var player: SKSpriteNode!
We're going to add a dedicated createPlayer() method that loads the sprite, gives it circle physics, and adds it to the 
scene, but it's going to do three other things that are important.

First, it's going to set the physics body's allowsRotation property to be false. We haven't changed that so far, but it 
does what you might expect – when false, the body no longer rotates. This is useful here because the ball looks like a 
marble: it's shiny, and those reflections wouldn't rotate in real life.

Second, we're going to give the ball a linearDamping value of 0.5, which applies a lot of friction to its movement. 
The game will still be hard, but this does help a little by slowing the ball down naturally.

Finally, we'll be combining three values together to get the ball's contactTestBitMask: the star, the vortex and the finish.

Here's the code for createPlayer():

func createPlayer() {
    player = SKSpriteNode(imageNamed: "player")
    player.position = CGPoint(x: 96, y: 672)
    player.zPosition = 1
    player.physicsBody = SKPhysicsBody(circleOfRadius: player.size.width / 2)
    player.physicsBody?.allowsRotation = false
    player.physicsBody?.linearDamping = 0.5

    player.physicsBody?.categoryBitMask = CollisionTypes.player.rawValue
    player.physicsBody?.contactTestBitMask = CollisionTypes.star.rawValue | CollisionTypes.vortex.rawValue | CollisionTypes.finish.rawValue
    player.physicsBody?.collisionBitMask = CollisionTypes.wall.rawValue
    addChild(player)
}

You can go ahead and add a call to createPlayer() directly after the call to loadLevel() inside didMove(to:). 
Note: you must create the player after the level, otherwise it will appear below vortexes and other level objects.

If you try running the game now, you'll see the ball drop straight down until it hits a wall, then it bounces briefly 
and stops. This game has players looking down on their iPad, so by default there ought to be no movement – it's only 
if the player tilts their iPad down that the ball should move downwards.

The ball is moving because the scene's physics world has a default gravity roughly equivalent to Earth's.
We don't want that, so in didMove(to:) add this somewhere:

physicsWorld.gravity = .zero

Playing the game now hasn't really solved much: sure, the ball isn't moving now, but… the ball isn't moving now! 
This would make for a pretty terrible game on the App Store.

Before we get onto how to work with the accelerometer, we're going to put together a hack that lets you simulate the 
experience of moving the ball using touch. What we're going to do is catch touchesBegan(), touchesMoved(), and 
touchesEnded(), and use them to set or unset a new property called lastTouchPosition. Then in the update() method 
we'll subtract that touch position from the player's position, and use it set the world's gravity.

It's a hack. And if you're happy to test on a device, you don't really need it. But if you're stuck with the iOS 
Simulator or are just curious, let's put in the hack. First, declare the new property:

var lastTouchPosition: CGPoint?

Now use touchesBegan() and touchesMoved() to set the value of that property using the same three lines of code, like this:

override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    guard let touch = touches.first else { return }
    let location = touch.location(in: self)
    lastTouchPosition = location
}

override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
    guard let touch = touches.first else { return }
    let location = touch.location(in: self)
    lastTouchPosition = location
}

When touchesEnded() is called, we need to set the property to be nil – it is optional, after all:

override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
    lastTouchPosition = nil
}

Easy, I know, but it gets (only a little!) trickier in the update() method. This needs to unwrap our optional property, 
calculate the difference between the current touch and the player's position, then use that to change the gravity value 
of the physics world. Here it is:

override func update(_ currentTime: TimeInterval) {
    if let currentTouch = lastTouchPosition {
        let diff = CGPoint(x: currentTouch.x - player.position.x, y: currentTouch.y - player.position.y)
        physicsWorld.gravity = CGVector(dx: diff.x / 100, dy: diff.y / 100)
    }
}

This is clearly not a permanent solution, but it's good enough that you can run the app now and test it out.

Now for the new bit: working with the accelerometer. This is easy to do, which is remarkable when you think how much is 
happening behind the scenes.

All motion detection is done with an Apple framework called Core Motion, and most of the work is done by a class called 
CMMotionManager. Using it here won't require any special user permissions, so all we need to do is create an instance of 
the class and ask it to start collecting information. We can then read from that information whenever and wherever we 
need to, and in this project the best place is update().

Add import CoreMotion just above the import SpriteKit line at the top of your game scene, then add this property:

var motionManager: CMMotionManager!

Now it's just a matter of creating the object and asking it start collecting accelerometer data. This is done using the 
startAccelerometerUpdates() method, which instructs Core Motion to start collecting accelerometer information we can read 
later. Put this this into didMove(to:):

motionManager = CMMotionManager()
motionManager.startAccelerometerUpdates()

The last thing to do is to poll the motion manager inside our update() method, checking to see what the current tilt 
data is. But there's a complication: we already have a hack in there that lets us test in the simulator, so we want one 
set of code for the simulator and one set of code for devices.

Swift solves this problem by adding special compiler instructions. If the instruction evaluates to true it will compile 
one set of code, otherwise it will compile the other. This is particularly helpful once you realize that any code wrapped 
in compiler instructions that evaluate to false never get seen – it's like they never existed. So, this is a great way 
to include debug information or activity in the simulator that never sees the light on devices.

The compiler directives we care about are: #if targetEnvironment(simulator), #else and #endif. 
As you can see, this is mostly the same as a standard Swift if/else block, although here you don't need braces because 
everything until the #else or #endif will execute.

The code to read from the accelerometer and apply its tilt data to the world gravity look like this:

if let accelerometerData = motionManager.accelerometerData {
    physicsWorld.gravity = CGVector(dx: accelerometerData.acceleration.y * -50, dy: accelerometerData.acceleration.x * 50)
}

The first line safely unwraps the optional accelerometer data, because there might not be any available. The second line 
changes the gravity of our game world so that it reflects the accelerometer data. You're welcome to adjust the speed 
multipliers as you please; I found a value of 50 worked well.

Note that I passed accelerometer Y to CGVector's X and accelerometer X to CGVector's Y. This is not a typo! 
Remember, your device is rotated to landscape right now, which means you also need to flip your coordinates around.

We need to put that code inside the current update() method, wrapped inside the new compiler directives. 
Here's how the method should look now:

override func update(_ currentTime: TimeInterval) {
#if targetEnvironment(simulator)
    if let currentTouch = lastTouchPosition {
        let diff = CGPoint(x: currentTouch.x - player.position.x, y: currentTouch.y - player.position.y)
        physicsWorld.gravity = CGVector(dx: diff.x / 100, dy: diff.y / 100)
    }
#else
    if let accelerometerData = motionManager.accelerometerData {
        physicsWorld.gravity = CGVector(dx: accelerometerData.acceleration.y * -50, dy: accelerometerData.acceleration.x * 50)
    }
#endif
}

If you can test on a device, please do. It took only a few lines of code, but the game is now adapting beautifully to 
device tilting!



---------- Contacting but not colliding

All the game is missing now is some challenge, and that's where our star and vortex level elements come in. 
Players will get one point for every star they collect, and lose one point every time they fall into a vortex. 
To track scores, we need a property to hold the score and a label to show it, so add these now:

var scoreLabel: SKLabelNode!

var score = 0 {
    didSet {
        scoreLabel.text = "Score: \(score)"
    }
}

We're going to show the label in the top-left corner of the screen, so add this to didMove(to:):

scoreLabel = SKLabelNode(fontNamed: "Chalkduster")
scoreLabel.text = "Score: 0"
scoreLabel.horizontalAlignmentMode = .left
scoreLabel.position = CGPoint(x: 16, y: 16)
scoreLabel.zPosition = 2
addChild(scoreLabel)

When a collision happens, we need to figure out whether it was the player colliding with a star, or the star colliding 
with a player – the same semi-philosophical problem we had in project 11. And our solution is identical too: figure out 
which is which, then call another method.

First, we need to make ourselves the contact delegate for the physics world, so make your class conform to 
SKPhysicsContactDelegate then add this line in didMove(to:):

physicsWorld.contactDelegate = self

We already know which node is our player, which means we know which node isn't our player. This means our didBegin() 
method is easy:

func didBegin(_ contact: SKPhysicsContact) {
    guard let nodeA = contact.bodyA.node else { return }
    guard let nodeB = contact.bodyB.node else { return }

    if nodeA == player {
        playerCollided(with: nodeB)
    } else if nodeB == player {
        playerCollided(with: nodeA)
    }
}

There are three types of collision we care about: when the player hits a vortex they should be penalized, when the player 
hits a star they should score a point, and when the player hits the finish flag the next level should be loaded. 
I'll deal with the first two here, and you can think about the third one yourself!

When a player hits a vortex, a few things need to happen. Chief among them is that we need to stop the player controlling 
the ball, which will be done using a single boolean property called isGameOver. Add this property now:

var isGameOver = false

You'll need to modify your update() method so that it works only when isGameOver is false, like this:

override func update(_ currentTime: TimeInterval) {
    guard isGameOver == false else { return }

    #if targetEnvironment(simulator)
        if let currentTouch = lastTouchPosition {
            let diff = CGPoint(x: currentTouch.x - player.position.x, y: currentTouch.y - player.position.y)
            physicsWorld.gravity = CGVector(dx: diff.x / 100, dy: diff.y / 100)
        }
    #else
        if let accelerometerData = motionManager.accelerometerData {
            physicsWorld.gravity = CGVector(dx: accelerometerData.acceleration.y * -50, dy: accelerometerData.acceleration.x * 50)
        }
    #endif
}

Of course, a number of other things need to be done when a player collides with a vortex:

- We need to stop the ball from being a dynamic physics body so that it stops moving once it's sucked in.

- We need to move the ball over the vortex, to simulate it being sucked in. It will also be scaled down at the same time.

- Once the move and scale has completed, we need to remove the ball from the game.

- After all the actions complete, we need to create the player ball again and re-enable control.

We'll put that together using an SKAction sequence, followed by a trailing closure that will execute when the actions 
finish. When colliding with a star, we just remove the star node from the scene and add one to the score.

func playerCollided(with node: SKNode) {
    if node.name == "vortex" {
        player.physicsBody?.isDynamic = false
        isGameOver = true
        score -= 1

        let move = SKAction.move(to: node.position, duration: 0.25)
        let scale = SKAction.scale(to: 0.0001, duration: 0.25)
        let remove = SKAction.removeFromParent()
        let sequence = SKAction.sequence([move, scale, remove])

        player.run(sequence) { [weak self] in
            self?.createPlayer()
            self?.isGameOver = false
        }
    } else if node.name == "star" {
        node.removeFromParent()
        score += 1
    } else if node.name == "finish" {
        // next level?
    }
}

That method finishes the game, so it's down to you now to try and play the whole level without falling into a vortex. 
What happens when you hit the finish flag? Nothing… yet.