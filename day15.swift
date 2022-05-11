10/05/2022


REVISÃO (DIA 3)


---------- 1. PROPERTIES 

Estruturas e classes (coletivamente: "tipos") podem ter suas próprias variáveis e constantes, e estas são chamadas de propriedades. 
Eles permitem que você anexe valores aos seus tipos para representá-los exclusivamente, mas como os tipos também podem ter métodos, 
você pode fazer com que eles se comportem de acordo com seus próprios dados.

Vamos dar uma olhada em um exemplo agora:

struct Person {
    var clothes: String
    var shoes: String

    func describe() {
        print("I like wearing \(clothes) with \(shoes)")
    }
}

let taylor = Person(clothes: "T-shirts", shoes: "sneakers")
let other = Person(clothes: "short skirts", shoes: "high heels")
taylor.describe()
other.describe()

Como você pode ver, quando você usa uma propriedade dentro de um método, ela usará automaticamente o valor que pertence ao mesmo objeto.


- Observadores da propriedade
Swift permite que você adicione código a ser executado quando uma propriedade estiver prestes a ser alterada ou tiver sido alterada. 
Esta é frequentemente uma boa maneira de ter uma atualização da interface do usuário quando um valor muda, por exemplo.

There are two kinds of property observer: willSet and didSet, and they are called before or after a property is changed. 
In willSet Swift provides your code with a special value called newValue that contains what the new property value is going to be, 
and in didSet you are given oldValue to represent the previous value.

Let's attach two property observers to the clothes property of a Person struct:

struct Person {
    var clothes: String {
        willSet {
            updateUI(msg: "I'm changing from \(clothes) to \(newValue)")
        }

        didSet {
            updateUI(msg: "I just changed from \(oldValue) to \(clothes)")
        }
    }
}

func updateUI(msg: String) {
    print(msg)
}

var taylor = Person(clothes: "T-shirts")
taylor.clothes = "short skirts"

Isso imprimirá as mensagens "Estou mudando de camisetas para saias curtas" e "Acabei de mudar de camisetas para saias curtas".


- Propriedades calculadas
It's possible to make properties that are actually code behind the scenes. We already used the uppercased() method of strings, 
for example, but there’s also a property called capitalized that gets calculated as needed, rather than every string always storing 
a capitalized version of itself.

To make a computed property, place an open brace after your property then use either get or set to make an action happen at the appropriate time. 
For example, if we wanted to add a ageInDogYears property that automatically returned a person's age multiplied by seven, we'd do this:

struct Person {
    var age: Int

    var ageInDogYears: Int {
        get {
            return age * 7
        }
    }
}

var fan = Person(age: 25)
print(fan.ageInDogYears)

As propriedades calculadas são cada vez mais comuns no código da Apple, mas menos comuns no código do usuário.

Nota: Se você pretende usá-los apenas para ler dados, você pode simplesmente remover completamente a parte get, assim:

var ageInDogYears: Int {
    return age * 7
}



---------- 2. STATIC PROPERTIES AND METHODS 

O Swift permite que você crie propriedades e métodos que pertencem a um tipo, em vez de instâncias de um tipo. 
Isso é útil para organizar seus dados de forma significativa, armazenando dados compartilhados.

A Swift chama essas propriedades compartilhadas de "propriedades estáticas", e você cria uma apenas usando a palavra-chave static. 
Uma vez feito isso, você acessa a propriedade usando o nome completo do tipo. Aqui está um exemplo simples:

struct TaylorFan {
    static var favoriteSong = "Look What You Made Me Do"

    var name: String
    var age: Int
}

let fan = TaylorFan(name: "James", age: 25)
print(TaylorFan.favoriteSong)

Então, um fã de Taylor Swift tem um nome e uma idade que pertencem a eles, mas todos eles têm a mesma música favorita.

Como os métodos estáticos pertencem à própria estrutura, em vez de a instâncias dessa estrutura, 
você não pode usá-la para acessar propriedades não estáticas da estrutura.



---------- 3. ACCESS CONTROL 

O controle de acesso permite que você especifique quais dados dentro de estruturas e classes devem ser expostos ao mundo exterior, 
e você pode escolher quatro modificadores:

- Public: isso significa que todos podem ler e escrever a propriedade.

- Internal: isso significa que apenas o seu código Swift pode ler e gravar a propriedade. 
Se você enviar seu código como uma estrutura para outras pessoas usarem, elas não poderão ler a propriedade.

