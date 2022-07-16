16/07/2022


MARCO: PROJETOS 4-6



---------- WHAT YOU LEARNED 

O Project 4 mostrou como é fácil criar aplicativos complexos: a estrutura WebKit da Apple contém um navegador 
da web completo que você pode incorporar em qualquer aplicativo que precise de HTML para ser exibido. Esse pode 
ser um pequeno trecho que você mesmo gerou, ou pode ser um site completo, como visto no projeto 4.

Depois disso, o projeto 5 mostrou como construir seu segundo jogo, ao mesmo tempo em que se esgueirava um pouco 
mais de prática com o UITableViewController. A partir do projeto 11, mudaremos para o SpriteKit para jogos, mas 
há muitos jogos que você também pode fazer no UIKit.

O WebKit é a segunda estrutura externa que usamos, depois da estrutura Social no projeto 3. Essas estruturas 
sempre oferecem muitas funcionalidades complexas agrupadas para uma finalidade, mas você também aprendeu 
muitas outras coisas:

- Delegation. We used this in project 4 so that WebKit events get sent to our ViewController class so that 
we can act on them.

- We used UIAlertController with its .actionSheet style to present the user with options to choose from. 
We gave it a .cancel button without a handler, which dismisses the options.

- You saw you can place UIBarButtonItems into the toolbarItems property, then have a UIToolbar shown by 
the navigation controller. We also used the .flexibleSpace button type to make the layout look better.

- Você conheceu a Observação de Valor-Chave, ou KVO, que usamos para atualizar o progresso do carregamento 
em nosso navegador da web. Isso permite que você monitore qualquer propriedade em todo o iOS e seja notificado 
quando ela mudar.

- Você aprendeu a carregar arquivos de texto do disco usando contentsOf.

- We added a text field to UIAlertController for the first time, then read it back using ac?.textFields?[0]. 
We’ll be doing this in several other projects in this series.

- Você mergulhou os dedos dos pés no mundo dos fechamentos mais uma vez. Essas são bestas complicadas 
quando você está aprendendo, mas neste momento da sua carreira Swift, pense nelas como funções que você 
pode passar em variáveis ou como parâmetros para outras funções.

- Você trabalhou com alguns métodos para manipulação de strings e matrizes: contains(), remove(at:)firstIndex(of:)

- Além disso, também mergulhamos profundamente no mundo do Layout Automático. Usamos isso brevemente nos 
projetos 1 e 2, mas agora você aprendeu mais maneiras de organizar seus projetos: Linguagem de Formato Visual 
e âncoras. Ainda há outras maneiras por vir, e em breve você começará a descobrir que prefere um método a 
outro - e tudo bem. Estou mostrando todos eles para que você possa encontrar o que funciona melhor para você, 
e todos nós temos nossas próprias preferências!



----------  KEY POINTS 

Há três peças de código que eu gostaria de revisitar porque elas têm um significado especial.

First, let’s consider the WKWebView from project 4. We added this property to the view controller:

var webView: WKWebView!

Em seguida, adicionou este novo método loadView():

override func loadView() {
    webView = WKWebView()
    webView.navigationDelegate = self
    view = webView
}

The loadView() method is often not needed, because most view layouts are loaded from a storyboard. 
However, it’s common to write part or all of your user interface in code, and for those times you’re 
likely to want to replace loadView() with your own implementation.

If you wanted a more complex layout – perhaps if you wanted the web view to occupy only part of the 
screen – then this approach wouldn’t have worked. Instead, you would need to load the normal storyboard 
view then use viewDidLoad() to place the web view where you wanted it.

As well as overriding the loadView() method, project 4 also had a webView property. This was important, 
because as far as Swift is concerned the regular view property is just a UIView.

Yes, we know it’s actually a WKWebView, but Swift doesn’t. So, when you want to call any methods on 
it like reload the page, Swift won’t let you say view.reload() because as far as it’s concerned UIView 
doesn’t have a reload() method.

