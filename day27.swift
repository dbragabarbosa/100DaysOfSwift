22/06/2022


PROJECT 5, PART ONE 

Você provavelmente se lembra de aprender sobre fechamentos há algumas semanas, principalmente porque era 
uma parte particularmente difícil do curso. Desde então, tentei trabalhá-los lentamente para que você possa 
dominá-los pouco a pouco, e hoje é hora de mergulhar neles com nosso próprio fechamento.

Acho que você já sabe o que vou dizer, mas vou dizer de qualquer maneira: isso não vai ser fácil. Mas o general 
dos EUA, George Patton, disse uma vez: "aceite os desafios para que você possa sentir a alegria da vitória" - 
quando você finalmente sentir que entende os fechamentos (o que pode ser hoje!) é quando você sabe que está 
realmente se sentindo confortável com Swift.

Hoje vou apresentar um novo aspecto dos fechamentos chamado listas de captura. Para facilitar as coisas, preparei 
um novo artigo apenas para esta série que explica em detalhes o que são listas de captura e como elas funcionam - 
você deve começar lendo isso.

Hoje você deve trabalhar no artigo sobre listas de captura e, em seguida, nos três tópicos do projeto 5.



---------- CAPTURE LISTS IN SWIFT: WHATS THE DIFFERENCE BETWEEN WEAK, STRONG, AND UNOWNED REFERENCES? 

As listas de captura vêm antes da lista de parâmetros de um fechamento em seu código e capturam valores do ambiente 
como fortes, fracos ou não. Nós os usamos muito, principalmente para evitar ciclos de referência fortes - também 
conhecidos como ciclos de retenção.

Decidir qual usar não é fácil quando você está aprendendo, então você pode gastar tempo tentando descobrir forte vs fraco, 
ou fraco vs não é dono, mas à medida que você progride com seu aprendizado, você começará a perceber que muitas vezes 
há apenas uma escolha certa.

Primeiro, vamos dar uma olhada no problema. Primeiro, aqui está uma aula simples:

class Singer {
    func playSong() {
        print("Shake it off!")
    }
}

Second, here’s a function that creates an instance of Singer, creates a closure that uses the singer’s playSong() method, 
and returns that closure for us to use elsewhere:

func sing() -> () -> Void {
    let taylor = Singer()

    let singing = {
        taylor.playSong()
        return
    }

    return singing
}

Finally, we can call sing() to get back a function we can call wherever we want to have playSong() printed:

let singFunction = sing()
singFunction()

Isso imprimirá “Agite!” graças à chamada para singFunction().



Captura fraca

A Swift nos permite especificar uma lista de captura para determinar como os valores usados dentro do fechamento 
devem ser capturados. A alternativa mais comum à captura forte é chamada de captura fraca, e muda duas coisas:

Valores fracamente capturados não são mantidos vivos pelo fechamento, então eles podem ser destruídos e ser ajustados.
Como resultado de 1, valores fracamente capturados são sempre opcionais em Swift. Isso impede que você assuma que eles 
estão presentes quando, na verdade, podem não estar.

Podemos modificar nosso exemplo para usar captura fraca e você verá uma diferença imediata:

func sing() -> () -> Void {
    let taylor = Singer()

    let singing = { [weak taylor] in
        taylor?.playSong()
        return
    }

    return singing
}

That [weak taylor] part is our capture list, which is a specific part of closures where we give specific instructions 
as to how values should be captured. Here we’re saying that taylor should be captured weakly, which is why we need to 
use taylor?.playSong() – it’s an optional now, because it could be set to nil at any time.

If you run the code now you’ll see that calling singFunction() doesn’t print anything any more. The reason is that 
taylor exists only inside sing(), because the closure it returns doesn’t keep a strong hold of it.

To see this behavior in action, try changing sing() to this:

func sing() -> () -> Void {
    let taylor = Singer()

    let singing = { [weak taylor] in
        taylor!.playSong()
        return
    }

    return singing
}

That force unwraps taylor inside the closure, which will cause your code to crash because taylor becomes nil.



Captura de propriedade

An alternative to weak is unowned, which behaves more like implicitly unwrapped optionals. Like weak capturing, 
unowned capturing allows values to become nil at any point in the future. However, you can work with them as if 
they are always going to be there – you don’t need to unwrap optionals.

Por exemplo:

