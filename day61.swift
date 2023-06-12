Project 16, part two

I could easily have written this whole course about UIKit, skipping out Core Image, SpriteKit, MapKit, and more. But 
my hope is that by immersing you in other Apple frameworks you’re starting to become soaked in their way of approaching 
things – you’re starting to build a build a gut instinct for how Apple’s framework work.

I realize this place extra learning stress on you, because rather than staying within our comfort we’re constantly 
pushing forward into new things. It will help you in the long term, though – as James Bryant Conant said, “behold 
the turtle – it makes progress only when it sticks its neck out.”

Today you’ve finished another app, and I hope feel like you have a basic grasp of how maps work. There’s a lot more 
you can do with them, such as adding placemarks, looking up locations, and finding directions, but I hope you can at 
least see that it’s all within your grasp now!

Today you should work through the wrap up chapter for project 16, complete its review, then work through all three of 
its challenges.



---------- Wrap up

I tried to keep this project as simple as possible so that you can focus on the map component, because there was a lot 
to learn: MKMapView, MKAnnotation, MKPinAnnotationView, CLLocationCoordinate2D and so on, and all must be used before 
you get a finished product.

Again, we've only scratched the surface of what maps can do in iOS, but that just gives you more room to 
extend the app yourself!

Challenge
One of the best ways to learn is to write your own code as often as possible, so here are three ways you should try 
your new knowledge to make sure you fully understand what’s going on:

1. Try typecasting the return value from dequeueReusableAnnotationView() so that it's an MKPinAnnotationView. 
Once that’s done, change the pinTintColor property to your favorite UIColor.

2. Add a UIAlertController that lets users specify how they want to view the map. There's a mapType property that 
draws the maps in different ways. For example, .satellite gives a satellite view of the terrain.

3. Modify the callout button so that pressing it shows a new view controller with a web view, taking users to the 
Wikipedia entry for that city.