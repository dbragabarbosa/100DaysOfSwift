29/04/2022


OPTIONALS (opcionais)

Referências nula - literalmente quando uma variável não tem valor - foram inventadas por Tony Hoare em 1965. 
Quando perguntado sobre isso em retrospecto, ele disse: "Eu chamo isso de meu erro de bilhões de dólares" porque eles levam a muitos problemas.

Este dia é dedicado exclusivamente à solução da Swift para referências nulas, conhecidas como opcionais. 
Estes são um recurso de linguagem muito importante, mas podem machucar um pouco o seu cérebro.


---------- 1. HANDLING MISSING DATA 

We’ve used types such as Int to hold values like 5. 
But if you wanted to store an age property for users, what would you do if you didn’t know someone’s age?

Você pode dizer “bem, eu vou guardar 0”, mas então você ficaria confuso entre bebês recém-nascidos e pessoas cuja idade você não conhece. 
Você poderia usar um número especial, como 1000 ou -1, para representar "desconhecido", ambos idades impossíveis, 
mas então você realmente se lembraria desse número em todos os lugares em que é usado?

Swift’s solution is called optionals, and you can make optionals out of any type. 
An optional integer might have a number like 0 or 40, but it might have no value at all – it might literally be missing, which is nil in Swift.

Para tornar um tipo opcional, adicione um ponto de interrogação depois dele. Por exemplo, podemos criar um número inteiro opcional como este:

var age: Int? = nil

Isso não contém nenhum número - não contém nada. Mas se aprendermos essa idade mais tarde, podemos usá-la:

age = 38



Os opcionais da Swift são um de seus recursos mais poderosos, além de serem um dos mais confusos. 
Seu trabalho principal é simples: eles nos permitem representar a ausência de alguns dados - uma string que não está apenas vazia, 
mas literalmente não existe.

Qualquer tipo de dados pode ser opcional em Swift:

- Um inteiro pode ser 0, -1, 500 ou qualquer outro intervalo de números.

- Um inteiro opcional pode ser todos os valores inteiros regulares, mas também pode ser nil - pode não existir.

- Uma corda pode ser "Olá", pode ser as obras completas de Shakespeare, ou pode ser "" - uma corda vazia.

- Uma string opcional pode ser qualquer valor de string regular, mas também pode ser nil.

- A custom User struct could contain all sorts of properties that describe a user.

- An optional User struct could contain all those same properties, or not exist at all.

- Fazer essa distinção entre "pode ser qualquer valor possível para esse tipo" e "pode ser nulo" é a chave 
para entender os opcionais, e às vezes não é fácil.

Por exemplo, pense em booleanos: eles podem ser verdadeiros ou falsos. Isso significa que um Bool opcional pode ser verdadeiro, 
falso ou nenhum dos dois - não pode ser nada. Isso é um pouco difícil de entender mentalmente, porque certamente algo é sempre verdadeiro 
ou falso a qualquer momento?

Bem, me responda o seguinte: eu gosto de chocolate? A menos que você seja um amigo meu ou talvez me siga muito de perto no Twitter, 
você não pode dizer com certeza - você definitivamente não pode dizer Verdadeiro (eu gosto de chocolate) ou Falso (eu não gosto de chocolate), 
porque você simplesmente não sabe. Claro, você poderia me perguntar e descobrir, mas até que você faça isso, a única resposta segura é "Eu não sei", 
que neste caso poderia ser representada tornando o booleano opcional com um valor nulo.

Isso também é um pouco confuso quando você pensa em strings vazias, “”. 
Essa string não contém nada, mas isso não é a mesma coisa que nil - uma string vazia ainda é uma string.



---------- 2. UNWRAPPING OPTIONALS (desembrulhando opcionais)

Strings opcionais podem conter uma string como "Olá" ou podem ser nulas - nada.

Considere esta string opcional:

var name: String? = nil

What happens if we use name.count? A real string has a count property that stores how many letters it has, 
but this is nil – it’s empty memory, not a string, so it doesn’t have a count.

