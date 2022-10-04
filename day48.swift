21/09/2022 


Project 12, part one 


Douglas Adams disse uma vez: “a maior parte do tempo gasto lutando com tecnologias que ainda não funcionam simplesmente 
não vale o esforço para os usuários finais, por mais divertido que seja para nerds como nós.” E é claro que ele estava 
certo: quando o software não funciona, às vezes vemos como um desafio encontrar uma solução alternativa, enquanto todos 
os outros no mundo ficam irritados ou desistem.

Pense na frequência com que você vê um botão Salvar no iOS. Quase nunca, certo? Isso não é um acidente: o iOS faz parecer 
que todos os aplicativos estão sendo executados o tempo todo quando realmente são enviados em segundo plano ou até mesmo 
encerrados o tempo todo, mas os usuários não querem ter que pensar em salvar arquivos antes que um programa seja encerrado.

Esse comportamento é um ótimo exemplo de como a Apple tira o aborrecimento para os usuários finais - eles não precisam 
gastar o esforço de gerenciar dados ou se preocupar com programas, o que significa que eles podem se concentrar apenas 
em usar seu dispositivo para as coisas com as quais realmente se importam.

Agora cabe a nós. O Projeto 10 funcionou muito bem, exceto que não salva as fotos que os usuários adicionam. Hoje você 
vai aprender uma das maneiras pelas quais podemos consertar isso, e vamos pensar em uma opção diferente amanhã.

Today you have three topics to work through, and you’ll learn about UserDefaults, NSCoding and more.



---------- Setting up 

This is our fourth technique project, and we're going to go back to project 10 and fix its glaring bug: all the names 
and faces you add to the app don't get saved, which makes the app rather pointless!

We're going to fix this using a new class called UserDefaults and a new protocol NSCoding – it’s similar in intent to 
the Codable protocol we used when working with JSON, but the former is available only to Swift developers whereas the 
latter is also available to Objective-C developers.

Along the way you’ll also use the classes NSKeyedArchiver and NSKeyedUnarchiver (for use with NSCoding), and JSONEncoder 
and JSONDecoder (for use with Codable), all of which are there to convert custom objects into data that can be written 
to disk.

Putting all that together, we're going to update project 10 so that it saves its people array whenever anything is 
changed, then loads when the app runs.

We're going to be modifying project 10 twice over, once for each method of solving the problem, so I suggest you take 
a copy of the project 10 folder twice – call the copies project12a and project12b.


---------- Reading and writing basics: UserDefaults

You can use UserDefaults to store any basic data type for as long as the app is installed. You can write basic types 
such as Bool, Float, Double, Int, String, or URL, but you can also write more complex types such as arrays, dictionaries 
and Date – and even Data values.

When you write data to UserDefaults, it automatically gets loaded when your app runs so that you can read it back again. 
This makes using it really easy, but you need to know that it's a bad idea to store lots of data in there because it will 
slow loading of your app. If you think your saved data would take up more than say 100KB, UserDefaults is almost certainly 
the wrong choice.

Before we get into modifying project 10, we're going to do a little bit of test coding first to try out what UserDefaults 
lets us do. You might find it useful to create a fresh Single View App project just so you can test out the code.

Para começar com o UserDefaults, você cria uma nova instância da classe como esta:

let defaults = UserDefaults.standard

Uma vez feito isso, é fácil definir uma variedade de valores - você só precisa dar a cada um uma chave única para que 
possa referenciá-la mais tarde. Esses valores quase sempre não têm significado além do que você os usa, então certifique-se 
de que os nomes-chave sejam memoráveis.

Aqui estão alguns exemplos:

let defaults = UserDefaults.standard
defaults.set(25, forKey: "Age")
defaults.set(true, forKey: "UseTouchID")
defaults.set(CGFloat.pi, forKey: "Pi")

You can also use the set() to store strings, arrays, dictionaries and dates. Now, here's a curiosity that's worth 
explaining briefly: in Swift, strings, arrays and dictionaries are all structs, not objects. But UserDefaults was 
written for NSString and friends – all of which are 100% interchangeable with Swift their equivalents – which is why 
this code works.

Using set() for these advanced types is just the same as using the other data types:

