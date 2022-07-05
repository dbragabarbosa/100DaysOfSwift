17/03/2022

CLOSURES (ENCERRAMENTOS) - parte 2


---------- 1. USING CLOSURES AS PARAMETERS WHEN THEY ACCEPT PARAMETERS 

É aqui que os fechamentos podem começar a ser lidos um pouco como o ruído da linha: 
um fechamento que você passa para uma função também pode aceitar seus próprios parâmetros.

We’ve been using () -> Void to mean “accepts no parameters and returns nothing”, but you can go ahead 
and fill the () with the types of any parameters that your closure should accept.

To demonstrate this, we can write a travel() function that accepts a closure as its only parameter, 
and that closure in turn accepts a string:

func travel(action: (String) -> Void) {
    print("I'm getting ready to go.")
    action("London")
    print("I arrived!")
}

Now when we call travel() using trailing closure syntax, our closure code is required to accept a string:

travel { (place: String) in
    print("I'm going to \(place) in my car")
}


Para dar um exemplo prático, imagine que você estava construindo um carro. 
O carro precisa saber qual motor tem, qual volante tem, quantos assentos tem e assim por diante. Claro, 
o motor pode ser apenas uma série de informações, mas realmente deve ser capaz de realmente acelerar ou 
desacelerar a uma certa velocidade.

Então, primeiro podemos escrever um encerramento como este:

let changeSpeed = { (speed: Int) in
    print("Changing speed to \(speed)kph")
}

And now we can create a buildCar() function that accepts any sort of closure for the engine, 
as long as that closure can be told to accelerate or decelerate to a specific integer value:

func buildCar(name: String, engine: (Int) -> Void) {
    // build the car
}

Once you become more comfortable with closures, you’ll start to realize the power here is 
that our closure is effectively a sealed box. Yes, we know that it will print a message that 
we’re changing speed, but all buildCar() knows is that it takes an integer and returns nothing. 
We could create a completely different closure to handle flying cars or underwater cars, and buildCar() 
wouldn’t care because it satisfies the same rules of accepting an integer and returning nothing.


---------- 2. USING CLOSURES AS PARAMETERS WHEN THEY RETURN VALUES 

We’ve been using () -> Void to mean “accepts no parameters and returns nothing”, 
but you can replace that Void with any type of data to force the closure to return a value.

To demonstrate this, we can write a travel() function that accepts a closure as its only parameter, 
and that closure in turn accepts a string and returns a string:

func travel(action: (String) -> String) {
    print("I'm getting ready to go.")
    let description = action("London")
    print(description)
    print("I arrived!")
}

Now when we call travel() using trailing closure syntax, our closure code is required to 
accept a string and return a string:

travel { (place: String) -> String in
    return "I'm going to \(place) in my car"
}


Os fechamentos da Swift podem retornar valores, bem como parâmetros de tomada, e você pode usar esses fechamentos 
em funções. Melhor ainda, essas funções também podem retornar valores, mas é fácil para o seu cérebro ficar um 
pouco confuso aqui porque há muita sintaxe.

Para demonstrar um uso comum para esse tipo de fechamento, vamos implementar um método simples de redução. 
Este é um comportamento comum projetado para resumir matrizes - para pegar muitos números, ou strings, ou o 
que quer que seja, e reduzi-los a um único valor.

Em nosso exemplo simplificado, nosso redutor aceitará dois parâmetros: uma matriz de números e um fechamento 
que pode reduzir essa matriz a um único valor. Por exemplo, ele pode aceitar uma matriz de números e adicioná-los 
e, em seguida, retornar o total final. Para fazer isso, o fechamento aceitará dois parâmetros: um para rastrear o 
valor atual (tudo o que foi reduzido até agora) e o valor atual que precisa ser adicionado ao valor reduzido. 
O fechamento também retornará um valor, que é o novo valor reduzido, e toda a função retornará o valor totalmente 
reduzido - o total de todos os números, por exemplo.

Por exemplo, se quiséssemos reduzir a matriz [10, 20, 30], funcionaria mais ou menos assim:

It would create a variable called current with a value set to the first item in its array. This is our starting value.
It would then start a loop over the items in the array that got passed in, using the range 1... so that 
it counts from index 1 to the end.
Em seguida, chamaria o fechamento com 10 (o valor atual) e 20 (o segundo valor na matriz).
O fechamento pode estar reduzindo a matriz usando adição, então adicionaria de 10 a 20 e retornaria a soma, 30.
Nossa função chamaria o fechamento com 30 (o novo valor atual) e 30 (o terceiro item da matriz).
O fechamento adicionaria de 30 a 30 e devolveria a soma, que é 60.
Nossa função enviaria de volta 60 como seu valor de retorno.
No código, fica assim:

func reduce(_ values: [Int], using closure: (Int, Int) -> Int) -> Int {
    // start with a total equal to the first value    
    var current = values[0]

    // loop over all the values in the array, counting from index 1 onwards
    for value in values[1...] {
        // call our closure with the current value and the array element, assigning its result to our current value
        current = closure(current, value)
    }

    // send back the final current value    
    return current
}

Com esse código em vigor, agora podemos escrever isso, então adicione uma matriz de números:

let numbers = [10, 20, 30]

let sum = reduce(numbers) { (runningTotal: Int, next: Int) in
    runningTotal + next
}

print(sum)

Tip: In that code we’re explicit that runningTotal and next will both be integers, but we can actually leave 
out the type annotation and Swift will figure it out. Notice that we haven’t had to say our closure returns an integer, 
again because Swift can figure that out for itself.

The great thing here is that reduce() doesn’t care what its closure does – it only cares that it will accept two 
integers and return one integer. So, we could multiply all the items in our array like this:

let multiplied = reduce(numbers) { (runningTotal: Int, next: Int) in
    runningTotal * next
}

Embora este tenha sido apenas um exemplo para demonstrar por que fechamentos com valores de retorno são 
parâmetros funcionais úteis, quero mencionar mais três coisas.

First, our reduce() function uses values[0] for its initial value, but what happens if we call reduce() with 
an empty array? We get a crash – that’s what happens. Clearly that isn’t a good thing, so you wouldn’t want to 
use this code outside of a learning sandbox.

Second, I mentioned previously that Swift’s operators are actually functions in their own right. 
For example, + is a function that accepts two numbers (e.g. 5 and 10) and returns another number (15).

So, + takes two numbers and returns a number. And our reduce() function expects a closure that takes two numbers 
and returns a number. That’s the same thing! The + function fulfills the same contract as reduce() wants – it takes 
the same parameters and returns the same value.

Como resultado, podemos realmente escrever isso:

let sum = reduce(numbers, using: +)
Sim, sério. Legal, hein?

Third, this reduce() function is so important that a variant actually comes with Swift as standard. 
The concept is the same, but it’s more advanced in several ways:

Você pode especificar seu próprio valor inicial.
Ele funcionará em matrizes de qualquer tipo, incluindo strings.
Ele lida com erros graciosamente.
Melhor ainda, ele não travará quando usado em uma matriz vazia!

Isso levou um pouco de explicação, mas espero que tenha lhe dado um exemplo prático de por que fechamentos que 
retornam valores podem ser úteis como parâmetros. À medida que você progride em suas habilidades, aprenderá 
muitos outros exemplos - é surpreendentemente comum.


---------- 3. SHORTHAND PARAMETER NAMES 

Acabamos de fazer uma função travel(). Ele aceita um parâmetro, que é um fechamento que aceita um parâmetro 
e retorna uma string. Esse fechamento é então executado entre duas chamadas para print().

Aqui está isso no código:

func travel(action: (String) -> String) {
    print("I'm getting ready to go.")
    let description = action("London")
    print(description)
    print("I arrived!")
}

We can call travel() using something like this:

travel { (place: String) -> String in
    return "I'm going to \(place) in my car"
}

No entanto, Swift sabe que o parâmetro para esse fechamento deve ser uma string, para que possamos removê-lo:

travel { place -> String in
    return "I'm going to \(place) in my car"
}

Ele também sabe que o fechamento deve retornar uma string, para que possamos remover isso:

travel { place in
    return "I'm going to \(place) in my car"
}

Como o fechamento tem apenas uma linha de código que deve ser a que retorna o valor, então Swift também nos permite remover a palavra-chave return:

travel { place in
    "I'm going to \(place) in my car"
}

Swift tem uma sintaxe abreviada que permite que você fique ainda mais curto. 
Em vez de escrever place in, podemos permitir que a Swift forneça nomes automáticos para os parâmetros do fechamento. 
Estes são nomeados com um cifrão e, em seguida, um número contando de 0.

travel {
    "I'm going to \($0) in my car"
}



      FECHAMENTOS AVANÇADOS 



---------- 4. CLOSURES WITH MULTIPLE PARAMETERS 

Just to make sure everything is clear, we’re going to write another closure example using two parameters.

This time our travel() function will require a closure that specifies where someone is traveling to, 
and the speed they are going. This means we need to use (String, Int) -> String for the parameter’s type:

func travel(action: (String, Int) -> String) {
    print("I'm getting ready to go.")
    let description = action("London", 60)
    print(description)
    print("I arrived!")
}

We’re going to call that using a trailing closure and shorthand closure parameter names. 
Because this accepts two parameters, we’ll be getting both $0 and $1:

travel {
    "I'm going to \($0) at \($1) miles per hour."
}

Some people prefer not to use shorthand parameter names like $0 because it can be confusing, 
and that’s OK – do whatever works best for you.


---------- 5. RETURNING CLOSURES FROM FUNCTIONS 

Da mesma forma que você pode passar um fechamento para uma função, você também pode obter fechamentos 
retornados de uma função.

The syntax for this is a bit confusing a first, because it uses -> twice: once to specify your 
function’s return value, and a second time to specify your closure’s return value.

To try this out, we’re going to write a travel() function that accepts no parameters, but returns a closure. 
The closure that gets returned must be called with a string, and will return nothing.

Veja como isso fica em Swift:

func travel() -> (String) -> Void {
    return {
        print("I'm going to \($0)")
    }
}

We can now call travel() to get back that closure, then call it as a function:

let result = travel()
result("London")

It’s technically allowable – although really not recommended! – to call the return value from travel() directly:

let result2 = travel()("London")


Quero dar um pequeno exemplo de como isso parece, porque Swift realmente vem com um gerador de números aleatórios integrado.
Parece com isso:

print(Int.random(in: 1...10))
Isso imprimirá um número de 1 a 10.

Se quiséssemos escrever uma função que retornasse um número aleatório entre 1 e 10, escreveríamos o seguinte:

func getRandomNumber()-> Int {
    Int.random(in: 1...10)
}

Isso retornará um inteiro aleatório toda vez que for chamado, para que possamos usá-lo assim:

print(getRandomNumber())

Agora vamos dar um passo adiante: vamos criar uma função que retorna um fechamento que, quando chamado, 
gerará um número aleatório de 1 a 10:

func makeRandomGenerator() -> () -> Int {
    let function = { Int.random(in: 1...10) }
    return function
}

Notice that our return type is now () -> Int, which means “a closure that takes no parameters and 
returns an integer.” Then, inside the function, we create a closure that wraps Int.random(in: 1...10) and 
send back that closure.

We can now use makeRandomGenerator() like this:

let generator = makeRandomGenerator()
let random1 = generator()
print(random1)

Again, the flexibility here is that all our code can call makeRandomGenerator() to be sent back some sort 
of code that can generate a random number. It doesn’t have to care what it does; we only care that it generates 
a new number every time it’s called.


>>>>>>>>>> SITE DE COMO FAZER QUALQUER DECLARAÇÃO DE CLOSURE EM SWIFT: http://goshdarnclosuresyntax.com/ 


---------- 6. CAPTURING VALUES 

Se você usar quaisquer valores externos dentro do seu fechamento, o Swift os captura - os armazena ao lado do fechamento, 
para que possam ser modificados mesmo que não existam mais.

Right now we have a travel() function that returns a closure, and the returned closure accepts a string as 
its only parameter and returns nothing:

func travel() -> (String) -> Void {
    return {
        print("I'm going to \($0)")
    }
}

We can call travel() to get back the closure, then call that closure freely:

let result = travel()
result("London")

Closure capturing happens if we create values in travel() that get used inside the closure. 
For example, we might want to track how often the returned closure is called:

func travel() -> (String) -> Void {
    var counter = 1

    return {
        print("\(counter). I'm going to \($0)")
        counter += 1
    }
}

Even though that counter variable was created inside travel(), it gets captured by the closure so 
it will still remain alive for that closure.

So, if we call result("London") multiple times, the counter will go up and up:

result("London")
result("London")
result("London")


---------- 7. CLOSURES SUMMARY 

1.Você pode atribuir fechamentos a variáveis e chamá-las mais tarde.

2.Os fechamentos podem aceitar parâmetros e valores de retorno, como funções regulares.

3.Você pode passar fechamentos para funções como parâmetros, e esses fechamentos podem ter parâmetros próprios e um valor de retorno.

4.Se o último parâmetro da sua função for um fechamento, você pode usar a sintaxe de fechamento à direita.

5.Swift automatically provides shorthand parameter names like $0 and $1, but not everyone uses them.

6.Se você usar valores externos dentro de seus fechamentos, eles serão capturados para que o fechamento possa se referir a eles mais tarde.










