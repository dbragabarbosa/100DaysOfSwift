11/05/2022


PROJECT 1, PART ONE 


---------- 1. SETTING UP 

Neste projeto, você produzirá um aplicativo que permite que os usuários percorrem uma lista de imagens e, em seguida, 
selecionem uma para visualizar. É deliberadamente simples, porque há muitas outras coisas que você precisará aprender 
ao longo do caminho, então prenda-se - isso vai ser longo!

Inicie o Xcode e escolha "Criar um novo projeto Xcode" na tela de boas-vindas. Escolha Aplicativo de Visualização Única na 
lista e clique em Próximo. Para Nome do Produto, digite Project1 e, em seguida, certifique-se de ter Swift selecionado para o idioma.

Criando um novo projeto de aplicativo de visualização única no Xcode.

Um dos campos que serão solicitados é "Identificador de Organização", que é um identificador exclusivo geralmente composto pelo 
nome de domínio pessoal do seu site ao contrário. Por exemplo, eu usaria com.hackingwithswift se estivesse criando um aplicativo. 
Você precisará colocar algo válido lá se estiver implantando em dispositivos, mas, caso contrário, você pode simplesmente usar com.example.

Nota importante: alguns modelos de projeto do Xcode têm caixas de seleção dizendo "Usar Dados Principais", "Incluir Testes Unitários" e 
"Incluir Testes de UI". Certifique-se de que essas caixas estejam desmarcadas para este projeto e, de fato, para quase todos os projetos 
desta série - há apenas um projeto em que esse não é o caso, e ficou bem claro lá!

Agora clique em Avançar novamente e você será perguntado onde deseja salvar o projeto - sua área de trabalho está bem. 
Uma vez feito isso, você verá o projeto de exemplo que o Xcode fez para você. A primeira coisa que precisamos fazer é garantir que 
você tenha tudo configurado corretamente, e isso significa executar o projeto como está.

Ao executar um projeto, você pode escolher que tipo de dispositivo o Simulador iOS deve fingir ser, ou também pode selecionar um 
dispositivo físico se tiver um conectado. Essas opções estão listadas no menu Produto > Destino, e você deve ver iPad Air, iPhone 8 
e assim por diante.

Há também um atalho para este menu: no canto superior esquerdo da janela do Xcode está o botão reproduzir e parar, mas à direita disso 
deve dizer Project1 e depois um nome de dispositivo. Você pode clicar no nome do dispositivo para selecionar outro dispositivo.

Por enquanto, escolha iPhone XR e clique no botão Reproduzir triângulo no canto superior esquerdo. Isso compilará seu código, que é o 
processo de convertê-lo em instruções que os iPhones podem entender, depois iniciar o simulador e executar o aplicativo. 
Como você verá quando interagir com o aplicativo, nosso "aplicativo" mostra apenas uma grande tela branca - ele não faz nada, pelo menos ainda não.

O projeto básico do aplicativo Single View no Xcode. Sim, é apenas um grande espaço em branco.

Você começará e interromperá muito os projetos à medida que aprende, então há três dicas básicas que você precisa saber:

