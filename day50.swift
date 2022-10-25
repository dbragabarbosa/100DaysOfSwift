12/09/2022


Milestone: Projects 10-12

It’s time for another consolidation day, which means you have lots to review, lots to dig into, and a fresh programming 
challenge too. I’ve mentioned before the importance of repetition, so I hope you’re able to seize this opportunity to try 
your hand at something new that helps you apply your new knowledge practically.

Aristotle once said, “it is frequent repetition that produces a natural tendency.” And that’s our goal with this 
repetition: to bake knowledge of Swift and iOS so deep into your head and hands that you can start to build things 
without second guessing yourself. So, when it comes to writing code for your own projects, or even writing code during 
an iOS interview, you know for sure that you’ve got it in hand – you can do it, because you’ve done it 20 times before.

So, make sure you work through today’s challenge fully: experiment and see what you can make!

Today you have three topics to work through, one of which of is your challenge.



---------- What you learned 

Você provavelmente ainda não percebeu, mas os projetos que acabou de concluir foram alguns dos mais importantes da série. 
Os resultados finais são bons o suficiente, mas o que eles ensinam é mais importante - você fez sua primeira aula 
completamente do zero, que é como você enfrentará muitos, muitos problemas no futuro:

- You met UICollectionView and saw how similar it is to UITableView. Sure, it displays things in columns as well as rows, 
but the method names are so similar I hope you felt comfortable using it.

- You also designed a custom UICollectionViewCell, first in the storyboard and then in code. Table views come with several 
useful cell types built in, but collection views don’t so you’ll always need to design your own.

- We used UIImagePickerController for the first time in this project. It’s not that easy to use, particularly in the way 
it returns its selected to you, but we’ll be coming back to it again in the future so you’ll have more chance to practice.

- The UUID data type is used to generate universally unique identifiers, which is the easiest way to generate filenames 
that are guaranteed to be unique. We used them to save images in project 10 by converting each UIImage to a Data that 
could be written to disk, using jpegData().

- You met Apple’s appendingPathComponent() method, as well as my own getDocumentsDirectory() helper method. Combined, 
these two let us create filenames that are saved to the user’s documents directory. You could, in theory, create the 
filename by hand, but using appendingPathComponent() is safer because it means your code won’t break if things change 
in the future.

O Projeto 11 foi o primeiro jogo que fizemos usando o SpriteKit, que é a estrutura de jogos 2D de alto desempenho da 
Apple. Introduziu uma enorme variedade de coisas novas:

- The SKSpriteNode class is responsible for loading and drawing images on the screen.

- You can draw sprites using a selection of blend modes. We used .replace for drawing the background image, which causes 
SpriteKit to ignore transparency. This is faster, and perfect for our solid background image.

- You add physics to sprite nodes using SKPhysicsBody, which has rectangleOf and circleWithRadius initializers that 
create different shapes of physics bodies.

- Adicionar ações a coisas, como girar ou remover do jogo, é feito usando o SKAction.

- Os ângulos geralmente são medidos em radianos usando CGFloat.

Lastly, you also met UserDefaults, which lets you read and write user preferences, and gets backed up to iCloud 
automatically. You shouldn’t abuse it, though: try to store only the absolute essentials in UserDefaults to avoid 
causing performance issues. In fact, tvOS limits you to just 500KB of UserDefaults storage, so you have no choice!

For the times when your storage needs are bigger, you should either use the Codable protocol to convert your objects to 
JSON, or use NSKeyedArchiver and NSKeyedUnarchiver. These convert your custom data types into a Data object that you can 
read and write to disk.



---------- Key points 