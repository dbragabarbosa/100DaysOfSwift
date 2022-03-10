10/03/2022

TIPOS DE DADOS COMPLEXOS


-----------  ARRAYS
let john = "John Lennon"
let paul = "Paul McCartney"
let george = "George Harrison"
let ringo = "Ringo Starr"

let beatles = [john, paul, george, ringo]   --> ARRAY
beatles[1]  --> Paul McCartney

Usamos os arrays quando queremos armazenar muitos valores 
Tentar ler um array utilizando um índice inválido trava o programa


----------- SETS 
Sets são coleções de valores como matrizes, exceto que eles têm duas diferenças:
-Os itens não são armazenados em nenhuma ordem; eles são armazenados no que é efetivamente uma ordem aleatória.
-Nenhum item pode aparecer duas vezes em um conjunto; todos os itens devem ser exclusivos.

let colors = Set(["red", "green", "blue"])

Sets são mais úteis para momentos em que você deseja dizer “este item existe?”


---------- TUPLES
Tuplas permitem que você armazene vários valores juntos em um único valor. Isso pode soar como matrizes, mas as tuplas são diferentes:

1.Você não pode adicionar ou remover itens de uma tupla; eles são fixos em tamanho.
2.Você não pode alterar o tipo de itens em uma tupla; eles sempre têm os mesmos tipos com os quais foram criados.
3.Você pode acessar itens em uma tupla usando posições numéricas ou nomeando-os, mas Swift não permite que você leia números ou nomes que não existem.

As tuplas são criadas colocando vários itens entre parênteses, assim:
var name = (first: "Taylor", last: "Swift")
Você então acessa itens usando posições numéricas a partir de 0:
name.0
Ou você pode acessar itens usando seus nomes:
name.first

Remember, you can change the values inside a tuple after you create it, but not the types of values. 
So, if you tried to change name to be (first: "Justin", age: 25) you would get an error.


---------- ARRAYS VS SETS VS TUPLES
If you need a specific, fixed collection of related values where each item has a precise position or name, you should use a tuple:
let address = (house: 555, street: "Taylor Swift Avenue", city: "Nashville")

If you need a collection of values that must be unique or you need to be able to check whether a specific item is in there extremely quickly, you should use a set:
let set = Set(["aardvark", "astronaut", "azalea"])

If you need a collection of values that can contain duplicates, or the order of your items matters, you should use an array:
let pythons = ["Eric", "Graham", "John", "Michael", "Terry", "Terry"]

Arrays are by far the most common of the three types.

Lembre-se: os arrays mantêm a ordem e podem ter duplicatas, os conjuntos não são ordenados e não podem ter duplicatas, 
e as tuplas têm um número fixo de valores de tipos fixos dentro deles.


---------- DICTIONARIES
Dicionários são coleções de valores como matrizes, mas em vez de armazenar coisas com uma posição inteira,
 você pode acessá-las usando o que quiser. --> usando CHAVES

 let heights = [
    "Taylor Swift": 1.78,
    "Ed Sheeran": 1.73
]


---------- DICTIONARY DEFAULT VALUES 
Sempre que você lê um valor de um dicionário, pode receber um valor de volta ou pode voltar zero - pode não haver valor para 
essa chave. Não ter valor pode causar problemas no seu código, até porque você precisa adicionar funcionalidade extra para 
lidar com valores ausentes com segurança, e é aí que entram os valores padrão do dicionário: eles permitem que você forneça 
um valor de backup para usar quando a chave que você pede não existir.


---------- CREATING EMPTY COLLECTIONS
Se você quiser criar uma coleção vazia, basta escrever seu tipo seguido de abrir e fechar parênteses. 
Por exemplo, podemos criar um dicionário vazio com strings para chaves e valores como este:
var teams = [String: String]()
Podemos então adicionar entradas mais tarde, assim:
teams["Paul"] = "Red"


---------- ENUMERATIONS 
With enums we can define a Result type that can be either success or failure, like this:

enum Result {
    case success
    case failure
}
E agora, quando o usamos, devemos escolher um desses dois valores:

let result4 = Result.failure
Isso impede que você use acidentalmente strings diferentes a cada vez.


---------- ENUM ASSOCIATED VALUES
Enum associated values let us add those additional details:

enum Activity {
    case bored
    case running(destination: String)
    case talking(topic: String)
    case singing(volume: Int)
}
Now we can be more precise – we can say that someone is talking about football:

let talking = Activity.talking(topic: "football")

Então, enums com valores associados nos permitem adicionar informações extras a um caso enum - pense neles como adjetivos 
para um substantivo, porque nos permite descrever a coisa com mais detalhes.


--------- ENUM RAW VALUES 
Às vezes você precisa ser capaz de atribuir valores a enums para que elas tenham significado. Isso permite que você os crie dinamicamente e também os use de maneiras diferentes.

For example, you might create a Planet enum that stores integer values for each of its cases:

enum Planet: Int {
    case mercury
    case venus
    case earth
    case mars
}
Swift will automatically assign each of those a number starting from 0, and you can use that number to create an instance of the appropriate enum case. For example, earth will be given the number 2, so you can write this:

let earth = Planet(rawValue: 2)
Se desejar, você pode atribuir um ou mais casos a um valor específico, e Swift gerará o resto. Não é muito natural para nós pensarmos na Terra como o segundo planeta, então você poderia escrever isto:

enum Planet: Int {
    case mercury = 1
    case venus
    case earth
    case mars
}
Now Swift will assign 1 to mercury and count upwards from there, meaning that earth is now the third planet.


------------ COMPLEX TYPES: SUMMARY
RESUMO:

1.Matrizes, conjuntos, tuplas e dicionários permitem que você armazene um grupo de itens sob um único valor. Cada um deles faz isso de maneiras diferentes, então o que você usa depende do comportamento que deseja.

2.Arrays armazenam itens na ordem em que você os adiciona, e você os acessa usando posições numéricas.

3.Define itens de armazenamento sem qualquer pedido, para que você não possa acessá-los usando posições numéricas.

4.As tuplas são fixas em tamanho, e você pode anexar nomes a cada um de seus itens. Você pode ler itens usando posições numéricas ou usando seus nomes.

5.Os dicionários armazenam itens de acordo com uma chave, e você pode ler itens usando essas chaves.

6.As Enums são uma maneira de agrupar valores relacionados para que você possa usá-los sem erros ortográficos.

7.Você pode anexar valores brutos a enums para que eles possam ser criados a partir de inteiros ou strings, ou você pode adicionar valores associados para armazenar informações adicionais sobre cada caso.