defaults.set("Paul Hudson", forKey: "Name")
defaults.set(Date(), forKey: "LastRun")

Even if you're trying to save complex types such as arrays and dictionaries, UserDefaults laps it up:

let array = ["Hello", "World"]
defaults.set(array, forKey: "SavedArray")

let dict = ["Name": "Paul", "Country": "UK"]
defaults.set(dict, forKey: "SavedDict")

Isso é o suficiente sobre escrever por enquanto; vamos dar uma olhada na leitura.

When you're reading values from UserDefaults you need to check the return type carefully to ensure you know what you're 
getting. Here's what you need to know:

- integer(forKey:)retorna um inteiro se a chave existir, ou 0 se não.

- bool(forKey:)retorna um booleano se a chave existia, ou falso se não.

- float(forKey:)retorna um flutuador se a chave existir, ou 0,0 se não.

- double(forKey:)retorna um duplo se a chave existir, ou 0,0 se não.

- object(forKey:)devolve Any? então você precisa digitá-lo condicionalmente para o seu tipo de dados.

Knowing the return values are important, because if you use bool(forKey:) and get back "false", does that mean the key 
didn't exist, or did it perhaps exist and you just set it to be false?

It's object(forKey:) that will cause you the most bother, because you get an optional object back. You're faced with two 
options, one of which isn't smart so you realistically have only one option!

Suas opções:

- Use as! para forçar o typecast do seu objeto ao tipo de dados que ele deveria ser.

- Usar as? para opcionalmente digitar seu objeto para o tipo que deveria ser.

If you use as! and object(forKey:) returned nil, you'll get a crash, so I really don't recommend it unless you're 
absolutely sure. But equally, using as? is annoying because you then have to unwrap the optional or create a default 
value.

Há uma solução aqui, e tem o nome cativante do operador de coalescing nil, e parece assim:??. Isso faz duas coisas ao 
mesmo tempo: se o objeto à esquerda for opcional e existir, ele será desembrulhado em um valor não opcional; se não 
existir, ele usará o valor à direita.

This means we can use object(forKey:) and as? to get an optional object, then use ?? to either unwrap the object or set 
a default value, all in one line.

Por exemplo, digamos que queremos ler a matriz que salvamos anteriormente com o nome da chave SavedArray. Veja como 
fazer isso com o operador de coalescência nil:

let array = defaults.object(forKey:"SavedArray") as? [String] ?? [String]()

So, if SavedArray exists and is a string array, it will be placed into the array constant. If it doesn't exist (or if it 
does exist and isn't a string array), then array gets set to be a new string array.

Esta técnica também funciona para dicionários, mas obviamente você precisa digitá-la corretamente. Para ler o dicionário 
que salvamos anteriormente, usaria o seguinte:

let dict = defaults.object(forKey: "SavedDict") as? [String: String] ?? [String: String]()



---------- Fixing Project 10: NSCoding

Você acabou de aprender todos os fundamentos básicos de trabalhar com UserDefaults, mas estamos apenas começando. Você vê, 
acima e além de inteiros, datas, strings, matrizes e assim por diante, você também pode salvar qualquer tipo de dado dentro 
do UserDefaults, desde que siga algumas regras.

What happens is simple: you use the archivedData() method of NSKeyedArchiver, which turns an object graph into a Data 
object, then write that to UserDefaults as if it were any other object. If you were wondering, “object graph” means “your 
object, plus any objects it refers to, plus any objects those objects refer to, and so on.”

As regras são muito simples:

1. All your data types must be one of the following: boolean, integer, float, double, string, array, dictionary, Date, or 
a class that fits rule 2.

2. Se o seu tipo de dados for uma classe, ele deve estar em conformidade com o protocolo NSCoding, que é usado para 
arquivar gráficos de objetos.

3. Se o seu tipo de dados for uma matriz ou dicionário, todas as chaves e valores devem corresponder à regra 1 ou à regra 2.

Many of Apple's own classes support NSCoding, including but not limited to: UIColor, UIImage, UIView, UILabel, UIImageView, 
UITableView, SKSpriteNode and many more. But your own classes do not, at least not by default. If we want to save the people 
array to UserDefaults we'll need to conform to the NSCoding protocol.

