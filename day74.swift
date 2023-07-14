Milestone: Projects 19-21

In the last week your brain has been crammed full of important Swift and iOS skills. Don’t believe me? Here’s a list 
that’s not even complete: extensions, NotificationCenter, UITextView, color blending, shake gestures, for case let, 
reversing arrays, local notifications, and more – and that’s just in one week, while also building an app and a game!

Of course, just learning something new isn’t enough – it’s important to put that learning into practice, not only so that 
it really starts to stick in your head, but also so that you can take another step towards your goal of being an app 
developer. After all, it’s fun learning and I hope you’ll carry on discovering great new things in iOS and Swift for 
years to come, but I hope you have a greater goal in mind.

Henry Petroski, a professor of engineering at Duke University in the US, said “as engineers, we’re going to be in a 
position to change the world, not just study it.” Now that the end of the 100 days challenge is almost in sight, how 
do you plan to change the world?

Today you have three topics to work through, one of which of is your challenge.



---------- What you learned

These three projects were a mixed bag in terms of difficulty: although Safari extensions are clearly a bit of a wart in 
Apple’s APIs, it’s still marvelous to be able to add features directly to one of the most important features in iOS. 
As for the Fireworks Night project, I hope it showed you it doesn’t take much in the way of graphics to make something fun!

You also learned about local notifications, which might seem trivial at first but actually open up a huge range of 
possibilities for your apps because you can prompt users to take action even when your app isn’t running.

The best example of this is the Duolingo app – it sets “You should practice your language!” reminders for 1 day, 2 days, 
and 3 days after the app was most recently launched. If you launch the app before the reminders appear, they just clear 
them and reset the timer so you never notice them.

Here’s a quick reminder of the things we covered:

- How to make extensions for Safari by connecting Swift code to JavaScript. Getting the connection working isn’t too easy, 
but once it’s set up you can send whatever you want between the two.

- Editing multi-line text using UITextView. This is used by apps like Mail, Messages, and Notes, so you’ll definitely 
use it in your own apps.

- You met Objective-C’s NSDictionary type. It’s not used much in Swift because you lose Swift’s strong typing, but it’s 
occasionally unavoidable.

- We used the iOS NotificationCenter center class to receive system messages. Specifically, we requested that a method 
be called when the keyboard was shown or hidden so that we can adjust the insets of our text view. We’ll be using this 
again in a later project, so you have ample chance for practice.

- The follow() SKAction, which causes a node to follow a bezier path that you specify. Use orientToPath: true to make 
the sprite rotate as it follows.

- The color and colorBlendFactor properties for SKSpriteNode, which let you dynamically recolor your sprite.

- The motionBegan() method, which gets called on your view controllers when the user shakes their device.

- Swift’s for case let syntax for adding a condition to a loop.

- The UserNotifications framework, which allows you to create notifications and attach them to triggers.



---------- Key points

There are three pieces of code I’d like to review, just to make sure you understand them fully.

The first thing I’d like to recap is NotificationCenter, which is a system-wide broadcasting framework that lets you send 
and receive messages. These messages come in two forms: messages that come from iOS, and messages you send yourself. 
Regardless of whether the messages come from, NotificationCenter is a good example of loose coupling – you don’t care who 
subscribes to receive your messages, or indeed if anyone at all does; you’re just responsible for posting them.

In project 19 we used NotificationCenter so that iOS notified us when the keyboard was shown or hidden. This meant 
registering for the Notification.Name.UIKeyboardWillChangeFrame and Notification.Name.UIKeyboardWillHide: we told iOS 
we want to be notified when those events occurred, and asked it to execute our adjustForKeyboard() method. Here’s the 
code we used:

let notificationCenter = NotificationCenter.default
notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: Notification.Name.UIKeyboardWillHide, object: nil)

There are lots of these events – just try typing Notification.Name. and letting autocomplete show you what’s available. 
For example, in project 28 we use the Notification.Name.UIApplicationWillResignActive event to detect when the app moves 
to the background.

Like I said, it’s also possible to send your own notifications using NotificationCenter. Their names are just strings, 
and only your application ever sees them, so you can go ahead and make as many as you like. For example, to post a 
“UserLoggedIn” notification, you would write this:

let notificationCenter = NotificationCenter.default
notificationCenter.post(name: Notification.Name("UserLoggedIn"), object: nil)

If no other part of your app has subscribed to receive that notification, nothing will happen. But you can make any other 
objects subscribe to that notification – it could be one thing, or ten things, it doesn’t matter. This is the essence of 
loose coupling: you’re transmitting the event to everyone, with no direct knowledge of who your receivers are.

