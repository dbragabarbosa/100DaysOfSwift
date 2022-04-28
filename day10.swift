27/04/2022 


CLASSES e herança 

A princípio, as classes parecem muito semelhantes às estruturas porque as usamos 
para criar novos tipos de dados com propriedades e métodos. No entanto, eles 
introduzem um recurso novo, importante e complexo chamado herança - a capacidade 
de fazer com que uma classe se baseie sobre os fundamentos de outra.


---------- 1. CREAITNG YOUR OWN CLASSES 

As classes são semelhantes às estruturas, pois permitem que você crie novos tipo
com propriedades e métodos, mas elas têm cinco diferenças importantes.

A primeira diferença entre classes e estruturas é que as classes nunca vêm com 
um inicializador membro. Isso significa que, se você tiver propriedades em sua 
classe, você deve sempre criar seu próprio inicializador.

Por exemplo:

class Dog {
    var name: String
    var breed: String

    init(name: String, breed: String) {
        self.name = name
        self.breed = breed
    }
}

Criar instâncias dessa classe parece exatamente o mesmo que se fosse uma estrutura:

let poppy = Dog(name: "Poppy", breed: "Poodle")



Classes e estruturas dão aos desenvolvedores Swift a capacidade de criar tipos personalizados e complexos com propriedades e métodos, 
mas eles têm cinco diferenças importantes:

1. As classes não vêm com inicializadores sintetizados por membro.

2.Uma classe pode ser construída (“herdar de”) outra classe, ganhando suas propriedades e métodos.

3. Cópias de estruturas são sempre únicas, enquanto cópias de classes realmente apontam para os mesmos dados compartilhados.

4. As classes têm desiniciadores, que são métodos que são chamados quando uma instância da classe é destruída, mas as estruturas não.

5. As propriedades variáveis em classes constantes podem ser modificadas livremente, mas as propriedades variáveis em estruturas constantes não podem.

A maioria dos desenvolvedores Swift prefere usar estruturas em vez de classes quando possível, o que significa que, 
quando você escolhe uma classe em vez de uma estrutura, está fazendo isso porque deseja um dos comportamentos acima.


---------- 2. CLASS INHERITANCE (herança de classe)

A segunda diferença entre classes e estruturas é que você pode criar uma classe com base em uma classe existente - 
ela herda todas as propriedades e métodos da classe original e pode adicionar a sua própria no topo.

Isso é chamado de herança de classe ou subclasse, a classe da qual você herda é chamada de classe "pai" ou "super", 
e a nova classe é chamada de classe "filho".

Here’s the Dog class we just created:

class Dog {
    var name: String
    var breed: String

    init(name: String, breed: String) {
        self.name = name
        self.breed = breed
    }
}

We could create a new class based on that one called Poodle. It will inherit the same properties and initializer as Dog by default:

class Poodle: Dog {

}

However, we can also give Poodle its own initializer. 
We know it will always have the breed “Poodle”, so we can make a new initializer that only needs a name property. 
Even better, we can make the Poodle initializer call the Dog initializer directly so that all the same setup happens:

class Poodle: Dog {
    init(name: String) {
        super.init(name: name, breed: "Poodle")
    }
}

For safety reasons, Swift always makes you call super.init() from child classes – 
just in case the parent class does some important work when it’s created.


---------- 3. OVERRIDING METHODS (métodos de substituição) 

Child classes can replace parent methods with their own implementations – a process known as overriding. 
Here’s a trivial Dog class with a makeNoise() method:

class Dog {
    func makeNoise() {
        print("Woof!")
    }
}

If we create a new Poodle class that inherits from Dog, it will inherit the makeNoise() method. So, this will print “Woof!”:

class Poodle: Dog {
}

let poppy = Poodle()
poppy.makeNoise()

Method overriding allows us to change the implementation of makeNoise() for the Poodle class.

Swift requires us to use override func rather than just func when overriding a method – it stops you from overriding a method by accident, 
and you’ll get an error if you try to override something that doesn’t exist on the parent class:

class Poodle: Dog {
    override func makeNoise() {
        print("Yip!")
    }
}

With that change, poppy.makeNoise() will print “Yip!” rather than “Woof!”.


---------- 4. FINAL CLASSES 

