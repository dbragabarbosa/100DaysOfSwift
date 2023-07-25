Project 23, part two

This is a big project, right? Believe me, though: it is worth it – as Thomas Edison once said, “the most certain way to 
succeed is always to try just one more time.” So, even if you’re having a hard time I encourage you to stick with it – 
we’re finishing the project today, and I feel confident you’ll be impressed with the final game.

What I think you’ll find is that the code we’re looking it isn’t particularly hard, it’s just that there’s a lot of it. 
But this is important: it gives you the chance to flex your GCD muscles in a different project, with different purposes, 
which helps make that knowledge sink in a little more.

You’re also going to meet CaseIterable for the first time, which is a bit like Codable – it’s one of Swift’s built-in 
protocols that makes the compiler generate some code on our behalf. In this instance, though, it’s designed to let us 
read all the cases of an enum as an array, and it’s useful so that we can make random enemy types in our game.

Today you have three topics to work through, and you’ll learn about CaseIterable, plus you’ll get more practice with GCD, 
SKTexture, and more.



---------- Follow the sequence

You've come so far already, and really there isn't a lot to show for your work other than being able to draw glowing slice 
shapes when you move touches around the screen. But that's all about to change, because we're now about to create the 
interesting code – we're going to make the game actually create some enemies.

Now, you might very well be saying, “but Paul, we just wrote the enemy creating code, and I never want to see it again!” 
You're right (and I never want to see it again either!) but it's a bit more complicated: the createEnemy() method creates 
one enemy as required. The code we're going to write now will call createEnemy() in different ways so that we get varying 
groups of enemies.

For example, sometimes we want to create two enemies at once, sometimes we want to create four at once, and sometimes we 
want to create five in quick sequence. Each one of these will call createEnemy() in different ways.

There's a lot to cover here, so let's get started: add this new enum before the ForceBomb enum you added a few minutes ago:

enum SequenceType: CaseIterable {
    case oneNoBomb, one, twoWithOneBomb, two, three, four, chain, fastChain
}

That outlines the possible types of ways we can create enemy: one enemy that definitely is not a bomb, one that might or 
might not be a bomb, two where one is a bomb and one isn't, then two/three/four random enemies, a chain of enemies, then 
a fast chain of enemies.

The first two will be used exclusively when the player first starts the game, to give them a gentle warm up. After that, 
they'll be given random sequence types from twoWithOneBomb to fastChain.

You might have noticed I slipped in a new protocol there: CaseIterable. This is one of Swift’s most useful protocols, and 
it will automatically add an allCases property to the SequenceType enum that lists all its cases as an array. This is 
really useful in our project because we can then use randomElement() to pick random sequence types to run our game.

We're going to need quite a few new properties in order to make the plan work, so please add these now:

var popupTime = 0.9
var sequence = [SequenceType]()
var sequencePosition = 0
var chainDelay = 3.0
var nextSequenceQueued = true
And here's what they do:

The popupTime property is the amount of time to wait between the last enemy being destroyed and a new one being created.
The sequence property is an array of our SequenceType enum that defines what enemies to create.
The sequencePosition property is where we are right now in the game.
The chainDelay property is how long to wait before creating a new enemy when the sequence type is .chain or .fastChain. Enemy chains don't wait until the previous enemy is offscreen before creating a new one, so it's like throwing five enemies quickly but with a small delay between each one.
The nextSequenceQueued property is used so we know when all the enemies are destroyed and we're ready to create more.

Whenever we call our new method, which is tossEnemies(), we're going to decrease both popupTime and chainDelay so that the 
game gets harder as they play. Sneakily, we're always going to increase the speed of our physics world, so that objects 
move rise and fall faster too.

Nearly all the tossEnemies() method is a large switch/case statement that looks at the sequencePosition property to figure 
out what sequence type it should use. It then calls createEnemy() correctly for the sequence type, passing in whether to 
force bomb creation or not.

The one thing that will need to be explained is the way enemy chains are created. Unlike regular sequence types, a chain 
is made up of several enemies with a space between them, and the game doesn't wait for an enemy to be sliced before showing 
the next thing in the chain.

The best thing for you to do is to put this source code into your project, and we can talk about the chain complexities in 
a moment:

