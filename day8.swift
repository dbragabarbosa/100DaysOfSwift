13/04/2022

STRUCTS (ESTRUTURAS) - parte 1



As estruturas nos permitem criar nossos próprios tipos de dados a partir de vários tipos pequenos. 
Por exemplo, você pode juntar três strings e um booleano e dizer que isso representa um usuário em seu aplicativo.

---------- 1. CREATING YOUR OWN STRUCTS 

As estruturas podem receber suas próprias variáveis e constantes, e suas próprias funções, depois criadas e usadas como 
você quiser.

Let’s start with a simple example: we’re going to create a Sport struct that stores its name as a string. 
Variables inside structs are called properties, so this is a struct with one property:

struct Sport {
    var name: String
}

Isso define o tipo, então agora podemos criar e usar uma instância dele:

var tennis = Sport(name: "Tennis")
print(tennis.name)

We made both name and tennis variable, so we can change them just like regular variables:

tennis.name = "Lawn tennis"

As propriedades podem ter valores padrão, assim como as variáveis regulares, 
e você geralmente pode confiar na inferência de tipo da Swift.


Obs:
use tuplas quando quiser retornar dois ou mais valores arbitrários de uma função, 
mas prefira estruturas quando tiver alguns dados fixos que deseja enviar ou receber várias vezes.


---------- 2. COMPUTED PROPERTIES 

We just created a Sport struct like this:

struct Sport {
    var name: String
}

Isso tem uma propriedade name que armazena uma String. 
Estas são chamadas de propriedades armazenadas, porque o Swift tem um tipo diferente de propriedade chamada propriedade 
calculada - uma propriedade que executa código para descobrir seu valor.

We’re going to add another stored property to the Sport struct, then a computed property. Here’s how that looks:

struct Sport {
    var name: String
    var isOlympicSport: Bool

    var olympicStatus: String {
        if isOlympicSport {
            return "\(name) is an Olympic sport"
        } else {
            return "\(name) is not an Olympic sport"
        }
    }
}

As you can see, olympicStatus looks like a regular String, but it returns different values depending on the other properties.

Podemos experimentá-lo criando uma nova instância do Sport:

let chessBoxing = Sport(name: "Chessboxing", isOlympicSport: false)
print(chessBoxing.olympicStatus)


---------- 3. PROPERTY OBSERVERS 

Property observers let you run code before or after any property changes. 
To demonstrate this, we’ll write a Progress struct that tracks a task and a completion percentage:

struct Progress {
    var task: String
    var amount: Int
}

Agora podemos criar uma instância dessa estrutura e ajustar seu progresso ao longo do tempo:

var progress = Progress(task: "Loading data", amount: 0)
progress.amount = 30
progress.amount = 80
progress.amount = 100

What we want to happen is for Swift to print a message every time amount changes, 
and we can use a didSet property observer for that. This will run some code every time amount changes:

struct Progress {
    var task: String
    var amount: Int {
        didSet {
            print("\(task) is now \(amount)% complete")
        }
    }
}

You can also use willSet to take action before a property changes, but that is rarely used.


---------- 4. METHODS 

As estruturas podem ter funções dentro delas, e essas funções podem usar as propriedades da estrutura conforme necessário. 
As funções dentro das estruturas são chamadas de métodos, mas ainda usam a mesma palavra-chave func.

We can demonstrate this with a City struct. This will have a population property that stores how many people 
are in the city, plus a collectTaxes() method that returns the population count multiplied by 1000. 
Because the method belongs to City it can read the current city’s population property.

Aqui está o código:

struct City {
    var population: Int

    func collectTaxes() -> Int {
        return population * 1000
    }
}

Esse método pertence à estrutura, então o chamamos de instâncias da estrutura assim:

let london = City(population: 9_000_000)
london.collectTaxes()


---------- 5. MUTATING METHODS 

Se uma estrutura tem uma propriedade variável, mas a instância da estrutura foi criada como uma constante, 
essa propriedade não pode ser alterada - a estrutura é constante, então todas as suas propriedades também 
são constantes, independentemente de como foram criadas.

O problema é que, quando você cria a estrutura, a Swift não tem ideia se você a usará com constantes ou variáveis, 
portanto, por padrão, ela adota a abordagem segura: a Swift não permitirá que você escreva métodos que alterem as 
propriedades, a menos que você a solicite especificamente.

Quando você deseja alterar uma propriedade dentro de um método, você precisa marcá-la usando 
a palavra-chave mutating, assim:

struct Person {
    var name: String

    mutating func makeAnonymous() {
        name = "Anonymous"
    }
}

Because it changes the property, Swift will only allow that method to be called on Person instances that are variables:

var person = Person(name: "Ed")
person.makeAnonymous()



Por que precisamos marcar alguns métodos como mutantes?

É possível modificar as propriedades de uma estrutura, mas somente se essa estrutura for criada como uma variável. 
Claro, dentro da sua estrutura, não há como dizer se você estará trabalhando com uma estrutura variável ou uma estrutura 
constante, então a Swift tem uma solução simples: sempre que o método de uma estrutura tentar alterar 
qualquer propriedade, você deve marcá-la como mutating.

Você não precisa fazer nada além de marcar o método como mutating, mas isso dá à Swift informações suficientes para 
impedir que esse método seja usado com instâncias constantes de estrutura.

Há dois detalhes importantes que você achará úteis:

1.Marking methods as mutating will stop the method from being called on constant structs, even if the method itself 
doesn’t actually change any properties. If you say it changes stuff, Swift believes you!

2.Um método que não está marcado como mutante não pode chamar uma função mutante - você deve marcá-los como mutantes.


---------- 6.   PROPERTIES AND METHODS OF STRINGS 

Usamos muitas strings até agora, e acontece que elas são estruturas - elas têm 
seus próprios métodos e propriedades que podemos usar para consultar e manipular a string.

Primeiro, vamos criar uma sequência de teste:

let string = "Do or do not, there is no try."

Você pode ler o número de caracteres em uma string usando sua propriedade count:

print(string.count)

They have a hasPrefix() method that returns true if the string starts with specific letters:

print(string.hasPrefix("Do"))

Você pode colocar uma string em maiúsculas chamando seu método uppercased():

print(string.uppercased())

E você pode até fazer com que o Swift classifique as letras da string em uma matriz:

print(string.sorted())

Strings have lots more properties and methods – try typing string. to bring up Xcode’s code completion options.


---------- 7. PROPERTIES AND METHODS OF ARRAYS 

Arrays também são estruturas, o que significa que eles também têm seus próprios 
métodos e propriedades que podemos usar para consultar e manipular a matriz.

Aqui está uma matriz simples para nos ajudar a começar:

var toys = ["Woody"]

Você pode ler o número de itens em uma matriz usando sua propriedade count:

print(toys.count)

If you want to add a new item, use the append() method like this:

toys.append("Buzz")

Você pode localizar qualquer item dentro de uma matriz usando seu método firstIndex(), assim:

toys.firstIndex(of: "Buzz")
Isso retornará 1 porque os arrays contam de 0.

Assim como com strings, você pode fazer com que o Swift classifique os itens da matriz em ordem alfabética:

print(toys.sorted())

Finally, if you want to remove an item, use the remove() method like this:

toys.remove(at: 0)

Arrays have lots more properties and methods – try typing toys. to bring up Xcode’s code completion options.






