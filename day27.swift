22/06/2022


PROJECT 5, PART ONE 

Você provavelmente se lembra de aprender sobre fechamentos há algumas semanas, principalmente porque era 
uma parte particularmente difícil do curso. Desde então, tentei trabalhá-los lentamente para que você possa 
dominá-los pouco a pouco, e hoje é hora de mergulhar neles com nosso próprio fechamento.

Acho que você já sabe o que vou dizer, mas vou dizer de qualquer maneira: isso não vai ser fácil. Mas o general 
dos EUA, George Patton, disse uma vez: "aceite os desafios para que você possa sentir a alegria da vitória" - 
quando você finalmente sentir que entende os fechamentos (o que pode ser hoje!) é quando você sabe que está 
realmente se sentindo confortável com Swift.

Hoje vou apresentar um novo aspecto dos fechamentos chamado listas de captura. Para facilitar as coisas, preparei 
um novo artigo apenas para esta série que explica em detalhes o que são listas de captura e como elas funcionam - 
você deve começar lendo isso.

Hoje você deve trabalhar no artigo sobre listas de captura e, em seguida, nos três tópicos do projeto 5.



---------- CAPTURE LISTS IN SWIFT: WHATS THE DIFFERENCE BETWEEN WEAK, STRONG, AND UNOWNED REFERENCES? 

As listas de captura vêm antes da lista de parâmetros de um fechamento em seu código e capturam valores do ambiente 
como fortes, fracos ou não. Nós os usamos muito, principalmente para evitar ciclos de referência fortes - também 
conhecidos como ciclos de retenção.

Decidir qual usar não é fácil quando você está aprendendo, então você pode gastar tempo tentando descobrir forte vs fraco, 
ou fraco vs não é dono, mas à medida que você progride com seu aprendizado, você começará a perceber que muitas vezes 
há apenas uma escolha certa.

Primeiro, vamos dar uma olhada no problema. Primeiro, aqui está uma aula simples:

class Singer {
    func playSong() {
        print("Shake it off!")
    }
}

Second, here’s a function that creates an instance of Singer, creates a closure that uses the singer’s playSong() method, 
and returns that closure for us to use elsewhere:

func sing() -> () -> Void {
    let taylor = Singer()

    let singing = {
        taylor.playSong()
        return
    }

    return singing
}

Finally, we can call sing() to get back a function we can call wherever we want to have playSong() printed:

let singFunction = sing()
singFunction()

Isso imprimirá “Agite!” graças à chamada para singFunction().



Captura fraca

A Swift nos permite especificar uma lista de captura para determinar como os valores usados dentro do fechamento 
devem ser capturados. A alternativa mais comum à captura forte é chamada de captura fraca, e muda duas coisas:

Valores fracamente capturados não são mantidos vivos pelo fechamento, então eles podem ser destruídos e ser ajustados.
Como resultado de 1, valores fracamente capturados são sempre opcionais em Swift. Isso impede que você assuma que eles 
estão presentes quando, na verdade, podem não estar.

Podemos modificar nosso exemplo para usar captura fraca e você verá uma diferença imediata:

func sing() -> () -> Void {
    let taylor = Singer()

    let singing = { [weak taylor] in
        taylor?.playSong()
        return
    }

    return singing
}

That [weak taylor] part is our capture list, which is a specific part of closures where we give specific instructions 
as to how values should be captured. Here we’re saying that taylor should be captured weakly, which is why we need to 
use taylor?.playSong() – it’s an optional now, because it could be set to nil at any time.

If you run the code now you’ll see that calling singFunction() doesn’t print anything any more. The reason is that 
taylor exists only inside sing(), because the closure it returns doesn’t keep a strong hold of it.

To see this behavior in action, try changing sing() to this:

func sing() -> () -> Void {
    let taylor = Singer()

    let singing = { [weak taylor] in
        taylor!.playSong()
        return
    }

    return singing
}

