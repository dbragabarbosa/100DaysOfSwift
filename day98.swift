Project 30, part two

After all these days of learning how to write Swift and then how to build apps, you might now be wondering how fast all 
that code you wrote was. Did you get blended layers right? Where you using off-screen rendered images? Was there wasted 
memory?

I know it might seem like a lot to keep in your head: not only are you thinking about the language and Apple’s many 
frameworks, but you now also need to think about how to keep your performance high! But don’t despair: the key here 
isn’t to do everything perfectly. You’ll make mistakes and you’ll learn from them, even after 20 or 30 years of this 
job. As Izey Victoria Odiase said, “don't aim for perfection – aim for 'better than yesterday’.”

Once you accept that you’ll make mistakes, learning to identify them using Instruments becomes second nature, and 
you’ll actually start to benefit from those mistakes.

And you know what we call developers who make mistakes?

Developers.

Today you should work through the “Fixing the bugs: Running out of memory” chapter and wrap up for project 30, complete 
its review, then work through all three of its challenges.



---------- Fixing the bugs: Running out of memory

Now, why does the app crash when you go the detail view controller enough times? There are two answers to this question, 
one code related and one not. For the second question, I already explained that we’re working with supremely over-sized 
images here – far larger than we actually need.

But there's something else subtle here, and it's something we haven't covered yet so this is the perfect time. When you 
create a UIImage using UIImage(named:) iOS loads the image and puts it into an image cache for reuse later. This is 
sometimes helpful, particularly if you know the image will be used again. But if you know it's unlikely to be reused 
or if it's quite large, then don't bother putting it into the cache – it will just add memory pressure to your app and 
probably flush out other more useful images!

If you look in the viewDidLoad() method of ImageViewController you'll see this line of code:

let original = UIImage(named: image)!

How likely is it that users will go back and forward to the same image again and again? Not likely at all, so we can skip 
the image cache by creating our images using the UIImage(contentsOfFile:) initializer instead. This isn't as friendly as 
UIImage(named:) because you need to specify the exact path to an image rather than just its filename in your app bundle. 
The solution is to use Bundle.main.path(forResource:ofType:), which is similar to the Bundle.main.url(forResource:) 
method we’ve used previously, except it returns a simple string rather than a URL:

let path = Bundle.main.path(forResource: image, ofType: nil)!
let original = UIImage(contentsOfFile: path)!

Let's take a look at one more problem, this time quite subtle. Loading the images was slow because they were so big, 
and iOS was caching them unnecessarily. But UIImage's cache is intelligent: if it senses memory pressure, it automatically 
clears itself to make room for other stuff. So why does our app run out of memory?

To find another problems, profile the app using Instruments and select the allocations instrument again. This time filter 
on "imageviewcontroller" and to begin with you'll see nothing because the app starts on the table view. But if you tap 
into a detail view then go back, you'll see one is created and remains persistent – it hasn't been destroyed. Which means 
the image it's showing also hasn't been destroyed, hence the massive memory usage.

What's causing the image view controller to never be destroyed? If you read through SelectionViewController.swift and 
ImageViewController.swift you might spot these two things:

1. The selection view controller has a viewControllers array that claims to be a cache of the detail view controllers. 
This cache is never actually used, and even if it were used it really isn't needed.

2. The image view controller has a property var owner: SelectionViewController! – that makes it a strong reference to 
the view controller that created it.

The first problem is easily fixed: just delete the viewControllers array and any code that uses it, because it's just 
not needed. The second problem smells like a strong reference cycle, so you should probably change it to this:

weak var owner: SelectionViewController!

Run Instruments again and you'll see that the problem is… still there?! That's right: those two were either red herrings 
or weren't enough to solve the problem, because something far more sneaky is happening.

The view controllers aren't destroyed because of this line of code in ImageViewController.swift:

animTimer = Timer.scheduledTimer(withTimeInterval: 5, repeats: true) { timer in

That timer does a hacky animation on the image, and it could easily be replaced with better animations as done inside 
project 15. But even so, why does that cause the image view controllers to never leak?

The reason is that when you provide code for your timer to run, the timer holds a strong reference to it so it can 
definitely be called when the timer is up. We're using self inside our timer’s code, which means our view controller 
owns the timer strongly and the timer owns the view controller strongly, so we have a strong reference cycle.

There are several solutions here: rewrite the code using smarter animations, use a weak self closure capture list, or 
destroy the timer when it's no longer needed, thus breaking the cycle. We’re going to take the last option here, to give 
you a little more practice with invalidating timers – all we need to do is detect when the image view controller is about 
to disappear and stop the timer. We'll do this in viewWillDisappear():

override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    animTimer.invalidate()
}

Calling invalidate() on a timer stops it immediately, which also forces it to release its strong reference on the view 
controller it belongs to, thus breaking the strong reference cycle. If you profile again, you'll see all the 
ImageViewController objects are now transient, and the app should no longer be quite so crash-prone.

That being said, the app might still crash sometimes because despite our best efforts we’re still juggling pictures that 
are far too big. However, the code is at least a great deal more efficient now, and none of the problems were too hard 
to find.



----------- Wrap up

Hold up your right hand and repeat after me: “I will never ship an app without running it through Instruments first.” 
It doesn't take long, it's not difficult, and I promise it will pay off – your user interfaces will be smoother, your 
code will run faster, and you'll avoid wasting memory, all using a tool that's completely free and you already have 
installed.

I have, predictably, only touched briefly on the many features of Instruments, Xcode, and the Simulator here, but I 
hope I've inspired you to learn more. Instruments can tell you exactly what each CPU core is doing at any given time, 
it can tell you when every object was created and when it was destroyed along with what code triggered it, and it can 
even simulate user interface interactions to help you stress test your apps!

At the same time, I also snuck in a few more techniques for you to try in your own apps – layer shadows, Core Graphics 
clipping, and how UIImage has an automatic cache for when you need it.

So: all in all another great technique project, and you’ve learned some important skills that will be useful in every iOS 
project you make from now on.

Challenge
One of the best ways to learn is to write your own code as often as possible, so here are three ways you should try your 
new knowledge to make sure you fully understand what’s going on:

1. Go through project 30 and remove all the force unwraps. Note: implicitly unwrapped optionals are not the same thing as 
force unwraps – you’re welcome to fix the implicitly unwrapped optionals too, but that’s a bonus task.

2. Pick any of the previous 29 projects that interests you, and try exploring it using the Allocations instrument. 
Can you find any objects that are persistent when they should have been destroyed?

3. For a tougher challenge, take the image generation code out of cellForRowAt: generate all images when the app first 
launches, and use those smaller versions instead. For bonus points, combine the getDocumentsDirectory() method I 
introduced in project 10 so that you save the resulting cache to make sure it never happens again.

As a reminder, here’s the code for getDocumentsDirectory():

func getDocumentsDirectory() -> URL {
    let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    return paths[0]
}