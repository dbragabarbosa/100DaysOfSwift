15/03/2022

FUNCTIONS 

---------- 1. WRITING FUNCTIONS 

Ex: 

func printHelp() {
    let message = """
Welcome to MyApp!

Run this app inside a directory of images and
MyApp will resize them all into thumbnails
"""

    print(message)
}

We can now run that using printHelp() by itself:
printHelp()


---------- 2. ACCEPTING PARAMETERS 

Ex:

func square(number: Int) {
    print(number * number)
}

Isso diz à Swift que esperamos receber um Int, e ele deve ser chamado de number. Este nome é usado tanto dentro da função quando 
você deseja se referir ao parâmetro, quanto quando você executa a função, assim:

square(number: 8)


---------- 3. RETURNING VALUES 

func square(number: Int) -> Int {
    return number * number
}

Agora podemos pegar esse valor de retorno quando a função for executada e imprimi-lo lá:

let result = square(number: 8)
print(result)


Swift lets us skip using the return keyword when we have only one expression in our function. So, these two functions do the same thing:

func doMath() -> Int {
    return 5 + 5
}

func doMoreMath() -> Int {
    5 + 5
}


Como você pode retornar dois ou mais valores de uma função?
Ex:
func getUser() -> (first: String, last: String) {
    (first: "Taylor", last: "Swift")
}

let user = getUser()
print(user.first)


---------- 4. PARAMETER LABELS 

Swift nos permite fornecer dois nomes para cada parâmetro: um a ser usado externamente ao chamar a função e um a ser usado 
internamente dentro da função. Isso é tão simples quanto escrever dois nomes, separados por um espaço.

Para demonstrar isso, aqui está uma função que usa dois nomes para seu parâmetro string:

func sayHello(to name: String) {
    print("Hello, \(name)!")
}

The parameter is called to name, which means externally it’s called to, but internally it’s called name. 
This gives variables a sensible name inside the function, but means calling the function reads naturally:

sayHello(to: "Taylor")

Por ter os rótulos interno e externo, nossas funções leem mais naturalmente tanto onde as chamamos quanto dentro da própria função. 
Eles não são necessários e, muitas vezes, você terá apenas um rótulo para seus parâmetros, mas ainda é bom tê-los por perto.


---------- 5. OMITTING PARAMETER LABELS 

You might have noticed that we don’t actually send any parameter names when we call print() – we say print("Hello") 
rather than print(message: "Hello").

Você pode obter esse mesmo comportamento em suas próprias funções usando um sublinhado, _, para o nome do seu parâmetro externo, assim:

func greet(_ person: String) {
    print("Hello, \(person)!")
}

You can now call greet() without having to use the person parameter name:

greet("Taylor")


---------- 6. DEFAULT PARAMETERS 

You can give your own parameters a default value just by writing an = after its type followed by the default you want to give it. 
So, we could write a greet() function that can optionally print nice greetings:

func greet(_ person: String, nicely: Bool = true) {
    if nicely == true {
        print("Hello, \(person)!")
    } else {
        print("Oh no, it's \(person) again...")
    }
}

Isso pode ser chamado de duas maneiras:

greet("Taylor")
greet("Taylor", nicely: false)


Os desenvolvedores Swift usam parâmetros padrão com muita frequência, porque eles nos permitem nos concentrar nas partes importantes 
que precisam mudar regularmente. Isso pode realmente ajudar a simplificar a função complexa e tornar seu código mais fácil de escrever.

Por exemplo:

func findDirections(from: String, to: String, route: String = "fastest", avoidHighways: Bool = false) {
    // code here
}

Isso pressupõe que, na maioria das vezes, as pessoas querem dirigir entre dois locais pela rota mais rápida, sem evitar rodovias - 
padrões sensatos que provavelmente funcionarão a maior parte do tempo, ao mesmo tempo em que nos dão espaço para fornecer valores
personalizados quando necessário.

Como resultado, podemos chamar essa mesma função de qualquer uma das três maneiras:

findDirections(from: "London", to: "Glasgow")
findDirections(from: "London", to: "Glasgow", route: "scenic")
findDirections(from: "London", to: "Glasgow", route: "scenic", avoidHighways: true)

Código mais curto e simples na maioria das vezes, mas flexibilidade quando precisamos - perfeito.


---------- 7. VARIADIC FUNCTIONS 

Some functions are variadic, which is a fancy way of saying they accept any number of parameters of the same type. 
The print() function is actually variadic: if you pass lots of parameters, they are all printed on one line with spaces between them:

print("Haters", "gonna", "hate")

