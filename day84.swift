Project 25, part two

There are a number of well-known quotes from Steve Jobs, but if I had to pick one – my all-time favorite – it would be 
this: “it is in Apple’s DNA that technology alone is not enough – it’s technology married with liberal arts, married with 
the humanities, that yields us the results that make our heart sing.”

Multipeer connectivity is another one of those frameworks that should set off sparks in your brain: “how can I use this 
make something great?” Honestly, I can’t answer that question for you. As Saint Steve said, technology alone is not 
enough – you won’t build something truly great just by shipping a thin layer over Apple’s APIs.

It’s easy to think to yourself, “what can I make that’s different from everything else?” What you ought to be thinking is 
“what unique perspective does my background and experience give me that lets me build a fresh take on an existing idea?” 
In 2015 (seven years after the App Store launched) Microsoft spent north of $100 million acquiring Wonderlist, which was – 
shock! – a to do list app.

What I’m saying is that your idea doesn’t need to be special, and really your code doesn’t need to be that special either. 
Because what matters – the part that makes our heart sing – is where you blend all that with what makes you you. 
If you’ve used 10 to do apps and none quite scratch the itch you have, it’s time for you to make your own. And with over 
a billion people out there using iOS, you’ll find that there are hundreds of thousands of people that have exactly that 
same itch, and would happily hand over a buck or two for your solution.

Whether your app idea ends up building on multipeer networking, iBeacons, Core Image, or more – it doesn’t matter. 
What matters is that you’re giving yourself the skills you need to build the app of your dreams, and you should be 
darned proud of yourself.

Today you should work through the wrap up chapter for project 25, complete its review, then work through all three of 
its challenges.



---------- Wrap up

Multipeer connectivity is something that used to be awfully hard, but in iOS it's less than 150 lines of code to produce 
this entire app – and over half of that is code for the collection view and the image picker!

The advantage it has compared to traditional data sharing over Wi-Fi is that multipeer can use an existing Wi-Fi network, 
or can silently create a new Wi-Fi network or even a Bluetooth network depending on what's available. All this is an 
implementation detail that Apple solves on your behalf – we don’t have to care how it works.


Challenge
One of the best ways to learn is to write your own code as often as possible, so here are three ways you should try your 
new knowledge to make sure you fully understand what’s going on:

1. Show an alert when a user has disconnected from our multipeer network. Something like “Paul’s iPhone has disconnected” 
is enough.

2. Try sending text messages across the network. You can create a Data from a string using Data(yourString.utf8), and 
convert a Data back to a string by using String(decoding: yourData, as: UTF8.self).

3. Add a button that shows an alert controller listing the names of all devices currently connected to the session – 
use the connectedPeers property of your session to find that information.