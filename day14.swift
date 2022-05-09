09/05/2022


REVISÃO (DIA 2)


---------- 1. FUNCTIONS 

As funções permitem definir peças de código reutilizáveis que executam peças de funcionalidade específicas. 
Normalmente, as funções são capazes de receber alguns valores para modificar a maneira como funcionam, mas não é necessário.

Vamos começar com uma função simples:

func favoriteAlbum() {
    print("My favorite is Fearless")
}

Se você colocar esse código no seu playground, nada será impresso. E sim, está correto. 
A razão pela qual nada é impresso é que colocamos a mensagem "Meu favorito é destemido" em uma função chamada favoriteAlbum(), 
e esse código não será chamado até pedirmos à Swift para executar a função favoriteAlbum(). 
Para fazer isso, adicione esta linha de código:

favoriteAlbum()

Isso executa a função (ou "chama"), então agora você verá "Meu favorito é Fearless" impresso.

Como você pode ver, você define uma função escrevendo func, depois o nome da sua função, depois abre e fecha parênteses e, 
em seguida, um bloco de código marcado por chaves abertas e fechadas. Em seguida, você chama essa função escrevendo seu 
nome seguido de parênteses abertos e fechados.

Claro, esse é um exemplo bobo - essa função faz a mesma coisa, não importa o que aconteça, então não adianta existir. 
Mas e se quiséssemos imprimir um álbum diferente a cada vez? Nesse caso, poderíamos dizer à Swift que queremos que nossa 
função aceite um valor quando for chamado e, em seguida, use esse valor dentro dele.

Vamos fazer isso agora:

func favoriteAlbum(name: String) {
    print("My favorite is \(name)")
}

Isso diz à Swift que queremos que a função aceite um valor (chamado de "parâmetro"), chamado "nome", que deve ser uma string. 
Em seguida, usamos a interpolação de strings para escrever o nome do álbum favorito diretamente em nossa mensagem de saída. 
Para chamar a função agora, você escreveria o seguinte:

favoriteAlbum(name: "Fearless")

Você ainda pode estar se perguntando qual é o objetivo, já que ainda é apenas uma linha de código. 
Bem, imagine que usamos essa função em 20 lugares diferentes em torno de um grande aplicativo, então seu designer 
principal aparece e diz para você mudar a mensagem para "Eu amo tanto Fearless - é o meu favorito!" 
Você realmente quer encontrar e alterar todas as 20 instâncias do seu código? Provavelmente não. 
Com uma função, você a altera uma vez e tudo é atualizado.

Você pode fazer com que suas funções aceitem quantos parâmetros quiser, então vamos fazê-lo aceitar um nome e um ano:

func printAlbumRelease(name: String, year: Int) {
    print("\(name) was released in \(year)")
}

printAlbumRelease(name: "Fearless", year: 2008)
printAlbumRelease(name: "Speak Now", year: 2010)
printAlbumRelease(name: "Red", year: 2012)

Esses nomes de parâmetros de função são importantes e, na verdade, fazem parte da própria função. 
Às vezes, você verá várias funções com o mesmo nome, por exemplo, handle(), mas com nomes de parâmetros 
diferentes para distinguir as diferentes ações.


- Nomes de parâmetros externos e internos
Às vezes, você quer que os parâmetros sejam nomeados de uma maneira quando uma função é chamada, mas de outra maneira 
dentro da própria função. Isso significa que quando você chama uma função, ela usa inglês quase natural, mas dentro da 
função os parâmetros têm nomes sensíveis. Essa técnica é empregada com muita frequência em Swift, então vale a pena 
entender agora.

To demonstrate this, let’s write a function that prints the number of letters in a string. 
This is available using the count property of strings, so we could write this:

func countLettersInString(string: String) {
    print("The string \(string) has \(string.count) letters.")
}

Com essa função em vigor, poderíamos chamá-la assim:

countLettersInString(string: "Hello")

Embora isso certamente funcione, é um pouco prolixo. Além disso, não é o tipo de coisa que você diria em voz alta: 
“contar letras em string string hello”.

A solução da Swift é permitir que você especifique um nome para o parâmetro quando ele está sendo chamado e outro 
dentro do método. Para usar isso, basta escrever o nome do parâmetro duas vezes - uma para externo, outra para interno.

For example, we could name the parameter myString when it’s being called, and str inside the method, like this:

func countLettersInString(myString str: String) {
    print("The string \(str) has \(str.count) letters.")
}

countLettersInString(myString: "Hello")  

Você também pode especificar um sublinhado, _, como o nome do parâmetro externo, que diz à Swift que ela não deve ter 
nenhum nome externo. Por exemplo:

func countLettersInString(_ str: String) {
    print("The string \(str) has \(str.count) letters.")
}

countLettersInString("Hello")

Como você pode ver, isso faz com que a linha de código seja lida como uma frase em inglês: "contar letras na string hello".

While there are many cases when using _ is the right choice, Swift programmers generally prefer to name all their parameters. 
And think about it: why do we need the word “String” in the function – what else would we want to count letters on?

Então, o que você costuma ver são nomes de parâmetros externos como "in", "for" e "with", e nomes internos mais significativos. 
Então, a maneira “Ruveloz” de escrever essa função é assim:

