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