- File Private: isso significa que apenas o código Swift no mesmo arquivo que o tipo pode ler e gravar a propriedade.

- Private: esta é a opção mais restritiva e significa que a propriedade está disponível apenas dentro de métodos que pertencem 
ao tipo ou suas extensões.

Na maioria das vezes, você não precisa especificar o controle de acesso, mas às vezes você vai querer definir 
explicitamente uma propriedade como privada porque impede que outras pessoas a acessem diretamente. 
Isso é útil porque seus próprios métodos podem funcionar com essa propriedade, mas outros não, forçando-os 
a passar pelo seu código para executar certas ações.

Para declarar uma propriedade privada, basta fazer o seguinte:

class TaylorFan {
    private var name: String?
}

Se você quiser usar o controle de acesso "file private", basta escrevê-lo como uma palavra assim: fileprivate.



---------- 4. POLYMORPHISM AND TYPECASTING 

Because classes can inherit from each other (e.g. CountrySinger can inherit from Singer) it means one class is effectively a superset of another: 
class B has all the things A has, with a few extras. This in turn means that you can treat B as type B or as type A, depending on your needs.

Confuso? Vamos tentar algum código:

class Album {
    var name: String

    init(name: String) {
        self.name = name
    }
}

class StudioAlbum: Album {
    var studio: String

    init(name: String, studio: String) {
        self.studio = studio
        super.init(name: name)
    }
}

class LiveAlbum: Album {
    var location: String

    init(name: String, location: String) {
        self.location = location
        super.init(name: name)
    }
}

That defines three classes: albums, studio albums and live albums, with the latter two both inheriting from Album. 
Because any instance of LiveAlbum is inherited from Album it can be treated just as either Album or LiveAlbum – 
it's both at the same time. This is called "polymorphism," but it means you can write code like this:

var taylorSwift = StudioAlbum(name: "Taylor Swift", studio: "The Castles Studios")
var fearless = StudioAlbum(name: "Speak Now", studio: "Aimeeland Studio")
var iTunesLive = LiveAlbum(name: "iTunes Live from SoHo", location: "New York")

var allAlbums: [Album] = [taylorSwift, fearless, iTunesLive]

Lá, criamos uma matriz que contém apenas álbuns, mas colocamos dentro dela dois álbuns de estúdio e um álbum ao vivo. 
Isso é perfeitamente bom em Swift porque todos eles são descendentes da classe Album, então eles compartilham o mesmo comportamento básico.

We can push this a step further to really demonstrate how polymorphism works. Let's add a getPerformance() method to all three classes:

class Album {
    var name: String

    init(name: String) {
        self.name = name
    }

    func getPerformance() -> String {
        return "The album \(name) sold lots"
    }
}

class StudioAlbum: Album {
    var studio: String

    init(name: String, studio: String) {
        self.studio = studio
        super.init(name: name)
    }

    override func getPerformance() -> String {
        return "The studio album \(name) sold lots"
    }
}

class LiveAlbum: Album {
    var location: String

    init(name: String, location: String) {
        self.location = location
        super.init(name: name)
    }

    override func getPerformance() -> String {
        return "The live album \(name) sold lots"
    }
}

The getPerformance() method exists in the Album class, but both child classes override it.
 When we create an array that holds Albums, we're actually filling it with subclasses of albums: LiveAlbum and StudioAlbum. 
 They go into the array just fine because they inherit from the Album class, but they never lose their original class. 
 So, we could write code like this:

var taylorSwift = StudioAlbum(name: "Taylor Swift", studio: "The Castles Studios")
var fearless = StudioAlbum(name: "Speak Now", studio: "Aimeeland Studio")
var iTunesLive = LiveAlbum(name: "iTunes Live from SoHo", location: "New York")

var allAlbums: [Album] = [taylorSwift, fearless, iTunesLive]

for album in allAlbums {
    print(album.getPerformance())
}

Isso usará automaticamente a versão de substituição de getPerformance(), dependendo da subclasse em questão. 
Isso é polimorfismo em ação: um objeto pode funcionar como sua classe e suas classes pai, tudo ao mesmo tempo.


- Convertendo tipos com typecasting
Muitas vezes você descobrirá que tem um objeto de um certo tipo, mas realmente sabe que é um tipo diferente. 
Infelizmente, se a Swift não souber o que você sabe, ela não construirá seu código. 
Então, há uma solução, e ela é chamada de typecasting: converter um objeto de um tipo para outro.

