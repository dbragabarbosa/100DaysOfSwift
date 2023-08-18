Project 28, part two

In the Secret Swift project you’ve learned about two important security techniques in iOS: biometric authentication and 
the keychain. Both of these in theory add some sort of security, but only if you use them correctly:

- If you use biometric authentication but store your data in UserDefaults, it can be read out by bypassing the app.

- If you store your data in the iOS keychain but don’t put it behind biometric authentication or similar, anyone can 
launch the app and just take it.

But even with both of those two combined, is our data truly secure? As Gene Spafford once said, “the online truly secure 
system is one that is powered off, cast in a block of concrete and sealed in a lead-lined room with armed guards.”

That doesn’t mean you shouldn’t try. As you’ve seen, Apple gives us a variety of tools we can use to keep our user data 
safe, and it’s worth using them all as best as we can.

Today you should work through the wrap up chapter for project 28, complete its review, then work through all three of its 
challenges



---------- Wrap up

The great thing about biometric authentication is that you don't get any access to fingerprints, face scans, or other 
secure information. Instead, the system does all the authentication for you, which keeps both your app and users safe.

More importantly, users trust it: they know that Touch ID and Face ID are highly secure system that guarantee security in 
our apps, so it immediately makes our apps feel both more personal and more safe.


Challenge
One of the best ways to learn is to write your own code as often as possible, so here are three ways you should try your 
new knowledge to make sure you fully understand what’s going on:

1. Add a Done button as a navigation bar item that causes the app to re-lock immediately rather than waiting for the user 
to quit. This should only be shown when the app is unlocked.

2. Create a password system for your app so that the Touch ID/Face ID fallback is more useful. You'll need to use an 
alert controller with a text field like we did in project 5, and I suggest you save the password in the keychain!

3. Go back to project 10 (Names to Faces) and add biometric authentication so the user’s pictures are shown only when 
they have unlocked the app. You’ll need to give some thought to how you can hide the pictures – perhaps leave the array 
empty until they are authenticated?