func sing() -> () -> Void {
    let taylor = Singer()

    let singing = { [unowned taylor] in
        taylor.playSong()
        return
    }

    return singing
}

That will crash in a similar way to our force-unwrapped example from earlier: unowned taylor says I know for sure 
that taylor will always exist for the lifetime of the closure I’m sending back so I don’t need to hold on to the 
memory, but in practice taylor will be destroyed almost immediately so the code will crash.

You should use unowned very carefully indeed.



Problemas comuns

Há quatro problemas que as pessoas geralmente enfrentam ao usar a captura de fechamento:

1. Eles não sabem onde usar as listas de captura quando os fechamentos aceitam parâmetros.

2. Eles fazem ciclos de referência fortes, fazendo com que a memória seja consumida.

3. Eles acidentalmente usam referências fortes, especialmente quando usam várias capturas.

4. Eles fazem cópias de fechamentos e compartilham dados capturados.

Vamos percorrer cada um deles com alguns exemplos de código, para que você possa ver o que acontece.



Capture listas ao lado dos parâmetros

Este é um problema comum a ser atingido quando você está começando com listas de captura, 
mas felizmente é um que Swift pega para nós.

When using capture lists and closure parameters together the capture list must always come first, 
then the word in to mark the start of your closure body – trying to put it after the closure parameters 
will stop your code from compiling.

Por exemplo:

writeToLog { [weak self] user, message in 
    self?.addToLog("\(user) triggered event: \(message)")
}



Ciclos de referência fortes

Quando a coisa A possui a coisa B, e a coisa B possui a coisa A, você tem o que é chamado de ciclo de 
referência forte, ou muitas vezes apenas um ciclo de retenção.

Por exemplo, considere este código:

class House {
    var ownerDetails: (() -> Void)?

    func printDetails() {
        print("This is a great house.")
    }

    deinit {
        print("I'm being demolished!")
    }
}

That creates a House class with one property (a closure), one method, and a deinitializer so it 
prints a message when it’s being destroyed.

Now here’s an Owner class that is the same, except its closure stores house details:

class Owner {
    var houseDetails: (() -> Void)?

    func printDetails() {
        print("I own a house.")
    }

    deinit {
        print("I'm dying!")
    }
}

We can try creating two instances of those classes inside a do block. We don’t need a catch block here, 
but using do ensures they will be destroyed as soon as the } is reached:

print("Creating a house and an owner")

do {
    let house = House()
    let owner = Owner()
}

print("Done")

Isso deve imprimir "Criando uma casa e um dono", "Estou morrendo!", "Estou sendo demolido!", 
depois "Concluído" - tudo funciona como esperado.

Agora vamos criar um ciclo de referência forte:

print("Creating a house and an owner")

do {
    let house = House()
    let owner = Owner()
    house.ownerDetails = owner.printDetails
    owner.houseDetails = house.printDetails
}

print("Done")

Agora ele imprimirá "Criando uma casa e um proprietário" e depois "Concluído", sem nenhum desiniciador sendo chamado.

What’s happening here is that house has a property that points to a method of owner, and owner has a 
property that points to a method of house, so neither can be safely destroyed. In real code this causes 
memory that can’t be freed, known as a memory leak, which degrades system performance and can even cause 
your app to be terminated.

Para corrigir isso, precisamos criar um novo fechamento e usar captura fraca para um ou ambos os valores, assim:

print("Creating a house and an owner")

do {
    let house = House()
    let owner = Owner()
    house.ownerDetails = { [weak owner] in owner?.printDetails() }
    owner.houseDetails = { [weak house] in house?.printDetails() }
}

print("Done")

Não é necessário ter ambos os valores fracamente capturados - tudo o que importa é que pelo menos um seja, 
porque permite que Swift destrua os dois quando necessário.

Agora, no código de projeto real, é raro encontrar ciclos de referência fortes que são tão óbvios, mas isso 
significa que é ainda mais importante usar captura fraca para evitar completamente o problema.



Referências fortes acidentais

O padrão da Swift é captura forte, o que pode causar problemas não intencionais.

Voltando ao nosso exemplo de canto anterior, considere este código:

func sing() -> () -> Void {
    let taylor = Singer()
    let adele = Singer()

    let singing = { [unowned taylor, adele] in
        taylor.playSong()
        adele.playSong()
        return
    }

    return singing
}


