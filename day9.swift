18/04/2022


STRUCTS (ESTRUTURAS) - parte 2




---------- 1. INITIALIZERS 

Inicializadores são métodos especiais que fornecem diferentes maneiras de criar sua estrutura. 
Todas as estruturas vêm com uma por padrão, chamada de inicializador memberwise - 
isso pede que você forneça um valor para cada propriedade ao criar a estrutura.

You can see this if we create a User struct that has one property:

struct User {
    var username: String
}

Quando criamos uma dessas estruturas, devemos fornecer um nome de usuário:

var user = User(username: "twostraws")

Podemos fornecer nosso próprio inicializador para substituir o padrão. 
Por exemplo, podemos querer criar todos os novos usuários como "Anônimos" e imprimir uma mensagem, assim:

struct User {
    var username: String

    init() {
        username = "Anonymous"
        print("Creating a new user!")
    }
}

You don’t write func before initializers, but you do need to make sure all properties have a value before the initializer ends.

Agora nosso inicializador não aceita parâmetros, precisamos criar a estrutura assim:

var user = User()
user.username = "twostraws"


Por padrão, todas as estruturas Swift obtêm um inicializador sintetizado por membro por padrão, 
o que significa que obtemos automaticamente um inicializador que aceita valores para cada uma das propriedades da estrutura. 
Este inicializador torna as estruturas fáceis de trabalhar, mas Swift faz mais duas coisas que a tornam especialmente inteligente.

Primeiro, se alguma de suas propriedades tiver valores padrão, elas serão incorporadas ao inicializador como valores de parâmetros padrão. 
Então, se eu fizer uma estrutura como esta:

struct User {
    var name: String
    var yearsActive = 0
}

Então eu posso criá-lo de qualquer uma dessas duas maneiras:

struct Employee {
    var name: String
    var yearsActive = 0
}

let roslin = Employee(name: "Laura Roslin")
let adama = Employee(name: "William Adama", yearsActive: 45)

Isso os torna ainda mais fáceis de criar, porque você pode preencher apenas as peças necessárias.

A segunda coisa inteligente que Swift faz é remover o inicializador memberwise se você criar seu próprio inicializador.

Por exemplo, se eu tivesse um inicializador personalizado que criasse funcionários anônimos, ficaria assim:

struct Employee {
    var name: String
    var yearsActive = 0

    init() {
        self.name = "Anonymous"
        print("Creating an anonymous employee…")
    }
}

Com isso em vigor, eu não podia mais confiar no inicializador memberwise, então isso não seria mais permitido:

let roslin = Employee(name: "Laura Roslin")

Isso não é um acidente, mas é um recurso deliberado: criamos nosso próprio inicializador, e se a Swift deixou seu inicializador membro no lugar, 
pode estar faltando um trabalho importante que colocamos em nosso próprio inicializador.

Então, assim que você adiciona um inicializador personalizado para sua estrutura, o inicializador padrão memberwise desaparece. 
Se você quiser que ele permaneça, mova seu inicializador personalizado para uma extensão, como esta:

struct Employee {
    var name: String
    var yearsActive = 0
}

extension Employee {
    init() {
        self.name = "Anonymous"
        print("Creating an anonymous employee…")
    }
}

// creating a named employee now works
let roslin = Employee(name: "Laura Roslin")

// as does creating an anonymous employee
let anon = Employee()



---------- 2. REFERRING TO THE CURRENT INSTANCE 

Inside methods you get a special constant called self, which points to whatever instance of the struct is currently being used. 
This self value is particularly useful when you create initializers that have the same parameter names as your property.

For example, if you create a Person struct with a name property, 
then tried to write an initializer that accepted a name parameter, 
self helps you distinguish between the property and the parameter – 
self.name refers to the property, whereas name refers to the parameter.

Aqui está isso no código:

struct Person {
    var name: String

    init(name: String) {
        print("\(name) was born!")
        self.name = name
    }
}


---------- 3. LAZY PROPERTIES 

As a performance optimization, Swift lets you create some properties only when they are needed. 
As an example, consider this FamilyTree struct – it doesn’t do much, but in theory creating a family tree for someone takes a long time:

struct FamilyTree {
    init() {
        print("Creating family tree!")
    }
}

We might use that FamilyTree struct as a property inside a Person struct, like this:

struct Person {
    var name: String
    var familyTree = FamilyTree()