Você pode executar seu projeto pressionando Cmd+R. Isso é equivalente a clicar no botão play.
Você pode parar um projeto em execução pressionando Cmd+. quando o Xcode estiver selecionado.
Se você fez alterações em um projeto em execução, basta pressionar Cmd+R novamente. O Xcode solicitará que você interrompa 
a execução atual antes de iniciar outra. Certifique-se de marcar a caixa "Não mostrar esta mensagem novamente" para evitar ser incomodado no futuro.
Este projeto tem tudo a ver com permitir que os usuários selecionem imagens para visualizar, então você precisará importar algumas imagens. 
Baixe os arquivos para este projeto do GitHub (https://github.com/twostraws/HackingWithSwift) e procure na pasta "projeto1-arquivos". 
Você verá outra pasta lá chamada Conteúdo, e eu gostaria que você arrastasse essa pasta Conteúdo diretamente para o seu projeto Xcode, 
logo abaixo de onde diz "Info.plist".

Dica: Se você não tem certeza do que baixar, use este link: https://github.com/twostraws/HackingWithSwift/archive/main.zip - 
esse é o arquivo zip para todos os arquivos do meu projeto.

Uma janela aparecerá perguntando como você deseja adicionar os arquivos: verifique se a opção "Copiar itens, se necessário" 
está marcada e "Criar grupos" está selecionada. Importante: não escolha "Criar referências de pasta", caso contrário, seu projeto não funcionará.

Ao adicionar itens ao Xcode, certifique-se de escolher Criar Referências de Pasta.

Clique em Concluir e você verá uma pasta de Conteúdo amarela aparecer no Xcode. Se você vir um azul, não selecionou 
"Criar grupos" e terá problemas para seguir este tutorial!



---------- 2. LISTING IMAGES WITH FileManager

As imagens que lhe forneci vêm da Administração Nacional Oceânica e Atmosférica (NOAA), que é uma agência do governo dos EUA e, 
portanto, produz conteúdo de domínio público que podemos reutilizar livremente. Depois que forem copiados para o seu projeto, 
o Xcode os incorporará automaticamente ao seu aplicativo finalizado para que você possa acessá-los.

Nos bastidores, um aplicativo iOS é na verdade um diretório que contém muitos arquivos: o próprio binário (essa é a versão compilada 
do seu código, pronta para ser executada), todos os ativos de mídia que seu aplicativo usa, quaisquer arquivos de layout visual que 
você tenha, além de uma variedade de outras coisas, como metadados e direitos de segurança.

Esses diretórios de aplicativos são chamados de pacotes e têm a extensão de arquivo .app. Como nossos arquivos de mídia estão soltos 
dentro da pasta, podemos pedir ao sistema que nos informe todos os arquivos que estão lá e, em seguida, retire os que queremos. 
Você deve ter notado que todas as imagens começam com o nome "nssl" (abreviação de National Severe Storms Laboratory), então nossa 
tarefa é simples: liste todos os arquivos no diretório do nosso aplicativo e retire os que começam com "nssl".

Por enquanto, carregaremos essa lista e a imprimiremos no visualizador de log integrado do Xcode, mas em breve as faremos aparecer 
em nosso aplicativo.

Então, passo 1: abra ViewController.swift. Um controlador de visualização é melhor pensado como sendo uma tela de informações, 
e para nós isso é apenas uma grande tela em branco. ViewController.swift é responsável por mostrar essa tela em branco, e agora 
ela não conterá muito código. Você deveria ver algo assim:

import UIKit

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
}

Isso contém quatro coisas interessantes que eu quero discutir antes de seguir em frente.

1. O arquivo começa com a import UIKit, o que significa que "este arquivo fará referência ao kit de ferramentas da interface do usuário do iOS".

2. The class ViewController: UIViewController line means “I want to create a new screen of data called ViewController, 
based on UIViewController.” When you see a data type that starts with “UI”, it means it comes from UIKit. UIViewController 
is Apple’s default screen type, which is empty and white until we change it.

3. The line override func viewDidLoad() starts a method. As you know, the override keyword is needed because it means 
“we want to change Apple’s default behavior from UIViewController.” viewDidLoad() is called by UIKit when the screen has 
loaded, and is ready for you to customize.