Now we have two values being captured by the closure, and both values are being used the same 
way inside the closure. However, only taylor is being captured as unowned – adele is being captured 
strongly, because the unowned keyword must be used for each captured value in the list.

Now, if you want taylor to be unowned but adele to be strongly captured, that’s fine. But if you want
both to be unowned you need to say so:

[unowned taylor, unowned adele]

Swift does offer some protection against accidental capturing, but it’s limited: if you use self 
implicitly inside a closure, Swift forces you to add self. or self?. to make your intentions clear.

Implicit use of self happens a lot in Swift. For example, this initializer calls playSong(), but what 
it really means is self.playSong() – the self part is implied by the context:

class Singer {
    init() {
        playSong()
    }

    func playSong() {
        print("Shake it off!")
    }
}

A Swift não permitirá que você use fechamentos internos implícitos, o que ajuda a reduzir um tipo comum de ciclo de retenção.



Cópias de fechamentos

A última coisa que tropeça nas pessoas é a maneira como os próprios fechamentos são copiados, porque seus dados 
capturados são compartilhados entre as cópias.

For example, here’s a simple closure that captures the numberOfLinesLogged integer created outside so that it can 
increment and print its value whenever its called:

var numberOfLinesLogged = 0

let logger1 = {
    numberOfLinesLogged += 1
    print("Lines logged: \(numberOfLinesLogged)")
}

logger1()

Isso imprimirá "Linhas registradas: 1" porque chamamos o fechamento no final.

Agora, se pegarmos uma cópia desse fechamento, essa cópia compartilha os mesmos valores de captura que o original, portanto, 
quer chamemos o original ou a cópia, você verá a contagem de linhas de log aumentando:

let logger2 = logger1
logger2()
logger1()
logger2()

That will now print that 1, 2, 3, and 4 lines have been logged, because both logger1 and logger2 are pointing at 
the same captured numberOfLinesLogged value.



Quando usar forte, quando usar fraco, quando usar sem propriedade

Agora que você entende como tudo funciona, vamos tentar resumir se devemos usar referências fortes, fracas ou não próprias:

1. If you know for sure your captured value will never go away while the closure has any chance of being called, 
you can use unowned. This is really only for the handful of times when weak would cause annoyances to use, but even 
when you could use guard let inside the closure with a weakly captured variable.

2. Se você tem uma situação forte do ciclo de referência - onde a coisa A possui a coisa B e a coisa B possui a coisa A - 
então um dos dois deve usar captura fraca. Isso geralmente deve ser o que quer que seja destruído primeiro, portanto, se o 
controlador de visualização A apresentar o controlador de visualização B, o controlador de visualização B pode conter 
uma referência fraca a A.

3. If there’s no chance of a strong reference cycle you can use strong capturing. For example, performing animation 
won’t cause self to be retained inside the animation closure, so you can use strong capturing.

If you’re not sure which to use, start out with weak and change only if you need to.



Onde agora?

As you’ve seen, closure capture lists help us avoid memory problems by controlling each how values are captured inside our closures. 
They are captured strongly by default, but we can use weak and even unowned to allow values to be destroyed 
even if they are used inside our closure.



---------- SETTING UP 

Os projetos 1 a 4 foram bastante fáceis, porque meu objetivo era ensinar a você o básico do desenvolvimento do iOS e, 
ao mesmo tempo, tentar fazer algo útil. Mas agora que espero que você esteja começando a se familiarizar com as principais 
ferramentas que temos, é hora de mudar de marcha e lidar com algo um pouco mais difícil.

In this project you're going to learn how to make a word game that deals with anagrams, but as per usual I'll be hijacking 
it as a method to teach you more about iOS development. This time around we're going back to the table views as seen in 
project 1, but you're also going to learn how to load text from files, how to ask for user input in UIAlertController, 
and get a little more insight to how closures work.

No Xcode, crie um novo aplicativo de visualização única chamado Project5. Vamos transformar isso em um controlador de 
visualização de mesa, assim como fizemos no projeto 1. Então, abra ViewController.swift e encontre esta linha:

class ViewController: UIViewController {

Por favor, altere-o para ler isso:

class ViewController: UITableViewController {

Se você se lembra, isso só altera a definição do nosso controlador de visualização em código. Precisamos mudar o 
storyboard também, então abra o Main.storyboard agora.

No Interface Builder, use o esboço do documento para selecionar e excluir o controlador de visualização existente 
para que o documento fique em branco e, em seguida, substitua-o por um novo controlador de visualização de tabela. 
Use o inspetor de identidade para alterar a classe do novo controlador para "ViewController", selecione sua célula 
protótipo e forneça o identificador de reutilização "Word" e o estilo de célula Básico.

Tudo isso foi abordado no projeto 1, mas tudo bem se você esquecer - não tenha medo de voltar ao projeto 1 e reler 
quaisquer bits sobre os quais você não tenha certeza.

Agora selecione o controlador de visualização novamente (use o esboço do documento - é mais fácil!) em seguida, 
certifique-se de que a caixa "É o Controlador de Visualização Inicial" esteja marcada no inspetor de atributos. 
Por fim, vá para o menu Editor e escolha Incorporar > Controlador de Navegação. Não colocaremos nada na pilha do 
controlador de navegação como fizemos com o projeto 1, mas ele fornece automaticamente a barra de navegação na parte 
superior, que usaremos.

Nota: Este aplicativo pede aos usuários que façam anagramas a partir de uma palavra, por exemplo, quando recebem a 
palavra "anagramas", eles podem fornecer "raios". Se você olhar para isso e pensar "isso não é um anagrama - ele não 
usa todas as letras!" então você precisa pesquisar na internet por "bem, na verdade" e ter uma boa e longa reflexão 
sobre a vida.



---------- READING FROM DISK: contentsOf 

We're going to make an anagram game, where the user is asked to make words out of a larger word. We're going to put 
together a list of possible starter words for the game, and that list will be stored in a separate file. But how do 
we get the text from the file into the app? Well, it turns out that Swift's String data type makes it a cinch – thanks, Apple!

Se você ainda não baixou os ativos deste projeto do GitHub , faça isso agora. Na pasta project5-files, você encontrará 
o arquivo start.txt - arraste-o para o seu projeto Xcode, certificando-se de que "Copiar itens, se necessário" esteja marcado.

O arquivo start.txt contém mais de 12.000 palavras de oito letras que podemos usar para o nosso jogo, todas armazenadas 
uma palavra por linha. Precisamos transformar isso em uma variedade de palavras com as quais possamos brincar. Nos bastidores, 
essas quebras de linha são marcadas com um caractere especial de quebra de linha que geralmente é expresso como \n. 
Então, precisamos carregar essa lista de palavras em uma string e, em seguida, dividi-la em uma matriz, dividindo onde quer que vejamos \n.

Primeiro, vá para o início da sua aula e faça duas novas matrizes. Usaremos o primeiro para armazenar todas as palavras 
no arquivo de entrada, e o segundo conterá todas as palavras que o jogador usou atualmente no jogo.

Então, abra ViewController.swift e adicione estas duas propriedades:

var allWords = [String]()
var usedWords = [String]()

Em segundo lugar, carregando nossa matriz. Isso é feito em três partes: encontrar o caminho para o nosso arquivo 
start.txt, carregar o conteúdo desse arquivo e dividi-lo em uma matriz.

Finding a path to a file is something you'll do a lot, because even though you know the file is called "start.txt" 
you don't know where it might be on the filesystem. So, we use a built-in method of Bundle to find it: path(forResource:). 
This takes as its parameters the name of the file and its path extension, and returns a String? – i.e., you either get 
the path back or you get nil if it didn’t exist.

Carregar um arquivo em uma string também é algo com o qual você precisará se familiarizar e, novamente, há uma maneira 
fácil de fazê-lo: quando você cria uma instância String, você pode pedir que ela se crie a partir do conteúdo de um arquivo 
em um caminho específico.

Finalmente, precisamos dividir nossa única string em uma matriz de strings com base em onde quer que encontremos uma 
quebra de linha (\n). Isso é tão simples quanto outra chamada de método em String: components(separatedBy:) Diga qual 
string você deseja usar como separador (para nós, isso é \n), e você receberá de volta uma matriz.

Before we get onto the code, there are two things you should know: path(forResource:) and creating a String from the 
contents of a file both return String?, which means we need to check and unwrap the optional using if let syntax.

OK, hora de algum código. Coloque isso em viewDidLoad(), após a super:

if let startWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt") {
    if let startWords = try? String(contentsOf: startWordsURL) {
        allWords = startWords.components(separatedBy: "\n")
    }
}

if allWords.isEmpty {
    allWords = ["silkworm"]
}

Se você olhar com cuidado, há uma nova palavra-chave lá: try?. Você já viu try! anteriormente, e realmente poderíamos 
usar isso aqui também porque estamos carregando um arquivo do pacote do nosso aplicativo, então qualquer falha
provavelmente será catastrófica. No entanto, dessa forma, tenho a chance de te ensinar algo novo: try? significa 
"chame este código e, se ele lançar um erro, basta me enviar de volta nil". Isso significa que o código que você 
chama sempre funcionará, mas você precisa desembrulhar o resultado com cuidado.

I also added in a new and useful property of arrays: isEmpty. This returns true if the array is empty, and is 
effectively equal to writing allWords.count == 0. The reason we use isEmpty is because some collection types, 
such as string, have to calculate their size by counting over all the elements they contain, so reading count == 0 
can be significantly slower than using isEmpty.

As you can see, that code carefully checks for and unwraps the contents of our start file, then converts it to an array. 
When it has finished, allWords will contain 12,000+ strings ready for us to use in our game.

To prove that everything is working before we continue, let's create a new method called startGame(). This will be 
called every time we want to generate a new word for the player to work with, and it will use the randomElement() 
method of Swift’s arrays to choose one random item from all the strings.

Aqui está o código:

func startGame() {
    title = allWords.randomElement()
    usedWords.removeAll(keepingCapacity: true)
    tableView.reloadData()
}

A linha 1 define o título do nosso controlador de visualização como uma palavra aleatória na matriz, que será a 
palavra que o jogador precisa encontrar.

Line 2 removes all values from the usedWords array, which we'll be using to store the player's answers so far. 
We aren't adding anything to it right now, so removeAll() won't do anything just yet.

Line 3 is the interesting part: it calls the reloadData() method of tableView. That table view is given to us as a 
property because our ViewController class comes from UITableViewController, and calling reloadData() forces it to call
 numberOfRowsInSection again, as well as calling cellForRowAt repeatedly. Our table view doesn't have any rows yet, 
 so this won't do anything for a few moments. However, the method is ready to be used, and allows us to check we've 
 loaded all the data correctly, so add this just before the end of viewDidLoad():

startGame()

Agora pressione Cmd+R para executar o aplicativo, e você deve ver uma palavra de oito letras na parte superior, 
pronta para começar a jogar.

Before we’re done, we need to add a few methods to handle the table view data: numberOfRowsInSection and cellForRowAt. 
These are identical to the implementations in project 1, except now we’re drawing on the usedWords array and the “Word” 
cell identifier. Add these two methods now:

override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return usedWords.count
}