Because of this, trying to read name.count is unsafe and Swift won’t allow it. 
Instead, we must look inside the optional and see what’s there – a process known as unwrapping.

Uma maneira comum de desembrulhar opcionais é com a sintaxe if let, que desembrulha com uma condição. 
Se houvesse um valor dentro do opcional, então você pode usá-lo, mas se não houvesse, a condição falha.

Por exemplo:

if let unwrapped = name {
    print("\(unwrapped.count) letters")
} else {
    print("Missing name.")
}

If name holds a string, it will be put inside unwrapped as a regular String and we can read its count property inside the condition. 
Alternatively, if name is empty, the else code will be run.



Swift’s optionals can either store a value, such as 5 or “Hello”, or they might be nothing at all. 
As you might imagine, trying to add two numbers together is only possible if the numbers are actually there, 
which is why Swift won’t let us try to use the values of optionals unless we unwrap them – unless we look inside the optional, 
check there’s actually a value there, then take the value out for us.

There are several ways of doing this in Swift, but one of the most common is if let, like this:

func getUsername() -> String? {
    "Taylor"
}

if let username = getUsername() {
    print("Username is \(username)")
} else {
    print("No username")
}

The getUsername() function returns an optional string, which means it could be a string or it could be nil. 
I’ve made it always return a value here to make it easier to understand, but that doesn’t change what Swift thinks – it’s still an optional string.

That single if let line combines lots of functionality:

1. It calls the getUsername() function.

2. It receives the optional string back from there.

3. It looks inside the optional string to see whether it has a value.

4. As it does have a value (it’s “Taylor”), that value will be taken out of the optional and placed into a new username constant.

5. The condition is then considered true, and it will print “Username is Taylor”.

6. So, if let is a fantastically concise way of working with optionals, taking care of checking and extracting values all at once.

The single most important feature of optionals is that Swift won’t let us use them without unwrapping them first. 
This provides a huge amount of protection for all our apps, because it puts a stop to uncertainty: when you’re handing a string you know it’s a vali
string, when you call a function that returns an integer, you know it’s immediately safe to use. And when you do have optionals in your code, Swift 
will always make sure you handle them correctly – that you check and unwrap them, rather than just mixing unsafe values with known safe data.



---------- 3. UNWRAPPING WITH GUARD 

An alternative to if let is guard let, which also unwraps optionals. guard let will unwrap an optional for you, 
but if it finds nil inside it expects you to exit the function, loop, or condition you used it in.

However, the major difference between if let and guard let is that your unwrapped optional remains usable after the guard code.

Let’s try it out with a greet() function. This will accept an optional string as its only parameter and try to unwrap it, 
but if there’s nothing inside it will print a message and exit. Because optionals unwrapped using guard let stay around after 
the guard finishes, we can print the unwrapped string at the end of the function:

func greet(_ name: String?) {
    guard let unwrapped = name else {
        print("You didn't provide a name!")
        return
    }

    print("Hello, \(unwrapped)!")
}

Using guard let lets you deal with problems at the start of your functions, then exit immediately. 
This means the rest of your function is the happy path – the path your code takes if everything is correct.



Swift gives us an alternative to if let called guard let, which also unwraps optionals if they contain a value, 
but works slightly differently: guard let is designed to exit the current function, loop, or condition if the check fails, 
so any values you unwrap using it will stay around after the check.

Para demonstrar a diferença, aqui está uma função que retorna o significado da vida como um inteiro opcional:

func getMeaningOfLife() -> Int? {
    42
}

E aqui está essa função que está sendo usada dentro de outra função, chamada printMeaningOfLife():

func printMeaningOfLife() {
    if let name = getMeaningOfLife() {
        print(name)
    }
}

That uses if let, so that the result of getMeaningOfLife() will only be printed if it returned an integer rather than nil.

If we had written that using guard let, it would look like this:

func printMeaningOfLife() {
    guard let name = getMeaningOfLife() else {
        return
    }

    print(name)
}

Sim, isso é um pouco mais longo, mas duas coisas importantes mudaram:

1. Isso nos permite focar no "caminho feliz" - o comportamento da nossa função quando tudo foi planejado, que é imprimir o sentido da vida.

2. guard requer que saiamos do escopo atual quando ele for usado, o que, neste caso, significa que devemos retornar da função se ela falhar. 
Isso não é opcional: Swift não compilará nosso código sem que isso return.

It’s common to see guard used one or more times at the start of methods, because it’s used to verify some conditions are correct up front. 
This makes our code easier to read than if we tried to check a condition then run some code, then check another condition and run some different code.

So, use if let if you just want to unwrap some optionals, but prefer guard let if you’re 
specifically checking that conditions are correct before continuing.



---------- 4. FORCE UNWRAPPING (forçar o desembrulho)

Os opcionais representam dados que podem ou não estar lá, mas às vezes você sabe com certeza que um valor não é nulo. 
Nesses casos, o Swift permite forçar o desembrulho opcional: converta-o de um tipo opcional para um tipo não opcional.

For example, if you have a string that contains a number, you can convert it to an Int like this:

let str = "5"
let num = Int(str)

That makes num an optional Int because you might have tried to convert a string like “Fish” rather than “5”.

Even though Swift isn’t sure the conversion will work, you can see the code is safe so 
you can force unwrap the result by writing ! after Int(str), like this:

let num = Int(str)!

Swift will immediately unwrap the optional and make num a regular Int rather than an Int?. But if you’re wrong – 
if str was something that couldn’t be converted to an integer – your code will crash.

Como resultado, você deve forçar o desembrulho somente quando tiver certeza de que é seguro - 
há uma razão pela qual muitas vezes é chamado de operador de colisão.



---------- 5. IMPLICITY UNWRAPPED OPTIONALS (opcionais implicitamente desembrulhados)

Como os opcionais regulares, os opcionais implicitamente desembrulhados podem conter um valor ou podem ser nil. 
No entanto, ao contrário dos opcionais regulares, você não precisa desembrulhá-los para usá-los: você pode usá-los como se não fossem opcionais.

Os opcionais implicitamente desembrulhados são criados adicionando um ponto de exclamação após o nome do seu tipo, assim:

let age: Int! = nil

Because they behave as if they were already unwrapped, you don’t need if let or guard let to use implicitly unwrapped optionals. 
However, if you try to use them and they have no value – if they are nil – your code crashes.

Implicitly unwrapped optionals exist because sometimes a variable will start life as nil, but will always have a value before you need to use it. 
Because you know they will have a value by the time you need them, it’s helpful not having to write if let all the time.

Dito isto, se você for capaz de usar opcionais regulares, geralmente é uma boa ideia.



---------- 6. NIL COALESCING (caraciamento nulo)

The nil coalescing operator unwraps an optional and returns the value inside if there is one. If there isn’t a value – 
if the optional was nil – then a default value is used instead. Either way, the result won’t be optional: it will either 
be the value from inside the optional or the default value used as a backup.

Aqui está uma função que aceita um inteiro como seu único parâmetro e retorna uma string opcional:

func username(for id: Int) -> String? {
    if id == 1 {
        return "Taylor Swift"
    } else {
        return nil
    }
}

If we call that with ID 15 we’ll get back nil because the user isn’t recognized, but with nil coalescing 
we can provide a default value of “Anonymous” like this:

let user = username(for: 15) ?? "Anonymous"

That will check the result that comes back from the username() function: if it’s a string then it will be unwrapped and placed into user, 
but if it has nil inside then “Anonymous” will be used instead.



A coalescência nula nos permite tentar desembrulhar um opcional, mas fornecer um valor padrão se o opcional contiver nil. 
Isso é extraordinariamente útil em Swift, porque, embora os opcionais sejam um ótimo recurso, geralmente é melhor ter um não opcional - 
ter uma string real em vez de um "pode ser uma string, pode ser nulo" - e a coalescência nula é uma ótima maneira de conseguir isso.