func tossEnemies() {
    popupTime *= 0.991
    chainDelay *= 0.99
    physicsWorld.speed *= 1.02

    let sequenceType = sequence[sequencePosition]

    switch sequenceType {
    case .oneNoBomb:
        createEnemy(forceBomb: .never)

    case .one:
        createEnemy()

    case .twoWithOneBomb:
        createEnemy(forceBomb: .never)
        createEnemy(forceBomb: .always)

    case .two:
        createEnemy()
        createEnemy()

    case .three:
        createEnemy()
        createEnemy()
        createEnemy()

    case .four:
        createEnemy()
        createEnemy()
        createEnemy()
        createEnemy()

    case .chain:
        createEnemy()

        DispatchQueue.main.asyncAfter(deadline: .now() + (chainDelay / 5.0)) { [weak self] in self?.createEnemy() }
        DispatchQueue.main.asyncAfter(deadline: .now() + (chainDelay / 5.0 * 2)) { [weak self] in self?.createEnemy() }
        DispatchQueue.main.asyncAfter(deadline: .now() + (chainDelay / 5.0 * 3)) { [weak self] in self?.createEnemy() }
        DispatchQueue.main.asyncAfter(deadline: .now() + (chainDelay / 5.0 * 4)) { [weak self] in self?.createEnemy() }

    case .fastChain:
        createEnemy()

        DispatchQueue.main.asyncAfter(deadline: .now() + (chainDelay / 10.0)) { [weak self] in self?.createEnemy() }
        DispatchQueue.main.asyncAfter(deadline: .now() + (chainDelay / 10.0 * 2)) { [weak self] in self?.createEnemy() }
        DispatchQueue.main.asyncAfter(deadline: .now() + (chainDelay / 10.0 * 3)) { [weak self] in self?.createEnemy() }
        DispatchQueue.main.asyncAfter(deadline: .now() + (chainDelay / 10.0 * 4)) { [weak self] in self?.createEnemy() }
    }

    sequencePosition += 1
    nextSequenceQueued = false
}

That looks like a massive method, I know, but in reality it's just the same thing being called in different ways. 
The interesting parts are the .chain and .fastChain cases, and also I want to explain in more detail the nextSequenceQueued 
property.

Each sequence in our array creates one or more enemies, then waits for them to be destroyed before continuing. Enemy chains 
are different: they create five enemies with a short break between, and don't wait for each one to be destroyed before 
continuing.

To handle these chains, we have calls to asyncAfter() with a timer value. If we assume for a moment that chainDelay is 10 
seconds, then:

That makes chainDelay / 10.0 equal to 1 second.
That makes chainDelay / 10.0 * 2 equal to 2 seconds.
That makes chainDelay / 10.0 * 3 equal to three seconds.
That makes chainDelay / 10.0 * 4 equal to four seconds.

So, it spreads out the createEnemy() calls quite neatly.

The nextSequenceQueued property is more complicated. If it's false, it means we don't have a call to tossEnemies() in the 
pipeline waiting to execute. It gets set to true only in the gap between the previous sequence item finishing and 
tossEnemies() being called. Think of it as meaning, "I know there aren't any enemies right now, but more will come shortly."

We can make our game come to life with enemies with two more pieces of code. First, add this just before the end of didMove(to:):

sequence = [.oneNoBomb, .oneNoBomb, .twoWithOneBomb, .twoWithOneBomb, .three, .one, .chain]

for _ in 0 ... 1000 {
    if let nextSequence = SequenceType.allCases.randomElement() {
        sequence.append(nextSequence)
    }
}

DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [weak self] in
    self?.tossEnemies()
}

That code fills the sequence array with seven pre-written sequences to help players warm up to how the game works, then 
adds 1001 (the ... operator means “up to and including”) random sequence types to fill up the game. Finally, it triggers 
the initial enemy toss after two seconds.

The way we generate random sequence type values is using the CaseIterable protocol I mentioned earlier. If you cast your 
mind back, this is how we defined the SequenceType enum:

enum SequenceType: CaseIterable {
    case oneNoBomb, one, twoWithOneBomb, two, three, four, chain, fastChain
}

