16/03/2022

CLOSURES (ENCERRAMENTOS) - parte 1

---------- 1. CREATING BASIC CLOSURES 

Swift nos permite usar funções como qualquer outro tipo, como strings e inteiros. Isso significa que você pode criar uma função 
e atribuí-la a uma variável, chamar essa função usando essa variável e até mesmo passar essa função para outras funções como parâmetros.

As funções usadas dessa maneira são chamadas de fechamentos e, embora funcionem como funções, são escritas de maneira um pouco diferente.

Vamos começar com um exemplo simples que imprime uma mensagem:

let driving = {
    print("I'm driving in my car")
}

That effectively creates a function without a name, and assigns that function to driving. 
You can now call driving() as if it were a regular function, like this:

driving()


Uma das razões mais comuns para fechamentos em Swift é armazenar a funcionalidade - para poder 
dizer "aqui está algum trabalho que eu quero que você faça em algum momento, mas não necessariamente agora". Alguns exemplos:

1.Executando algum código após um atraso.

2.Executando algum código após a conclusão de uma animação.

3.Executando algum código quando um download terminar.

4.Executando algum código quando um usuário seleciona uma opção no seu menu.

5.Os fechamentos nos permitem envolver algumas funcionalidades em uma única variável e, em seguida, armazená-las em algum lugar. 
Também podemos devolvê-lo de uma função e armazenar o fechamento em outro lugar.


---------- 2. ACCEPTING PARAMETERS IN A CLOSURE 

Quando você cria fechamentos, eles não têm um nome ou espaço para escrever nenhum parâmetro. 
Isso não significa que eles não possam aceitar parâmetros, apenas que o fazem de uma maneira diferente: 
eles estão listados dentro das chaves abertas.

To make a closure accept parameters, list them inside parentheses just after the opening brace, then write in so that 
Swift knows the main body of the closure is starting.

Por exemplo, poderíamos fazer um fechamento que aceite uma string de nome de lugar como seu único parâmetro como este:

let driving = { (place: String) in
    print("I'm going to \(place) in my car")
}

One of the differences between functions and closures is that you don’t use parameter labels when running closures. 
So, to call driving() now we’d write this:

driving("London")


Tanto os fechamentos quanto as funções podem ter parâmetros, mas a maneira como eles assumem parâmetros é muito diferente. Aqui está uma função que aceita uma string e um inteiro:

func pay(user: String, amount: Int) {
    // code
}
E aqui está exatamente a mesma coisa escrita como um encerramento:

let payment = { (user: String, amount: Int) in
    // code
}
As you can see, the parameters have moved inside the braces, and the in keyword is there to mark the 
end of the parameter list and the start of the closure’s body itself.

Closures take their parameters inside the brace to avoid confusing Swift: if we had written 
let payment = (user: String, amount: Int) then it would look like we were trying to create a tuple, not a closure, which would be strange.

Se você pensar sobre isso, ter os parâmetros dentro das chaves também captura perfeitamente a maneira como a coisa toda é 
um bloco de dados armazenados dentro da variável - a lista de parâmetros e o corpo de fechamento fazem parte do mesmo pedaço de 
código e armazenados em nossa variável.

Having the parameter list inside the braces shows why the in keyword is so important – without that it’s hard for Swift to 
know where your closure body actually starts, because there’s no second set of braces.



---------- 3. RETURNING VALUES FROM A CLOSURE 

Os fechamentos também podem retornar valores, e eles são escritos de forma semelhante aos parâmetros: 
você os escreve dentro do seu fechamento, diretamente antes da palavra-chave in.

To demonstrate this, we’re going to take our driving() closure and make it return its value rather than print it directly. Here’s the original:

let driving = { (place: String) in
    print("I'm going to \(place) in my car")
}

We want a closure that returns a string rather than printing the message directly, so we need to use -> String before in, 
then use return just like a normal function:

let drivingWithReturn = { (place: String) -> String in
    return "I'm going to \(place) in my car"
}

Agora podemos executar esse fechamento e imprimir seu valor de retorno:

let message = drivingWithReturn("London")
print(message)