func countLetters(in string: String) {
    print("The string \(string) has \(string.count) letters.")
}

Isso significa que você chama a função com o nome do parâmetro "in", o que não teria sentido dentro da função. 
No entanto, dentro da função, o mesmo parâmetro é chamado de "string", o que é mais útil. 
Então, a função pode ser chamada assim:

countLetters(in: "Hello")

E esse é realmente um código Swifty: "contar letras em olá" parece inglês natural, mas o código também é claro e conciso.


- Valores de retorno
Swift functions can return a value by writing -> then a data type after their parameter list. 
Once you do this, Swift will ensure that your function will return a value no matter what, 
so again this is you making a promise about what your code does.

Por exemplo, vamos escrever uma função que retorne verdadeiro se um álbum for de Taylor Swift ou falso de outra forma. 
Isso precisa aceitar um parâmetro (o nome do álbum a ser verificado) e retornará um booleano. Aqui está o código:

func albumIsTaylor(name: String) -> Bool {
    if name == "Taylor Swift" { return true }
    if name == "Fearless" { return true }
    if name == "Speak Now" { return true }
    if name == "Red" { return true }
    if name == "1989" { return true }

    return false
}

Se você quisesse experimentar seu novo conhecimento switch/case, esta função é um lugar onde funcionaria bem.

Agora você pode chamar isso passando o nome do álbum e agindo sobre o resultado:

if albumIsTaylor(name: "Red") {
    print("That's one of hers!")
} else {
    print("Who made that?!")
}

if albumIsTaylor(name: "Blue") {
    print("That's one of hers!")
} else {
    print("Who made that?!")
}



---------- 2. OPTIONALS 

Swift é uma linguagem muito segura, o que significa que trabalha duro para garantir que seu código nunca falhe de maneiras 
surpreendentes.

Uma das maneiras mais comuns de o código falhar é quando ele tenta usar dados ruins ou ausentes. 
Por exemplo, imagine uma função como esta:

func getHaterStatus() -> String {
    return "Hate"
}

Essa função não aceita nenhum parâmetro e retorna uma string: "Ódio". Mas e se hoje for um dia particularmente ensolarado, 
e esses inimigos não quiserem odiar - e então? Bem, talvez não queiramos devolver nada: esse inimigo não está odiando hoje.

Agora, quando se trata de uma string, você pode pensar que uma string vazia é uma ótima maneira de não comunicar nada, 
e isso pode ser verdade às vezes. Mas que tal números - 0 é um "número vazio"? Ou -1?

Antes de começar a tentar criar regras imaginárias para si mesmo, Swift tem uma solução: opcionais. 
Um valor opcional é aquele que pode ter um valor ou não. A maioria das pessoas acha os opcionais difíceis de entender, 
e tudo bem - vou tentar explicá-lo de várias maneiras, então espero que um funcione.

Por enquanto, imagine uma pesquisa em que você pergunta a alguém: "Em uma escala de 1 a 5, quão incrível é Taylor Swift?" - 
o que alguém responderia se nunca tivesse ouvido falar dela? 1 estaria injustamente acenando, e 5 estaria elogiando-a 
quando eles não tinham ideia de quem era Taylor Swift. A solução é opcional: "Eu não quero fornecer nenhum número".

Quando usamos -> String, isso significa "isso definitivamente retornará uma string", o que significa que essa função 
não pode retornar nenhum valor e, portanto, pode ser chamada de safe, sabendo que você sempre receberá um valor de volta 
que pode usar como string. Se quiséssemos dizer à Swift que essa função pode retornar um valor ou não, precisamos usar 
isso em vez disso:

func getHaterStatus() -> String? {
    return "Hate"
}

Observe o ponto de interrogação extra: String? significa "cadera opcional". Agora, no nosso caso, ainda estamos 
retornando "Ódio", não importa o que aconteça, mas vamos em frente e modificar ainda mais essa função: 
se o tempo estiver ensolarado, os inimigos viraram uma nova folha e desistiram de sua vida de ódio, 
então não queremos devolver nenhum valor. Em Swift, esse "sem valor" tem um nome especial: nil.

Altere a função para isso:

func getHaterStatus(weather: String) -> String? {
    if weather == "sunny" {
        return nil
    } else {
        return "Hate"
    }
}

Isso aceita um parâmetro de string (o clima) e retorna uma string (status de ódio), mas esse valor de retorno pode estar 
lá ou não - é nulo. Nesse caso, isso significa que podemos ter uma string, ou podemos ficar nulos.

Agora, as coisas importantes: Swift quer que seu código seja realmente seguro, e tentar usar um valor nulo é uma má ideia. 
Pode travar seu código, estragar a lógica do seu aplicativo ou pode fazer com que sua interface de usuário mostre a 
coisa errada. Como resultado, quando você declara um valor como opcional, a Swift garantirá que você o manipule com segurança.

Vamos tentar isso agora: adicione estas linhas de código ao seu playground:

var status: String
status = getHaterStatus(weather: "rainy")

The first line creates a string variable, and the second assigns to it the value from getHaterStatus() – 
and today the weather is rainy, so those haters are hating for sure.

