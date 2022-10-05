05/10/2022


Project 12, part two

Alan Perlis once said “fools ignore complexity; pragmatists suffer it; some can avoid it; geniuses remove it.” Today you’re 
going to see that in Swift code: rather than try to simplify the code for NSCoding, the Swift team found a way to remove it 
entirely using the Codable protocol.

Sometimes you won’t have a choice and need to use NSCoding, but where possible Codable is both easier and safer to use. 
You do need to know them both, though, and by seeing them both used to solve the same problem hopefully you’ll able to 
decide for yourself which you prefer.

Before you get down to work, here’s another fun Swift in-joke for you: sometimes you might see T-shirts with a picture of a 
fish followed by “able”, but before you scratch your head wondering what “fishable” might mean please remember that “COD” 
is a type of fish!

Today you should work through the Codable chapter and wrap up for project 12, complete its review, then work through all 
three of its challenges.



---------- Fixing Project 10: Codable

NSCodingé uma ótima maneira de ler e gravar dados ao usar UserDefaults, e é a opção mais comum quando você deve escrever 
código Swift que vive ao lado do código Objective-C.

However, if you’re only writing Swift, the Codable protocol is much easier. We already used it to load petition JSON back 
in project 7, but now we’ll be loading and saving JSON.

Existem três diferenças principais entre as duas soluções:

1. The Codable system works on both classes and structs. We made Person a class because NSCoding only works with classes, 
but if you didn’t care about Objective-C compatibility you could make it a struct and use Codable instead.

2. When we implemented NSCoding in the previous chapter we had to write encode() and init() calls ourself. With Codable 
this isn’t needed unless you need more precise control - it does the work for you.

3. When you encode data using Codable you can save to the same format that NSCoding uses if you want, but a much more 
pleasant option is JSON – Codable reads and writes JSON natively.

Todos os três combinados significam que você pode definir uma estrutura para armazenar dados e fazer com que o Swift crie 
instâncias dessa estrutura diretamente do JSON sem nenhum trabalho extra de você.

Anyway, to demonstrate more of Codable in action I’d like you to close project12a and open project12b – this should be 
identical to project 10, because it doesn’t contain any of the NSCoding changes.

First, let’s modify the Person class so that it conforms to Codable:

class Person: NSObject, Codable {
…and that’s it. Yes, just adding Codable to the class definition is enough to tell Swift we want to read and write this 
thing. So, now we can go back to ViewController.swift and add code to load and save the people array.

As with NSCoding we’re going to create a single save() method we can use anywhere that's needed. This time it’s going to 
use the JSONEncoder class to convert our people array into a Data object, which can then be saved to UserDefaults. This 
conversion might fail, so we’re going to use if let and try? so that we save data only when the JSON conversion was 
successful.

Adicione este método ao ViewController.swift agora:

func save() {
    let jsonEncoder = JSONEncoder()
    if let savedData = try? jsonEncoder.encode(people) {
        let defaults = UserDefaults.standard
        defaults.set(savedData, forKey: "people")
    } else {
        print("Failed to save people.")
    }
}

Just like with the NSCoding example you need to modify our collection view's didSelectItemAt method so that you call 
self?.save() just after calling self.collectionView.reloadData(). Again, remember that adding self is required because 
we're inside a closure. You then need to modify the image picker's didFinishPickingMediaWithInfo method so that it calls 
save() just before the end of the method.

Finalmente, precisamos carregar a matriz de volta do disco quando o aplicativo for executado, então adicione este código 
toviewDidLoadviewDidLoad():

let defaults = UserDefaults.standard

if let savedPeople = defaults.object(forKey: "people") as? Data {
    let jsonDecoder = JSONDecoder()

    do {
        people = try jsonDecoder.decode([Person].self, from: savedPeople)
    } catch {
        print("Failed to load people")
    }
}

This code is effectively the save() method in reverse: we use the object(forKey:) method to pull out an optional Data, 
using if let and as? to unwrap it. We then give that to an instance of JSONDecoder to convert it back to an object graph – 
i.e., our array of Person objects.

Once again, note the interesting syntax for decode() method: its first parameter is [Person].self, which is Swift’s way 
of saying “attempt to create an array of Person objects.” This is why we don’t need a typecast when assigning to people – 
that method will automatically return [People], or if the conversion fails then the catch block will be executed instead.



---------- Wrap up

You will use UserDefaults in your projects. That isn't some sort of command, just a statement of inevitability. If you 
want to save any user settings, or if you want to save program settings, it's just the best place for it. And I hope 
you'll agree it is (continuing a trend!) easy to use and flexible, particularly when your own classes conform to Codable.

As you saw, the NSCoding protocol is also available. Yes, it takes extra work to use, and can be quite annoying when 
your data types have lots of properties you need to save, but it does have the added benefit of Objective-C compatibility 
if you have a mixed codebase.

One proviso you ought to be aware of: please don't consider UserDefaults to be safe, because it isn't. If you have user 
information that is private, you should consider writing to the keychain instead – something we'll look at in project 28.


Challenge

One of the best ways to learn is to write your own code as often as possible, so here are three ways you should try your 
new knowledge to make sure you fully understand what’s going on:

1. Modify project 1 so that it remembers how many times each storm image was shown – you don’t need to show it anywhere, 
but you’re welcome to try modifying your original copy of project 1 to show the view count as a subtitle below each image 
name in the table view.

2. Modify project 2 so that it saves the player’s highest score, and shows a special message if their new score beat the 
previous high score.

3. Modify project 5 so that it saves the current word and all the player’s entries to UserDefaults, then loads them back 
when the app launches.