The first step is to modify your Person class to this:

class Person: NSObject, NSCoding {

Quando estávamos trabalhando neste código no projeto 10, havia duas perguntas pendentes:

- Por que precisamos de uma aula aqui quando uma estrutura vai funcionar tão bem? (E, na verdade, melhor, porque as 
estruturas vêm com um inicializador padrão!)

- Por que precisamos herdar do NSObject?

It's time for the answers to become clear. You see, working with NSCoding requires you to use objects, or, in the case of 
strings, arrays and dictionaries, structs that are interchangeable with objects. If we made the Person class into a struct, 
we couldn't use it with NSCoding.

The reason we inherit from NSObject is again because it's required to use NSCoding – although cunningly Swift won't mention 
that to you, your app will just crash.

Depois de estar em conformidade com o protocolo NSCoding, você receberá erros do compilador porque o protocolo exige que 
você implemente dois métodos: um novo inicializador e encode().

Precisamos escrever mais algum código para corrigir os problemas e, embora o código seja muito semelhante ao que você já 
viu no UserDefaults, ele tem duas coisas novas que você precisa saber.

Primeiro, você usará uma nova classe chamada NSCoder. Isso é responsável pela codificação (escrita) e pela decodificação 
(leitura) de seus dados para que possam ser usados com UserDefaults.

Second, the new initializer must be declared with the required keyword. This means "if anyone tries to subclass this class, 
they are required to implement this method." An alternative to using required is to declare that your class can never be 
subclassed, known as a final class, in which case you don't need required because subclassing isn't possible. We'll be 
using required here.

Adicione estes dois métodos à classe Person:

required init(coder aDecoder: NSCoder) {
    name = aDecoder.decodeObject(forKey: "name") as? String ?? ""
    image = aDecoder.decodeObject(forKey: "image") as? String ?? ""
}

func encode(with aCoder: NSCoder) {
    aCoder.encode(name, forKey: "name")
    aCoder.encode(image, forKey: "image")
}

The initializer is used when loading objects of this class, and encode() is used when saving. The code is very similar to 
using UserDefaults, but here we’re adding as? typecasting and nil coalescing just in case we get invalid data back.

With those changes, the Person class now conforms to NSCoding, so we can go back to ViewController.swift and add code to 
load and save the people array.

Let's start with writing, because once you understand that the reading code will make much more sense. As I said earlier, 
you can write Data objects to UserDefaults, but we don't currently have a Data object – we just have an array.

Fortunately, the archivedData() method of NSKeyedArchiver turns an object graph into a Data object using those NSCoding 
methods we just added to our class. Because we make changes to the array by adding people or by renaming them, let's create 
a single save() method we can use anywhere that's needed:

func save() {
    if let savedData = try? NSKeyedArchiver.archivedData(withRootObject: people, requiringSecureCoding: false) {
        let defaults = UserDefaults.standard
        defaults.set(savedData, forKey: "people")
    }
}

So: line 1 is what converts our array into a Data object, then lines 2 and 3 save that data object to UserDefaults. You 
now just need to call that save() method when we change a person's name or when we import a new picture.

You need to modify our collection view's didSelectItemAt method so that you call self.save() just after calling 
self.collectionView.reloadData(). Remember, the self is required because we're inside a closure. You then need to modify 
the image picker's didFinishPickingMediaWithInfo method so that it calls save() just before the end of the method.

E é isso - só alteramos os dados em dois lugares, e ambos agora têm uma chamada tosavesave().

Finalmente, precisamos carregar a matriz de volta do disco quando o aplicativo for executado, então adicione este código 
aoviewDidLoadviewDidLoad():

let defaults = UserDefaults.standard

if let savedPeople = defaults.object(forKey: "people") as? Data {
    if let decodedPeople = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(savedPeople) as? [Person] {
        people = decodedPeople
    }
}

This code is effectively the save() method in reverse: we use the object(forKey:) method to pull out an optional Data, 
using if let and as? to unwrap it. We then give that to the unarchiveTopLevelObjectWithData() method of NSKeyedUnarchiver 
to convert it back to an object graph – i.e., our array of Person objects.