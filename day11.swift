28/04/2022 


PROTOCOLS AND EXTENSIONS 

Hoje você vai aprender algumas funcionalidades verdadeiramente rápidas: protocolos e programação orientada a protocolos (POP).

O POP elimina hierarquias de herança grandes e complexas e as substitui por protocolos muito menores e mais simples que podem ser combinados. 
Este é realmente o cumprimento de algo que Tony Hoare disse há muitos anos: "dentro de cada grande programa, há um pequeno programa tentando sair".


---------- 1. PROTOCOLS 

Protocolos são uma maneira de descrever quais propriedades e métodos algo deve ter. 
Em seguida, você diz à Swift quais tipos usam esse protocolo - um processo conhecido como adoção ou conformidade com um protocolo.

For example, we can write a function that accepts something with an id property, but we don’t care precisely what type of data is used. We’ll start by creating an Identifiable protocol, which will require all conforming types to have an id string that can be read (“get”) or written (“set”):

protocol Identifiable {
    var id: String { get set }
}
Não podemos criar instâncias desse protocolo - é uma descrição do que queremos, em vez de algo que podemos criar e usar diretamente. 
Mas podemos criar uma estrutura que esteja em conformidade com ela:

struct User: Identifiable {
    var id: String
}

Finally, we’ll write a displayID() function that accepts any Identifiable object:

func displayID(thing: Identifiable) {
    print("My ID is \(thing.id)")
}



Os protocolos nos permitem definir como estruturas, classes e enums devem funcionar: 
quais métodos eles devem ter e quais propriedades eles devem ter. 
O Swift aplicará essas regras para nós, de modo que, quando dissermos que um tipo está em conformidade com um protocolo, 
o Swift garantirá que ele tenha todos os métodos e propriedades exigidos por esse protocolo.

In practice, what protocols allow us to do is treat our data in more general terms. 
So, rather than saying “this buy() method must accept a Book object,” we can say “this method can accept anything 
that conforms to the Purchaseable protocol. That might be a book, but it might also be a movie, a car, some coffee, 
and so on – it makes our simple method more flexible, while ensuring that Swift enforces the rules for us.

In code terms, our simple buy() method that works only with books would look like this:

struct Book {
    var name: String
}

func buy(_ book: Book) {
    print("I'm buying \(book.name)")
}

Para criar uma abordagem mais flexível e baseada em protocolo, primeiro criaríamos um protocolo que declarasse a funcionalidade 
básica de que precisamos. Podem ser muitos métodos e propriedades, mas aqui vamos apenas dizer que precisamos de uma string de nome:

protocol Purchaseable {
    var name: String { get set }
}

Agora podemos ir em frente e definir quantas estruturas precisarmos, com cada uma em conformidade com esse protocolo, tendo uma string de nome:

struct Book: Purchaseable {
    var name: String
    var author: String
}

struct Movie: Purchaseable {
    var name: String
    var actors: [String]
}

struct Car: Purchaseable {
    var name: String
    var manufacturer: String
}

struct Coffee: Purchaseable {
    var name: String
    var strength: Int
}

Você notará que cada um desses tipos tem uma propriedade diferente que não foi declarada no protocolo, e tudo bem - 
os protocolos determinam a funcionalidade mínima necessária, mas sempre podemos adicionar mais.

Finally, we can rewrite the buy() function so that it accepts any kind of Purchaseable item:

func buy(_ item: Purchaseable) {
    print("I'm buying \(item.name)")
}

Inside that method we can use the name property of our item safely, because Swift will guarantee that each Purchaseable item has a name property. 
It doesn’t guarantee that any of the other properties we defined will exist, only the ones that are specifically declared in the protocol.

Portanto, os protocolos nos permitem criar projetos de como nossos tipos compartilham funcionalidades e, em seguida, 
usar esses projetos em nossas funções para permitir que eles trabalhem em uma variedade maior de dados.


---------- 2. PROTOCOL INHERITANCE 

Um protocolo pode herdar de outro em um processo conhecido como herança de protocolo. 
Ao contrário das classes, você pode herdar de vários protocolos ao mesmo tempo antes de adicionar suas próprias personalizações no topo.

We’re going to define three protocols: Payable requires conforming types to implement a calculateWages() method, 
NeedsTraining requires conforming types to implement a study() method, and HasVacation requires conforming types 
to implement a takeVacation() method:

protocol Payable {
    func calculateWages() -> Int
}

protocol NeedsTraining {
    func study()
}

protocol HasVacation {
    func takeVacation(days: Int)
}

We can now create a single Employee protocol that brings them together in one protocol. 
We don’t need to add anything on top, so we’ll just write open and close braces:

protocol Employee: Payable, NeedsTraining, HasVacation { }

Agora podemos fazer com que novos tipos estejam em conformidade com esse único protocolo, em vez de cada um dos três individuais.



O Swift nos permite criar um novo protocolo com base em protocolos existentes, 
assim como a maneira como nos permite criar novas classes com base em classes existentes.

Uma razão comum para usar a herança do protocolo é combinar funcionalidade para um trabalho comum. Por exemplo:

Todos os produtos têm um preço e um peso
Todos os computadores têm uma CPU, além de quanta memória eles têm e quanto armazenamento
Todos os laptops têm um tamanho de tela
You could absolutely define a Computer protocol like this:

protocol Computer {
    var price: Double { get set }
    var weight: Int { get set }
    var cpu: String { get set }
    var memory: Int { get set }
    var storage: Int { get set }
}

Then define a Laptop protocol like this:

protocol Laptop {
    var price: Double { get set }
    var weight: Int { get set }
    var cpu: String { get set }
    var memory: Int { get set }
    var storage: Int { get set }
    var screenSize: Int { get set }
}

Mas você vê quanta duplicação já temos? Agora imagine trabalhar com telefones e tablets - mais protocolos e mais duplicação.

É muito mais simples e flexível se dividirmos nossos protocolos em partes menores e depois os remontarmos como tijolos Lego.

Então, poderíamos começar definindo como é um produto:

protocol Product {
    var price: Double { get set }
    var weight: Int { get set }
}

We could then define what a computer looks like, by basing it on a Product then adding some extras:

protocol Computer: Product {
    var cpu: String { get set }
    var memory: Int { get set }
    var storage: Int { get set }
}
Now we can define what a Laptop looks like, by basing it on a Computer (and therefore also a Product), and adding another property:

protocol Laptop: Computer {
    var screenSize: Int { get set }
}

Como você pode ver, usar a herança de protocolo dessa maneira nos permite compartilhar definições e reduzir a duplicação, 
o que é uma ótima maneira de criar funcionalidade peça por peça.



---------- 3. EXTENSIONS 

As extensões permitem que você adicione métodos aos tipos existentes, para fazê-los fazer coisas para as quais não foram originalmente projetados.

For example, we could add an extension to the Int type so that it has a squared() method that returns the current number multiplied by itself:

extension Int {
    func squared() -> Int {
        return self * self
    }
}

Para experimentar isso, basta criar um número inteiro e você verá que agora tem um método squared():

let number = 8
number.squared()

Swift doesn’t let you add stored properties in extensions, so you must use computed properties instead. 
For example, we could add a new isEven computed property to integers that returns true if it holds an even number:

extension Int {
    var isEven: Bool {
        return self % 2 == 0
    }
}

Os métodos adicionados usando extensões são indistinguíveis dos métodos que originalmente faziam parte do tipo, 
mas há uma diferença para as propriedades: as extensões podem não adicionar novas propriedades armazenadas, apenas propriedades calculadas.


---------- 4. PROTOCOL EXTENSIONS 

Os protocolos permitem que você descreva quais métodos algo deve ter, mas não forneça o código dentro. 
As extensões permitem que você forneça o código dentro de seus métodos, mas afetam apenas um tipo de dados - 
você não pode adicionar o método a muitos tipos ao mesmo tempo.

As extensões de protocolo resolvem esses dois problemas: elas são como extensões regulares, exceto que, em vez de 
estender um tipo específico, como Int, você estende um protocolo inteiro para que todos os tipos em conformidade recebam suas alterações.

Por exemplo, aqui está uma matriz e um conjunto contendo alguns nomes:

let pythons = ["Eric", "Graham", "John", "Michael", "Terry", "Terry"]
let beatles = Set(["John", "Paul", "George", "Ringo"])

Swift’s arrays and sets both conform to a protocol called Collection, so we can write an extension to that protocol to add 
a summarize() method to print the collection neatly

extension Collection {
    func summarize() {
        print("There are \(count) of us:")

        for name in self {
            print(name)
        }
    }
}

Both Array and Set will now have that method, so we can try it out:

pythons.summarize()
beatles.summarize()


---------- 5. PROTOCOL-ORIENTED PROGRAMMING (programação orientada a protocolos)

As extensões de protocolo podem fornecer implementações padrão para nossos próprios métodos de protocolo. 
Isso facilita a conformidade dos tipos com um protocolo e permite uma técnica chamada "programação orientada a protocolos" - 
criando seu código em torno de protocolos e extensões de protocolo.

First, here’s a protocol called Identifiable that requires any conforming type to have an id property and an identify() method:

protocol Identifiable {
    var id: String { get set }
    func identify()
}

Poderíamos fazer com que cada tipo em conformidade escrevesse seu próprio método identify(), 
mas as extensões de protocolo nos permitem fornecer um padrão:

extension Identifiable {
    func identify() {
        print("My ID is \(id).")
    }
}

Now when we create a type that conforms to Identifiable it gets identify() automatically:

struct User: Identifiable {
    var id: String
}

let twostraws = User(id: "twostraws")
twostraws.identify()


---------- 6. PROTOCOLS AND EXTENSIONS SUMMARY 

1. Os protocolos descrevem quais métodos e propriedades um tipo em conformidade deve ter, mas não fornecem as implementações desses métodos.

2. Você pode criar protocolos em cima de outros protocolos, semelhantes às classes.

3. As extensões permitem que você adicione métodos e propriedades calculadas a tipos específicos, como Int.

4. As extensões de protocolo permitem que você adicione métodos e propriedades calculadas aos protocolos.

5. A programação orientada a protocolos é a prática de projetar a arquitetura do seu aplicativo como uma série de protocolos e, em seguida, 
usar extensões de protocolo para fornecer implementações de métodos padrão.



