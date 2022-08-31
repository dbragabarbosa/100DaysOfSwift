31/08/2022


PROJECT 10, PART ONE 


Today you have three topics to work through, and you’ll learn about UICollectionView and UICollectionViewCell.


----------- SETTING UP 

Este é um projeto divertido, simples e útil que permitirá que você crie um aplicativo para ajudar a armazenar nomes de pessoas que 
você conheceu. Se você é um viajante frequente, ou talvez apenas ruim em colocar nomes em rostos, este projeto será perfeito para você.

And yes, you'll be learning lots along the way: this time you'll meet UICollectionViewController, UIImagePickerController, Data, and UUID. 
Plus you'll get to do more with your old pals CALayer, UIAlertController, and closures. But above all, you're going to learn how to 
make a new data type from scratch for the first time.

Crie um novo projeto Single View App no Xcode, chame-o de Project10 e salve-o em algum lugar. Isso deve ser uma segunda natureza 
para você agora - você está se tornando um veterano!



----------- DESIGNING UICollectionView CELLS 

We’ve used UITableViewController a few times so far, but this time we’re going to use UICollectionViewController instead. The procedure 
is quite similar, and starts by opening ViewController.swift and making it inherit from UICollectionViewController instead.

Então, encontre esta linha:

class ViewController: UIViewController {

E mude para isso:

class ViewController: UICollectionViewController {

Agora abra o Main.storyboard no Interface Builder e exclua o controlador de visualização existente. Em seu lugar, arraste um Controlador 
de Visualização de Coleção (não uma visualização de coleção regular!), marque-o como o controlador de visualização inicial e 
incorpore-o dentro de um controlador de navegação. Certifique-se de também usar o inspetor de identidade para alterar sua classe 
para “ViewController” para que ele aponte para a nossa classe em código.

Use o esboço do documento para selecionar a visualização de coleção dentro do controlador de visualização de coleção, vá para 
o inspetor de tamanho e defina o Tamanho da Célula para ter a largura 140 e a altura 180. Agora defina as inserções de seção 
para superior, inferior, esquerda e direita para que todas sejam 10.

As visualizações de coleção são extremamente semelhantes às visualizações de tabela, com a exceção de que elas são exibidas 
como grades em vez de linhas simples. Mas, embora a tela seja diferente, as chamadas de método subjacentes são tão semelhantes 
que você provavelmente poderia mergulhar em si mesmo se quisesse! (Não se preocupe, no entanto: vou orientá-lo sobre isso.)

Nossa visualização de coleção já tem uma célula protótipo, que é o quadrado vazio que você verá no canto superior esquerdo. 
Isso funciona da mesma forma que com as visualizações de tabela - você lembrará que alteramos a célula inicial no projeto 7 
para que pudéssemos adicionar legendas.

Select that collection view cell now, then go to the attributes inspector: change its Background from "Default" (transparent) 
to white and give it the identifier “Person” so that we can reference it in code. Now place a UIImageView in there, with X:10, 
Y:10, width 120 and height 120. We'll be using this to show pictures of people's faces.

Place a UILabel in there too, with X:10, Y:134, width 120 and height 40. In the attributes inspector, change the label's font 
by clicking the T button and choosing "Custom" for font, "Marker Felt" for family, and "Thin" for style. Give it the font size 
16, which is 1 smaller than the default, then set its alignment to be centered and its number of lines property to be 2.

Até agora, este tem sido um trabalho de storyboard bastante comum, mas agora vamos fazer algo que nunca fizemos antes: criar uma 
classe personalizada para o nosso celular. Isso é necessário porque nossa célula de visualização de coleção tem duas visualizações 
que criamos - a visualização de imagem e o rótulo - e precisamos de uma maneira de manipular isso no código. A maneira de atalho 
seria dar-lhes tags exclusivas e dar-lhes variáveis quando o aplicativo for executado, mas vamos fazê-lo da maneira correta desta 
vez para que você possa aprender.

Go to the File menu and choose New > File, then select iOS > Source > Cocoa Touch Class and click Next. You'll be asked to fill in 
two text fields: where it says "Subclass of" you should enter "UICollectionViewCell", and where it says "Class" enter "PersonCell". 
Click Next then Create, and Xcode will create a new class called PersonCell that inherits from UICollectionViewCell.

Esta nova classe precisa ser capaz de representar o layout da visualização da coleção que acabamos de definir no Interface Builder, 
então ela só precisa de duas tomadas. Dê à classe estas duas propriedades:

@IBOutlet var imageView: UIImageView!
@IBOutlet var name: UILabel!
Agora volte para o Interface Builder e selecione a célula de visualização de coleção no esboço do documento. Selecione o inspetor 
de identidade (Cmd+Alt+3) e você verá ao lado da Classe a palavra "UICollectionViewCell" em texto cinza. Isso está nos dizendo que 
a célula é seu tipo de classe padrão.

Queremos usar nossa classe personalizada aqui, então digite "PersonCell" e clique em return. Você verá que "PersonCell" agora 
aparece no esboço do documento.

Now that Interface Builder knows that the cell is actually a PersonCell, we can connect its outlets. Go to the connections inspector 
(it's the last one, so Alt+Cmd+6) with the cell selected and you'll see imageView and name in there, both with empty circles to their 
right. That empty circle has exactly the same meaning as when you saw it with outlets in code: there is no connection between the 
storyboard and code for this outlet.

To make a connection from the connections inspector, just click on the empty circle next to imageView and drag a line over the view 
you want to connect. In our case, that means dragging over the image view in our custom cell. Now connect name to the label, 
and you're done with the storyboard.



---------- 