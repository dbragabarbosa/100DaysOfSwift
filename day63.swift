Project 17, part two

When you follow this course you are, in a way, following in my footsteps. I lay out a path for you to follow, showing 
you how to make a variety of apps and games, and give you tips and advice to help you stay on track.

But every couple of days comes a day like this one – a day where there is no track laid down by me, and it’s down to 
you to go through my review questions and complete the challenges all by yourself.

These days are really important. As Mahatma Gandhi said, “An ounce of practice is worth more than tons of preaching.” 
Well, it’s time for the preaching to stop and for your practice to begin!

Today you should work through the wrap up chapter for project 17, complete its review, then work through all three of 
its challenges.



----------- Wrap up

That's it! We just made a game in 20 minutes or so, which shows you just how fast SpriteKit is. I even showed you how 
per-pixel collision detection works (it's so easy!), how to advance particle systems so they start life with some 
history behind them, how to run code repeatedly using Timer, and how to adjust linear and angular damping so that 
objects don't slow down over time.

Challenge
One of the best ways to learn is to write your own code as often as possible, so here are three ways you should try 
your new knowledge to make sure you fully understand what’s going on:

1. Stop the player from cheating by lifting their finger and tapping elsewhere – try implementing touchesEnded() to 
make it work.

2. Make the timer start at one second, but then after 20 enemies have been made subtract 0.1 seconds from it so 
it’s triggered every 0.9 seconds. After making 20 more, subtract another 0.1, and so on. Note: you should call 
invalidate() on gameTimer before giving it a new value, otherwise you end up with multiple timers.

3. Stop creating space debris after the player has died.