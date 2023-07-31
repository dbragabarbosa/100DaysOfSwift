Milestone: Projects 22-24

These last few projects haven’t been easy, and there’s a good chance you’re feeling really tired today. Well, I have two 
pieces of good news for you.

First, it’s a consolidation day, which means you won’t be learning a lot of new stuff today. Second, today’s challenge 
isn’t about building an app from scratch, so hopefully you’ll get through it relatively quickly and have time to take a break.

Cicero once said that “to know the laws is not to memorize their letter but to grasp their full force and meaning.” 
These same is true of these consolidation days: they are here to make sure you really understand what you’ve learned. 
It’s not enough just to memorize method names and pieces of code, because if you don’t grasp why they work like they do 
you’ll never be able to use them in other contexts.

Today you have three topics to work through, one of which of is your challenge.



---------- What you learned

If everything is going to plan you should be starting to find the code for these projects easier and easier. 
That’s not to say it’s all plain sailing from now on – there are still some tough things to learn! – but it does show 
that your skills are advancing and you’re starting to retain what you’ve learned.

Let’s recap what you’ve learned in this milestone:

- You met CLLocationManager from the Core Location framework, which is the central point for location permissions and 
updates in iOS.

- You learned to set “Always” or “When in use” in your Info.plist, so that iOS can show a meaningful permission request 
to your user.

- We used CLBeaconRegion to scan for a particular iBeacon, using a UUID, major number, and minor number. That’s enough 
to identify anywhere in the world uniquely.

- When a beacon was being ranged, we used CLProximity to determine how close it was. iBeacons use extremely low signal 
strengths to preserve battery life, so the proximity levels are quite vague!

- You learned how to draw custom paths using UIBezierPath, then render them in SpriteKit using SKShapeNode – we used these 
to draw the swiping glow effect in Swifty Ninja.

- We made the bomb sound play using AVAudioPlayer, because we wanted to be able to stop it at any point. 
In project 36 you’ll learn about SKAudioNode, which is able to achieve similar results.

- You learned how Swift strings are more than just arrays of characters, which is why we can’t write someString[3] by default.

- We looked at common methods of String and added some more of our own using extensions.

- I introduced you to NSAttributedString, and how it lets us add colors, fonts, and more to text.



---------- Key points

Before you continue to the next milestone, there are two things I’d like to discuss briefly.

First, project 22 introduced Core Location to enable scanning for iBeacons. That’s just one of several things that Core 
Location does, and I couldn’t possibly continue without at least giving you a taste of the others. 
For example, Core Location’s functionality includes:

- Providing co-ordinates for the user’s location at a granularity you specify.

- Tracking the places the user has visited.

- Indoor location, even down to what floor a user is on, for locations that have been configured by Apple.

- Geocoding, which converts co-ordinates to user-friendly names like cities and streets.

Using these things starts with what you have already: modifying the Info.plist to provide a description of how you intend 
to use location data, then requesting permission. If you intend to use visit tracking you should request the “always” 
permission because visits are delivered to you in the background.

Once you have permission, try using this to get the user’s location just once, rather than ongoing:

locationManager = CLLocationManager()
manager.delegate = self

    // request the user's coordinates
locationManager.requestLocation()

func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    if let location = locations.first {
            print("Found user's location: \(location)")
    }
}

func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
    print("Failed to find user's location: \(error.localizedDescription)")
}

You can also request visit monitoring, like this:

// start monitoring visits
locationManager.startMonitoringVisits()

When the user arrives or departs from a location, you’ll get a callback method if you implement it. 
The method is the same regardless of whether the user arrived or departed at the location, so you need to check the 
departureDate property to decide.

Here’s an example to get you started:

func locationManager(_ manager: CLLocationManager, didVisit visit: CLVisit) {
    if visit.departureDate == Date.distantFuture {
        print("User arrived at location \(visit.coordinate) at time \(visit.arrivalDate)")
    } else {
        print("User departed location \(visit.coordinate) at time \(visit.departureDate)")
    }
}

Note: the definition of a “visit” is pretty vague because iOS can’t tell whether the user has walked into a store or is 
just standing at a bus stop or sitting in traffic.

The second thing I’d like to discuss further is Swift extensions. These are extraordinarily powerful, because you can 
extend specific types (e.g. Int and String) but also whole protocols of types (e.g. “all collections”.) Protocol extensions 
allow us to build up functionality extremely quickly, and using it extensively – a technique known as protocol-oriented 
programming – is common.

We just wrote several extensions on String, which is what we call a concrete data type – a thing you can actually make. 
We can write extensions for other concrete types like Int, like this:

extension Int {
    var isOdd: Bool {
        return !self.isMultiple(of: 2)
    }

    var isEven: Bool {
        return self.isMultiple(of: 2)
    }
}

However, that will only extend Int – Swift has a variety of different sizes and types of integers to handle very specific 
situations. For example, ‌Int8 is a very small integer that holds between -128 and 127, for times when you don’t need much 
data but space is really restricted. Or there’s UInt64, which holds much larger numbers than a regular Int, but those 
numbers must always be positive.

Making extensions for whole protocols at once adds our functionality to many places, which in the case of integers means 
we can add isOdd and isEven to Int, Int8, UInt64, and more by extending the BinaryInteger protocol that covers them all:

extension BinaryInteger {
    var isOdd: Bool {
        return !self.isMultiple(of: 2)
    }

    var isEven: Bool {
        return self.isMultiple(of: 2)
    }
}

However, where things get really interesting is if when we want only a subset of a protocol to be extended. 
For example, Swift has a Collection protocol that covers arrays, dictionaries, sets, and more, and if we wanted to write 
a method that counted how many odd and even numbers it held we might start by writing something like this:

extension Collection {
    func countOddEven() -> (odd: Int, even: Int) {
        // start with 0 even and odd
        var even = 0
        var odd = 0

        // go over all values
        for val in self {
            if val.isMultiple(of: 2) {
                // this is even; add one to our even count
                even += 1
            } else {
                // this must be odd; add one to our odd count                
                odd += 1
            }
        }

        // send back our counts as a tuple
        return (odd, even)
    }
}

However, that code won’t work. You see, we’re trying to extend all collections, which means we’re asking Swift to make 
the method available on arrays like this one:

let names = ["Arya", "Bran", "Rickon", "Robb", "Sansa"]

That array contains strings, and we can’t check whether a string is a multiple of 2 – it just doesn’t make sense.

What we mean to say is “add this method to all collections that contain integers, regardless of that integer type.” 
To make this work, you need to specify a where clause to filter where the extension is applied: we want this extension 
only for collections where the elements inside that collection conform to the BinaryInteger protocol.

This is actually surprisingly easy to do – just modify the extension to this:

extension Collection where Element: BinaryInteger {

As you’ll learn, these extension constraints are extraordinarily powerful, particularly when you constrain using a 
protocol rather than specific type. For example, if you extend Array so that your methods only apply to arrays that 
hold Comparable objects, the methods in that extension gain access to a whole range of built-in methods such as 
firstIndex(of:), contains(), sort(), and more – because Swift knows the elements must all conform to Comparable.

If you want to try such a constraint yourself – and trust me, you’ll need it for one of the challenges coming up! – 
write your extensions like this:

extension Array where Element: Comparable {
    func doStuff(with: Element) {
    }
}

Inside the doStuff() method, Swift will ensure that Element automatically means whatever type of element the array holds.

That’s just a teaser of what’s to come once your Swift skills advance a little further, but I hope you’re starting to see 
why Swift is called a protocol-oriented programming language – you can extend specific types if you want to, but it’s far 
more efficient – and powerful! – to extend whole groups of them at once.



---------- Challenge

Your challenge this time is not to build a project from scratch. Instead, I want you to implement three Swift language 
extensions using what you learned in project 24. I’ve ordered them easy to hard, so you should work your way from first 
to last if you want to make your life easy!

Here are the extensions I’d like you to implement:

1. Extend UIView so that it has a bounceOut(duration:) method that uses animation to scale its size down to 0.0001 over 
a specified number of seconds.

2. Extend Int with a times() method that runs a closure as many times as the number is high. 
For example, 5.times { print("Hello!") } will print “Hello” five times.

3. Extend Array so that it has a mutating remove(item:) method. If the item exists more than once, it should remove only 
the first instance it finds. Tip: you will need to add the Comparable constraint to make this work!

As per usual, please try and complete this challenge yourself before you read my hints below. And again, don’t worry if 
you find this challenge challenging – the clue is in the name, these are designed to make you think!

Here are some hints in case you hit problems:

1. Animation timings are specified using a TimeInterval, which is really just a Double behind the scenes. You should 
specify your method as bounceOut(duration: TimeInterval).

2. If you’ve forgotten how to scale a view, look up CGAffineTransform in project 15.

3. To add times() you’ll need to make a method that accepts a closure, and that closure should accept no parameters and 
return nothing: () -> Void.

4. Inside times() you should make a loop that references self as the upper end of a range – that’s the value of the 
integer you’re working with.

5. Integers can be negative. What happens if someone writes let count = -5 then uses count.times { … } and how can you 
make that better?

6. When it comes to implementing the remove(item:) method, make sure you constrain your extension like this: extension 
Array where Element: Comparable.

7. You can implement remove(item:) using a call to firstIndex(of:) then remove(at:).

Those hints ought to be enough for you to solve the complete challenge, but if you still hit problems then read over my 
solutions below, or put this all into a playground to see it in action.

import UIKit

// extension 1: animate out a UIView
extension UIView {
    func bounceOut(duration: TimeInterval) {
        UIView.animate(withDuration: duration) { [unowned self] in
            self.transform = CGAffineTransform(scaleX: 0.0001, y: 0.0001)
        }
    }
}

// extension 2: create a times() method for integers
extension Int {
    func times(_ closure: () -> Void) {
        guard self > 0 else { return }

        for _ in 0 ..< self {
            closure()
        }
    }
}    

// extension 3: remove an item from an array
extension Array where Element: Comparable {
    mutating func remove(item: Element) {
        if let location = self.firstIndex(of: item) {
            self.remove(at: location)
        }
    }
}

// some test code to make sure everything works
let view = UIView()
view.bounceOut(duration: 3)

5.times { print("Hello") }

var numbers = [1, 2, 3, 4, 5]
numbers.remove(item: 3)