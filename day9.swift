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