Por exemplo, se você estava trabalhando em um aplicativo de bate-papo e queria carregar qualquer rascunho de mensagem 
que o usuário tivesse salvo, você pode escrever um código assim:

let savedData = loadSavedMessage() ?? ""

So, if loadSavedMessage() returns an optional with a string inside, it will be unwrapped and placed into savedData. 
But if the optional is nil then Swift will set savedData to be an empty string. Either way, savedData will end up being a String and not a String?.

Você pode encadear zero coalescendo se quiser, embora eu não ache que seja comum. Então, esse tipo de código é válido se você quiser:

let savedData = first() ?? second() ?? ""

Isso tentará executar first(), e se isso retornar nil, tente executar second(), e se isso retornar nil, ele usará uma string vazia.

Lembre-se, a leitura de uma chave de dicionário sempre retornará uma opcional, então você pode querer usar a coalescência nil aqui 
para garantir que você volte uma não opcional:

let scores = ["Picard": 800, "Data": 7000, "Troi": 900]
let crusherScore = scores["Crusher"] ?? 0

Esta é definitivamente uma questão de gosto, mas os dicionários oferecem uma abordagem ligeiramente diferente que nos permite especificar o 
valor padrão para quando a chave não for encontrada:

let crusherScore = scores["Crusher", default: 0]

Você pode escolher o que preferir - ao ler os valores do dicionário, não há diferença real.



---------- 7. OPTIONAL CHAINING 

Swift provides us with a shortcut when using optionals: if you want to access something like a.b.c and b is optional, 
you can write a question mark after it to enable optional chaining: a.b?.c.

When that code is run, Swift will check whether b has a value, and if it’s nil the rest of the line will be ignored – 
Swift will return nil immediately. But if it has a value, it will be unwrapped and execution will continue.

Para experimentar isso, aqui está uma variedade de nomes:

let names = ["John", "Paul", "George", "Ringo"]

We’re going to use the first property of that array, which will return the first name if there is one or nil if the array is empty.
 We can then call uppercased() on the result to make it an uppercase string:

let beatle = names.first?.uppercased()

That question mark is optional chaining – if first returns nil then Swift won’t try to uppercase it, and will set beatle to nil immediately.



---------- 8. OPTIONAL TRY 

Quando estávamos falando sobre funções de lançamento, olhamos para este código:

enum PasswordError: Error {
    case obvious
}

func checkPassword(_ password: String) throws -> Bool {
    if password == "password" {
        throw PasswordError.obvious
    }

    return true
}

do {
    try checkPassword("password")
    print("That password is good!")
} catch {
    print("You can't use that password.")
}

That runs a throwing function, using do, try, and catch to handle errors gracefully.

Existem duas alternativas para try, ambas farão mais sentido agora que você entende os opcionais e força o desembrulhar.

The first is try?, and changes throwing functions into functions that return an optional. If the function throws an error you’ll be 
sent nil as the result, otherwise you’ll get the return value wrapped as an optional.

Using try? we can run checkPassword() like this:

if let result = try? checkPassword("password") {
    print("Result was \(result)")
} else {
    print("D'oh.")
}

A outra alternativa é try!, que você pode usar quando tiver certeza de que a função não falhará. Se a função lançar um erro, seu código falhará.

Usando try! podemos reescrever o código para isso:

try! checkPassword("sekrit")
print("OK!")



We can run throwing functions using do, try, and catch in Swift, but an alternative is to use try? to convert a throwing function call 
into an optional. If the function succeeds, its return value will be an optional containing whatever you would normally have received back, 
and if it fails the return value will be an optional set to nil.