Note that it says enum SequenceType: CaseIterable, and it means we’ll automatically get an allCases property generated for 
our enum that contains each case in the enum in the order it was defined. So, to generate lots of random sequence types we 
can use SequenceType.allCases.randomElement() again and again.

The second change we're going to make is to remove enemies from the game when they fall off the screen. This is required, 
because our game mechanic means that new enemies aren't created until the previous ones have been removed. The exception 
to this rule are enemy chains, where multiple enemies are created in a batch, but even then the game won't continue until 
all enemies from the chain have been removed.

We're going to modify the update() method so that:

If we have active enemies, we loop through each of them.
If any enemy is at or lower than Y position -140, we remove it from the game and our activeEnemies array.
If we don't have any active enemies and we haven't already queued the next enemy sequence, we schedule the next enemy sequence and set nextSequenceQueued to be true.

Put this code first in the update() method:

if activeEnemies.count > 0 {
    for (index, node) in activeEnemies.enumerated().reversed() {
        if node.position.y < -140 {
            node.removeFromParent()
            activeEnemies.remove(at: index)
        }
    }
} else {
    if !nextSequenceQueued {
        DispatchQueue.main.asyncAfter(deadline: .now() + popupTime) { [weak self] in
            self?.tossEnemies()
        }

        nextSequenceQueued = true
    }
}

And now the part you've been waiting for extremely patiently: press Cmd+R to run the game, because it should now be getting 
close to useful!



---------- Slice to win

We need to modify touchesMoved() to detect when users slice penguins and bombs. The code isn't complicated, but it is long, 
so I'm going to split it into three. First, here's the structure – place this just before the end of touchesMoved():

let nodesAtPoint = nodes(at: location)

for case let node as SKSpriteNode in nodesAtPoint {
    if node.name == "enemy" {
        // destroy penguin
    } else if node.name == "bomb" {
        // destroy bomb
    }
}

Now, let's take a look at what destroying a penguin should do. It should:

Create a particle effect over the penguin.
Clear its node name so that it can't be swiped repeatedly.
Disable the isDynamic of its physics body so that it doesn't carry on falling.
Make the penguin scale out and fade out at the same time.
After making the penguin scale out and fade out, we should remove it from the scene.
Add one to the player's score.
Remove the enemy from our activeEnemies array.
Play a sound so the player knows they hit the penguin.
Replace the // destroy penguin with this, following along with my numbered comments:

// 1
if let emitter = SKEmitterNode(fileNamed: "sliceHitEnemy") {
    emitter.position = node.position
    addChild(emitter)
}

// 2
node.name = ""

// 3
node.physicsBody?.isDynamic = false

// 4
let scaleOut = SKAction.scale(to: 0.001, duration:0.2)
let fadeOut = SKAction.fadeOut(withDuration: 0.2)
let group = SKAction.group([scaleOut, fadeOut])

// 5
let seq = SKAction.sequence([group, .removeFromParent()])
node.run(seq)

// 6
score += 1

// 7
if let index = activeEnemies.firstIndex(of: node) {
    activeEnemies.remove(at: index)
}

// 8
run(SKAction.playSoundFileNamed("whack.caf", waitForCompletion: false))

You've now seen the two ways of collecting SpriteKit actions together: groups and sequences. An action group specifies 
that all actions inside it should execute simultaneously, whereas an action sequence runs them all one at a time. In the 
code above we have a group inside a sequence, which is common.

If the player swipes a bomb by accident, they lose the game immediately. This uses much the same code as destroying a 
penguin, but with a few differences:

The node called "bomb" is the bomb image, which is inside the bomb container. So, we need to reference the node's parent when looking up our position, changing the physics body, removing the node from the scene, and removing the node from our activeEnemies array..
I'm going to create a different particle effect for bombs than for penguins.
We end by calling the (as yet unwritten) method endGame().
Replace the // destroy bomb comment with this:

guard let bombContainer = node.parent as? SKSpriteNode else { continue }

if let emitter = SKEmitterNode(fileNamed: "sliceHitBomb") {
    emitter.position = bombContainer.position
    addChild(emitter)
}

node.name = ""
bombContainer.physicsBody?.isDynamic = false

