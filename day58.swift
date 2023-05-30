Project 15, part two


I hope you can agree that animation in iOS is almost invisible – we just lay out all the changes we want to happen, and 
Core Animation figures out all the intermediate steps to make it happen.

As I’ve said several times, animation is more than about making our software look good – it has a functional purpose too, 
ensuring that users understand why things and changing and what states they are moving from and to.

Larry Niven once said, “that's the thing about people who think they hate computers – what they really hate is lousy 
programmers.” Folks paid a lot of money for their iPhones and iPads, and Apple’s software oozes polish and refinement – 
if you don’t put a similar level of care into your own code then your app will stick out, and not in a good way.

So, with today’s challenges you need to apply your new animation knowledge to the projects you’ve made previously. 
I think you’ll be pleased how easy it is, and I hope also inspired to take on more animations in the future!

Today you should work through the wrap up chapter for project 15, complete its review, then work through all three of 
its challenges.



---------- Wrap up

Core Animation is an extraordinary toolkit, and UIKit wraps it in a simple and flexible set of methods. And because it's 
so simple to use, you really have no excuse for not using it.

In this project you learned about the animate(withDuration:) method of UIView, spring animations, as well as alpha values 
and CGAffineTransform.

Remember, animation isn’t just there to make our apps look pretty – it also helps guide the users eyes. So, if you're 
moving something around conceptually (e.g., moving an email to a folder, showing a palette of paint brushes, rolling a 
dice, etc) then move it around visually too. Your users will thank you for it!


Challenge
One of the best ways to learn is to write your own code as often as possible, so here are three ways you should try your 
new knowledge to make sure you fully understand what’s going on:

1. Go back to project 8 and make the letter group buttons fade out when they are tapped. We were using the isHidden 
property, but you'll need to switch to alpha because isHidden is either true or false, it has no animatable values between.

2. Go back to project 13 and make the image view fade in when a new picture is chosen. To make this work, set the alpha to 0 first.

3. Go back to project 2 and make the flags scale down with a little bounce when pressed.