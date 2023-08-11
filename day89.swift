Project 27, part two

Swift was first introduced way back in 2014, at Apple’s annual Worldwide Developer Conference (WWDC). When showing off 
the new language, Chris Lattner (the creator of Swift) took to the stage and immediately did something that was 
revolutionary for us – at least back then: he created a Swift playground in Xcode.

You see, before then we were using Objective-C, which was a language that had no concept of interactive code playback, 
which meant we didn’t have the ability to tinker quickly with our code to try out experiments.

In fact, for some years all Swift playgrounds came with a quote at the top that set the tone perfectly: 
“Playground – noun: a place where people can play.” That didn’t mean the code we write in playgrounds isn’t important 
or serious, just that it’s built in an environment where tinkering is actively encouraged – we can make one small change 
and see it take effect immediately.

While learning Core Graphics and Core Animation, we built a sandbox where there’s no clutter and no complexity – it’s 
just a simple UI that lets us try things out freely, and without worry of breaking any important code. So, I hope today’s 
challenges will encourage you to try something new with what you’ve learned. Try various approaches to the same problem, 
try using code completion to explore, and just feel free to make mistakes – because each mistake will teach you something 
new, and help take you closer to your goal.

Today you should work through the wrap up chapter for project 27, complete its review, then work through all three of 
its challenges.



---------- Wrap up

I could easily have written twice as much about Core Graphics, because it's capable of some extraordinary effects. 
Clipping paths, gradients, blend modes and more are just a few lines of code away, so there really is no excuse not 
to give them a try! And if you don't give it a try yourself, don't worry: we'll be drawing with Core Graphics in 
project 29, so you can't avoid it.

This project has given you a sandbox where you can play around with various Core Graphics techniques easily, so I would 
highly encourage you to spend more time tinkering with the code in your project. There are some suggested challenges 
below, but you can also use code completion to try new functions, change my values to others to see what happens, and 
so on. Playing with code like this can help you to discover new functionality, and will also help you remember more 
later. Have fun!


Challenge
One of the best ways to learn is to write your own code as often as possible, so here are three ways you should try 
your new knowledge to make sure you fully understand what’s going on:

1. Pick any emoji and try creating it using Core Graphics. You should find some easy enough, but for a harder challenge 
you could also try something like the star emoji.

2. Use a combination of move(to:) and addLine(to:) to create and stroke a path that spells “TWIN” on the canvas.

3. Go back to project 3 and change the way the selected image is shared so that it has some rendered text on top saying 
“From Storm Viewer”. This means reading the size property of the original image, creating a new canvas at that size, 
drawing the image in, then adding your text on top.