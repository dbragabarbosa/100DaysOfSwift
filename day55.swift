08/11/2022


Project 14, part one 


Ezra Koenig said “some people say video games rot your brain, but I think they work different muscles that maybe you don't
normally use.” By now you should know I believe that idea extends further: making video games works different muscles 
that you wouldn’t otherwise use making apps or similar.

Yes, you might decide making games is what you want to do on iOS, and maybe you’ll even be lucky enough to get into 
Apple’s Arcade program. Of course, you’re also just as likely to decide that your goal is to make apps, but even then 
the skills you learn making games will prove useful.

In this project, the skills include loops, masking, GCD, and more – all the kinds of things you can use regardless of 
whether you decide games are for you. And of course the deeper skill is learning how to structure Swift to solve problems 
– practicing the art of understanding code flow across larger projects.

So, whether or not you decide to make games in the future, there’s lots to learn in this project!

Today you have three topics to work through, and you’ll learn about SKCropNode, SKTexture, and more.



---------- Setting up

It's time for another game, and we'll be using more of SpriteKit to build a whack-a-mole game, except with penguins 
because Whack-a-Penguin isn't trademarked. You're going to learn about SKCropNode, SKTexture and some more types of 
SKAction, and we'll also use more GCD to execute closures after a delay.

Create a new SpriteKit game project in Xcode, named Project14 and targeting landscape iPads, then delete most of the 
example code just like you did in project 11 – you want the same clean project, with no “Hello World” template content.

If you don’t remember all the steps, here’s the abridged version:

- Delete Actions.sks.

- Open GameScene.sks and delete the “Hello World” label.

- Change the scene’s anchor point to X:0 Y:0, its width to 1024 and its height to 768.

Finally, remove almost everything in GameScene.swift so that it looks like this:

import SpriteKit

class GameScene: SKScene {
    override func didMove(to view: SKView) {
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    }
}

I won’t be repeating those instructions again from now on.

Now download the files for this project from GitHub (https://github.com/twostraws/HackingWithSwift) 
and copy the assets from the Content folder into your Xcode project.

All set? Open up GameScene.swift and get whacking!

Reminder: When working with SpriteKit projects I strongly recommend you use a device if possible. If you don’t have a 
physical iPad to hand, use the lowest-spec iPad simulator rather than something like the 12.9-inch iPad Pro – you'll 
get much slightly frame rates, making it much more suitable for testing.



---------- Getting up and running: SKCropNode