The second piece of code I’d like to review is this, taken from project 21:

let center = UNUserNotificationCenter.current()

center.requestAuthorization(options: [.alert, .badge, .sound]) { (granted, error) in
    if granted {
        print("Yay!")
    } else {
        print("D'oh")
    }
}

In that code, everything from { (granted, error) in to the end is a closure: that code won’t get run straight away. 
Instead, it gets passed as the second parameter to the requestAuthorization() method, which stores the code. This is 
important – in fact essential – to the working of this code, because iOS needs to ask the user for permission to show 
notifications.

iPhones can do literally billions of things every second, so in the time it takes for the “Do you want to allow 
notifications” message to appear, then for the user to read it, consider it, then make a choice, the iPhone CPU has 
done countless other things.

It would be a pretty poor experience if your app had to pause completely while the user was thinking, which is why 
closures are used: you tell iOS what to do when the user has made a decision, but that code only gets called when that 
decision is finally made. As soon as you call requestAuthorization(), execution continues immediately on the very next 
line after it – iOS doesn’t stop while the user thinks. Instead, you sent the closure – the code to run – to the 
notification center, and that’s what will get called when the user makes a choice.

Finally, let’s take another look at for case let syntax. Its job is to perform some sort of filtering on our data based 
on the result of a check, which means inside the Swift loop the compiler has more information about the data it’s working 
with.

For example, if we wanted to loop over all the subviews of a UIView, we’d write this:

for subview in view.subviews {
    print("Found a subview with the tag: \(subview.tag)")
}

All views have a tag, which is an identifying number we can use to distinguish between views in some specific circumstances.

However, what if wanted to find all the labels in our subviews and print out their text? We can’t print out the text 
above, because a regular UIView doesn’t have a text property, so we’d probably write something like this:

for subview in view.subviews {
    guard let label = subview as? UILabel else { continue }
    print("Found a label with the text: \(label.text)")
}
That certainly works, but this is a case where for case let can do the same job in less code:

for case let label as UILabel in view.subviews {
    print("Found a label with text \(label.text)")
}

for case let can also do the job of checking optionals for a value. If it finds a value inside it will unwrap it and 
provide that inside the loop; if there is no value that element will be skipped.

The syntax for this is a little curious, but I think you’ll appreciate its simplicity:

let names = ["Bill", nil, "Ted", nil]

for case let name? in names {
    print(name)
}

In that code the names array will be inferred as [String?] because elements are either strings or nil. Using for case let 
there will skip the two nil values, and unwrap and print the two strings.



----------- Challenge

Have you ever heard the phrase, “imitation is the highest form of flattery”? I can’t think of anywhere it’s more true 
than on iOS: Apple sets an extremely high standard for apps, and encourages us all to follow suit by releasing a vast 
collection of powerful, flexible APIs to work with.

Your challenge for this milestone is to use those API to imitate Apple as closely as you can: I’d like you to recreate 
the iOS Notes app. I suggest you follow the iPhone version, because it’s fairly simple: a navigation controller, a table 
view controller, and a detail view controller with a full-screen text view.

How much of the app you imitate is down to you, but I suggest you work through this list:

1. Create a table view controller that lists notes. Place it inside a navigation controller. (Project 1)

2. Tapping on a note should slide in a detail view controller that contains a full-screen text view. (Project 19)

3. Notes should be loaded and saved using Codable. You can use UserDefaults if you want, or write to a file. (Project 12)

4. Add some toolbar items to the detail view controller – “delete” and “compose” seem like good choices. (Project 4)

5. Add an action button to the navigation bar in the detail view controller that shares the text using UIActivityViewController. (Project 3)

Once you’ve done those, try using Interface Builder to customize the UI – how close can you make it look like Notes?

Note: the official Apple Notes app supports rich text input and media; don’t worry about that, focus on plain text.

Go ahead and try now. Remember: don’t fret if it sounds hard – it’s supposed to stretch you.

Here are some hints in case you hit a problem:

- You could represent each note using a custom Note class if you wanted, but to begin with perhaps just make each note a 
string that gets stored in a notes array.

- If you do intend to go down the custom class route for notes, make sure you conform to Codable – you might need to 
re-read project 12.

- Make sure you use NotificationCenter to update the insets for your detail text view when the keyboard is shown or hidden.

- Try changing the tintColor property in Interface Builder. This controls the color of icons in the navigation bar and 
toolbar, amongst other things.