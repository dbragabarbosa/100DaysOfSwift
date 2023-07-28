Project 24, part two

If there’s one thing you need to know about language, it’s this: language is complicated. And that’s the number one reason 
why Swift’s strings are also complicated: they are designed to do the right thing by default, so you get support for all 
known languages, plus fantasy languages like Klingon and Elvish, and even emoji – all without having to do anything special.

Although this might seem like a pointless technicality, you’d do well to remember this quote from Frank Chimero: “people 
ignore design that ignores people.” Our job isn’t just to write great code and hope for the best, but instead to put our 
users needs front and centre all the time – to make sure we meet their needs and solve their problems.

If your software falls on the first hurdle – if it’s unable to handle their language – then you might as well not bother.

Today you should work through the wrap up chapter for project 24, complete its review, then work through all three of its challenges.



---------- Wrap up

Coming into this project you might thought strings were trivial, but I hope I’ve shown you that there’s more to them than 
meets the eye.

We’ve looked at how strings are different from arrays, how we can write useful extensions for strings, how Swift lets us 
combine functions together beautifully, and how NSAttributedString lets us add formatting to strings.

Of course, we’ve only just scratched the surface of strings here, but the challenges below will encourage you to write 
some extensions of your own so you get a better feel for how it works.


Challenge
One of the best ways to learn is to write your own code as often as possible, so here are three ways you should try your 
new knowledge to make sure you fully understand what’s going on:

1. Create a String extension that adds a withPrefix() method. If the string already contains the prefix it should return 
itself; if it doesn’t contain the prefix, it should return itself with the prefix added. 
For example: "pet".withPrefix("car") should return “carpet”.

2. Create a String extension that adds an isNumeric property that returns true if the string holds any sort of number. 
Tip: creating a Double from a String is a failable initializer.

3. Create a String extension that adds a lines property that returns an array of all the lines in a string. 
So, “this\nis\na\ntest” should return an array with four elements.