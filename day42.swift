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



---------- UICollectionView DATA SOURCES 

We’ve now modified the user interface so that it considers ViewController to be a collection view controller, but we haven’t 
implemented any of the data source methods to make that work. This works just like table views, so we get questions like “how 
many items are there?” and “what’s in item number 1?” that we need to provide sensible answers for.

To begin with, let's put together the most basic implementation that allows our app to work. Normally this would be straightforward, 
but here we have a small complication: when we call dequeueReusableCell(withReuseIdentifier:for:) we’ll be sent back a regular 
UICollectionViewCell rather than our custom PersonCell type.

We can fix that we’ll add a conditional typecast, but that adds a second problem: what do we do if our typecast fails? That 
is, what if we expected to get a PersonCell but actually got back a regular UICollectionViewCell instead? If this happens it 
means something is fundamentally broken in our app – we screwed up in the storyboard, probably. As a result, we need to get 
out immediately; there’s no point trying to make our app limp onwards when something is really broken.

Então, vamos usar uma nova função chamada fatalError(). Quando chamado, isso fará com que seu aplicativo falhe incondicionalmente - 
ele morrerá imediatamente e imprimirá qualquer mensagem que você fornecer a ele. Isso pode parecer horrível, mas:

1.Você só deve chamar isso quando as coisas estão realmente ruins e não quer continuar - é realmente apenas uma verificação 
de bom senso para garantir que tudo esteja como esperamos.

2.Swift knows that fatalError() always causes a crash, so we can use it to escape from a method that has a return value without 
sending anything back. This makes it really convenient to use in places like our current scenario.

It’s best if you see fatalError() in some real code, so add these two methods now:

override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 10
}

override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Person", for: indexPath) as? PersonCell else {
        // we failed to get a PersonCell – bail out!
        fatalError("Unable to dequeue PersonCell.")
    }

    // if we're still here it means we got a PersonCell, so we can return it
    return cell
}

Não analisamos nenhum desses códigos antes, então quero separá-lo em detalhes antes de continuar:

- collectionView(_:numberOfItemsInSection:)Isso deve retornar um inteiro e informa à visualização da coleção quantos itens você 
deseja mostrar em sua grade. Eu devolvi 10 deste método, mas em breve mudaremos para o uso de uma matriz.

- collectionView(_:cellForItemAt:) This must return an object of type UICollectionViewCell. We already designed a prototype in 
Interface Builder, and configured the PersonCell class for it, so we need to create and return one of these.

- dequeueReusableCell(withReuseIdentifier:for:)Isso cria uma célula de visualização de coleção usando a reutilização identificada 
que especificamos, neste caso "Pessoa", porque foi isso que digitamos no Interface Builder anteriormente. Mas, assim como as 
visualizações de tabela, esse método tentará reutilizar automaticamente as células de visualização de coleção, portanto, assim 
que uma célula sair da vista, ela poderá ser reciclada para que não tenhamos que continuar criando novas.

Note that we need to typecast our collection view cell as a PersonCell because we'll soon want to access its imageView and name outlets.

Esses dois novos métodos vêm de visualizações de coleção, mas acho que você os encontrará notavelmente semelhantes aos métodos 
de visualização de tabela que usamos até agora - você pode voltar e abrir o projeto 1 novamente para ver o quão semelhante!

Pressione Cmd+R para executar seu projeto agora, e você verá o início das coisas começar a se unir: a célula protótipo que você 
projetou no Interface Builder aparecerá 10 vezes, e você pode rolar para cima e para baixo para ver todas elas. Como você verá, 
você pode encaixar duas células na tela, que é o que torna a visualização da coleção diferente da visualização da tabela. Além 
disso, se você girar para a paisagem, verá que ela anima automaticamente (e lindamente) o movimento das células para que elas 
assumam a largura total.

