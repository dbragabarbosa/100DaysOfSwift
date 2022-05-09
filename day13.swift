08/05/2022


REVISÃO (DIA 1)


---------- 1. VARIÁVEIS E CONSTANTES 

Todo programa útil precisa armazenar dados em algum momento, e em Swift existem duas maneiras de fazê-lo: variáveis e constantes. 
Uma variável é um armazenamento de dados que pode ter seu valor alterado sempre que você quiser, e uma constante é um armazenamento de dados 
que você define uma vez e nunca pode mudar. 
Então, as variáveis têm valores que podem variar, e as constantes têm valores que são constantes - fácil, certo?

Ter essas duas opções pode parecer inútil, afinal você pode simplesmente criar uma variável e nunca alterá-la - por que ela precisa se tornar 
uma constante? Bem, acontece que muitos programadores são - choque! - menos do que perfeitos em programação, e cometemos erros.

Uma das vantagens de separar constantes e variáveis é que o Xcode nos dirá se cometemos um erro. 
Se dissermos "torne desta data uma constante, porque eu sei que nunca mudará", 10 linhas depois tentarão alterá-la, 
o Xcode se recusará a criar nosso aplicativo.

As constantes também são importantes porque permitem que o Xcode tome decisões sobre a maneira como ele constrói seu aplicativo. 
Se ele sabe que um valor nunca mudará, ele é capaz de aplicar otimizações para fazer com que seu código seja executado mais rápido.

Em Swift, você cria uma variável usando a palavra-chave var, assim:

var name = "Tim McGraw"