override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "Word", for: indexPath)
    cell.textLabel?.text = usedWords[indexPath.row]
    return cell
}

They won’t have any effect just yet because the usedWords array never changes, but at least the foundation is in place now.



---------- PICK A WORD, ANY WORD: UIAlertController 

Este jogo solicitará que o usuário insira uma palavra que possa ser feita a partir da palavra de solicitação 
de oito letras. Por exemplo, se a palavra de oito letras for "agências", o usuário pode inserir "cessar". 
Vamos resolver isso com o UIAlertController, porque é um bom ajuste e também me dá a chance de apresentar 
alguns novos ensinamentos. Eu gosto de segundas intenções!

Adicione este código a viewDidLoad(), logo após a chamada para super:

navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(promptForAnswer))

That created a new UIBarButtonItem using the "add" system item, and configured it to run a method called 
promptForAnswer() when tapped – we haven’t created it yet, so you’ll get a compiler error for a few minutes 
as you read on. This new method will show a UIAlertController with space for the user to enter an answer, 
and when the user clicks Submit to that alert controller the answer is checked to make sure it's valid.

Antes de lhe dar o código, deixe-me explicar o que você precisa saber.

Veja, estamos prestes a usar um encerramento, e as coisas ficam um pouco complicadas. Como lembrete, estes são 
pedaços de código que podem ser tratados como uma variável - podemos enviar o fechamento para algum lugar, onde 
ele é armazenado e executado mais tarde. Para que isso funcione, Swift pega uma cópia do código e captura todos 
os dados aos quais faz referência, para que possa usá-los mais tarde.