That code will not run, because we said that status is of type String, which requires a value, but getHaterStatus() 
might not provide one because it returns an optional string. That is, we said there would definitely be a string in status, 
but getHaterStatus() might return nothing at all. Swift simply will not let you make this mistake, which is extremely 
helpful because it effectively stops dead a whole class of common bugs.

To fix the problem, we need to make the status variable a String?, or just remove the type annotation entirely and let 
Swift use type inference. The first option looks like this:

var status: String?
status = getHaterStatus(weather: "rainy")

E o segundo assim:

var status = getHaterStatus(weather: "rainy")

Independentemente de qual você escolher, esse valor pode estar lá ou não e, por padrão, a Swift não permitirá que você o 
use perigosamente. Por exemplo, imagine uma função como esta:

func takeHaterAction(status: String) {
    if status == "Hate" {
        print("Hating")
    }
}

Isso pega uma string e imprime uma mensagem dependendo do seu conteúdo. 
Esta função recebe um valor String, e não uma String? valor - você não pode passar um opcional aqui, ele quer uma string real, 
o que significa que não podemos chamá-lo usando a variável status.

Swift tem duas soluções. Ambos são usados, mas um é definitivamente preferido ao outro. 
A primeira solução é chamada de desembrulhar opcional e é feita dentro de uma instrução condicional usando sintaxe especial. 
Ele faz duas coisas ao mesmo tempo: verifica se um opcional tem um valor e, em caso afirmativo, o desembrulha em um tipo 
não opcional e executa um bloco de código.

A sintaxe é assim:

if let unwrappedStatus = status {
    // unwrappedStatus contains a non-optional value!
} else {
    // in case you want an else block, here you go…
}

These if let statements check and unwrap in one succinct line of code, which makes them very common. 
Using this method, we can safely unwrap the return value of getHaterStatus() and be sure that we only call takeHaterAction() 
with a valid, non-optional string. Here's the complete code:

func getHaterStatus(weather: String) -> String? {
    if weather == "sunny" {
        return nil
    } else {
        return "Hate"
    }
}

func takeHaterAction(status: String) {
    if status == "Hate" {
        print("Hating")
    }
}

if let haterStatus = getHaterStatus(weather: "rainy") {
    takeHaterAction(status: haterStatus)
}
Se você entende esse conceito, pode pular para o título que diz "Forçar o desembrulhar opcionais". 
Se você ainda não tem certeza sobre os opcionais, continue lendo.

OK, se você ainda estiver aqui, significa que a explicação acima não fazia sentido, ou você meio que entendeu, 
mas provavelmente precisa de algum esclarecimento. As opções são usadas extensivamente em Swift, 
então você realmente precisa entendê-las. Vou tentar explicar novamente, de uma maneira diferente, e espero que isso ajude!

Aqui está uma nova função:

func yearAlbumReleased(name: String) -> Int {
    if name == "Taylor Swift" { return 2006 }
    if name == "Fearless" { return 2008 }
    if name == "Speak Now" { return 2010 }
    if name == "Red" { return 2012 }
    if name == "1989" { return 2014 }

    return 0
}

Isso leva o nome de um álbum da Taylor Swift e retorna o ano em que foi lançado. Mas se o chamarmos com o nome do 
álbum de "Lantern" porque misturamos Taylor Swift com Hudson Mohawke (um erro fácil de cometer, certo?) então retorna 0 
porque não é um dos álbuns de Taylor.

Mas 0 faz sentido aqui? Claro, se o álbum foi lançado em 0 d.C., quando César Augusto era imperador de Roma, 0 
pode fazer sentido, mas aqui é apenas confuso - as pessoas precisam saber com antecedência que 0 significa "não reconhecido".

Uma ideia muito melhor é reescrever essa função para que ela retorne um número inteiro (quando um ano foi encontrado) 
ou nulo (quando nada foi encontrado), o que é fácil graças aos opcionais. Aqui está a nova função:

func yearAlbumReleased(name: String) -> Int? {
    if name == "Taylor Swift" { return 2006 }
    if name == "Fearless" { return 2008 }
    if name == "Speak Now" { return 2010 }
    if name == "Red" { return 2012 }
    if name == "1989" { return 2014 }

    return nil
}

Now that it returns nil, we need to unwrap the result using if let because we need to check whether a value exists or not.

Se você entende o conceito agora, pode pular para o título que diz "Forçar o desembrulhar opcional". 
Se você ainda não tem certeza sobre os opcionais, continue lendo.

OK, se você ainda estiver aqui, isso significa que está realmente lutando com opcionais, 
então vou ter uma última chance para explicá-los.

Aqui está uma variedade de nomes:

var items = ["James", "John", "Sally"]

Se quiséssemos escrever uma função que olhasse nessa matriz e nos dissesse o índice de um nome específico, 
poderíamos escrever algo assim:

func position(of string: String, in array: [String]) -> Int {
    for i in 0 ..< array.count {
        if array[i] == string {
            return i
        }
    }

    return 0
}

Isso percorre todos os itens da matriz, retornando sua posição se encontrar uma correspondência, caso contrário, retornando 0.