You can make any parameter variadic by writing ... after its type. 
So, an Int parameter is a single integer, whereas Int... is zero or more integers – potentially hundreds.

Dentro da função, o Swift converte os valores que foram passados em uma matriz de inteiros, para que você possa fazer 
um loop sobre eles conforme necessário.

To try this out, let’s write a square() function that can square many numbers:

func square(numbers: Int...) {
    for number in numbers {
        print("\(number) squared is \(number * number)")
    }
}

Agora podemos executar isso com muitos números apenas passando-os separados por vírgulas:

square(numbers: 1, 2, 3, 4, 5)


---------- 8. WRITING THROWING FUNCTIONS 

Sometimes functions fail because they have bad input, or because something went wrong internally. 
Swift lets us throw errors from functions by marking them as throws before their return type, then using the throw keyword when something goes wrong.

First we need to define an enum that describes the errors we can throw. These must always be based on Swift’s existing Error type. 
We’re going to write a function that checks whether a password is good, so we’ll throw an error if the user tries an obvious password:

enum PasswordError: Error {
    case obvious
}

Now we’ll write a checkPassword() function that will throw that error if something goes wrong. 
This means using the throws keyword before the function’s return value, then using throw PasswordError.obvious if their password is “password”.

Aqui está isso em Swift:

func checkPassword(_ password: String) throws -> Bool {
    if password == "password" {
        throw PasswordError.obvious
    }

    return true
}


---------- 9. RUNNING THROWING FUNCTIONS 

A Swift não gosta que erros aconteçam quando seu programa é executado, o que significa que não permitirá que você execute 
uma função de lançamento de erros por acidente.

Instead, you need to call these functions using three new keywords: do starts a section of code that might cause problems, 
try is used before every function that might throw an error, and catch lets you handle errors gracefully.

If any errors are thrown inside the do block, execution immediately jumps to the catch block. Let’s try calling checkPassword() 
with a parameter that throws an error:

do {
    try checkPassword("password")
    print("That password is good!")
} catch {
    print("You can't use that password.")
}

Quando esse código é executado, "Você não pode usar essa senha" é impresso, mas "Essa senha é boa" não será - 
esse código nunca será alcançado, porque o erro é lançado.


Using Swift’s throwing functions relies on three unique keywords: do, try, and catch. We need all three to be able to call a 
throwing function, which is unusual – most other languages use only two, because they don’t need to write try before every throwing function.

The reason Swift is different is fairly simple: by forcing us to use try before every throwing function, we’re explicitly acknowledging 
which parts of our code can cause errors. This is particularly useful if you have several throwing functions in a single do block, like this:

do {
    try throwingFunction1()
    nonThrowingFunction1()
    try throwingFunction2()
    nonThrowingFunction2()
    try throwingFunction3()
} catch {
    // handle errors
}

As you can see, using try makes it clear that the first, third, and fifth function calls can throw errors, but the second and fourth cannot.


---------- 10. INOUT PARAMETERS 

Todos os parâmetros passados para uma função Swift são constantes, então você não pode alterá-los. 
Se quiser, você pode passar um ou mais parâmetros como inout, o que significa que eles podem ser alterados dentro da sua função, 
e essas alterações refletem no valor original fora da função.

Por exemplo, se você quiser dobrar um número no lugar - ou seja, alterar o valor diretamente em vez de retornar um novo - 
você pode escrever uma função como esta:

func doubleInPlace(number: inout Int) {
    number *= 2
}

To use that, you first need to make a variable integer – you can’t use constant integers with inout, 
because they might be changed. You also need to pass the parameter to doubleInPlace using an ampersand, &, 
before its name, which is an explicit recognition that you’re aware it is being used as inout.

Em código, você escreveria o seguinte:

var myNum = 10 
doubleInPlace(number: &myNum)


---------- 11. FUNCTIONS SUMMARY 

1.As funções nos permitem reutilizar o código sem nos repetir.

2.As funções podem aceitar parâmetros - basta dizer à Swift o tipo de cada parâmetro.

3.As funções podem retornar valores e, novamente, basta especificar qual tipo será enviado de volta. Use tuplas se quiser devolver várias coisas.

4.Você pode usar nomes diferentes para parâmetros externa e internamente, ou omitir completamente o nome externo.

5.Os parâmetros podem ter valores padrão, o que ajuda você a escrever menos código quando valores específicos são comuns.

6.Funções variáveis aceitam zero ou mais de um parâmetro específico, e Swift converte a entrada em uma matriz.

7.Functions can throw errors, but you must call them using try and handle errors using catch.

8.You can use inout to change variables inside a function, but it’s usually better to return a new value.