É provável que você esteja lutando para pensar por que isso pode ser necessário, mas posso te dar um exemplo muito simples:

for album in allAlbums {
    print(album.getPerformance())
}

That was our loop from a few minutes ago. The allAlbums array holds the type Album, but we know that really it's holding one of the subclasses: 
StudioAlbum or LiveAlbum. Swift doesn't know that, so if you try to write something like print(album.studio) it will refuse to build because 
only StudioAlbum objects have that property.

O Typecasting em Swift vem em três formas, mas na maioria das vezes você só encontrará duas: as? e as!, conhecido como downcasting opcional 
e downcasting forçado. O primeiro significa "Acho que essa conversão pode ser verdadeira, mas pode falhar", e o segundo significa 
"Eu sei que essa conversão é verdadeira e estou feliz que meu aplicativo falhe se eu estiver errado".

Nota: quando eu digo "conversão", não quero dizer que o objeto literalmente seja transformado. 
Em vez disso, é apenas converter como Swift trata o objeto - você está dizendo a Swift que um objeto que ela pensou ser do tipo A é 
realmente o tipo E.

A pergunta e os pontos de exclamação devem lhe dar uma dica do que está acontecendo, porque isso é muito semelhante ao território opcional. 
Por exemplo, se você escrever isso:

for album in allAlbums {
    let studioAlbum = album as? StudioAlbum
}

Swift will make studioAlbum have the data type StudioAlbum?. That is, an optional studio album: 
the conversion might have worked, in which case you have a studio album you can work with, or it might have failed, in which case you have nil.

This is most commonly used with if let to automatically unwrap the optional result, like this:

for album in allAlbums {
    print(album.getPerformance())

    if let studioAlbum = album as? StudioAlbum {
        print(studioAlbum.studio)
    } else if let liveAlbum = album as? LiveAlbum {
        print(liveAlbum.location)
    }
}

That will go through every album and print its performance details, because that's common to the Album class and all its subclasses. 
It then checks whether it can convert the album value into a StudioAlbum, and if it can it prints out the studio name. The same thing 
is done for the LiveAlbum in the array.

A transmissão forçada é quando você tem certeza de que um objeto de um tipo pode ser tratado como um tipo diferente, 
mas se você estiver errado, seu programa simplesmente falhará. A transmissão forçada não precisa retornar um valor opcional, 
porque você está dizendo que a conversão definitivamente vai funcionar - se você estiver errado, isso significa que você escreveu seu código errado.

Para demonstrar isso de uma maneira não enjoada, vamos retirar o álbum ao vivo para que tenhamos apenas álbuns de estúdio na matriz:

var taylorSwift = StudioAlbum(name: "Taylor Swift", studio: "The Castles Studios")
var fearless = StudioAlbum(name: "Speak Now", studio: "Aimeeland Studio")

var allAlbums: [Album] = [taylorSwift, fearless]

for album in allAlbums {
    let studioAlbum = album as! StudioAlbum
    print(studioAlbum.studio)
}

That's obviously a contrived example, because if that really were your code you would just change allAlbums so that it 
had the data type [StudioAlbum]. Still, it shows how forced downcasting works, and the example won't crash because it 
makes the correct assumptions.

O Swift permite que você seja reduzido como parte do loop da matriz, o que, neste caso, seria mais eficiente. 
Se você quisesse escrever essa redução forçada no nível da matriz, você escreveria isso:

for album in allAlbums as! [StudioAlbum] {
    print(album.studio)
}

Isso não precisa mais reduzir todos os itens dentro do loop, porque isso acontece quando o loop começa. 
ovamente, é melhor você estar certo de que todos os itens da matriz são StudioAlbums, caso contrário, seu código falhará.

O Swift também permite a transmissão opcional no nível da matriz, embora seja um pouco mais complicado porque você precisa 
usar o operador de coalescência nulo para garantir que haja sempre um valor para o loop. Aqui está um exemplo:

for album in allAlbums as? [LiveAlbum] ?? [LiveAlbum]() {
    print(album.location)
}

What that means is, “try to convert allAlbums to be an array of LiveAlbum objects, but if that fails just create an empty array of 
live albums and use that instead” – i.e., do nothing.


- Convertendo tipos comuns com inicializadores
Typecasting is useful when you know something that Swift doesn’t, for example when you have an object of type A that Swift 
thinks is actually type B. However, typecasting is useful only when those types really are what you say – 
you can’t force a type A into a type Z if they aren’t actually related.