Agora tente executar estas quatro linhas de código:

let jamesPosition = position(of: "James", in: items)
let johnPosition = position(of: "John", in: items)
let sallyPosition = position(of: "Sally", in: items)
let bobPosition = position(of: "Bob", in: items)

Isso produzirá 0, 1, 2, 0 - as posições de James e Bob são as mesmas, mesmo que uma exista e outra não exista. 
Isso ocorre porque eu usei 0 para significar "não encontrado". A solução fácil pode ser fazer -1 não encontrado, 
mas seja 0 ou -1, você ainda tem um problema porque precisa se lembrar que esse número específico significa "não encontrado".

A solução é opcional: retorne um número inteiro se você encontrou a correspondência, ou nula de outra forma. 
Na verdade, esta é exatamente a abordagem que os métodos internos "find in array" usam: someArray.firstIndex(of: someValue)

When you work with these "might be there, might not be" values, Swift forces you to unwrap them before using them, 
thus acknowledging that there might not be a value. That's what if let syntax does: if the optional has a value then 
unwrap it and use it, otherwise don't use it at all. You can’t use a possibly-empty value by accident, because Swift 
won’t let you.


- Forçar o desembrulho opcional
O Swift permite que você substitua sua segurança usando o caractere do ponto de exclamação: !. 
Se você sabe que um opcional definitivamente tem um valor, você pode forçar o desembrulhar colocando este 
ponto de exclamação depois dele.

Por favor, tenha cuidado: se você tentar isso em uma variável que não tenha um valor, seu código falhará.

Para montar um exemplo funcional, aqui está um código fundamental:

func yearAlbumReleased(name: String) -> Int? {
    if name == "Taylor Swift" { return 2006 }
    if name == "Fearless" { return 2008 }
    if name == "Speak Now" { return 2010 }
    if name == "Red" { return 2012 }
    if name == "1989" { return 2014 }

    return nil
}

var year = yearAlbumReleased(name: "Red")

if year == nil {
    print("There was an error")
} else {
    print("It was released in \(year)")
}

That gets the year an album was released. If the album couldn't be found, year will be set to nil, 
and an error message will be printed. Otherwise, the year will be printed.

Or will it? Well, yearAlbumReleased() returns an optional integer, and this code doesn't use if let to unwrap that optional. 
As a result, it will print out the following: "It was released in Optional(2012)" – probably not what we wanted!

At this point in the code, we have already checked that we have a valid value, so it's a bit pointless to have another 
if let in there to safely unwrap the optional. So, Swift provides a solution – change the second print() call to this:

print("It was released in \(year!)")

Observe o ponto de exclamação: significa "Tenho certeza de que isso contém um valor, então force o desembrulhar agora".


- Opcionais implicitamente desembrulhados
Você também pode usar essa sintaxe de ponto de exclamação para criar opcionais implicitamente desembrulhados, 
que é onde algumas pessoas realmente começam a se confundir. Então, por favor, leia isso com atenção!

-A regular variable must contain a value. Example: String must contain a string, even if that string is empty, i.e. "". 
It cannot be nil.

-Uma variável opcional pode conter um valor ou não. Deve ser desembrulhado antes de ser usado. 
Exemplo: String? pode conter uma string ou pode conter nil. A única maneira de descobrir é desembrulhar.

-Um opcional implicitamente desembrulhado pode conter um valor ou não. Mas não precisa ser desembrulhado antes de ser usado. 
Swift não vai verificar para você, então você precisa ter muito cuidado. 
Exemplo: String! pode conter uma string, ou pode conter nil - e cabe a você usá-la adequadamente. 
É como uma opção regular, mas a Swift permite que você acesse o valor diretamente sem a segurança de desembrulhar. 
Se você tentar fazer isso, isso significa que sabe que há um valor lá - mas se você estiver errado, seu aplicativo vai falhar.

Os principais momentos em que você encontrará opcionais implicitamente desembrulhados são quando você está trabalhando 
com elementos da interface do usuário no UIKit no iOS ou no AppKit no macOS. Eles precisam ser declarados antecipadamente, 
mas você não pode usá-los até que tenham sido criados - e a Apple gosta de criar elementos da interface do usuário no 
último momento possível para evitar qualquer trabalho desnecessário. Ter que desembrulhar continuamente valores que 
você definitivamente sabe que estará lá é irritante, então eles são implicitamente desembrulhados.

Não se preocupe se você achar opcionais implicitamente desembrulhados um pouco difíceis de entender - 
ficará claro à medida que você trabalhar com o idioma.



---------- 3. OPTIONAL CHAINING 

Trabalhar com opcionais pode parecer um pouco desajeitado às vezes, e todo o desembrulhar e verificação podem se 
tornar tão onerosos que você pode ficar tentado a jogar alguns pontos de exclamação para forçar o desembrulhar 
coisas para que você possa continuar com o trabalho. Tenha cuidado, no entanto: se você forçar o desembrulhar um 
opcional que não tenha um valor, seu código falhará.

Swift tem duas técnicas para ajudar a tornar seu código menos complicado. O primeiro é chamado de encadeamento opcional, 
que permite que você execute o código somente se o seu opcional tiver um valor. Coloque o código abaixo no seu playground 
para nos ajudar a começar:

func albumReleased(year: Int) -> String? {
    switch year {
    case 2006: return "Taylor Swift"
    case 2008: return "Fearless"
    case 2010: return "Speak Now"
    case 2012: return "Red"
    case 2014: return "1989"
    default: return nil
    }
}

let album = albumReleased(year: 2006)
print("The album is \(album)")

Isso exibirá "O álbum é Opcional ("Taylor Swift")" no painel de resultados.

If we wanted to convert the return value of albumReleased() to be uppercase letters (that is, "TAYLOR SWIFT" rather than 
"Taylor Swift") we could call the uppercased() method of that string. For example:

let str = "Hello world"
print(str.uppercased())

The problem is, albumReleased() returns an optional string: it might return a string or it might return nothing at all. 
So, what we really mean is, "if we got a string back make it uppercase, otherwise do nothing." And that's where optional 
chaining comes in, because it provides exactly that behavior.

Tente alterar as duas últimas linhas de código para isso:

let album = albumReleased(year: 2006)?.uppercased()
print("The album is \(album)")

Observe que há um ponto de interrogação lá, que é o encadeamento opcional: tudo após o ponto de interrogação só será 
executado se tudo antes do ponto de interrogação tiver um valor. Isso não afeta o tipo de dados subjacente do album, 
porque essa linha de código agora retornará nil ou retornará o nome do álbum em maiúsculas - ainda é uma string opcional.

Suas correntes opcionais podem ser o tempo que você precisar, por exemplo:

let album = albumReleased(year: 2006)?.someOptionalValue?.someOtherOptionalValue?.whatever

A Swift os verificará da esquerda para a direita até encontrar nulo, momento em que pára.


- O operador de coalescência nulo
Esse recurso simples do Swift torna seu código muito mais simples e seguro, e ainda tem um nome tão grandioso que 
muitas pessoas têm medo dele. Isso é uma pena, porque o operador de coalescência nula tornará sua vida mais fácil 
se você reservar um tempo para descobrir!

O que ele faz é deixar você dizer "use o valor A se puder, mas se o valor A for nulo, use o valor B". É isso aí. 
É particularmente útil com opcionais, porque efetivamente impede que eles sejam opcionais porque você fornece um 
valor não opcional B. Então, se A é opcional e tem um valor, ele é usado (nós temos um valor). 
Se A estiver presente e não tiver valor, B será usado (então ainda temos um valor). 
De qualquer forma, definitivamente temos um valor.

Para lhe dar um contexto real, tente usar este código no seu playground:

let album = albumReleased(year: 2006) ?? "unknown"
print("The album is \(album)")

That double question mark is the nil coalescing operator, and in this situation it means 
"if albumReleased() returned a value then put it into the album variable, but if albumReleased() returned nil 
then use 'unknown' instead."

Se você olhar no painel de resultados agora, verá "O álbum é Taylor Swift" impresso lá - sem mais opcionais. 
Isso ocorre porque a Swift agora pode ter certeza de que receberá um valor real de volta, seja porque a função 
retornou um ou porque você está fornecendo "desconhecido". Isso, por sua vez, significa que você não precisa 
desembrulhar nada ou correr o risco de falhas - você tem a garantia de ter dados reais para trabalhar, 
o que torna seu código mais seguro e fácil de trabalhar.



---------- 4. ENUMERATIONS 

As enumerações - geralmente chamadas apenas de "enum" e pronunciadas "ee-num" - são uma maneira de definir seu próprio 
tipo de valor em Swift. Em algumas linguagens de programação, elas são pequenas coisas simples, mas a Swift adiciona 
uma enorme quantidade de poder a elas se você quiser ir além do básico.

Vamos começar com um exemplo simples de antes:

func getHaterStatus(weather: String) -> String? {
    if weather == "sunny" {
        return nil
    } else {
        return "Hate"
    }
}

Essa função aceita uma string que define o clima atual. O problema é que uma string é uma má escolha para esse tipo de dado 
- é "chuva", "chuva" ou "chuva"? Ou talvez "chuveiro", "chuvinho" ou "tempestade"? 
Pior, e se uma pessoa escrevesse "Chuva" com um R maiúsculo e outra pessoa escrevesse "Ran" porque não estava 
olhando para o que digitava?

As Enums resolvem esse problema permitindo que você defina um novo tipo de dados e, em seguida, 
defina os possíveis valores que ele pode conter. Por exemplo, podemos dizer que existem cinco tipos de clima: 
sol, nuvem, chuva, vento e neve. Se fizermos disso uma enum, isso significa que a Swift aceitará apenas esses 
cinco valores - qualquer outra coisa acionará um erro. E nos bastidores, as enums geralmente são apenas números 
simples, que são muito mais rápidos do que as strings para os computadores trabalharem.

Vamos colocar isso em código:

enum WeatherType {
    case sun, cloud, rain, wind, snow
}

func getHaterStatus(weather: WeatherType) -> String? {
    if weather == WeatherType.sun {
        return nil
    } else {
        return "Hate"
    }
}