Como você retorna um valor de um fechamento que não recebe parâmetros?

Aqui está um fechamento que aceita um parâmetro e não retorna nada:

let payment = { (user: String) in
    print("Paying \(user)…")
}

Agora, aqui está um fechamento que aceita um parâmetro e retorna um booleano:

let payment = { (user: String) -> Bool in
    print("Paying \(user)…")
    return true
}

If you want to return a value without accepting any parameters, you can’t just write -> Bool in – 
Swift won’t understand what you mean. Instead, you should use empty parentheses for your parameter list, like this:

let payment = { () -> Bool in
    print("Paying an anonymous person…")
    return true
}

Se você pensar sobre isso, isso funciona da mesma forma que uma função padrão onde escreveria func payment() -> Bool.


---------- 4. CLOSURES AS PARAMETERS 

Como os fechamentos podem ser usados como strings e inteiros, você pode passá-los para funções. 
A sintaxe para isso pode prejudicar seu cérebro no início, então vamos devagar.

First, here’s our basic driving() closure again

let driving = {
    print("I'm driving in my car")
}

Se quiséssemos passar esse fechamento para uma função para que ela possa ser executada dentro dessa função, 
especificaríamos o tipo de parâmetro como () -> Void. Isso significa "não aceita parâmetros e retorna Void" - a maneira de Swift de dizer "nada".

So, we can write a travel() function that accepts different kinds of traveling actions, and prints a message before and after:

func travel(action: () -> Void) {
    print("I'm getting ready to go.")
    action()
    print("I arrived!")
}

Agora podemos chamar isso usando nosso fechamento driving, assim:

travel(action: driving)


O fechamento passado não pode receber nenhum parâmetro e nem retornar nada


---------- 5. TRAILING CLOSURE SYNTAX 

Se o último parâmetro de uma função for um fechamento, o Swift permite que você use uma sintaxe especial chamada sintaxe 
de fechamento à direita. Em vez de passar seu fechamento como parâmetro, você o passa diretamente após a função dentro das chaves.

To demonstrate this, here’s our travel() function again. It accepts an action closure so that it can be run between two print() calls:

func travel(action: () -> Void) {
    print("I'm getting ready to go.")
    action()
    print("I arrived!")
}

Because its last parameter is a closure, we can call travel() using trailing closure syntax like this:

travel() {
    print("I'm driving in my car")
}

Na verdade, como não há outros parâmetros, podemos eliminar completamente os parênteses:

travel {
    print("I'm driving in my car")
}

A sintaxe de fechamento à direita é extremamente comum em Swift, então vale a pena se acostumar.


Por que a Swift tem sintaxe de fechamento à direita?

A sintaxe de fechamento à direita foi projetada para tornar o código Swift mais fácil de ler, embora alguns prefiram evitá-lo.

Let’s start with a simple example first. Here’s a function that accepts a Double then a closure full of changes to make:

func animate(duration: Double, animations: () -> Void) {
    print("Starting a \(duration) second animation…")
    animations()
}

(Caso você esteja se perguntando, essa é uma versão simplificada de uma função UIKit real e muito comum!)

Podemos chamar essa função sem um fechamento posterior como este:

animate(duration: 3, animations: {
    print("Fade out the image")
})

That’s very common. Many people don’t use trailing closures, and that’s OK. But many more Swift developers 
look at the }) at the end and wince a little – it isn’t pleasant.

Fechamentos à direita nos permitem limpar isso, ao mesmo tempo em que removemos o rótulo do parâmetro animations. 
Essa mesma chamada de função se torna esta:

animate(duration: 3) {
    print("Fade out the image")
}

Fechamentos à direita funcionam melhor quando seu significado está diretamente ligado ao nome da função - você pode 
ver o que o fechamento está fazendo porque a função é chamada animate().

Se você não tem certeza se deve usar fechamentos finais ou não, meu conselho é começar a usá-los em todos os lugares. 
Depois de dar a eles um mês ou dois, você terá uso suficiente para olhar para trás e decidir com mais clareza, mas espero 
que você se acostume com eles porque eles são realmente comuns em Swift!


