Project 18, part two

When I first took up cycling there was a particular long, steep hill I used to practice on, and it was so hard for me – 
I remember getting off half way up and walking the remainder! I asked one of the team at my local bike shop about it, 
and his response really stuck with me: “it doesn’t get much easier, but you do get faster.”

Today is another challenge day, and hopefully these challenges are getting a little easier to follow over time. I say 
“easier to follow” rather than just “easier” because it’s an important distinction – I don’t expect you’ll ever find 
these challenges easy but you will at least feel more able to tackle them. As the bike shop person said: it doesn’t 
get much easier, but you do get faster.

Today you should work through the wrap up chapter for project 18, complete its review, then work through all three of 
its challenges



---------- Wrap up

Debugging is a unique and essential skill that’s similar but different to regular coding. As you’ve just seen, there are 
lots of options to choose from, and you will – I promise! – use all of them at some point. Yes, even print().

There's more to learn about debugging, such as the Step Into and Step Out commands, but realistically you need to start 
with what you have before you venture any further. I would much rather you mastered three of the debugging tools available 
to you rather than having a weak grasp of all of them.


Challenge
One of the best ways to learn is to write your own code as often as possible, so here are three ways you should try your 
new knowledge to make sure you fully understand what’s going on:

1. Temporarily try adding an exception breakpoint to project 1, then changing the call to instantiateViewController() so 
that it uses the storyboard identifier “Bad” – this will fail, but your exception breakpoint should catch it.

2. In project 1, add a call to assert() in the viewDidLoad() method of DetailViewController.swift, checking that 
selectedImage always has a value.

3. Go back to project 5, and try adding a conditional breakpoint to the start of the submit() method that pauses only 
if the user submits a word with six or more letters.