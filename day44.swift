06/09/2022


PROJECT 10, PART THREE 


That’s another app completed, and several more important components learned: collection views for grids, image 
pickers for browsing in the photo library, UUID for making unique identifiers, and more.

Nenhuma dessas são pequenas coisas: espero que você possa realmente ver seu progresso, e, estando tudo bem, você 
já está se preparando mentalmente para os desafios de fim de projeto que sempre temos.

Sei que esses desafios podem ser difíceis, mas quero incentivá-lo a continuar. Quando você obtém resultados, está 
aprendendo, mas quando comete erros, está aprendendo quase tanto - tudo conta e, como disse Denis Waitley, “os 
esultados que você alcançar estarão em proporção direta ao esforço que você aplicar”.

Hoje você deve trabalhar no capítulo de encerramento do projeto 10, concluir sua revisão e, em seguida, trabalhar 
em todos os seus três desafios.


---------- Wrap up 

UICollectionView and UITableView are the most common ways of showing lots of information in iOS, and you now know 
how to use both. You should be able to go back to project 1 and recognize a lot of very similar code, and that's 
by intention – Apple has made it easy to learn both view types by learning either one.

Você também aprendeu outro lote de desenvolvimento do iOS, desta vez UIImagePickerController, UUID, classes 
personalizadas e muito mais. Você pode não perceber ainda, mas tem conhecimento suficiente agora para criar 
uma enorme variedade de aplicativos!

Antes de terminarmos, você pode ter visto um problema com este aplicativo: se você sair do aplicativo e relançado, 
ele não se lembrou das pessoas que você adicionou. Pior, os JPEGs ainda estão armazenados no disco, então seu 
aplicativo ocupa cada vez mais espaço sem ter nada para mostrar!

Isso é bastante intencional, e algo que voltarei para consertar no projeto 12. 
Antes disso, vamos dar uma olhada em outro jogo...


---------- Desafio 

Uma das melhores maneiras de aprender é escrever seu próprio código com a maior frequência possível, então aqui 
estão três maneiras de experimentar seu novo conhecimento para garantir que você entenda completamente o que está 
acontecendo:

1. Add a second UIAlertController that gets shown when the user taps a picture, asking them whether they want to 
rename the person or delete them.

2. Try using picker.sourceType = .camera when creating your image picker, which will tell it to create a new image 
by taking a photo. This is only available on devices (not on the simulator) so you might want to check the return 
value of UIImagePickerController.isSourceTypeAvailable() before trying to use it!

3. Modifique o projeto 1 para que ele use um controlador de visualização de coleção em vez de um controlador de 
visualização de tabela. Eu recomendo que você mantenha uma cópia do seu código original do controlador de visualização 
de tabela para que você possa consultá-lo mais tarde.