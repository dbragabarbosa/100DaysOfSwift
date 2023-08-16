Project 28, part one

Bruce Schneier – a well-known US cryptographer, security analyst, and writer, once said “if you think technology can solve 
your security problems, then you don't understand the problems and you don't understand the technology.”

You see, although computers are remarkable machines, ultimately they just do what we tell them – albeit extraordinarily 
quickly. Way back in 2004, a Windows compression program called WinZip added AES encryption to their software, to help 
folks keep their data secure. AES was (and still is) a worldwide standard for quality encryption, but the problem was that 
WinZip screwed up their implementation so they managed to make it insecure. Back then, Bruce Schneier was already a titan 
in the security industry, and he said this: “cryptography is hard, and simply using AES in a product does not magically 
make it secure.”

Fast forward to today, and you’ve already learned how to store user data using UserDefaults, but there’s a problem: just 
putting data into UserDefaults does not magically make it secure. In fact, UserDefaults is anything but secure – it’s 
possible to get data out of there easily, so it’s definitively the wrong place to store sensitive information.

To fix that – to put data somewhere safe – you need to learn how to use the iOS keychain, which is automatically encrypted 
by the system. To make things a little more spicy I’ll also be introducing you to biometric authentication, which is a 
fancy way of saying you’ll learn how to use Touch ID and Face ID.

Today you have four topics to work through, and you’ll learn about the LocalAuthentication framework and the iOS 
keychain, get some practice with UITextView, and more.