Existem vantagens e desvantagens em usar o try opcional, mas ele gira principalmente em torno da importância do erro para você. 
Se você quer executar uma função e se preocupar apenas para que ela seja bem-sucedida ou falhe - você não precisa distinguir entre as 
várias razões pelas quais ela pode falhar - então usar a tentativa opcional é uma ótima opção, porque você pode resumir a coisa toda a "funcionou?"

Então, em vez de escrever isso:

do {
    let result = try runRiskyFunction()
    print(result)
} catch {
    // it failed!
}

Em vez disso, você pode escrever isso:

if let result = try? runRiskyFunction() {
    print(result)
}

If that’s what you wanted to do then you could just make runRiskyFunction() return an optional rather than throwing an error, 
but throwing and using optional try does give us the flexibility to change our mind later. That is, if we write a function that throws errors 
then at the call site we can either use try/catch or use optional try based on what we need at that point.

Se vale de alguma coisa, eu uso muito o opcional no meu próprio código, porque ele faz maravilhas por me deixar focar no problema em questão.



---------- 9. FAILABLE INITIALIZERS (inicializadores com falha)

Ao falar sobre desembrulhar de força, usei este código:

let str = "5"
let num = Int(str)

Isso converte uma string em um inteiro, mas como você pode tentar passar qualquer string lá, 
o que você realmente recebe de volta é um inteiro opcional.

This is a failable initializer: an initializer that might work or might not. 
You can write these in your own structs and classes by using init?() rather than init(), and return nil if something goes wrong. 
The return value will then be an optional of your type, for you to unwrap however you want.

As an example, we could code a Person struct that must be created using a nine-letter ID string. 
If anything other than a nine-letter string is used we’ll return nil, otherwise we’ll continue as normal.

Aqui está isso em Swift:

struct Person {
    var id: String

    init?(id: String) {
        if id.count == 9 {
            self.id = id
        } else {
            return nil
        }
    }
}



Se um inicializador para uma estrutura ou classe puder falhar - se você perceber parcialmente que não pode criar o objeto usando os dados que 
lhe foram fornecidos - então você precisa de um inicializador com falha. Em vez de retornar uma nova instância de objeto, isso retorna uma 
instância opcional que será nula se a inicialização falhar.

Fazer um inicializador com falha leva duas etapas:

1. Escreva seu inicializador como init?() em vez deinit()
2. Retorna nil para quaisquer caminhos que devam falhar

Você pode ter quantos caminhos de falha precisar, mas não precisa se preocupar com o caminho do sucesso - se você não retornar nulo do método, 
Swift assume que você quer dizer que tudo funcionou corretamente.

To demonstrate this, here’s an Employee struct that has a failable initializer with two checks:

struct Employee {
    var username: String
    var password: String

    init?(username: String, password: String) {
        guard password.count >= 8 else { return nil }
        guard password.lowercased() != "password" else { return nil }

        self.username = username
        self.password = password
    }
}

Isso requer que as senhas tenham pelo menos 8 caracteres e não sejam a string "senha". Podemos tentar isso com dois exemplos de funcionários:

let tim = Employee(username: "TimC", password: "app1e")
let craig = Employee(username: "CraigF", password: "ha1rf0rce0ne")

O primeiro deles será um conjunto opcional como nulo porque a senha é muito curta, 
mas o segundo será um conjunto opcional para uma instância válida User.

Inicializadores com falha nos dão a oportunidade de desistir da criação de um objeto se as verificações de validação falharem. 
No caso anterior, essa era uma senha muito curta, mas você também pode verificar se o nome de usuário já foi usado, se a senha era a 
mesma que o nome de usuário e assim por diante.

Sim, você poderia absolutamente colocar essas verificações em um método separado, mas é muito mais seguro colocá-las no inicializador - 
é muito fácil esquecer de chamar o outro método, e não adianta deixar esse buraco aberto.



---------- 10. TYPECASTING 

A Swift deve sempre saber o tipo de cada uma das suas variáveis, mas às vezes você sabe mais informações do que a Swift. 
Por exemplo, aqui estão três classes:

class Animal { }
class Fish: Animal { }

class Dog: Animal {
    func makeNoise() {
        print("Woof!")
    }
}

Podemos criar alguns peixes e alguns cães e colocá-los em uma matriz, assim:

let pets = [Fish(), Dog(), Fish(), Dog()]
Swift can see both Fish and Dog inherit from the Animal class, so it uses type inference to make pets an array of Animal.

If we want to loop over the pets array and ask all the dogs to bark, we need to perform a typecast: 
Swift will check to see whether each pet is a Dog object, and if it is we can then call makeNoise().

Isso usa uma nova palavra-chave chamadaas?, que retorna um opcional: será nil se o typecast falhar ou um tipo convertido de outra forma.

Veja como escrevemos o loop em Swift:

for pet in pets {
    if let dog = pet as? Dog {
        dog.makeNoise()
    }
}



O tipo de fundição nos permite dizer à Swift que um objeto que ele acha que é do tipo A é realmente do tipo B, 
o que é útil quando se trabalha com protocolos e herança de classes.

Como você viu, os protocolos nos permitem agrupar funcionalidades comuns para que possamos compartilhar código. 
No entanto, algumas vezes precisamos ir na direção oposta - precisamos ser capazes de ver 
"você tem um objeto que está em conformidade com um protocolo, mas eu gostaria que você me deixasse usá-lo como um tipo específico".

Para demonstrar isso, aqui está uma hierarquia de classes simples:

class Person {
    var name = "Anonymous"
}

class Customer: Person {
    var id = 12345
}

class Employee: Person {
    var salary = 50_000
}

Eu usei valores padrão para cada propriedade, então não precisamos escrever um inicializador.

Podemos criar uma instância de cada um deles e adicioná-los à mesma matriz:

let customer = Customer()
let employee = Employee()
let people = [customer, employee]

Because both Customer and Employee inherit from Person, Swift will consider that people constant to be a Person array. 
So, if we loop over people we’ll only be able to access the name of each item in the array – or at least we would only be able to do that, 
if it weren’t for type casting:

for person in people {
    if let customer = person as? Customer {
        print("I'm a customer, with id \(customer.id)")
    } else if let employee = person as? Employee {
        print("I'm an employee, earning $\(employee.salary)")
    }
}

As you can see, that attempts to convert person first to Customer and then to Employee. 
If either test passes, we can then use the extra properties that belong to that class, as well as the name property from the parent class.

A fundição de tipo não é especificamente desaprovada em Swift, mas eu diria que a fundição de tipo repetida pode significar que você tem um 
problema subjacente em seu código. Mais especificamente, a Swift funciona melhor quando entende com quais dados você está trabalhando, e um 
tipo de elenco efetivamente diz à Swift: "Eu sei mais informações do que você". Se você encontrar maneiras de transmitir essas informações 
para Swift para que ela também as entenda, isso geralmente funciona melhor.




---------- 11. OPTIONALS SUMMARY 

Você chegou ao final da décima parte desta série, então vamos resumir:

1. Os opcionais nos permitem representar a ausência de um valor de maneira clara e inequívoca.

2. Swift won’t let us use optionals without unwrapping them, either using if let or using guard let.

3. You can force unwrap optionals with an exclamation mark, but if you try to force unwrap nil your code will crash.

4. Os opcionais implicitamente desembrulhados não têm as verificações de segurança dos opcionais regulares.

5. Você pode usar a coalescência nula para desembrulhar um opcional e fornecer um valor padrão se não houver nada dentro.

6. O encadeamento opcional nos permite escrever código para manipular um opcional, mas se o opcional estiver vazio, o código será ignorado.

7. Você pode try? para converter uma função de lançamento em um valor de retorno opcional, ou try! para travar se um erro for lançado.

8. Se você precisar que seu inicializador falhe quando receber uma entrada ruim, use init?() para fazer um inicializador com falha.

9. Você pode usar o typecasting para converter um tipo de objeto em outro.