Let's put that into a playground so you can start getting feedback. 
Delete everything in there apart from the import UIKit line (that's the bit that pulls in Apple's core iOS framework and it's needed later on), 
and add that variable. You should see the picture below.

Nos playgrounds do Xcode, você digita seu código à esquerda e vê os resultados à direita um segundo depois.

Because this is a variable, you can change it whenever you want, but you shouldn't use the var keyword each time – 
that's only used when you're declaring new variables. Try writing this:

var name = "Tim McGraw"
name = "Romeo"

So, the first line creates the name variable and gives it an initial value, then the second line updates the name variable so that its value is 
now "Romeo". You'll see both values printed in the results area of the playground.

Now, what if we had made that a constant rather than a variable? Well, constants use the let keyword rather than var, so you can change your 
first line of code to say let name rather than var name like this:

import UIKit
let name = "Tim McGraw"
name = "Romeo"

Mas agora há um problema: o Xcode está mostrando um símbolo de aviso vermelho ao lado da linha três, e deveria ter desenhado um sublinhado 
rabissado abaixo do seu código. Se você clicar no símbolo de aviso vermelho, o Xcode lhe dirá o problema: 
"Não é possível atribuir ao 'let' value 'name'" - que é Xcode-speak para "você está tentando alterar uma constante e não pode fazer isso".

Se você tentar alterar uma constante em Swift, o Xcode se recusará a criar seu aplicativo.

Portanto, as constantes são uma ótima maneira de fazer uma promessa à Swift e a si mesmo de que um valor não mudará, 
porque se você tentar alterá-lo, o Xcode se recusará a ser executado. Os desenvolvedores Swift têm uma forte preferência por usar constantes 
sempre que possível, pois isso torna seu código mais fácil de entender. Na verdade, nas versões mais recentes do Swift, o Xcode realmente lhe 
dirá se você faz algo uma variável, então nunca a altera!

Nota importante: nomes de variáveis e constantes devem ser exclusivos em seu código. 
Você receberá um erro se tentar usar o mesmo nome de variável duas vezes, assim:

var name = "Tim McGraw"
var name = "Romeo"

Se o playground encontrar um erro no seu código, ele sinalizará um aviso em uma caixa vermelha ou simplesmente se recusará a executar. 
Você saberá se o último aconteceu porque o texto no painel de resultados ficou cinza em vez de preto habitual.



---------- 2. TIPOS DE DADOS 

There are lots of kinds of data, and Swift handles them all individually. 
You already saw one of the most important types when you assigned some text to a variable, but in Swift this is called a String – 
literally a string of characters.

Strings can be long (e.g. a million letters or more), short (e.g. 10 letters) or even empty (no letters), it doesn't matter: 
they are all strings in Swift's eyes, and all work the same. Swift knows that name should hold a string because you assign a string to 
it when you create it: "Tim McGraw". If you were to rewrite your code to this it would stop working:

var name
name = "Tim McGraw"

This time Xcode will give you an error message that won't make much sense just yet: "Type annotation missing in pattern". 
What it means is, "I can't figure out what data type name is because you aren't giving me enough information."

Neste ponto, você tem duas opções: criar sua variável e dar a ela um valor inicial em uma linha de código, ou usar o que é chamado de 
anotação de tipo, que é onde você diz à Swift qual tipo de dados a variável manterá mais tarde, mesmo que você não esteja dando a ela um valor agora.

You've already seen how the first option looks, so let's look at the second: type annotations. We know that name is going to be a string, 
so we can tell Swift that by writing a colon then String, like this:

var name: String
name = "Tim McGraw"

Nota: algumas pessoas gostam de colocar um espaço antes e depois dos dois pontos, fazendo o var name : String, 
mas elas estão erradas e você deve tentar evitar mencionar seu erro em companhia educada.

A lição aqui é que Swift sempre quer saber que tipo de dados cada variável ou constante armazenará. Sempre. 
Você não pode escapar, e isso é uma coisa boa porque fornece algo chamado tipo de segurança - se você disser "isso vai segurar uma corda", 
depois tente colocar um coelho lá, Swift vai recusar.

Podemos tentar isso agora introduzindo outro tipo de dados importante, chamado Int, que é a abreviação de "inteiro". 
Inteiros são números redondos como 3, 30, 300 ou -16777216. Por exemplo:

var name: String
name = "Tim McGraw"

var age: Int
age = 25

That declares one variable to be a string and one to be an integer. Note how both String and Int have capital letters at the start, 
whereas name and age do not – this is the standard coding convention in Swift.
 A coding convention is something that doesn't matter to Swift (you can write your names how you like!) but does matter to other developers. 
 In this case, data types start with a capital letter, whereas variables and constants do not.

Agora que temos variáveis de dois tipos diferentes, você pode ver a segurança do tipo em ação. Tente escrever isso:

name = 25
age = "Tim McGraw"

Nesse código, você está tentando colocar um inteiro em uma variável de string e uma string em uma variável inteira - 
e, felizmente, o Xcode lançará erros. Você pode pensar que isso é pedante, mas na verdade é bastante útil: 
você promete que uma variável conterá um tipo específico de dados, e o Xcode imporá isso ao longo do seu trabalho.


 - Flutuante e Duplo
Let's look at two more data types, called Float and Double. 
This is Swift's way of storing numbers with a fractional component, such as 3.1, 3.141, 3.1415926, and -16777216.5. 
There are two data types for this because you get to choose how much accuracy you want, but most of the time it doesn't matter 
so the official Apple recommendation is always to use Double because it has the highest accuracy.

Tente colocar isso no seu playground:

var latitude: Double
latitude = 36.166667

var longitude: Float
longitude = -86.783333

You can see both numbers appear on the right, but look carefully because there's a tiny discrepancy. 
We said that longitude should be equal to -86.783333, but in the results pane you'll see -86.78333 – 
it's missing one last 3 on the end. Now, you might well say, "what does 0.000003 matter among friends?" 
but this is ably demonstrating what I was saying about accuracy.

Because these playgrounds update as you type, we can try things out so you can see exactly how Float and Double differ. 
Try changing the code to be this:

var longitude: Float
longitude = -86.783333
longitude = -186.783333
longitude = -1286.783333
longitude = -12386.783333
longitude = -123486.783333
longitude = -1234586.783333

Isso é adicionar números crescentes antes do ponto decimal, mantendo a mesma quantidade de números depois. 
Mas se você olhar no painel de resultados, notará que, à medida que adiciona mais números antes do ponto, 
a Swift está removendo números depois. Isso ocorre porque tem espaço limitado para armazenar seu número, 
por isso está armazenando a parte mais importante primeiro - estar desligado por 1.000.000 é uma grande coisa, 
enquanto estar desligado por 0,000003 é menos.

Now try changing the Float to be a Double and you'll see Swift prints the correct number out every time:

var longitude: Double

This is because, again, Double has twice the accuracy of Float so it doesn't need to cut your number to fit. 
Doubles still have limits, though – if you were to try a massive number like 123456789.123456789 you would see it gets cut down to 123456789.1234568.


-Booleano
Swift tem um tipo de dados interno que pode armazenar se um valor é verdadeiro ou falso, chamado Bool, abreviação de Booleano. 
Bools não tem espaço para "talvez" ou "talvez", apenas absolutos: verdadeiro ou falso. Por exemplo:

var stayOutTooLate: Bool
stayOutTooLate = true

var nothingInBrain: Bool
nothingInBrain = true

var missABeat: Bool
missABeat = false

Tip: You’ll notice these variables are written in a very particular way: we don’t write MissABeat, missabeat, or other such variations, 
but instead make the initial letter lowercase then capitalize the first letter of the second and subsequent words. This is called “camel case” 
because it looks a bit like the humps of a camel, and it’s used to make it easier to read words in variable names.


-Usando anotações de tipo com sabedoria
Como você aprendeu, existem duas maneiras de dizer à Swift que tipo de dados uma variável contém: 
atribuir um valor ao criar a variável ou usar uma anotação de tipo. Se você tiver escolha, 
o primeiro é sempre preferível porque é mais claro. Por exemplo:

var name = "Tim McGraw"
...é preferido a:

var name: String
name = "Tim McGraw"

Isso se aplica a todos os tipos de dados. Por exemplo:

var age = 25
var longitude = -86.783333
var nothingInBrain = true

This technique is called type inference, because Swift can infer what data type should be used for a variable by looking at the type of data 
you want to put in there. When it comes to numbers like -86.783333, Swift will always infer a Double rather than a Float.

Por uma questão de integridade, devo acrescentar que é possível especificar um tipo de dados e fornecer um valor ao mesmo tempo, assim:

var name: String = "Tim McGraw"



---------- 3. OPERADORES 

Operators are those little symbols you learned in your very first math classes: + to add, - to subtract, * to multiply, / to divide, = to assign 
value, and so on. They all exist in Swift, along with a few extras.

Vamos tentar algumas noções básicas - digite isso no seu playground:

var a = 10
a = a + 1
a = a - 1
a = a * a

No painel de resultados, você verá 10, 11, 10 e 100, respectivamente. Agora tente isso:

var b = 10
b += 10
b -= 10

+= is an operator that means "add then assign to." 
In our case it means "take the current value of b, add 10 to it, then put the result back into b." 
As you might imagine, -= does the same but subtracts rather than adds. So, that code will show 10, 20, 10 in the results pane.

Alguns desses operadores se aplicam a outros tipos de dados. Como você pode imaginar, você pode adicionar duas duplas juntas assim:

var a = 1.1
var b = 2.2
var c = a + b

When it comes to strings, + will join them together. For example:

var name1 = "Tim McGraw"
var name2 = "Romeo"
var both = name1 + " and " + name2

Isso escreverá "Tim McGraw e Romeu" no painel de resultados.

One more common operator you’ll see is called modulus, and is written using a percent symbol: %. 
It means “divide the left hand number evenly by the right, and return the remainder.” So, 9 % 3 returns 0 because 3 divides evenly into 9, 
whereas 10 % 3 returns 1, because 10 divides by 3 three times, with remainder 1.


- Operadores de comparação
Swift tem um conjunto de operadores que realizam comparações de valores. Por exemplo:

var a = 1.1
var b = 2.2
var c = a + b

c > 3
c >= 3
c > 4
c < 4

Isso mostra maior que (>), maior ou igual (>=) e menor que (<). 
Na janela de resultados, você verá verdadeiro, verdadeiro, falso, verdadeiro - estes são booleanos, 
porque a resposta para cada uma dessas afirmações só pode ser verdadeira ou falsa.

Se você quiser verificar a igualdade, não pode usar = porque já tem um significado: 
é usado para dar um valor a uma variável. Então, Swift tem uma alternativa na forma de ==, que significa "é igual a". Por exemplo:

var name = "Tim McGraw"
name == "Tim McGraw"

That will show "true" in the results pane. 
Now, one thing that might catch you out is that in Swift strings are case-sensitive, 
which means "Tim McGraw", "TIM MCGRAW" and "TiM mCgRaW" are all considered different. 
If you use == to compare two strings, you need to make sure they have the same letter case.

Há mais um operador que eu quero apresentar a você, e é chamado de operador "não": !. 
Sim, é apenas um ponto de exclamação. Isso faz com que sua declaração signifique o oposto do que ela fez. Por exemplo:

var stayOutTooLate = true
stayOutTooLate
!stayOutTooLate

Isso imprimirá verdadeiro, verdadeiro, falso - com o último valor lá porque inverteu o verdadeiro anterior.

You can also use ! with = to make != or "not equal". For example:

var name = "Tim McGraw"
name == "Tim McGraw"
name != "Tim McGraw"



---------- 4. STRING INTERPOLATION 

Este é um nome sofisticado para o que na verdade é uma coisa muito simples: combinar variáveis e constantes dentro de uma string.

Limpe todo o código que você acabou de escrever e deixe apenas isso:

var name = "Tim McGraw"

Se quiséssemos imprimir uma mensagem para o usuário que incluía seu nome, a interpolação de string é o que facilita: 
basta escrever uma barra invertida, depois um parêntese aberto, depois seu código e, em seguida, um parêntese fechado, assim:

var name = "Tim McGraw"
"Your name is \(name)"

O painel de resultados agora mostrará "Seu nome é Tim McGraw", tudo como uma string, porque a interpolação de string combinou as duas para nós.

Agora, poderíamos ter escrito isso usando o operador +, assim:

var name = "Tim McGraw"
"Your name is " + name

...mas isso não é tão eficiente, especialmente se você estiver combinando várias variáveis. 
Além disso, a interpolação de strings em Swift é inteligente o suficiente para ser capaz de lidar com 
uma variedade de tipos de dados diferentes automaticamente. Por exemplo:

var name = "Tim McGraw"
var age = 25
var latitude = 36.166667

"Your name is \(name), your age is \(age), and your latitude is \(latitude)"

Doing that using + is much more difficult, because Swift doesn't let you add integers and doubles to a string.

Neste ponto, seu resultado pode não caber mais no painel de resultados, 
então redimensione sua janela ou passe o mouse sobre o resultado e clique no botão + que parece tê-lo mostrado em linha.

One of the powerful features of string interpolation is that everything between \( and ) can actually be a full Swift expression. 
For example, you can do mathematics in there using operators, like this:

var age = 25
"You are \(age) years old. In another \(age) years you will be \(age * 2)."



---------- 5. ARRAYS 

As matrizes permitem que você agrupe muitos valores em uma única coleção e, em seguida, acesse esses valores por sua posição na coleção. 
Swift usa inferência de tipo para descobrir que tipo de dados seu array contém, assim:

var evenNumbers = [2, 4, 6, 8]
var songs = ["Shake it Off", "You Belong with Me", "Back to December"]

Como você pode ver, Swift usa colchetes para marcar o início e o fim de uma matriz, e cada item da matriz é separado por uma vírgula.

Quando se trata de ler itens de uma matriz, há um problema: Swift começa a contar em 0. Isso significa que o primeiro item é 0, 
o segundo item é 1, o terceiro é 2 e assim por diante. Tente colocar isso no seu playground:

var songs = ["Shake it Off", "You Belong with Me", "Back to December"]
songs[0]
songs[1]
songs[2]

Isso imprimirá "Shake it Off", "You Belong with Me" e "Back to December" no painel de resultados.

An item's position in an array is called its index, and you can read any item from the array just by providing its index. 
However, you do need to be careful: our array has three items in, which means indexes 0, 1 and 2 work great. 
But if you try and read songs[3] your playground will stop working – and if you tried that in a real app it would crash!

Como você criou sua matriz dando a ela três strings, Swift sabe que esta é uma matriz de strings. 
Você pode confirmar isso usando um comando especial no playground que imprimirá o tipo de dados de qualquer variável, assim:

var songs = ["Shake it Off", "You Belong with Me", "Back to December"]
type(of: songs)

That will print Array<String>.Type into the results pane, telling you that Swift considers songs to be an array of strings.

Digamos que você tenha cometido um erro e acidentalmente colocou um número no final da matriz. 
Tente isso agora e veja o que o painel de resultados imprime:

var songs = ["Shake it Off", "You Belong with Me", "Back to December", 3]
type(of: songs)

Desta vez, você verá um erro. 
O erro não é porque a Swift não consegue lidar com matrizes mistas como esta - vou te mostrar como fazer isso em apenas um momento! - 
mas sim porque a Swift está sendo útil. 
A mensagem de erro que você verá é: "literal de coleção heterógena só pode ser inferida como '[Qualquer]'; adicione anotação de tipo explícita 
se isso for intencional". Ou, em inglês simples, "parece que este array foi projetado para conter muitos tipos de dados - se você realmente 
quis dizer isso, por favor, torne-o explícito".

A segurança do tipo é importante e, embora seja legal que a Swift possa fazer com que os arrays mantenham qualquer tipo de dados, 
este caso em particular foi um acidente. Felizmente, eu já disse que você pode usar anotações de tipo para especificar exatamente 
que tipo de dados deseja que um array armazene. Para especificar o tipo de matriz, escreva o tipo de dados que deseja armazenar com 
colchetes ao redor, assim:

var songs: [String] = ["Shake it Off", "You Belong with Me", "Back to December", 3]

Agora que dissemos à Swift que queremos armazenar apenas strings na matriz, ela sempre se recusará a executar o código porque 3 não é uma string.

Se você realmente quiser que a matriz contenha qualquer tipo de dados, use o tipo de dados especial Any, assim:

var songs: [Any] = ["Shake it Off", "You Belong with Me", "Back to December", 3]


- Criando matrizes
Se você criar uma matriz usando a sintaxe mostrada acima, Swift criará a matriz e a preencherá com os valores que especificamos. 
As coisas não são tão simples se você quiser criar a matriz e depois preenchê-la mais tarde - essa sintaxe não funciona:

var songs: [String]
songs[0] = "Shake it Off"

The reason is one that will seem needlessly pedantic at first, but has deep underlying performance implications so I'm afraid you're 
just stuck with it. Put simply, writing var songs: [String] tells Swift "the songs variable will hold an array of strings," 
but it doesn't actually create that array. It doesn't allocate any RAM, or do any of the work to actually create a Swift array. 
It just says that at some point there will be an array, and it will hold strings.

Existem algumas maneiras de expressar isso corretamente, e a que provavelmente faz mais sentido neste momento é esta:

var songs: [String] = []

Isso usa uma anotação de tipo para deixar claro que queremos uma matriz de strings, e atribui uma matriz vazia (esse é o[] parte) para isso.

Você também verá normalmente esta construção:

var songs = [String]()

That means the same thing: the () tells Swift we want to create the array in question, which is then assigned to songs using type inference. 
This option is two characters shorter, so it's no surprise programmers prefer it!


- Operadores de matriz
Você pode usar um conjunto limitado de operadores em arrays. Por exemplo, você pode mesclar dois arrays usando o operador +, assim:

var songs = ["Shake it Off", "You Belong with Me", "Love Story"]
var songs2 = ["Today was a Fairytale", "Welcome to New York", "Fifteen"]
var both = songs + songs2

Você também pode usar += para adicionar e atribuir, assim:

both += ["Everything has Changed"]



---------- 6. DICIONÁRIOS 

Como você viu, as matrizes Swift são uma coleção onde você acessa cada item usando um índice numérico, como songs[0] 
Os dicionários são outro tipo comum de coleção, mas diferem dos arrays porque permitem que você acesse valores com base em uma chave especificada.

Para dar um exemplo, vamos imaginar como podemos armazenar dados sobre uma pessoa em um array:

var person = ["Taylor", "Alison", "Swift", "December", "taylorswift.com"]

To read out that person's middle name, we'd use person[1], and to read out the month they were born we'd use person[3]. 
This has a few problems, not least that it's difficult to remember what index number is assigned to each value in the array! 
And what happens if the person has no middle name? Chances are all the other values would move down one place, causing chaos in your code.

Com dicionários, podemos reescrever isso para ser muito mais sensato, porque, em vez de números arbitrários, 
você pode ler e escrever valores usando uma chave que você especifica. Por exemplo:

var person = ["first": "Taylor", "middle": "Alison", "last": "Swift", "month": "December", "website": "taylorswift.com"]
person["middle"]
person["month"]

Pode ajudar se eu usar muito espaço em branco para dividir o dicionário na sua tela, assim:

var person = [
                "first": "Taylor",
                "middle": "Alison",
                "last": "Swift",
                "month": "December",
                "website": "taylorswift.com"
            ]

person["middle"]
person["month"]

Como você pode ver, quando você faz um dicionário, você escreve sua chave, depois dois pontos e, em seguida, seu valor. 
Você pode então ler qualquer valor do dicionário apenas conhecendo sua chave, o que é muito mais fácil de trabalhar.

Tal como acontece com matrizes, você pode armazenar uma grande variedade de valores dentro de dicionários, 
embora as chaves sejam mais comumente strings.



---------- 7. CONDITIONAL STATEMENTS 

Sometimes you want code to execute only if a certain condition is true, and in Swift that is represented primarily by the if and else statements. 
You give Swift a condition to check, then a block of code to execute if that condition is true.

You can optionally also write else and provide a block of code to execute if the condition is false, or even else if and have more conditions. 
A "block" of code is just a chunk of code marked with an open brace – { – at its start and a close brace – } – at its end.

Aqui está um exemplo básico:

var action: String
var person = "hater"

if person == "hater" {
    action = "hate"
}

That uses the == (equality) operator introduced previously to check whether the string inside person is exactly equivalent to the string "hater". 
If it is, it sets the action variable to "hate". Note that open and close braces, also known by their less technical name of "curly brackets" – 
that marks the start and end of the code that will be executed if the condition is true.

Let's add else if and else blocks:

var action: String
var person = "hater"

if person == "hater" {
    action = "hate"
} else if person == "player" {
    action = "play"
} else {
    action = "cruise"
}

Isso verificará cada condição em ordem, e apenas um dos blocos será executado: uma pessoa é um inimigo, um jogador ou qualquer outra coisa.


- Avaliando várias condições
You can ask Swift to evaluate as many conditions as you want, but they all need to be true in order for Swift to execute the block of code. 
To check multiple conditions, use the && operator – it means "and". For example:

var action: String
var stayOutTooLate = true
var nothingInBrain = true

if stayOutTooLate && nothingInBrain {
    action = "cruise"
}

Because stayOutTooLate and nothingInBrain are both true, the whole condition is true, and action gets set to "cruise." 
Swift uses something called short-circuit evaluation to boost performance: if it is evaluating multiple things that all need to be true, 
and the first one is false, it doesn't even bother evaluating the rest.


- Procurando o oposto da verdade
Isso pode parecer profundamente filosófico, mas na verdade isso é importante: às vezes você se importa se uma condição não é verdadeira, 
ou seja, é falsa. Você pode fazer isso com o! (não) operador que foi introduzido anteriormente. Por exemplo:

if !stayOutTooLate && !nothingInBrain {
    action = "cruise"
}

This time, the action variable will only be set if both stayOutTooLate and nothingInBrain are false – the ! has flipped them around.



---------- 8. LOOPS 

Os computadores são ótimos em fazer tarefas chatas bilhões de vezes no tempo que você levou para ler esta frase. 
Quando se trata de repetir tarefas em código, você pode copiar e colar seu código várias vezes, ou pode usar loops - 
construções de programação simples que repetem um bloco de código enquanto uma condição for verdadeira.

To demonstrate this, I want to introduce you to a special debugging function called print(): you give it some text to print, and it will print it. 
If you're running in a playground like we are, you'll see your text appear in the results window. If you're running a real app in Xcode, 
you'll see your text appear in Xcode's log window. Either way, print() is a great way to get a sneak peek at the contents of a variable.

Dê uma olhada neste código:

print("1 x 10 is \(1 * 10)")
print("2 x 10 is \(2 * 10)")
print("3 x 10 is \(3 * 10)")
print("4 x 10 is \(4 * 10)")
print("5 x 10 is \(5 * 10)")
print("6 x 10 is \(6 * 10)")
print("7 x 10 is \(7 * 10)")
print("8 x 10 is \(8 * 10)")
print("9 x 10 is \(9 * 10)")
print("10 x 10 is \(10 * 10)")

Quando terminar de funcionar, você terá a tabela de 10 vezes no painel de resultados do playground. 
Mas não é um código eficiente e, de fato, uma maneira muito mais limpa é percorrer um intervalo de números usando o que é 
chamado de operador de intervalo fechado, que são três períodos seguidos:...

Usando o operador de intervalo fechado, poderíamos reescrever tudo isso em três linhas:

for i in 1...10 {
    print("\(i) x 10 is \(i * 10)")
}

O painel de resultados mostra apenas "(10 vezes)" para o nosso loop, o que significa que o loop foi executado 10 vezes. 
Se você quiser saber o que o loop realmente fez, clique no quadrado imediatamente à direita de “(10 vezes). 
Você verá uma caixa dizendo que "10 x 10 é 100" aparece dentro do seu código e, se você clicar com o botão direito do mouse, 
verá a opção "Histórico de Valores". 

What the loop does is count from 1 to 10 (including 1 and 10), assigns that number to the constant i, then runs the block of code inside the braces.

Se você não precisa saber em que número está, pode usar um sublinhado. Por exemplo, poderíamos imprimir algumas letras de Taylor Swift como esta:

var str = "Fakers gonna"

for _ in 1 ... 5 {
    str += " fake"
}

print(str)

Isso imprimirá "Fakers vão falsificar falso falso falso falso falso" adicionando à corda toda vez que o loop girar.

If Swift doesn’t have to assign each number to a variable each time the loop goes around, it can run your code a little faster. 
As a result, if you write for i in… then don’t use i, Xcode will suggest you change it to _.

There's a variant of the closed range operator called the half open range operator, and they are easily confused. 
The half open range operator looks like ..< and counts from one number up to and excluding another. For example, 1 ..< 5 will count 1, 2, 3, 4.


- Looping sobre matrizes
Swift fornece uma maneira muito simples de percorrer todos os elementos de uma matriz. 
Como a Swift já sabe que tipo de dados sua matriz possui, ela passará por todos os elementos da matriz, 
atribuirá a uma constante que você nomear e, em seguida, executará um bloco do seu código. 
Por exemplo, poderíamos imprimir uma lista de ótimas músicas como esta:

var songs = ["Shake it Off", "You Belong with Me", "Look What You Made Me Do"]

for song in songs {
    print("My favorite song is \(song)")
}

You can also use the for i in loop construct to loop through arrays, because you can use that constant to index into an array.
 We could even use it to index into two arrays, like this:

var people = ["players", "haters", "heart-breakers", "fakers"]
var actions = ["play", "hate", "break", "fake"]

for i in 0 ... 3 {
    print("\(people[i]) gonna \(actions[i])")
}

Você pode se perguntar qual é o uso do operador de meio alcance aberto, mas é particularmente útil para trabalhar com matrizes porque elas contam 
a partir do zero. Então, em vez de contar de 0 até e incluindo 3, poderíamos contar de 0 até e excluindo o número de itens em uma matriz.

Lembre-se: eles contam de zero, portanto, se tiverem 4 itens, o índice máximo é 3, e é por isso que precisamos usar a exclusão para o loop.

Para contar quantos itens estão em uma matriz, use someArray.count. Então, poderíamos reescrever nosso código assim:

var people = ["players", "haters", "heart-breakers", "fakers"]
var actions = ["play", "hate", "break", "fake"]

for i in 0 ..< people.count {
    print("\(people[i]) gonna \(actions[i])")
}


- Loops internos
Você pode colocar loops dentro de loops, se quiser, e até mesmo loops dentro de loops dentro de loops - 
embora de repente você possa descobrir que está fazendo algo 10 milhões de vezes, então tenha cuidado!

Podemos combinar dois de nossos loops anteriores para criar isso:

var people = ["players", "haters", "heart-breakers", "fakers"]
var actions = ["play", "hate", "break", "fake"]

for i in 0 ..< people.count {
    var str = "\(people[i]) gonna"

    for _ in 1 ... 5 {
        str += " \(actions[i])"
    }

    print(str)
}

Isso produz "os jogadores vão jogar, jogar, jogar, jogar, jogar", depois "os odiadores vão..." Bem, você entendeu a ideia.

One important note: although programmers conventionally use i, j and even k for loop constants, you can name them whatever you please: 
for personNumber in 0 ..< people.count is perfectly valid.


- Enquanto loops
Há um terceiro tipo de loop que você verá, que repete um bloco de código até que você diga para parar. 
Isso é usado para coisas como loops de jogo, onde você não tem ideia de com antecedência de quanto tempo o jogo vai durar - 
você continua repetindo "verifique se há toques, anime robôs, desenhe a tela, verifique se há toques..." e assim por diante, 
até que, eventualmente, o usuário toque em um botão para sair do jogo e voltar para o menu principal.

These loops are called while loops, and they look like this:

var counter = 0

while true {
    print("Counter is now \(counter)")
    counter += 1

    if counter == 556 {
        break
    }
}

That code introduces a new keyword, called break. It's used to exit a while or for loop at a point you decide. 
Without it, the code above would never end because the condition to check is just "true", and true is always true. 
Without that break statement the loop is an infinite loop, which is A Bad Thing.

These while loops work best when you're using unknown data, such as downloading things from the internet, reading from a file such as XML, 
looking through user input, and so on. This is because you only know when to stop the loop after you've run it a sufficient number of times.

There is a counterpart to break called continue. Whereas breaking out of a loop stops execution immediately and continues directly after the loop,
continuing a loop only exits the current iteration of the loop – it will jump back to the top of the loop and pick up from there.

Por exemplo, considere o código abaixo:

var songs = ["Shake it Off", "You Belong with Me", "Look What You Made Me Do"]

for song in songs {
    if song == "You Belong with Me" {
        continue
    }

    print("My favorite song is \(song)")
}

That loops through three Taylor Swift songs, but it will only print the name of two. 
The reason for this is the continue keyword: when the loop tries to use the song "You Belong with Me", continue gets called, 
which means the loop immediately jumps back to the start – the print() call is never made, and instead the loop continues 
straight on to “Look What You Made Me Do”.



---------- 9. SWITCH CASE 

You've seen if statements and now loops, but Swift has another type of flow control called switch/case. 
It's easiest to think of this as being an advanced form of if, because you can have lots of matches and Swift will execute the right one.

In the most basic form of a switch/case you tell Swift what variable you want to check, then provide a list of possible cases for that variable. 
Swift will find the first case that matches your variable, then run its block of code. When that block finishes, 
Swift exits the whole switch/case block.

Here's a basic example:

let liveAlbums = 2

switch liveAlbums {
case 0:
    print("You're just starting out")

case 1:
    print("You just released iTunes Live From SoHo")

case 2:
    print("You just released Speak Now World Tour")

default:
    print("Have you done something new?")
}

We could very well have written that using lots of if and else if blocks, but this way is clearer and that's important.

One advantage to switch/case is that Swift will ensure your cases are exhaustive. That is, if there's the possibility of your variable 
having a value you don't check for, Xcode will refuse to build your app.

In situations where the values are effectively open ended, like our liveAlbums integer, you need to include a default case to catch 
these potential values. Yes, even if you "know" your data can only fall within a certain range, Swift wants to be absolutely sure.

Swift can apply some evaluation to your case statements in order to match against variables. For example, if you wanted to check 
for a range of possible values, you could use the closed range operator like this:

let studioAlbums = 5

switch studioAlbums {
case 0...1:
    print("You're just starting out")

case 2...3:
    print("You're a rising star")

case 4...5:
    print("You're world famous!")

default:
    print("Have you done something new?")
}

One thing you should know is that switch/case blocks in Swift don't fall through like they do in some other languages you might have seen. 
If you're used to writing break in your case blocks, you should know this isn't needed in Swift.

Instead, you use the fallthrough keyword to make one case fall into the next – it's effectively the opposite. Of course, 
if you have no idea what any of this means, that's even better: don't worry about it!