Embora a herança de classes seja muito útil - e, de fato, grandes partes das plataformas da Apple exijam que você a use - 
às vezes você quer não permitir que outros desenvolvedores criem sua própria classe com base na sua.

Swift gives us a final keyword just for this purpose: when you declare a class as being final, no other class can inherit from it. 
This means they can’t override your methods in order to change your behavior – they need to use your class the way it was written.

To make a class final just put the final keyword before it, like this:

final class Dog {
    var name: String
    var breed: String

    init(name: String, breed: String) {
        self.name = name
        self.breed = breed
    }
}


---------- 5. COPYING OBJECTS 

A terceira diferença entre classes e estruturas é como elas são copiadas. Quando você copia uma estrutura, 
tanto o original quanto a cópia são coisas diferentes - mudar uma não mudará a outra. Quando você copia uma classe, 
tanto o original quanto a cópia apontam para a mesma coisa, então mudar uma muda a outra.

For example, here’s a simple Singer class that has a name property with a default value:

class Singer {
    var name = "Taylor Swift"
}

Se criarmos uma instância dessa classe e imprimirmos seu nome, receberemos "Taylor Swift":

var singer = Singer()
print(singer.name)

Agora vamos criar uma segunda variável a partir da primeira e mudar seu nome:

var singerCopy = singer
singerCopy.name = "Justin Bieber"

Because of the way classes work, both singer and singerCopy point to the same object in memory, 
so when we print the singer name again we’ll see “Justin Bieber”:

print(singer.name)

On the other hand, if Singer were a struct then we would get “Taylor Swift” printed a second time:

struct Singer {
    var name = "Taylor Swift"
}


---------- 6. DEINITIALIZERS 

A quarta diferença entre classes e estruturas é que as classes podem ter desiniciadores - 
código que é executado quando uma instância de uma classe é destruída.

To demonstrate this, here’s a Person class with a name property, a simple initializer, and a printGreeting() method that prints a message:

class Person {
    var name = "John Doe"

    init() {
        print("\(name) is alive!")
    }

    func printGreeting() {
        print("Hello, I'm \(name)")
    }
}

We’re going to create a few instances of the Person class inside a loop, 
because each time the loop goes around a new person will be created then destroyed:

for _ in 1...3 {
    let person = Person()
    person.printGreeting()
}

And now for the deinitializer. This will be called when the Person instance is being destroyed:

deinit {
    print("\(name) is no more!")
}


---------- 7. MUTABILITY 

A diferença final entre classes e estruturas é a maneira como elas lidam com as constantes. 
Se você tem uma estrutura constante com uma propriedade variável, essa propriedade não pode ser alterada porque a própria estrutura é constante.

However, if you have a constant class with a variable property, that property can be changed. Because of this, 
classes don’t need the mutating keyword with methods that change properties; that’s only needed with structs.

Essa diferença significa que você pode alterar qualquer propriedade de variável em uma classe, 
mesmo quando a classe é criada como uma constante - este é um código perfeitamente válido:

class Singer {
    var name = "Taylor Swift"
}

let taylor = Singer()
taylor.name = "Ed Sheeran"
print(taylor.name)

Se você quiser impedir que isso aconteça, você precisa tornar a propriedade constante:

class Singer {
    let name = "Taylor Swift"
}


---------- 8. CLASSES SUMMARY 

1. Classes e estruturas são semelhantes, na medida em que podem permitir que você crie seus próprios tipos com propriedades e métodos.

2. Uma classe pode herdar de outra e ganha todas as propriedades e métodos da classe pai. É comum falar sobre hierarquias de classe - 
uma classe baseada em outra, que por sua vez é baseada em outra.

3. Você pode marcar uma classe com a palavra-chave final, o que impede que outras classes herdem dela.

4. A substituição de métodos permite que uma classe filha substitua um método em sua classe pai por uma nova implementação.

5. Quando duas variáveis apontam para a mesma instância de classe, ambas apontam para a mesma parte da memória - alterar uma altera a outra.

6. As classes podem ter um desiniciador, que é o código que é executado quando uma instância da classe é destruída.

7. As classes não impõem constantes tão fortemente quanto as estruturas - se uma propriedade for declarada como uma variável, 
ela pode ser alterada independentemente de como a instância da classe foi criada.