That force unwraps taylor inside the closure, which will cause your code to crash because taylor becomes nil.



Captura de propriedade

An alternative to weak is unowned, which behaves more like implicitly unwrapped optionals. Like weak capturing, 
unowned capturing allows values to become nil at any point in the future. However, you can work with them as if 
they are always going to be there – you don’t need to unwrap optionals.

Por exemplo:

func sing() -> () -> Void {
    let taylor = Singer()

    let singing = { [unowned taylor] in
        taylor.playSong()
        return
    }

    return singing
}

That will crash in a similar way to our force-unwrapped example from earlier: unowned taylor says I know for sure 
that taylor will always exist for the lifetime of the closure I’m sending back so I don’t need to hold on to the 
memory, but in practice taylor will be destroyed almost immediately so the code will crash.

You should use unowned very carefully indeed.



Problemas comuns

Há quatro problemas que as pessoas geralmente enfrentam ao usar a captura de fechamento:

1. Eles não sabem onde usar as listas de captura quando os fechamentos aceitam parâmetros.

2. Eles fazem ciclos de referência fortes, fazendo com que a memória seja consumida.

3. Eles acidentalmente usam referências fortes, especialmente quando usam várias capturas.

4. Eles fazem cópias de fechamentos e compartilham dados capturados.

Vamos percorrer cada um deles com alguns exemplos de código, para que você possa ver o que acontece.



Capture listas ao lado dos parâmetros

Este é um problema comum a ser atingido quando você está começando com listas de captura, 
mas felizmente é um que Swift pega para nós.

When using capture lists and closure parameters together the capture list must always come first, 
then the word in to mark the start of your closure body – trying to put it after the closure parameters 
will stop your code from compiling.

Por exemplo:

writeToLog { [weak self] user, message in 
    self?.addToLog("\(user) triggered event: \(message)")
}



Ciclos de referência fortes

Quando a coisa A possui a coisa B, e a coisa B possui a coisa A, você tem o que é chamado de ciclo de 
referência forte, ou muitas vezes apenas um ciclo de retenção.

Por exemplo, considere este código:

class House {
    var ownerDetails: (() -> Void)?

    func printDetails() {
        print("This is a great house.")
    }

    deinit {
        print("I'm being demolished!")
    }
}

That creates a House class with one property (a closure), one method, and a deinitializer so it 
prints a message when it’s being destroyed.

Now here’s an Owner class that is the same, except its closure stores house details:

class Owner {
    var houseDetails: (() -> Void)?

    func printDetails() {
        print("I own a house.")
    }

    deinit {
        print("I'm dying!")
    }
}

We can try creating two instances of those classes inside a do block. We don’t need a catch block here, 
but using do ensures they will be destroyed as soon as the } is reached:

print("Creating a house and an owner")

do {
    let house = House()
    let owner = Owner()
}

print("Done")

Isso deve imprimir "Criando uma casa e um dono", "Estou morrendo!", "Estou sendo demolido!", 
depois "Concluído" - tudo funciona como esperado.

Agora vamos criar um ciclo de referência forte:

print("Creating a house and an owner")

do {
    let house = House()
    let owner = Owner()
    house.ownerDetails = owner.printDetails
    owner.houseDetails = house.printDetails
}

print("Done")

Agora ele imprimirá "Criando uma casa e um proprietário" e depois "Concluído", sem nenhum desiniciador sendo chamado.

What’s happening here is that house has a property that points to a method of owner, and owner has a 
property that points to a method of house, so neither can be safely destroyed. In real code this causes 
memory that can’t be freed, known as a memory leak, which degrades system performance and can even cause 
your app to be terminated.

Para corrigir isso, precisamos criar um novo fechamento e usar captura fraca para um ou ambos os valores, assim:

print("Creating a house and an owner")

do {
    let house = House()
    let owner = Owner()
    house.ownerDetails = { [weak owner] in owner?.printDetails() }
    owner.houseDetails = { [weak house] in house?.printDetails() }
}