4. The viewDidLoad() method contains one line of code saying super.viewDidLoad() and one line of comment 
(that’s the line starting with //). This super call means “tell Apple’s UIViewController to run its own code before 
I run mine,” and you’ll see this used a lot.

Voltaremos muito a esse código em projetos futuros; não se preocupe se estiver tudo um pouco nebuloso agora.

Sem números de linha? Enquanto você está lendo o código, é frequentemente útil ter os números de linha ativados para que você 
possa consultar um código específico com mais facilidade. Se o seu Xcode não estiver mostrando números de linha por padrão, 
sugiro que você os ative agora: vá para o menu Xcode e escolha Preferências, depois escolha a guia Edição de Texto e verifique 
se "Números de linha" está marcada.

As I said before, the viewDidLoad() method is called when the screen has loaded and is ready for you to customize. 
We're going to put some more code into that method to load the NSSL images. Add this beneath the line that says super.viewDidLoad():

let fm = FileManager.default
let path = Bundle.main.resourcePath!
let items = try! fm.contentsOfDirectory(atPath: path)

for item in items {
    if item.hasPrefix("nssl") {
        // this is a picture to load!
    }
}

Note: Some experienced Swift developers will read that code, see try!, then write me an angry email. 
If you’re considering doing just that, please continue reading first.

Esse é um grande pedaço de código, a maioria dos quais é nova. Vamos ver o que ele faz linha por linha:

- The line let fm = FileManager.default declares a constant called fm and assigns it the value returned by FileManager.default. 
This is a data type that lets us work with the filesystem, and in our case we'll be using it to look for files.

- The line let path = Bundle.main.resourcePath! declares a constant called path that is set to the resource path of our app's bundle. 
Remember, a bundle is a directory containing our compiled program and all our assets. So, this line says, "tell me where I can find all 
those images I added to my app."

- The line let items = try! fm.contentsOfDirectory(atPath: path) declares a third constant called items that is set to the contents 
of the directory at a path. Which path? Well, the one that was returned by the line before. As you can see, Apple's long method names 
really does make their code quite self-descriptive! The items constant will be an array of strings containing filenames.

- The line for item in items { starts a loop that will execute once for every item we found in the app bundle. Remember: 
the line has an opening brace at the end, signaling the start of a new block of code, and there's a matching closing brace four 
lines beneath. Everything inside those braces will be executed each time the loop goes around.

- The line if item.hasPrefix("nssl") { is the first line inside our loop. By this point, we'll have the first filename ready to work with, 
and it'll be called item. To decide whether it's one we care about or not, we use the hasPrefix() method: it takes one parameter (the prefix 
to search for) and returns either true or false. That "if" at the start means this line is a conditional statement: if the item has the prefix 
"nssl", then… that's right, another opening brace to mark another new code block. This time, the code will be executed only if hasPrefix() 
returned true.

- Finally, the line // this is a picture to load! is a comment – if we reach here, item contains the name of a 
picture to load from our bundle, so we need to store it somewhere.

Neste caso, não há problema em usar Bundle.main.resourcePath! e try!, porque se esse código falhar, significa que nosso aplicativo 
não pode ler seus próprios dados, então algo deve estar seriamente errado. Alguns desenvolvedores Swift tentam escrever código para 
lidar com esses erros catastróficos em tempo de execução, mas infelizmente muitas vezes eles apenas mascaram o problema real que ocorreu.

No momento, nosso código carrega a lista de arquivos que estão dentro do nosso pacote de aplicativos e, em seguida, percorre todos 
eles para encontrar aqueles com um nome que começa com "nssl". No entanto, na verdade, ele não faz nada com esses arquivos, então 
nosso próximo passo é criar uma matriz de todas as imagens "nssl" para que possamos consultá-las mais tarde, em vez de ter que reler 
o diretório de recursos várias vezes.

The three constants we already created – fm, path, and items – live inside the viewDidLoad() method, and will be destroyed as soon 
as that method finishes. What we want is a way to attach data to the whole ViewController type so that it will exist for as long as 
our screen exists. So, this a perfect example of when to use a property – we can give our ViewController class as many of these 
properties as we want, then read and write them as often as needed while the screen exists.

To create a property, you need to declare it outside of methods. We’ve been creating constants using let so far, but this array 
is going to be changed inside our loop so we need to make it variable. We also need to tell Swift exactly what kind of data it will 
hold – in our case that’s an array of strings, where each item will be the name of an “nssl” picture.

Adicione esta linha de código antes de viewDidLoad():

var pictures = [String]()
Se você o colocou corretamente, seu código deve ficar assim:

class ViewController: UIViewController {
    var pictures = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()

        let fm = FileManager.default

That pictures array will be created when the ViewController screen is created, and exist for as long as the screen exists. 
It will be empty, because we haven’t actually filled it with anything, but at least it’s there ready for us to fill.

What we really want is to add to the pictures array all the files we match inside our loop. To do that, we need to replace the existing 
// this is a picture to load! comment with code to add each picture to the pictures array.

Helpfully, Swift’s arrays have a built-in method called append that we can use to add any items we want. So, replace the 
// this is a picture to load! comment with this:

pictures.append(item)

É isso aí! Irritantemente, depois de todo esse trabalho, nosso aplicativo não parecerá fazer nada quando você pressionar play -
 você verá a mesma tela branca de antes. Funcionou ou as coisas falharam silenciosamente?

Para descobrir, adicione esta linha de código no final de viewDidLoad(), pouco antes da chave de fechamento:

print(pictures)

That tells Swift to print the contents of pictures to the Xcode debug console. When you run the program now, you should see this 
text appear at the bottom of your Xcode window: //“["nssl0033.jpg", "nssl0034.jpg", "nssl0041.jpg", "nssl0042.jpg", "nssl0043.jpg", 
// "nssl0045.jpg", "nssl0046.jpg", "nssl0049.jpg", "nssl0051.jpg", "nssl0091.jpg”]” 

Nota: o iOS gosta de imprimir muitas mensagens de depuração desinteressantes no console de depuração do Xcode. Não se preocupe se 
você vir muitos outros textos lá que você não reconhece - basta rolar até ver o texto acima, e se você vir isso, então você está pronto para ir.



---------- 3. DESIGNING OUR INTERFACE 

Our app loads all the storm images correctly, but it doesn’t do anything interesting with them – printing to the Xcode console is helpful for 
debugging, but I can promise you it doesn’t make for a best-selling app!

To fix this, our next goal is to create a user interface that lists the images so users can select one. UIKit – 
the iOS user interface framework – has a lot of built-in user interface tools that we can draw on to build powerful 
apps that look and work the way users expect.

For this app, our main user interface component is called UITableViewController. It’s based on UIViewController – 
Apple’s most basic type of screen – but adds the ability to show rows of data that can be scrolled and selected. 
You can see UITableViewController in the Settings app, in Mail, in Notes, in Health, and many more – it’s powerful, 
flexible, and extremely fast, so it’s no surprise it gets used in so many apps.

Our existing ViewController screen is based on UIViewController, but what we want is to have it based on UITableViewController instead. 
This doesn’t take much to do, but you’re going to meet a new part of Xcode called Interface Builder.

We’ll get on to Interface Builder in a moment. First, though, we need to make a tiny change in ViewController.swift. Find this line:

class ViewController: UIViewController {

That’s the line that says “create a new screen called ViewController and have it build on Apple’s own UIViewController screen.” 
I want you to change it to this:

class ViewController: UITableViewController {

It’s only a small difference, but it’s an important one: it means ViewController now inherits its functionality from
 UITableViewController instead of UIViewController, which gives us a huge amount of extra functionality for free as you’ll see in a moment.

Behind the scenes, UITableViewController still builds on top of UIViewController – this is called a “class hierarchy”, and is a 
common way to build up functionality quickly.

We’ve changed the code for ViewController so that it builds on UITableViewController, but we also need to change the user interface to match. 
User interfaces can be written entirely in code if you want – and many developers do just that – but more commonly they are created 
using a graphical editor called Interface Builder. We need to tell Interface Builder (usually just called “IB”) that ViewController 
is a table view controller, so that it matches the change we just made in our code.

Up to this point we’ve been working entirely in the file ViewController.swift, but now I’d like you to use the project navigator 
(the pane on the left) to select the file Main.storyboard. Storyboards contain the user interface for your app, and let you visualize 
some or all of it on a single screen.

When you select Main.storyboard, you’ll switch to the Interface Builder visual editor, and you should see something like the picture below:

The Single View App template gives you one large, empty canvas to draw on.

That big white space is what produces the big white space when the app runs. If you drop new components into that space, 
they would be visible when the app runs. However, we don’t want to do that – in fact, we don’t want that big white space at 
all, so we’re going to delete it.

The best way to view, select, edit, and delete items in Interface Builder is to use the document outline, but there’s a good 
chance it will be hidden for you so the first thing to do is show it. Go to the Editor menu and choose Show Document Outline – 
it’s probably the third option from the top. If you see Hide Document Outline instead, it means the document outline is already visible.

The document outline shows you all the components in all the screens in your storyboard. You should see “View Controller Scene” 
already in there, so please select it, then press Backspace on your keyboard to remove it.

Instead of a boring old UIViewController, we want a fancy new UITableViewController to match the change we made in our code. 
To create one, press Cmd+Shift+L to show the object library. Alternatively, if you dislike keyboard shortcuts you can go to 
the View menu and choose Libraries > Show Library instead.

The object library floats over the Xcode window, and contains a selection of graphical components that you can drag out and 
re-arrange to your heart’s content. It contains quite a lot of components, so you might find it useful to enter a few letters 
into the “Objects” box to slim down the selection.

Tip: If you want the object library to remain open after you drag something out, use Alt+Cmd+Shift+L and it will be a movable, 
resizable window when it appears.

Right now, the component we want is called Table View Controller. If you type “table” into the Filter box you’ll see Table View Controller, 
Table View, and Table View Cell. They are all different things, so please make sure you choose the Table View Controller – 
it has a yellow background in its icon.

Click on the Table View Controller component, then drag it out into the large open space that exists where the previous view 
controller was. When you let go to drop the table view controller onto the storyboard canvas, it will transform into a screen that 
looks like the below:


-  Toques finais para a interface do usuário
Antes de terminarmos aqui, precisamos fazer algumas pequenas mudanças.

Primeiro, precisamos dizer ao Xcode que este controlador de visualização de tabela de storyboard é o mesmo que temos em código dentro 
do ViewController.swift. Para fazer isso, pressione Alt+Cmd+3 para ativar o inspetor de identidade (ou vá para Exibir > Utilitários > 
Mostrar Inspetor de Identidade) e, em seguida, procure na parte superior de uma caixa chamada "Classe". Ele terá "UITableViewController" 
escrito lá em texto cinza claro, mas se você clicar na seta no lado direito, verá um menu suspenso que contém "ViewController" - 
selecione isso agora.

Em segundo lugar, precisamos dizer ao Xcode que este novo controlador de visualização de tabela é o que deve ser mostrado quando o 
aplicativo for executado pela primeira vez. Para fazer isso, pressione Alt+Cmd+4 para ativar o inspetor de atributos (ou vá para 
Exibir > Utilitários > Mostrar Inspetor de Atributos), procure a caixa de seleção chamada "É o Controlador de Visualização Inicial" 
e verifique se está marcada.

Em terceiro lugar, quero que você use o esboço do documento para olhar dentro do novo controlador de visualização de tabela. 
Dentro, você deve ver que contém uma "Visualização de Tabela", que por sua vez contém "Célula". Uma célula de visualização de tabela 
é responsável por exibir uma linha de dados em uma tabela, e vamos exibir um nome de imagem em cada célula.

Selecione "Célula" e, no inspetor de atributos, insira o texto "Imagem" no campo de texto marcado Identificador. Enquanto estiver lá, 
altere a opção Estilo na parte superior do inspetor de atributos - deve ser Personalizado agora, mas altere-o para Básico.

Finalmente, vamos colocar todo esse controlador de visualização de mesa dentro de outra coisa. É algo com o qual não precisamos 
configurar ou nos preocupar, mas é um elemento extremamente comum da interface do usuário no iOS e acho que você o reconhecerá 
imediatamente. É chamado de controlador de navegação, e você o vê em ação em aplicativos como Configurações e Mail - ele fornece a 
fina barra cinza na parte superior da tela e é responsável por essa animação deslizante da direita para a esquerda que acontece 
quando você se move entre as telas no iOS.

Para colocar nosso controlador de visualização de tabela em um controlador de navegação, tudo o que você precisa fazer é acessar o 
menu Editor e escolher Incorporar > Controlador de Navegação. O Interface Builder moverá seu controlador de visualização existente 
para a direita e adicionará um controlador de navegação em torno dele - você deve ver uma barra cinza simulada acima da sua visualização 
de tabela agora. Ele também moverá a propriedade "É o Controlador de Visualização Inicial" para o controlador de navegação.

Neste ponto, você já fez o suficiente para dar uma olhada nos resultados do seu trabalho: pressione o botão play do Xcode agora ou 
pressione Cmd+R se quiser se sentir um pouco elite. Depois que seu código for executado, agora você verá a caixa branca simples 
substituída por uma grande visualização de tabela vazia. Se você clicar e arrastar o mouse, ele verá rolar e saltar como seria de 
esperar, embora obviamente ainda não haja dados lá. Você também deve ver uma barra de navegação cinza na parte superior; isso será 
importante mais tarde.


- Mostrando muitas linhas
The next step is to make the table view show some data. Specifically, we want it to show the list of “nssl” pictures, one per row. 
Apple’s UITableViewController data type provides default behaviors for a lot of things, but by default it says there are zero rows.

Our ViewController screen builds on UITableViewController and gets to override the default behavior of Apple’s table view to provide 
customization where needed. You only need to override the bits you want; the default values are all sensible.

Para que a tabela mostre nossas linhas, precisamos substituir dois comportamentos: quantas linhas devem ser mostradas e o que cada 
linha deve conter. Isso é feito escrevendo dois métodos especialmente nomeados, mas quando você é novo no Swift, eles podem parecer 
um pouco estranhos no início. Para garantir que todos possam acompanhar, vou levar isso devagar - afinal, este é o primeiro projeto!

Let’s start with the method that sets how many rows should appear in the table. Add this code just after the end of viewDidLoad() – 
if you start typing “numberof” then you can use Xcode’s code completion to do most of the work for you:

override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return pictures.count
}

Observação: isso precisa ser após o final de viewDidLoad(), o que significa após sua chave de fechamento.

Esse método contém a palavra "visão de tabela" três vezes, o que é profundamente confuso no início, então vamos detalhar o que isso significa.

- The override keyword means the method has been defined already, and we want to override the existing behavior with this new behavior. 
If you didn't override it, then the previously defined method would execute, and in this instance it would say there are no rows.

- The func keyword starts a new function or a new method; Swift uses the same keyword for both. Technically speaking a method is a 
function that appears inside a class, just like our ViewController, but otherwise there’s no difference.

- O nome do método vem a seguir: tableView. Isso não parece muito útil, mas a maneira como a Apple define métodos é garantir que as 
informações que são passadas para eles - os parâmetros - sejam nomeadas de forma útil e, neste caso, a primeira coisa que é passada 
é a visualização da tabela que acionou o código. Uma visualização de tabela, como você deve ter percebido, é a coisa de rolagem que 
conterá todos os nossos nomes de imagem e é um componente central do iOS.

- As promised, the next thing to come is tableView: UITableView, which is the table view that triggered the code. But this contains 
two pieces of information at once: tableView is the name that we can use to reference the table view inside the method, and UITableView 
is the data type – the bit that describes what it is.

- The most important part of the method comes next: numberOfRowsInSection section: Int. This describes what the method actually does. 
We know it involves a table view because that's the name of the method, but the numberOfRowsInSection part is the actual action: 
this code will be triggered when iOS wants to know how many rows are in the table view. The section part is there because table 
views can be split into sections, like the way the Contacts app separates names by first letter. We only have one section, so 
we can ignore this number. The Int part means “this will be an integer,” which means a whole number like 3, 30, or 35678 number.”

- Finally, -> Int means “this method must return an integer”, which ought to be the number of rows to show in the table.

There was one more thing I missed out, and I missed it out for a reason: it’s a bit confusing at this point in your Swift career. 
Did you notice that _ in there? I hope you can remember that means the first parameter isn’t passed in using a name when called 
externally – this is a remnant of Objective-C, where the name of the first parameter was usually built right into the method name.

In this instance, the method is called tableView() because its first parameter is the table view that you’re working with. 
It wouldn’t make much sense to write tableView(tableView: someTableView), so using the underscore means you would write 
tableView(someTableView) instead.

Não vou fingir que é fácil entender como os métodos Swift parecem e funcionam, mas a melhor coisa a fazer é não se preocupar 
muito se você não entender agora, porque depois de algumas horas de codificação eles serão de segunda natureza.

At the very least you do need to know that these methods are referred to using their name (tableView) and any named parameters. 
Parameters without names are just referenced as underscores: _. So, to give it its full name, the method you just wrote is 
referred to as tableView(_:numberOfRowsInSection:) – clumsy, I know, which is why most people usually just talk about the 
important bit, for example, "in the numberOfRowsInSection method."

Escrevemos apenas uma linha de código no método, que era return pictures.count. Isso significa "enviar de volta o número de 
imagens em nossa matriz", por isso estamos pedindo que haja tantas linhas de tabela quanto imagens.


- Desenfileirando células
Esse é o primeiro de dois métodos que precisamos escrever para concluir este estágio do aplicativo. 
A segunda é especificar como deve ser cada linha e segue uma convenção de nomenclatura semelhante ao método anterior. Adicione este código agora:

override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "Picture", for: indexPath)
    cell.textLabel?.text = pictures[indexPath.row]
    return cell
}

Vamos dividi-lo em partes novamente, para que você possa ver exatamente como funciona.

First, override func tableView(_ tableView: UITableView is identical to the previous method: the method name is just tableView(), 
and it will pass in a table view as its first parameter. The _ means it doesn’t need to have a name sent externally, because it’s 
the same as the method name.

Second, cellForRowAt indexPath: IndexPath is the important part of the method name. The method is called cellForRowAt, and will 
be called when you need to provide a row. The row to show is specified in the parameter: indexPath, which is of type IndexPath. 
This is a data type that contains both a section number and a row number. We only have one section, so we can ignore that and just 
use the row number.

Third, -> UITableViewCell means this method must return a table view cell. If you remember, we created one inside Interface Builder 
and gave it the identifier “Picture”, so we want to use that.

Aqui é onde entra um pouco de magia do iOS: se você olhar para o aplicativo Configurações, verá que ele pode caber apenas cerca de 
12 linhas na tela a qualquer momento, dependendo do tamanho do seu telefone.

Para economizar tempo de CPU e RAM, o iOS cria apenas quantas linhas forem necessárias para funcionar. Quando uma linha sai da 
parte superior da tela, o iOS a tira e a coloca em uma fila de reutilização pronta para ser reciclada em uma nova linha que vem 
de baixo. Isso significa que você pode percorrer centenas de linhas por segundo, e o iOS pode se comportar preguiçosamente e evitar 
a criação de novas células de visualização de tabela - ele apenas recicla as existentes.

Essa funcionalidade é incorporada diretamente ao iOS, e é exatamente o que nosso código faz nesta linha:

let cell = tableView.dequeueReusableCell(withIdentifier: "Picture", for: indexPath)

Isso cria uma nova constante chamada cell, desenfileirando uma célula reciclada da tabela. 
Temos que dar a ele o identificador do tipo de célula que queremos reciclar, então inserimos o mesmo nome que demos ao 
Interface Builder: "Imagem". Também passamos o caminho de índice solicitado; isso é usado internamente pela visualização da tabela.

Isso nos retornará uma célula de visualização de tabela com a qual possamos trabalhar para exibir informações. 
Você pode criar seus próprios designs personalizados de células de visualização de tabela, se quiser (mais sobre isso muito mais tarde!), 
mas estamos usando o estilo Básico integrado que tem um rótulo de texto. É aí que entra a linha dois: ela dá ao rótulo de texto da 
célula o mesmo texto que uma imagem em nossa matriz. Aqui está o código novamente:

cell.textLabel?.text = pictures[indexPath.row]

The cell has a property called textLabel, but it’s optional: there might be a text label, or there might not be – if you had designed 
your own, for example. Rather than write checks to see if there is a text label or not, Swift lets us use a question mark – textLabel? – 
to mean “do this only if there is an actual text label there, or do nothing otherwise.”

We want to set the label text to be the name of the correct picture from our pictures array, and that’s exactly what the code does. 
indexPath.row will contain the row number we’re being asked to load, so we’re going to use that to read the corresponding picture 
from pictures, and place it into the cell’s text label.

The last line in the method is return cell. Remember, this method expects a table view cell to be returned, so we need to send back 
the one we created – that’s what the return cell does.

Com esses dois métodos bem pequenos em vigor, você pode executar seu código novamente agora e ver como ele fica. 
Tudo bem, agora você deve ver 10 células de visualização de tabela, cada uma com um nome de imagem diferente dentro.
Se você clicar em um deles, ele ficará cinza, mas nada mais acontecerá. Vamos consertar isso agora...