Isso é o que a propriedade resolve: é como um typecast permanente para a view, de modo que, sempre que 
precisarmos manipular a visualização da web, possamos usar essa propriedade e a Swift nos permitirá.

O segundo código interessante é este, retirado do projeto 5:

if let startWords = try? String(contentsOf: startWordsURL) {
    allWords = startWords.components(separatedBy: "\n")
}

This combines if let and try? in the same expression, which is something you’ll come across a lot. 
The contentsOf initializer for strings lets you load some text from disk. If it succeeds you’ll get 
the text back, but if it fails Swift will complain loudly by throwing an exception.

You learned about try, try!, and try? some time ago, but I hope now you can see why it’s helpful to 
have all three around. What try? does is say, “instead of throwing an exception, just return nil if 
the operation failed.” And so, rather than contentsOf returning a String it will actually return a String? – 
it might be some text, or it might be nil. That’s where if let comes in: it checks the return value from 
contentsOf and, if it finds valid text, executes the code inside the braces.

O último código que eu gostaria de revisar é este:

view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat:"V:|[label1(labelHeight)]-[label2(
    labelHeight)]-[label3(labelHeight)]-[label4(labelHeight)]-[label5(labelHeight)]->=10-|", options: [],
     metrics: metrics, views: viewsDictionary))

Eu acho que - em apenas uma linha de código - demonstra as vantagens de usar a Linguagem de Formato Visual: 
ela alinha cinco rótulos, um acima do outro, cada um com a mesma altura, com uma pequena quantidade de espaço 
entre eles e 10 ou mais pontos de espaço no final.

Essa linha também demonstra a desvantagem da Linguagem de Formato Visual: ela tem uma tendência a se 
parecer com ruído de linha! Você precisa lê-lo com muito cuidado, às vezes pulando para frente e para 
frente, a fim de desfazer o que está tentando fazer. O VFL é a maneira mais rápida e fácil de resolver
muitos problemas de Layout Automático de maneira expressiva, mas à medida que você avança neste curso, 
aprenderá alternativas como o UIStackView, que podem fazer a mesma coisa sem a sintaxe complexa.



---------- CHALLENGE 

É hora de testar suas habilidades criando seu próprio aplicativo completo do zero. Desta vez, seu trabalho 
é criar um aplicativo que permita que as pessoas criem uma lista de compras adicionando itens a uma 
visualização de tabela.

The best way to tackle this app is to think about how you build project 5: it was a table view that 
showed items from an array, and we used a UIAlertController with a text field to let users enter free 
text that got appended to the array. That forms the foundation of this app, except this time you don’t 
need to validate items that get added – if users enter some text, assume it’s a real product and add 
it to their list.

Para pontos de bônus, adicione um item de botão da barra esquerda que limpe a lista de compras - 
qual método deve ser usado depois para fazer com que a visualização da tabela recarregue todos os seus dados?

Aqui estão algumas dicas caso você tenha problemas:

-Remember to change ViewController to build on UITableViewController, then change the storyboard to match.

- Create a shoppingList property of type [String] to hold all the items the user wants to buy.

- Create your UIAlertController with the style .alert, then call addTextField() to let the user enter text.

- When you have a new shopping list item, make sure you insert() it into your shoppingList 
array before you call the insertRows(at:) method of your table view – your app will crash if you 
do this the wrong way around.

- You might be tempted to try to use UIActivityViewController to share the finished shopping list 
by email, but if you do that you’ll hit a problem: you have an array of strings, not a single string.

Existe um método especial que pode criar uma string a partir de uma matriz, costurando cada parte 
usando um separador que você fornece. Vou entrar nisso no projeto 8, mas se você estiver interessado 
em experimentá-lo agora, aqui está um código para começar:

let list = shoppingList.joined(separator: "\n")

That will create a new list constant that is a regular string, with each shopping list item 
separated by “\n” – that’s Swift’s way of representing a new line.