let scaleOut = SKAction.scale(to: 0.001, duration:0.2)
let fadeOut = SKAction.fadeOut(withDuration: 0.2)
let group = SKAction.group([scaleOut, fadeOut])

let seq = SKAction.sequence([group, .removeFromParent()])
bombContainer.run(seq)

if let index = activeEnemies.firstIndex(of: bombContainer) {
    activeEnemies.remove(at: index)
}

run(SKAction.playSoundFileNamed("explosion.caf", waitForCompletion: false))
endGame(triggeredByBomb: true)

Before I walk you through the endGame() method, we need to adjust the update() method a little. Right now, if a penguin 
or a bomb falls below -140, we remove it from the scene. We're going to modify that so that if the player misses slicing 
a penguin, they lose a life. We're also going to delete the node's name just in case any further checks for enemies or 
bombs happen – clearing the node name will avoid any problems.

In the update() method, replace this code:

if node.position.y < -140 {
    node.removeFromParent()
    activeEnemies.remove(at: index)
}
…with this:

if node.position.y < -140 {
    node.removeAllActions()

    if node.name == "enemy" {
        node.name = ""
        subtractLife()

        node.removeFromParent()
        activeEnemies.remove(at: index)
    } else if node.name == "bombContainer" {
        node.name = ""
        node.removeFromParent()
        activeEnemies.remove(at: index)
    }
}

That's mostly the same, except now we call subtractLife() when the player lets any penguins through. So, if you miss a 
penguin you lose one life; if you swipe a bomb, you lose all your lives. Or at least you would if our code actually 
compiled, which it won't: you're missing the subtractLife() and endGame() methods!



---------- Game over, man: SKTexture

You are now within reach of the end of this project, and not a moment too soon, I suspect. You'll be pleased to know that 
you're just two methods away from the end, and neither of them are particularly taxing.

First is the subtractLife() method, which is called when a penguin falls off the screen without being sliced. It needs to 
subtract 1 from the lives property that we created what seems like years ago, update the images in the livesImages array 
so that the correct number are crossed off, then end the game if the player is out of lives.

To make it a bit clearer that something bad has happened, we're also going to add playing a sound and animate the life 
being lost – we'll set the X and Y scale of the life being lost to 1.3, then animate it back down to 1.0.

Here's the code:

func subtractLife() {
    lives -= 1

    run(SKAction.playSoundFileNamed("wrong.caf", waitForCompletion: false))

    var life: SKSpriteNode

    if lives == 2 {
        life = livesImages[0]
    } else if lives == 1 {
        life = livesImages[1]
    } else {
        life = livesImages[2]
        endGame(triggeredByBomb: false)
    }

    life.texture = SKTexture(imageNamed: "sliceLifeGone")

    life.xScale = 1.3
    life.yScale = 1.3
    life.run(SKAction.scale(to: 1, duration:0.1))
}

Note how I'm using SKTexture to modify the contents of a sprite node without having to recreate it, just like in project 14.

Finally, there's the endGame() method. I've made this accept a parameter that sets whether the game ended because of a bomb, 
so that we can update the UI appropriately.

func endGame(triggeredByBomb: Bool) {
    if isGameEnded {
        return
    }

    isGameEnded = true
    physicsWorld.speed = 0
    isUserInteractionEnabled = false

    bombSoundEffect?.stop()
    bombSoundEffect = nil

    if triggeredByBomb {
        livesImages[0].texture = SKTexture(imageNamed: "sliceLifeGone")
        livesImages[1].texture = SKTexture(imageNamed: "sliceLifeGone")
        livesImages[2].texture = SKTexture(imageNamed: "sliceLifeGone")
    }
}

If the game hasn't already ended, this code stops every object from moving by adjusting the speed of the physics world 
to be 0. It stops any bomb fuse fizzing, and sets all three lives images to have the same "life gone" graphic. Nothing 
surprising in there, but you do need to declare isGameEnded as a property for your class, like this:

var isGameEnded = false

Even though the game has ended, some actions can still take place. This should be banned if possible, so add these lines 
to the start of tossEnemies() and touchesMoved():

if isGameEnded {
    return
}

That's it, your game is done!