getHaterStatus(weather: WeatherType.cloud)

Take a look at the first three lines: line 1 gives our type a name, WeatherType. 
This is what you'll use in place of String or Int in your code. Line 2 defines the five possible cases our enum can be, 
as I already outlined. Convention has these start with a lowercase letter, so “sun”, “cloud”, etc. 
And line 3 is just a closing brace, ending the enum.

Now take a look at how it's used: I modified the getHaterStatus() so that it takes a WeatherType value. 
The conditional statement is also rewritten to compare against WeatherType.sun, which is our value. 
Remember, this check is just a number behind the scenes, which is lightning fast.

Agora, volte e leia esse código novamente, porque estou prestes a reescrevê-lo com duas alterações que são importantes. 
Tudo pronto?

enum WeatherType {
    case sun
    case cloud
    case rain
    case wind
    case snow
}

func getHaterStatus(weather: WeatherType) -> String? {
    if weather == .sun {
        return nil
    } else {
        return "Hate"
    }
}

getHaterStatus(weather: .cloud)

I made two differences there. First, each of the weather types are now on their own line. 
This might seem like a small change, and indeed in this example it is, but it becomes important soon. 
The second change was that I wrote if weather == .sun – I didn't need to spell out that I meant WeatherType.sun 
because Swift knows I am comparing against a WeatherType variable, so it's using type inference.

Enums are particularly useful inside switch/case blocks, particularly because Swift knows all the values your enum can 
have so it can ensure you cover them all. For example, we might try to rewrite the getHaterStatus() method to this:

func getHaterStatus(weather: WeatherType) -> String? {
    switch weather {
    case .sun:
        return nil
    case .cloud, .wind:
        return "dislike"
    case .rain:
        return "hate"
    }
}

Sim, eu percebo que "odiadores vão não gostar" dificilmente é uma ótima letra, mas é acadêmico de qualquer maneira 
porque esse código não é construído: ele não lida com o caso .snow, e Swift quer que todos os casos sejam cobertos. 
Você precisa adicionar um caso para ele ou adicionar um caso padrão.


- Enums com valores adicionais
One of the most powerful features of Swift is that enumerations can have values attached to them that you define. 
To extend our increasingly dubious example a bit further, I'm going to add a value to the .wind case so that we can 
say how fast the wind is. Modify your code to this:

enum WeatherType {
    case sun
    case cloud
    case rain
    case wind(speed: Int)
    case snow
}

As you can see, the other cases don't need a speed value – I put that just into wind. Now for the real magic: 
Swift lets us add extra conditions to the switch/case block so that a case will match only if those conditions are true. 
This uses the let keyword to access the value inside a case, then the where keyword for pattern matching.

Aqui está a nova função:

func getHaterStatus(weather: WeatherType) -> String? {
    switch weather {
    case .sun:
        return nil
    case .wind(let speed) where speed < 10:
        return "meh"
    case .cloud, .wind:
        return "dislike"
    case .rain, .snow:
        return "hate"
    }
}

getHaterStatus(weather: WeatherType.wind(speed: 5))

You can see .wind appears in there twice, but the first time is true only if the wind is slower than 10 kilometers per hour.
If the wind is 10 or above, that won't match. The key is that you use let to get hold of the value inside the enum 
(i.e. to declare a constant name you can reference) then use a where condition to check.

Swift evaluates switch/case from top to bottom, and stops as soon as it finds a match. 
This means that if case .cloud, .wind: appears before case .wind(let speed) where speed < 10: 
then it will be executed instead – and the output changes.

Então, pense cuidadosamente sobre como você pede casos!

Tip: Swift’s optionals are actually implemented using enums with associated values. 
There are two cases: none, and some, with some having whatever value is inside the optional.



---------- 5. STRUCTS 

Structs are complex data types, meaning that they are made up of multiple values. 
You then create an instance of the struct and fill in its values, then you can pass it around as a single value in your code. 
For example, we could define a Person struct type that contains two properties: clothes and shoes:

struct Person {
    var clothes: String
    var shoes: String
}

Quando você define uma estrutura, o Swift os torna muito fáceis de criar, pois gera automaticamente o que é 
chamado de inicializador memberwise. Em linguagem simples, isso significa que você cria a estrutura passando 
valores iniciais para suas duas propriedades, assim:

let taylor = Person(clothes: "T-shirts", shoes: "sneakers")
let other = Person(clothes: "short skirts", shoes: "high heels")

Depois de criar uma instância de uma estrutura, você pode ler suas propriedades apenas escrevendo o nome da estrutura, 
um ponto e, em seguida, a propriedade que deseja ler:

print(taylor.clothes)
print(other.shoes)

Se você atribuir uma estrutura a outra, a Swift a copiará nos bastidores para que seja uma duplicata completa e 
autônoma do original. Bem, isso não é estritamente verdade: Swift usa uma técnica chamada "copiar na gravação", 
o que significa que ela só copia seus dados se você tentar alterá-los.

Para ajudá-lo a ver como as cópias de estrutura funcionam, coloque isso no seu playground:

struct Person {
    var clothes: String
    var shoes: String
}