    init(name: String) {
        self.name = name
    }
}

var ed = Person(name: "Ed")

But what if we didn’t always need the family tree for a particular person? 
If we add the lazy keyword to the familyTree property, then Swift will only create the FamilyTree struct when it’s first accessed:

lazy var familyTree = FamilyTree()

Então, se você quiser ver a “Criando árvore genealógica!” mensagem, você precisa acessar a propriedade pelo menos uma vez:

ed.familyTree


Existem algumas razões pelas quais você prefere propriedades armazenadas ou calculadas em vez de uma propriedade preguiçosa, como:

1. O uso de propriedades preguiçosas pode acidentalmente produzir trabalho onde você não espera. 
Por exemplo, se você estiver construindo um jogo e acessando uma propriedade preguiçosa complexa pela primeira vez, 
isso pode fazer com que seu jogo fique mais lento, por isso é muito melhor fazer um trabalho lento na frente e tirá-lo do caminho.

2. As propriedades preguiçosas sempre armazenam seu resultado, o que pode ser desnecessário (porque você não vai usá-lo novamente) 
ou inútil (porque precisa ser recalculado com frequência).

3. Como as propriedades preguiçosas alteram o objeto subjacente ao qual estão anexadas, você não pode usá-las em estruturas constantes.

Ao tentar otimizar o código, geralmente é uma ideia melhor esperar até que você realmente tenha um problema que você precisa otimizar, 
em vez de espalhar prematuramente coisas como propriedades preguiçosas.


---------- 4. STATIC PROPERTIES AND METHODS 

Todas as propriedades e métodos que criamos até agora pertenciam a instâncias individuais de estruturas, o que significa que, 
se tivéssemos uma estrutura Student, poderíamos criar várias instâncias de estudante, cada uma com suas próprias propriedades e métodos:

struct Student {
    var name: String

    init(name: String) {
        self.name = name
    }
}

let ed = Student(name: "Ed")
let taylor = Student(name: "Taylor")

Você também pode pedir para Swift compartilhar propriedades e métodos específicos em todas as instâncias da estrutura, declarando-os como estáticos.

To try this out, we’re going to add a static property to the Student struct to store how many students are in the class. 
Each time we create a new student, we’ll add one to it:

struct Student {
    static var classSize = 0
    var name: String

    init(name: String) {
        self.name = name
        Student.classSize += 1
    }
}

Because the classSize property belongs to the struct itself rather than instances of the struct, we need to read it using Student.classSize:

print(Student.classSize)


---------- 5. ACCESS CONTROL 

O controle de acesso permite restringir qual código pode usar propriedades e métodos. 
Isso é importante porque você pode querer impedir que as pessoas leiam uma propriedade diretamente, por exemplo.

We could create a Person struct that has an id property to store their social security number:

struct Person {
    var id: String

    init(id: String) {
        self.id = id
    }
}

let ed = Person(id: "12345")

Once that person has been created, we can make their id be private so you can’t read it from outside the struct – 
trying to write ed.id simply won’t work.

Basta usar a palavra-chave private, assim:

struct Person {
    private var id: String

    init(id: String) {
        self.id = id
    }
}

Now only methods inside Person can read the id property. For example:

struct Person {
    private var id: String

    init(id: String) {
        self.id = id
    }

    func identify() -> String {
        return "My social security number is \(id)"
    }
}

Outra opção comum é o public, que permite que todos os outros códigos usem a propriedade ou método.


---------- 6. STRUCTS SUMMARY 

1. Você pode criar seus próprios tipos usando estruturas, que podem ter suas próprias propriedades e métodos.

2. Você pode usar propriedades armazenadas ou usar propriedades calculadas para calcular valores em tempo real.

3. Se você quiser alterar uma propriedade dentro de um método, você deve marcá-la como mutating.

4. Inicializadores são métodos especiais que criam estruturas. 
Você obtém um inicializador memberwise por padrão, mas se você criar o seu próprio, deve dar um valor a todas as propriedades.

5. Use the self constant to refer to the current instance of a struct inside a method.

6. The lazy keyword tells Swift to create properties only when they are first used.

7. Você pode compartilhar propriedades e métodos em todas as instâncias de uma estrutura usando a palavra-chave static.

8. O controle de acesso permite restringir quais códigos podem usar propriedades e métodos.














