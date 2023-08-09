Project 26, part three

Seth Godin – author and marketing genius – once said “surprise and delight and connection are remarkable.” We already 
looked at connection way back in project 10, Names to Faces, where importing user photos transformed our collection 
view into something far more personal – and thus far more important to users.

The accelerometer is an almost invisibly small component in iOS devices, but I hope this project has shown you that it 
brings a fresh dose of delight to our apps – and that’s even after you’ve learned about many of the other frameworks 
iOS makes available to us.

As for “surprise”, this is somewhere we need to be a little more careful. You see, users trust us with their data: 
our code is running on their phone, which is packed with their lifetime of photos, emails, chats, and more – it’s a 
really personal device. If your app does something unexpected – if it behaves in a way they weren’t expecting – it’s 
easy to lose some trust, and once that trust is gone it’s really hard to win back.

However, small amounts of surprise in safe places releases a little dopamine rush, making users feel good about our app. 
iOS is filled with tiny things like this: the way the flashlight button on the home screen grows with pressure then 
clicks with a physical bump, the smooth zoom animations seen in the App Store, or even the page curl reading effect 
in Apple Books. None of those risk user data or make the app feel uncertain, they are just tiny touches that feel 
great every time you interact with them.

Core Motion opens up a whole area of delight for us, but make sure you use it judiciously: if everything moves your 
users will feel queasy, but if you add a tiny touch here and there it’s just one more thing to help bring your app to life.

Today you should work through the wrap up chapter for project 26, complete its review, then work through all three of its challenges.



---------- Wrap up

There's something wonderfully tactile about using the accelerometer to affect gravity in a game, because it feels 
incredibly realistic even though we're not using particularly good graphics.

SpriteKit is of course doing most of the hard work of collision detection, and Core Motion takes away all the complexity 
of working with accelerometers, so again it's our job to sew the components together to make something bigger than the 
sum of its parts.

Challenge
One of the best ways to learn is to write your own code as often as possible, so here are three ways you should try your 
new knowledge to make sure you fully understand what’s going on:

1. Rewrite the loadLevel() method so that it's made up of multiple smaller methods. This will make your code easier to 
read and easier to maintain, or at least it should do if you do a good job!

2. When the player finally makes it to the finish marker, nothing happens. What should happen? Well, that's down to you 
now. You could easily design several new levels and have them progress through.

3. Add a new block type, such as a teleport that moves the player from one teleport point to the other. 
Add a new letter type in loadLevel(), add another collision type to our enum, then see what you can do.