Por exemplo, se você tem um número inteiro chamado number, não poderia escrever código como este para torná-lo uma string:

let number = 5
let text = number as! String

Ou seja, você não pode forçar um inteiro em uma string, porque eles são dois tipos completamente diferentes. 
Em vez disso, você precisa criar uma nova string alimentando-a com o número inteiro, e Swift sabe como converter as duas. 
A diferença é sutil: este é um novo valor, em vez de apenas uma reinterpretação do mesmo valor.

Então, esse código deve ser reescrito assim:

let number = 5
let text = String(number)
print(text)

Isso só funciona para alguns dos tipos de dados internos da Swift: você pode converter inteiros e floats em strings e vice-versa, 
por exemplo, mas se você criou duas estruturas personalizadas, a Swift não pode converter magicamente uma para a outra - 
você mesmo precisa escrever esse código.



---------- 5. CLOSURES 

Você conheceu inteiros, strings, duplas, floats, booleanos, matrizes, dicionários, estruturas e classes até agora, 
mas há outro tipo de dados que é usado extensivamente em Swift, e é chamado de fechamento. Estes são complicados, 
mas são tão poderosos e expressivos que são usados de forma generalizada no Cocoa Touch, para que você não chegue muito longe sem entendê-los.

Um fechamento pode ser pensado como uma variável que contém código. Então, quando um inteiro contém 0 ou 500, 
um fechamento contém linhas de código Swift. Os fechamentos também capturam o ambiente onde são criados, o que 
significa que eles tiram uma cópia dos valores que são usados dentro deles.

Você nunca precisa projetar seus próprios fechamentos, então não tenha medo se achar o seguinte bastante complicado. 
No entanto, tanto o Cocoa quanto o Cocoa Touch geralmente pedem que você escreva fechamentos para atender às suas necessidades, 
então você pelo menos precisa saber como eles funcionam. Vamos dar um exemplo de Cocoa Touch primeiro:

let vw = UIView()

UIView.animate(withDuration: 0.5, animations: {
    vw.alpha = 0
})

UIView is an iOS data type in UIKit that represents the most basic kind of user interface container. 
Don't worry about what it does for now, all that matters is that it's the basic user interface component. 
UIView has a method called animate() and it lets you change the way your interface looks using animation – 
you describe what's changing and over how many seconds, and Cocoa Touch does the rest.

The animate() method takes two parameters in that code: the number of seconds to animate over, and a closure containing the 
code to be executed as part of the animation. I've specified half a second as the first parameter, and for the second I've asked UIKit 
to adjust the view's alpha (that's opacity) to 0, which means "completely transparent."

Esse método precisa usar um fechamento porque o UIKit tem que fazer todos os tipos de trabalho para se preparar para o início da animação, 
então o que acontece é que o UIKit pega uma cópia do código dentro do aparelho (esse é o nosso fechamento), o armazena, 
faz todo o seu trabalho de preparação e, em seguida, executa nosso código quando estiver pronto. 
Isso não seria possível se executássemos nosso código diretamente.

The above code also shows how closures capture their environment: I declared the vw constant outside of the closure, then used it inside. 
Swift detects this, and makes that data available inside the closure too.

O sistema de captura automática de um ambiente de fechamento da Swift é muito útil, mas ocasionalmente pode tropeçar em você: 
se o objeto A armazena um fechamento como uma propriedade, e essa propriedade também faz referência ao objeto A, você tem algo 
chamado de ciclo de referência forte e terá usuários insatisfeitos. Este é um tópico substancialmente mais avançado do que você 
precisa saber agora, então não se preocupe muito com isso ainda.


- Fechamentos à direita
Como os fechamentos são usados com tanta frequência, Swift pode aplicar um pouco de açúcar sintático para tornar seu código mais fácil de ler. 
A regra é esta: se o último parâmetro de um método for fechado, você pode eliminar esse parâmetro e, em vez disso, fornecê-lo como um bloco 
de código dentro de chaves. Por exemplo, poderíamos converter o código anterior para isso:

let vw = UIView()

UIView.animate(withDuration: 0.5) {
    vw.alpha = 0
}

Isso torna seu código mais curto e fácil de ler, portanto, esse formulário de sintaxe - 
conhecido como sintaxe de fechamento à direita - é preferido.