Mas há um problema: e se o fechamento fizer referência ao controlador de visualização? Então o que pode acontecer 
é um forte ciclo de referência: o controlador de visualização possui um objeto que possui um fechamento que possui 
o controlador de visualização, e nada poderia ser destruído.

Vou tentar (e provavelmente falhar!) para lhe dar um exemplo metafórico, então, por favor, tenha paciência comigo. 
Imagine se você construísse dois robôs de limpeza, vermelho e azul. Você disse ao robô vermelho: "não pare de limpar 
até que o robô azul pare", e disse ao robô azul "não pare de limpar até que o robô vermelho pare".

Quando eles parariam de limpar? A resposta é “nunca”, porque nenhum dos dois dará o primeiro passo.

Este é o problema que estamos enfrentando com um forte ciclo de referência: o objeto A possui o objeto B e o objeto 
B possui um fechamento que fez referência ao objeto A. E quando os fechamentos são criados, eles capturam tudo o que 
usam, portanto, o objeto B possui o objeto A.

Ciclos de referência fortes costumavam ser difíceis de encontrar, mas você ficará feliz em saber que Swift os torna 
triviais. Na verdade, a Swift torna tão fácil que você usará sua solução mesmo quando não tiver certeza se há um 
ciclo simplesmente porque você também pode.

Então, por favor, prepare-se: estamos prestes a dar nossa primeira olhada nos fechamentos reais. A sintaxe vai doer. 
E quando você finalmente entender, encontrará exemplos on-line que fazem seu cérebro doer novamente.

Pronto? Aqui está o método promptForAnswer():

@objc func promptForAnswer() {
    let ac = UIAlertController(title: "Enter answer", message: nil, preferredStyle: .alert)
    ac.addTextField()

    let submitAction = UIAlertAction(title: "Submit", style: .default) { [weak self, weak ac] action in
        guard let answer = ac?.textFields?[0].text else { return }
        self?.submit(answer)
    }

    ac.addAction(submitAction)
    present(ac, animated: true)
}

Esse código ainda não será construído, então não se preocupe se você vir erros - nós os corrigiremos em breve.
 Mas primeiro, vamos falar sobre o que o código acima faz. Ele introduz algumas coisas novas, mas antes de olharmos 
 para elas, vamos eliminar as coisas fáceis.

- It needs to be called from a UIBarButtonItem action, so we must mark it @objc. Hopefully you’re starting to sense when 
this is needed, but don’t worry if you forget – Xcode will always complain loudly if @objc is required and not present!

- Criando um novo UIAlertController: fizemos isso no projeto 2.

- The addTextField() method just adds an editable text input field to the UIAlertController. We could do more with it, 
but it's enough for now.

- The addAction() method is used to add a UIAlertAction to a UIAlertController. We used this in project 2 also.

- The present() method is also from project 2. Clearly project 2 was brilliant!

Isso deixa as coisas complicadas: criar submitAction. Essas poucas linhas de código demonstram nada menos que 
quatro coisas novas para aprender, todas importantes. Vou classificá-los mais facilmente primeiro, começando com UITextField.

UITextField is a simple editable text box that shows the keyboard so the user can enter something. We added a single 
text field to the UIAlertController using its addTextField() method, and we now read out the value that was inserted.

A seguir está a sintaxe de fechamento à direita. Cobrimos isso enquanto você estava aprendendo os fundamentos do Swift, 
mas agora você pode vê-lo em ação: em vez de especificar um parâmetro handler, passamos o código que queremos executar 
entre chaves após a chamada do método.

Next, action in. If you remember project 2, we had to modify the askQuestion() method so that it accepted a 
UIAlertAction parameter saying what button was tapped, like this:

func askQuestion(action: UIAlertAction!) {

We had no choice but to do that, because the handler parameter for UIAlertAction expects a method that takes 
itself as a parameter, and we also added a default value of “nil” so we could call it ourselves – hence the ! part. 
And that's what's happening here: we're giving the UIAlertAction some code to execute when it is tapped, and it 
wants to know that that code accepts a parameter of type UIAlertAction.

The in keyword is important: everything before that describes the closure; everything after that is the closure. 
So action in means that it accepts one parameter in, of type UIAlertAction.

In our current project, we could simplify this even further: we don't make any reference to the action parameter 
inside the closure, which means we don't need to give it a name at all. In Swift, to leave a parameter unnamed you 
just use an underscore character, like this:

_ in
O quarto é weak. Swift "captura" quaisquer constantes e variáveis que são usadas em um fechamento, com base nos 
valores do contexto circundante do fechamento. Ou seja, se você criar um inteiro, uma string, uma matriz e outra 
classe fora do fechamento e, em seguida, usá-los dentro do fechamento, o Swift os capturará.

Isso é importante, porque o fechamento faz referência às variáveis e pode até alterá-las. Mas eu ainda não disse o 
que "captura" realmente significa, e isso é porque depende do tipo de dados que você está usando. Felizmente, Swift 
esconde tudo para que você não precise se preocupar com isso...

...exceto por aqueles fortes ciclos de referência que mencionei. Aqueles com quem você precisa se preocupar. 
É aí que os objetos nem podem ser destruídos porque todos eles se agarram firmemente uns aos outros - conhecido 
como forte referência.

A solução da Swift é permitir que você declare que algumas variáveis não são mantidas com tanta força. É um 
processo de duas etapas, e é tão fácil que você vai se encontrar fazendo isso por tudo, por precaução. Caso o 
Xcode ache que você está indo um pouco longe demais, você receberá um aviso dizendo que pode relaxar um pouco.

First, you must tell Swift what variables you don't want strong references for. This is done in one of two ways: 
unowned or weak. These are somewhat equivalent to implicitly unwrapped optionals (unowned) and regular optionals 
(weak): a weakly owned reference might be nil, so you need to unwrap it or use optional chaining; an unowned 
reference is one you're certifying cannot be nil and so doesn't need to be unwrapped, however you'll hit a 
problem if you were wrong.

In our code we use this: [weak self, weak ac]. That declares self (the current view controller) and ac 
(our UIAlertController) to be captured as weak references inside the closure. It means the closure can 
use them, but won't create a strong reference cycle because we've made it clear the closure doesn't own 
either of them.

But that's not enough for Swift. Inside our method we're calling the submit() method of our view controller.
 We haven't created it yet, but you should be able to see it's going to take the answer the user entered and 
 try it out in the game.

This submit() method is external to the closure’s current context, so when you're writing it you might not 
realize that calling submit() implicitly requires that self be captured by the closure. That is, the closure 
can't call submit() if it doesn't capture the view controller.

We've already declared that self is weakly owned by the closure, but Swift wants us to be absolutely sure we 
know what we're doing: every call to a method or property of the current view controller must prefixed with 
"self?.", as in self?.submit().

In project 1, I told you there were two trains of thought regarding use of self, and said, 
"The first group of people never like to use self. unless it's required, because when it's required 
it's actually important and meaningful, so using it in places where it isn't required can confuse matters."

Implicit capture of self in closures is that place when using self is required and meaningful: Swift won't 
let you avoid it here. By restricting your use of self to closures you can easily check your code doesn’t 
have any reference cycles by searching for "self" – there ought not to be too many to look through!

Eu percebo que tudo isso soa muito denso, mas vamos dar uma olhada no código novamente:

let submitAction = UIAlertAction(title: "Submit", style: .default) { [weak self, weak ac] action in
    guard let answer = ac?.textFields?[0].text else { return }
    self?.submit(answer)
}
Espero que você possa começar a ver como ele se quebra:

- Usamos a sintaxe de fechamento à direita para fornecer algum código para executar quando a ação de alerta for selecionada.

- That code will use self and ac so we declare them as being weak so that Swift won’t create a strong reference cycle.

- The closure expects to receive a UIAlertAction as its parameter, so we write that inside the opening brace.

- Everything after in is the actual code of the closure.

- Inside the closure we need to reference methods on our view controller using self so that we’re clearly 
acknowledging the possibility of a strong reference cycle.

É complicado e não vou fingir o contrário, mas voltaremos a isso repetidamente no futuro - você terá chance 
mais do que suficiente de entendê-lo melhor.

Before we move on, let's make your code compile again because right now it's calling self?.submit() and we haven't 
made that method yet. So, add this new method somewhere in the class:

func submit(_ answer: String) {
}

Isso mesmo, está vazio - mas é o suficiente para fazer compilar o código de forma limpa para que possamos continuar.