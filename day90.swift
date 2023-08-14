Milestone: Projects 25-27

Now that the end of the 100 days challenge is finally in sight, I hope you’re finding second wind to press ahead through 
these last few days. As John Quincy Adams once said, “patience and perseverance have a magical effect before which 
difficulties disappear and obstacles vanish.”

You’ve definitely shown lots of patience and perseverance because you’ve made it this far, and with just a little more 
effort you’ll make it to the end. To give you a little boost, this is the first of two consolidation days, both of which 
will give you lots of fun practice with Core Graphics – you’ll get lots of practice, and perhaps even learn a couple of 
new things along the way!

Today you have three topics to work through, one of which of is your challenge.



---------- What you learned

All three of the projects in this milestone drew on frameworks outside UIKit: you tried the Multipeer Connectivity 
framework, Core Motion, and Core Graphics. These all form part of the wider iOS ecosystem, and I hope you’re starting 
to realize just how far-reaching Apple’s frameworks are – they really have done most of the work for you!

Let’s recap what you’ve learned in this milestone:

- We covered UIImagePickerController again, and I hope at this point you’re feeling you could almost use it blindfold! 
That’s OK, though: we learn through repetition, so I’m not afraid to repeat things when it matters.

- We also repeated UICollectionView, and again you should be feeling pretty good about it by now.

- You met the MultipeerConnectivity framework, which is designed for ad-hoc networking. We sent images in project 25, 
but any kind of data works great – yes, even data that represents custom classes you encoded using Codable.

- We finally used categoryBitMask, contactTestBitMask, and collisionBitMask in all their glory, setting up different 
kinds of collisions for our ball. Remember, “category” defines what something is, “collision” defines what it should 
be bounce off, and “contact” defines what collisions you want to be informed on.

- We used CMMotionManager from Core Motion to read the accelerometer. Make sure you call startAccelerometerUpdates() 
before you try to read the accelerometerData property.

- The #targetEnvironment(simulator) code allowed us to add testing code for using the simulator, while also keeping code 
to read the accelerometer on devices. Xcode automatically compiles the correct code depending on your build target.

And then there’s Core Graphics. Project 27 was one of the longest technique projects in all of Hacking with Swift, and 
with good reason: Core Graphics packed with features, and there are lots of methods and properties you need to learn to 
make use of it fully.

Here are some of the Core Graphics things we covered:

- The UIGraphicsImageRenderer is the primary iOS graphics renderer, and can export UIImages just by calling its image() 
method and providing some drawing code.

- You can get access to the underlying Core Graphics context by reading its cgContext property. This is where most of 
the interesting functionality is.

- You call setFillColor(), setStrokeColor(), setLineWidth() and such before you do your drawing. Think of Core Graphics 
like a state machine: set it up as you want, do some drawing, set it up differently, do some more drawing, and so on.

- Because Core Graphics works at a lower level than UIKit, you need to use CGColor rather than UIColor. Yes, the CG is 
short for “Core Graphics”.

- You learned that you can call translateBy() and rotate(by:) on a Core Graphics context to affect the way it does drawing.

- We tried using move(to:) and addLine(to:) to do custom line drawing. In combination with rotation, this created an 
interesting effect with very little code.

- We drew attributed strings and a UIImage straight into a Core Graphics context by calling their draw() method.

Once you get used to Core Graphics, you start to realize that its incredible speed allows you to do procedurally 
generated graphics for games without too much work. More on that in project 29…



---------- Key points

There are two things I’d like to discuss briefly, both extending what you already learned to help push your skills even 
further.

First, the #targetEnvironment(simulator) compiler directive. Swift has several of these, and I want to demonstrate two 
just briefly: #line and #if swift. #line is easy enough: when your code gets built it automatically gets replaced with 
the current line number. You can also use #filename and #function, and the combination of these are very useful in 
debugging strings.

The #if swift directive allows you to conditionally compile code depending on the Swift compiler version being used. 
So, you could write Swift 4.2 code and Swift 5.0 code in the same file, and have Xcode choose the right version automatically.

Now why, do you think, might you want such functionality? Well, there are two situations that you’re likely to encounter:

1. You create a library that you distribute as Swift source code. Supporting more than one version of Swift helps 
reduce complexity for your users without breaking their code.