let taylor = Person(clothes: "T-shirts", shoes: "sneakers")
let other = Person(clothes: "short skirts", shoes: "high heels")

var taylorCopy = taylor
taylorCopy.shoes = "flip flops"

print(taylor)
print(taylorCopy)

That creates two Person structs, then creates a third one called taylorCopy as a copy of taylor. 
What happens next is the interesting part: the code changes taylorCopy, and prints both it and taylor. 
If you look in your results pane (you might need to resize it to fit) you'll see that the copy has a different 
value to the original: changing one did not change the other.


- Funções dentro das estruturas
You can place functions inside structs, and in fact it’s a good idea to do so for all functions that read or change data 
inside the struct. For example, we could add a function to our Person struct to describe what they are wearing, like this:

struct Person {
    var clothes: String
    var shoes: String

    func describe() {
        print("I like wearing \(clothes) with \(shoes)")
    }
}

Há mais uma coisa que você deve saber, mas não pode ver nesse código: 
quando você escreve uma função dentro de uma estrutura, ela é chamada de método. 
Em Swift, você escreve func, seja uma função ou um método, mas a distinção é preservada quando você fala sobre eles.



---------- 6. CLASSES 

A Swift tem outra maneira de criar tipos de dados complexos chamados classes. 
Eles se parecem com as estruturas, mas têm várias diferenças importantes, incluindo:

-Você não recebe um inicializador automático para suas aulas; você precisa escrever o seu próprio.

-Você pode definir uma classe como sendo baseada em outra classe, adicionando quaisquer coisas novas que desejar.

-Quando você cria uma instância de uma classe, ela é chamada de objeto. Se você copiar esse objeto, 
ambas as cópias apontam para os mesmos dados por padrão - altere um e a cópia também muda.

Todas essas três são enormes diferenças, então vou cobri-las com mais profundidade antes de continuar.


- Inicializando um objeto
If we were to convert our Person struct into a Person class, Swift wouldn't let us write this:

class Person {
    var clothes: String
    var shoes: String
}

Isso ocorre porque estamos declarando que as duas propriedades são String, o que, se você se lembra, 
significa que elas absolutamente devem ter um valor. Isso foi bom em uma estrutura porque o Swift produz 
automaticamente um inicializador memberwise para nós que nos forçou a fornecer valores para as duas propriedades, 
mas isso não acontece com as classes, então o Swift não pode ter certeza de que elas receberão valores.

Existem três soluções: tornar os dois valores strings opcionais, dar a eles valores padrão ou escrever nosso 
próprio inicializador. A primeira opção é desajeitada porque introduz opcionais em todo o nosso código, onde 
eles não precisam estar. A segunda opção funciona, mas é um pouco desperdiçadora, a menos que esses valores 
padrão sejam realmente usados. Isso deixa a terceira opção, e realmente é a certa: escrever nosso próprio inicializador.

To do this, create a method inside the class called init() that takes the two parameters we care about:

class Person {
    var clothes: String
    var shoes: String

    init(clothes: String, shoes: String) {
        self.clothes = clothes
        self.shoes = shoes
    }
}

Há duas coisas que podem saltar para você nesse código.

First, you don't write func before your init() method, because it's special. 
Second, because the parameter names being passed in are the same as the names of the properties we want to assign, 
you use self. to make your meaning clear – "the clothes property of this object should be set to the clothes parameter 
that was passed in." You can give them unique names if you want – it's down to you.

Importante: Swift requer que todas as propriedades não opcionais tenham um valor até o final do inicializador, 
ou no momento em que o inicializador chama qualquer outro método - o que ocorrer primeiro.


- Herança de classe
A segunda diferença entre classes e estruturas é que as classes podem construir umas sobre as outras para produzir 
coisas maiores, conhecidas como herança de classes. Esta é uma técnica amplamente utilizada no Cocoa Touch, mesmo 
nos programas mais básicos, por isso é algo que você deve entender.

Let's start with something simple: a Singer class that has properties, which is their name and age. 
As for methods, there will be a simple initializer to handle setting the properties, plus a sing() 
method that outputs some words:

class Singer {
    var name: String
    var age: Int

    init(name: String, age: Int) {
        self.name = name
        self.age = age
    }

    func sing() {
        print("La la la la")
    }
}

Agora podemos criar uma instância desse objeto chamando esse inicializador, depois ler suas propriedades e chamar seu método:

var taylor = Singer(name: "Taylor", age: 25)
taylor.name
taylor.age
taylor.sing()

That's our basic class, but we're going to build on it: I want to define a CountrySinger class that has everything 
the Singer class does, but when I call sing() on it I want to print "Trucks, guitars, and liquor" instead.

You could of course just copy and paste the original Singer into a new class called CountrySinger but that's a 
lazy way to program and it will come back to haunt you if you make later changes to Singer and forget to copy them across. 
Instead, Swift has a smarter solution: we can define CountrySinger as being based off Singer and it will get all its 
properties and methods for us to build on:

class CountrySinger: Singer {

}

That colon is what does the magic: it means "CountrySinger extends Singer." 
Now, that new CountrySinger class (called a subclass) doesn't add anything to Singer 
(called the parent class, or superclass) yet. We want it to have its own sing() method, 
but in Swift you need to learn a new keyword: override. This means "I know this method was implemented by my parent class, 
but I want to change it for this subclass."

