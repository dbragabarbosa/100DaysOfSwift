Milestone: Projects 28-30

Today is the last consolidation day of this 100 Days challenge, and we’ll be looking over what you’ve learned before diving straight into your toughest challenge yet.

I know the thought of a tough challenge might not be welcome at this point, because you’re almost certainly tired. But as the Greek philosopher Epictetus once said, “the greater the difficulty the more glory in surmounting it” – this is a biggie, but you’ll feel great when you’re done because you’ll have had to exercise so many of the skills you’ve learned over these past few months.

Although biometric authentication is an interesting topic – and certainly an important one if you happen to be on a team building apps for a bank! – the real highlights of these last days have been more Core Graphics practice and dipping a toe in Instruments. Both of these are skills that will last you years. Sure, you might not remember the exact code required to make clipping masks in Core Graphics, or the precise button to press in Instruments to find the problem you’re hunting for, but you know where to look, and, more importantly, you know what you’re looking for.

As you might have learned yourself, when you’re facing a problem half the battle is figuring out what you’re looking for – what words to use, or even vaguely what kind of UIKit class might contain your answer. Since this course started you’ve gained so much experience across so many of Apple’s frameworks, but you will already have forgotten half of it.

And you know what? That’s OK. In fact, that’s normal. What you haven’t lost is all the code you wrote, which you can use as a reference for all your projects going forward. You also haven’t lost the concepts – you’re used to the idea of a table view delegate now, just like you’re used to storyboards, or view controllers, or Codable, and more. Those are the things that last, and, helpfully, those are the things that matter.

Today you have three topics to work through, one of which of is your challenge.



---------- What you learned

Project 29 was a serious game with a lot going on, not least the dynamically rendered buildings with destructible terrain, the scene transitions and the UIKit/SpriteKit integration.

And in project 30 we took our first steps outside of Xcode and into Instruments. I could write a whole book on Instruments, partly because it’s extremely powerful, but also because it’s extremely complicated. As per usual, I tried to cherrypick things so you can see useful, practical benefits from what I was teaching, and certainly you have the skills now to be able to diagnose and result a variety of performance problems on iOS.

Here are some of the things you learned in this milestone:

- How to access the keychain using SwiftKeychainWrapper.

- How to force the keyboard to disappear by calling resignFirstResponder() on a text view. (And remember: it also works on text fields.)

- How to detect when your app is moving to the background by registering for the UIApplication.willResignActiveNotification notification.

- How to use LAContext from the LocalAuthentication framework to require Touch ID authentication.

- Using the stride() function to loop across a range of numbers using a specific increment, e.g. from 0 to 100 in tens.

- Creating colors using the hue, saturation, and brightness. As I said, keeping the saturation and brightness constant while choosing different hues helps you create similar color palettes easily.

- SpriteKit texture atlases. These are automatically made by Xcode if you place images into a folder with the .atlas extension, and are drawn significantly quicker than regular graphics.

- Using usesPreciseCollisionDetection to make collisions work better with small, fast-moving physics bodies.

- Transitioning between scenes with the presentScene() method and passing in a transition effect. We’ll be using this again in project 36, so you’ll have ample time to practice transitions.

- Using the blend mode .clear to erase parts of an image. Once that was done, we just recalculated the pixel-perfect physics to get destructible terrain.

- Adding dynamic shadows to views using layer.shadowRadius and other properties – and particularly how to use the layer.shadowPath property to save shadow calculation.

- The importance of using dequeueReusableCell(withIdentifier:) so that iOS can re-use cells rather than continually creating new ones.

- How the UIImage(named:) initializer has an automatic cache to help load common images. When you don’t need that, use the UIImage(contentsOfFile:) initializer instead.



---------- Key points

There are two things I’d like to review for this milestone.

First, the weak keyword. We used it in project 29 to add a property to our game scene:

weak var viewController: GameViewController!
We also added the opposite property to the game view controller:

var currentGame: GameScene!
This approach allowed the game scene to call methods on the view controller, and vice versa. At the time I explained why one was weak and the other was not – do you remember? I hope so, because it’s important!

There are four possibilities:

1. Game scene holds strong view controller and view controller holds strong game scene.

2. Game scene holds strong view controller and view controller holds weak game scene.

3. Game scene holds weak view controller and view controller holds weak game scene.

4. Game scene holds weak view controller and view controller holds strong game scene.

Remember, “strong” means “I want to own this; don’t let this memory be destroyed until I’m done with it,” and weak means “I want to use this but I don’t want to own it; I’m OK if it gets destroyed, so don’t keep it around on my account.”

Now, the view controller has an SKView, which is what renders SpriteKit content. That’s owned strongly, because obviously the view controller can’t really work without something to draw to. And that SKView has a scene property, which is the current SKScene visible on the screen. That’s also strongly owned. As a result, the view controller already - albeit indirectly – has strong ownership of the game scene.

As a result, both options 1 and 2 will cause a strong reference cycle, because they would cause the game scene to have a strong reference to something that has a strong reference back to the game scene. This isn’t necessarily bad as long as you remember to break the strong reference cycle, but let’s face it: why take the risk?

That leaves options 3 and 4: both have the game scene using a weak reference to the view controller, but one has a weak reference going back the other way and the other has a strong one. Which is better? Honestly, I’m not sure it matters: using a strong reference wouldn’t result in anything new because there’s already the indirect strong reference in place. So, use whichever you prefer!