2. You want to experiment with a future version of Swift without breaking your existing code. Having both in the same 
file means you can toggle between them easily enough.

Here’s some example code to get you started:

#if swift(>=5.0)
print("Running Swift 5.0 or later")
#else
print("Running Swift 4.2")
#endif

The second thing I’d like to touch on briefly is image rendering. Hacking with Swift is written specifically for the 
latest and greatest APIs from Apple, because if you’re learning from scratch it’s usually not worth bothering learning 
older technologies.

However, the case of image rendering is unique because the old technology – i.e., everything before iOS 10.0 – takes 
only a minute to learn. So, I want to show you just quickly how to render images before iOS 10, because it’s likely 
you’ll come across it in the wider world.

Here’s the iOS 10 and later code we would use to render a circle:

let renderer = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))
let img = renderer.image { ctx in
    ctx.cgContext.setFillColor(UIColor.red.cgColor)
    ctx.cgContext.setStrokeColor(UIColor.green.cgColor)
    ctx.cgContext.setLineWidth(10)

    let rectangle = CGRect(x: 0, y: 0, width: 512, height: 512)
    ctx.cgContext.addEllipse(in: rectangle)
    ctx.cgContext.drawPath(using: .fillStroke)
}

To convert that to pre-iOS 10 rendering, you need to learn four new functions:

1. UIGraphicsBeginImageContextWithOptions(). This starts a new Core Graphics rendering pass. Pass it your size, then a 
rendering scale, and whether the image should be opaque. If you want to use the current device’s scale, use 0 for the 
scale parameter.

2. Just starting a rendering pass doesn’t give you a context. To do that, you need to use UIGraphicsGetCurrentContext(), 
which returns a CGContext?. It’s optional because of course Swift doesn’t know we just started a rendering pass.

3. Call UIGraphicsGetImageFromCurrentImageContext() when you want to extract a UIImage from your rendering. 
Again, this returns an optional (in this case UIImage?) because Swift doesn’t know a rendering pass is active.

4. Call UIGraphicsEndImageContext() when you’ve finished, to free up the memory from your rendering.

As you can see, the older calls are a little more flaky: having extra optionality is never welcome, and you need to 
remember to both start and end your rendering blocks. Still, if you want to give it a try, here’s the same circle 
rendering code rewritten for iOS 9.3 and earlier:

UIGraphicsBeginImageContextWithOptions(CGSize(width: 512, height: 512), false, 0)

if let ctx = UIGraphicsGetCurrentContext() {
    ctx.setFillColor(UIColor.red.cgColor)
    ctx.setStrokeColor(UIColor.green.cgColor)
    ctx.setLineWidth(10)

    let rectangle = CGRect(x: 5, y: 5, width: 502, height: 502)
    ctx.addEllipse(in: rectangle)
    ctx.drawPath(using: .fillStroke)
}

if let img = UIGraphicsGetImageFromCurrentImageContext() {
    // "img" is now a valid UIImage – use it here!
}

UIGraphicsEndImageContext()



---------- Challenge

Your challenge for this milestone is to create a meme generation app using UIImagePickerController, UIAlertController, 
and Core Graphics. If you aren’t familiar with them, memes are a simple format that shows a picture with one line of 
text overlaid at the top and another overlaid at the bottom.

Your app should:

- Prompt the user to import a photo from their photo library.

- Show an alert with a text field asking them to insert a line of text for the top of the meme.

- Show a second alert for the bottom of the meme.

- Render their image plus both pieces of text into one finished UIImage using Core Graphics.

- Let them share that result using UIActivityViewController.

Both the top and bottom pieces of text should be optional; the user doesn’t need to provide them if they don’t want to.

Try to solve the challenge now. As per usual, there are some hints below in case you hit problems.

1. Your UI can be pretty simple: a large image view, with three buttons below: Import Picture, Set Top Text, and Set 
Bottom Text.

2. Both pieces of text can be read in using a UIAlertController with a text field inside.

3. When rendering your finished image, make sure you draw your UIImage first, then add the text on top.

4. NSAttributedString has keys to specify the stroke width and color of text, which would make it more readable – can 
you experiment to figure it out?

OK, that’s enough hints – get coding!