print("Done")

Não é necessário ter ambos os valores fracamente capturados - tudo o que importa é que pelo menos um seja, 
porque permite que Swift destrua os dois quando necessário.

Agora, no código de projeto real, é raro encontrar ciclos de referência fortes que são tão óbvios, mas isso 
significa que é ainda mais importante usar captura fraca para evitar completamente o problema.



Referências fortes acidentais

O padrão da Swift é captura forte, o que pode causar problemas não intencionais.

Voltando ao nosso exemplo de canto anterior, considere este código:

func sing() -> () -> Void {
    let taylor = Singer()
    let adele = Singer()

    let singing = { [unowned taylor, adele] in
        taylor.playSong()
        adele.playSong()
        return
    }

    return singing
}


Now we have two values being captured by the closure, and both values are being used the same 
way inside the closure. However, only taylor is being captured as unowned – adele is being captured 
strongly, because the unowned keyword must be used for each captured value in the list.

Now, if you want taylor to be unowned but adele to be strongly captured, that’s fine. But if you want
both to be unowned you need to say so:

[unowned taylor, unowned adele]

Swift does offer some protection against accidental capturing, but it’s limited: if you use self 
implicitly inside a closure, Swift forces you to add self. or self?. to make your intentions clear.

Implicit use of self happens a lot in Swift. For example, this initializer calls playSong(), but what 
it really means is self.playSong() – the self part is implied by the context:

class Singer {
    init() {
        playSong()
    }

    func playSong() {
        print("Shake it off!")
    }
}

A Swift não permitirá que você use fechamentos internos implícitos, o que ajuda a reduzir um tipo comum de ciclo de retenção.



Cópias de fechamentos

A última coisa que tropeça nas pessoas é a maneira como os próprios fechamentos são copiados, porque seus dados 
capturados são compartilhados entre as cópias.

For example, here’s a simple closure that captures the numberOfLinesLogged integer created outside so that it can 
increment and print its value whenever its called:

var numberOfLinesLogged = 0

let logger1 = {
    numberOfLinesLogged += 1
    print("Lines logged: \(numberOfLinesLogged)")
}

logger1()

Isso imprimirá "Linhas registradas: 1" porque chamamos o fechamento no final.

Agora, se pegarmos uma cópia desse fechamento, essa cópia compartilha os mesmos valores de captura que o original, portanto, 
quer chamemos o original ou a cópia, você verá a contagem de linhas de log aumentando:

let logger2 = logger1
logger2()
logger1()
logger2()

That will now print that 1, 2, 3, and 4 lines have been logged, because both logger1 and logger2 are pointing at 
the same captured numberOfLinesLogged value.



Quando usar forte, quando usar fraco, quando usar sem propriedade

Agora que você entende como tudo funciona, vamos tentar resumir se devemos usar referências fortes, fracas ou não próprias:

1. If you know for sure your captured value will never go away while the closure has any chance of being called, 
you can use unowned. This is really only for the handful of times when weak would cause annoyances to use, but even 
when you could use guard let inside the closure with a weakly captured variable.

2. Se você tem uma situação forte do ciclo de referência - onde a coisa A possui a coisa B e a coisa B possui a coisa A - 
então um dos dois deve usar captura fraca. Isso geralmente deve ser o que quer que seja destruído primeiro, portanto, se o 
controlador de visualização A apresentar o controlador de visualização B, o controlador de visualização B pode conter 
uma referência fraca a A.

3. If there’s no chance of a strong reference cycle you can use strong capturing. For example, performing animation 
won’t cause self to be retained inside the animation closure, so you can use strong capturing.

If you’re not sure which to use, start out with weak and change only if you need to.



Onde agora?

As you’ve seen, closure capture lists help us avoid memory problems by controlling each how values are captured inside our closures. 
They are captured strongly by default, but we can use weak and even unowned to allow values to be destroyed 
even if they are used inside our closure.



---------- SETTING UP 