Having the override keyword is helpful, because it makes your intent clear. It also allows Swift to check your code: 
if you don't use override Swift won't let you change a method you got from your superclass, or if you use override and 
there wasn't anything to override, Swift will point out your error.

Então, precisamos usar o override func, assim:

class CountrySinger: Singer {
    override func sing() {
        print("Trucks, guitars, and liquor")
    }
}

Now modify the way the taylor object is created:

var taylor = CountrySinger(name: "Taylor", age: 25)
taylor.sing()

If you change CountrySinger to just Singer you should be able to see the different messages appearing in the results pane.

Agora, para tornar as coisas mais complicadas, vamos definir uma nova classe chamada HeavyMetalSinger. 
Mas desta vez vamos armazenar uma nova propriedade chamada noiseLevel, definindo o quão alto esse cantor de 
heavy metal em particular gosta de gritar no microfone.

Isso causa um problema, e é um que precisa ser resolvido de uma maneira muito particular:

- Swift quer que todas as propriedades não opcionais tenham um valor.

- Our Singer class doesn't have a noiseLevel property.

- So, we need to create a custom initializer for HeavyMetalSinger that accepts a noise level.

- That new initializer also needs to know the name and age of the heavy metal singer, 
so it can pass it onto the superclass Singer.

- A transmissão de dados para a superclasse é feita por meio de uma chamada de método, 
e você não pode fazer chamadas de método em inicializadores até que tenha fornecido todos os seus valores de propriedades.

- Portanto, precisamos definir nossa própria propriedade primeiro (noiseLevel) e, em seguida, 
passar os outros parâmetros para a superclasse usar.

- Isso pode parecer muito complicado, mas em código é simples. Aqui está a classe HeavyMetalSinger, 
completa com seu próprio método sing():

class HeavyMetalSinger: Singer {
    var noiseLevel: Int

    init(name: String, age: Int, noiseLevel: Int) {
        self.noiseLevel = noiseLevel
        super.init(name: name, age: age)
    }

    override func sing() {
        print("Grrrrr rargh rargh rarrrrgh!")
    }
}

Notice how its initializer takes three parameters, then calls super.init() to pass name and age on to the 
Singer superclass - but only after its own property has been set. You'll see super used a lot when working with objects, 
and it just means "call a method on the class I inherited from.” It's usually used to mean "let my parent class do 
everything it needs to do first, then I'll do my extra bits."

A herança de classe é um grande tópico, então não se preocupe se ainda não estiver claro. 
No entanto, há mais uma coisa que você precisa saber: a herança de classes geralmente se estende por muitos níveis. 
Por exemplo, A poderia herdar de B, e B poderia herdar de C, e C poderia herdar de D, e assim por diante. 
Isso permite que você crie funcionalidades e reutilize em várias classes, ajudando a manter seu código modular 
e fácil de entender.


- Trabalhando com o código Objective-C
Se você quiser que alguma parte do sistema operacional da Apple chame o método da sua classe Swift, 
você precisa marcá-lo com um atributo especial: @objc. Isso é a abreviação de "Objetivo-C", e o atributo 
efetivamente marca o método como estando disponível para a execução mais antiga do código Objective-C - 
que é quase todo iOS, macOS, watchOS e tvOS. Por exemplo, se você pedir ao sistema para chamar seu método 
depois de passar um segundo, precisará marcá-lo com @objc.

Don’t worry too much about @objc for now – not only will I be explaining it in context later on, but 
Xcode will always tell you when it’s needed. Alternatively, if you don’t want to use @objc for individual 
methods you can put @objcMembers before your class to automatically make all its methods available to Objective-C.


- Valores vs Referências
Quando você copia uma estrutura, a coisa toda é duplicada, incluindo todos os seus valores. 
Isso significa que alterar uma cópia de uma estrutura não altera as outras cópias - todas elas são individuais. 
Com classes, cada cópia de um objeto aponta para o mesmo objeto original, portanto, se você alterar um, todas elas mudam. 
A Swift chama as estruturas de "tipos de valor" porque apenas apontam para um valor e as classes de "tipos de referência" 
porque os objetos são apenas referências compartilhadas ao valor real.

Esta é uma diferença importante, e significa que a escolha entre estruturas e classes é importante:

- Se você quiser ter um estado compartilhado que seja passado e modificado no lugar, você está procurando aulas. 
Você pode passá-los para funções ou armazená-los em matrizes, modificá-los lá e ter essa mudança refletida no resto 
do seu programa.

- Se você quiser evitar o estado compartilhado em que uma cópia não pode afetar todas as outras, 
você está procurando estruturas. Você pode passá-los para funções ou armazená-los em matrizes, modificá-los lá, 
e eles não mudarão onde quer que sejam referenciados.

Se eu fosse resumir essa diferença fundamental entre estruturas e classes, eu diria o seguinte: 
as aulas oferecem mais flexibilidade, enquanto as estruturas oferecem mais segurança. 
Como regra básica, você deve sempre usar estruturas até ter um motivo específico para usar classes.