The second thing I’d like to cover is much easier: it’s the UIImage(contentsOfFile:) initializer for UIImage. Like I said in project 30, the UIImage(named:) initializer has a built-in cache system to help load and store commonly used images – anything you load with that initializer will automatically be cached, and so load instantly if you request it again.

Of course, if you don’t want something to be cached, that’s the wrong solution, which is where UIImage(contentsOfFile:) comes in: give it a path and it will load the image, with no magic caching ever happening.

The downside is that UIImage(named:) automatically finds images inside your app bundle, whereas UIImage(contentsOfFile:) does not. So, you need to write code like this:

let path = Bundle.main.path(forResource: someImage, ofType: nil)!
imageView.image = UIImage(contentsOfFile: path)

That’s hardly a lot of code, but it’s never nice writing even simple repetitive code – and look at that force unwrap after path()! Wouldn’t it be great to get rid of it? I’m going to show you how to do just that, and, as a bonus, I’m also going to teach you something new: convenience initializers.

You’ve already seen initializers – we’ve used dozens of them. They are special methods that create things, like UILabel() or UIImage(named:). Swift has complex rules about its initializers, all designed to stop you trying to access something that hasn’t been created yet.

Fortunately, there’s one easy part, which is convenience initializers, which are effectively wrappers around basic initializers that are designed to make coding a bit more pleasant. A convenience initializer is able to do some work before calling a regular initializer, which in our case means we can add a wrapper around UIImage(contentsOfFile:) so that it’s nicer to call.

To make things even better, we’re also going to get rid of the force unwrap. Remember, path(forResource:) can return nil because the file you requested might not exist. Force unwrapping it works on occasion if you know something definitely exists, but it’s usually a better idea to use an alternative such as failable initializers.

You’ve already used failable initializers several times – both UIImage(named:) and UIImage(contentsOfFile:) are failable, for example. A failable initializer is one that might return a valid created object, or it might fail and return nil. We’re going to use this so that we can return nil if the image name can’t be found in the app bundle.

So, leveraging the power of Swift extensions that you learned in project 24, here’s a UIImage extension that creates a new, failable, convenience initializer called UIImage(uncached:). It works like UIImage(named:) in that you don’t need to provide the full bundle path, but it doesn’t have the downside of caching images you don’t intend to use more than once.

Here’s the code:

extension UIImage {
    convenience init?(uncached name: String) {
        if let path = Bundle.main.path(forResource: name, ofType: nil) {
            self.init(contentsOfFile: path)
        } else {
            return nil
        }
    }
}

Note the init? syntax that marks this as an initializer that returns an optional.



---------- Challenge

Your challenge is to create a memory pairs game that has players find pairs of cards – it’s sometimes called Concentration, Pelmanism, or Pairs. At the very least you should:

- Come up with a list of pairs. Traditionally this is two pictures, but you could also use capital cities (e.g. one card says France and its match says Paris), languages (e.g one card says “hello” and the other says “bonjour”), and so on.

- Show a grid of face-down cards. How many is down to you, but if you’re targeting iPad I would have thought 4x4 or more.

- Let the player select any two cards, and show them face up as they are tapped.

- If they match remove them; if they don’t match, wait a second then turn them face down again.

- Show a You Win message once all are matched.

You can use either SpriteKit or UIKit depending on which skill you want to practice the most, but I think you’ll find UIKit much easier.

Don’t under-estimate this challenge! To make it work you’re going to need to draw on a wide variety of skills, and it will push you. That’s the point, though, so take your time and give yourself space to think.

If you’re looking for a more advanced challenge, go for a variant of the game that uses word pairs and add a parental option that lets them create new cards. This would mean:

- Authenticating users using Touch ID or Face ID.

- Showing a new view controller that lists all existing cards and lets them enter a new card.

- You can use a UIAlertController with one or two text fields for your card entry, depending on what kind of game you’ve made.

Please go ahead and try to solve the challenge now. My hints are below, but please try to avoid reading them unless you’re really struggling.

- Start small. Seriously! Find something really simple that works, and only try something bigger or better once your simplest possible solution actually works.

- If you’re using UIKit, you could try to solve this using a UICollectionView. This gives you a natural grid, as well as touch handling for selecting cells, but make sure you think carefully about cells being re-used – this might prove more difficult than you thought.

- An easier approach is to lay out your cards much like we did with the word letters in project 8, 7 Swifty Words. You could show your card backs as a button image, then when the button is tapped show the other side of the card – which might be as simple as changing the picture and making the button’s text label have a non-clear color, or perhaps using Core Graphics to render the text directly onto the card front image.

- If you made the buttons work and want to try something fancier, you can actually create a flip animation to toggle between views – see my article How to flip a UIView with a 3D effect: transition(with:) for more information.

- In terms of tracking the game state it really only has three states: player has chosen zero cards, player has chosen one card (flip it over), and player has chosen two cards (flip the second one over). When they’ve chosen two cards you need to decide whether you have a match, then either remove the cards or flip them back down and go back to the first state.

- For the content to show, you can just type in a list of words/images into your code if you want, but you’re welcome to use Codable if you want to push yourself.

Again, this is not an easy challenge so please take your time and don’t feel bad when you find yourself having to look back at previous projects.