Project 20, part two

Even today, the shake gesture in iOS feels a bit odd, at least to me. It’s particularly odd on iPad, where devices can be 
up to 12.9-inches – they are hefty, so shaking them feels, well, odd.

John Gruber recounts an anecdote he heard about how shake to undo came about, which might why it just doesn’t fit in with 
the rest of the platform:

Scott Forstall charged the iOS team with devising an interface for Undo — everyone knew the iPhone should have it,1 but no 
\one had a good idea how to do it. One engineer joked that they could just make you shake the iPhone to invoke it. Forstall 
said he loved the idea, and what was proposed as a joke has been with us as the Undo interface ever since.

Still, when it works it works, and I think it feels satisfying to make things explode by giving your iPad a little shake!

There’s only a little bit more to do to our game to finish it up, and I hope you’re happy with how it all came together – 
SpriteKit is fun.

Today you should work through the “Making things go bang” chapter and wrap up for project 20, complete its review, then 
work through all three of its challenges.



---------- Making things go bang: SKEmitterNode

This is easily the best bit of the game, mostly because it involves even more particle systems. There are three things we 
need to create: a method to explode a single firework, a method to explode all the fireworks (which will call the single 
firework explosion method), and some code to detect and respond the device being shaken.

First, the code to explode a single firework. Put this somewhere in your game scene:

func explode(firework: SKNode) {
    if let emitter = SKEmitterNode(fileNamed: "explode") {
        emitter.position = firework.position
        addChild(emitter)
    }

    firework.removeFromParent()
}

You should be able to read that once and know exactly what it does: it creates an explosion where the firework was, then 
removes the firework from the game scene.

The explodeFireworks() method is next, and is only fractionally more complicated. It will be triggered when the user wants 
to set off their selected fireworks, so it needs to loop through the fireworks array (backwards again!), pick out any 
selected ones, then call explode() on it.

As I said earlier, the player's score needs to go up by more when they select more fireworks, so about half of the 
explodeFireworks() method is taken up with figuring out what score to give the player.

There's one small piece of extra complexity: remember, the fireworks array stores the firework container node, so we need 
to read the firework image out of its children array.

Enough talk – here's the code:

func explodeFireworks() {
    var numExploded = 0

    for (index, fireworkContainer) in fireworks.enumerated().reversed() {
        guard let firework = fireworkContainer.children.first as? SKSpriteNode else { continue }

        if firework.name == "selected" {
            // destroy this firework!
            explode(firework: fireworkContainer)
            fireworks.remove(at: index)
            numExploded += 1
        }
    }

    switch numExploded {
    case 0:
        // nothing – rubbish!
        break
    case 1:
        score += 200
    case 2:
        score += 500
    case 3:
        score += 1500
    case 4:
        score += 2500
    default:
        score += 4000
    }
}

As you can see, exploding five fireworks is worth 20x more points than exploding just one, hence the incentive to select 
groups by color!

There's one last thing to do before this game is complete, and that's to detect the device being shaken. This is easy 
enough to do because iOS will automatically call a method called motionBegan() on our game when the device is shaken. 
Well, it's a little more complicated than that – what actually happens is that the method gets called in 
GameViewController.swift, which is the UIViewController that hosts our SpriteKit game scene.

The default view controller doesn't know that it has a SpriteKit view, and certainly doesn't know what scene is showing, 
so we need to do a little typecasting. Once we have a reference to our actual game scene, we can call explodeFireworks(). 
Put this method just after the prefersStatusBarHidden property in GameViewController.swift:

override func motionBegan(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
    guard let skView = view as? SKView else { return }
    guard let gameScene = skView.scene as? GameScene else { return }
    gameScene.explodeFireworks()
}

That's it, your game is done. Obviously you can't shake your laptop to make the iOS Simulator respond, but you can use the 
keyboard shortcut Ctrl+Cmd+Z to get the same result. If you're testing on your iPad, make sure you give it a good shake in 
order to trigger the explosions!



---------- Wrap up

This wasn’t a complicated project, although it did involve quite a bit of code because of the various ways fireworks are 
launched. However, it’s a good example of where particle systems can really bring a game to life – we only have two 
different types here, but they still do wonders as simple special effects.

Plus of course you have yet more Swift coding experience under your belt, now complete with follow(), UIBezierPath, for 
case let, color blending, and, yes, even the shake gesture – although I wouldn't be surprised if you switch to having a 
button on the screen to make explosions easier!


Challenge
One of the best ways to learn is to write your own code as often as possible, so here are three ways you should try your 
new knowledge to make sure you fully understand what’s going on:

1. For an easy challenge try adding a score label that updates as the player’s score changes.

2. Make the game end after a certain number of launches. You will need to use the invalidate() method of Timer to stop it 
from repeating.

3. Use the waitForDuration and removeFromParent actions in a sequence to make sure explosion particle emitters are removed 
from the game scene when they are finished.