24/05/2022


PROJECT 5, PART TWO 

Podemos ver mais evidências de como a linguagem é complicada olhando para a maneira como a Swift lida com strings. 
Você já se perguntou por que não consegue ler letras individuais de strings usando posições inteiras? Em código, esse 
tipo de coisa não está embutido no Swift:let letter = someString[5]

A razão para isso é que o Swift usa um sistema bastante complicado - mas extremamente importante! - de armazenamento de 
seus caracteres, conhecido como clusters de grafemas estendidos. Isso significa que, para Swift ler o caractere 8 de uma 
string, ele precisa começar em 0 e contar letras individuais até chegar ao 8o; ele não pode pular direto para lá.

As a result, Swift doesn’t let us use str[7] to read the 8th character – even though they could enable such behavior 
trivially, it could easily result in folks using integer subscripting inside a loop, which would have terrible performance.

All this matters because today you’re going to be using UITextChecker to check whether a string is spelled correctly. 
This comes from UIKit, which was written in Objective-C, so we need to be very careful how we give it Swift strings to use.

Today you have three topics to work through, and you’ll learn about using UITextChecker to find invalid words, inserting 
table view rows with animation, and more.



---------- PREPARE FOR SUBMISSION: lowercased() and IndexPath 

Você pode respirar de novo: terminamos os fechamentos por enquanto. Eu sei que não foi fácil, mas uma vez que 
você entenda os fechamentos básicos, você realmente percorreu um longo caminho em sua aventura Swift.

Vamos fazer uma codificação muito mais fácil agora, porque, acredite ou não, não estamos tão longe de fazer 
este jogo realmente funcionar!

We have now gone over the structure of a closure: trailing closure syntax, unowned self, a parameter being passed 
in, then the need for self. to make capturing clear. We haven't really talked about the actual content of our closure, 
because there isn't a lot to it. As a reminder, here's how it looks:

guard let answer = ac?.textFields?[0].text else { return }
self?.submit(answer)
The first line safely unwraps the array of text fields – it's optional because there might not be any. The second 
line pulls out the text from the text field and passes it to our (all-new-albeit-empty) submit() method.

Este método precisa verificar se a palavra do jogador pode ser feita a partir das letras fornecidas. Ele precisa 
verificar se a palavra já foi usada, porque obviamente não queremos palavras duplicadas. Ele também precisa verificar 
se a palavra é realmente uma palavra válida em inglês, porque, caso contrário, o usuário pode simplesmente digitar bobagens.

If all three of those checks pass, submit() needs to add the word to the usedWords array, then insert a new 
row in the table view. We could just use the table view's reloadData() method to force a full reload, but that's 
not very efficient when we're changing just one row.

Primeiro, vamos criar métodos fictícios para as três verificações que vamos fazer: a palavra é possível, é 
original e é real? Cada um deles aceitará uma sequência de palavras e retornará verdadeiro ou falso, mas por 
enquanto sempre retornaremos verdadeiro - voltaremos a eles em breve. Adicione estes métodos agora:

func isPossible(word: String) -> Bool {
    return true
}

func isOriginal(word: String) -> Bool {
    return true
}

func isReal(word: String) -> Bool {
    return true
}

Com esses três métodos em vigor, podemos escrever nossa primeira passagem no método submit():

func submit(_ answer: String) {
    let lowerAnswer = answer.lowercased()

    if isPossible(word: lowerAnswer) {
        if isOriginal(word: lowerAnswer) {
            if isReal(word: lowerAnswer) {
                usedWords.insert(answer, at: 0)

                let indexPath = IndexPath(row: 0, section: 0)
                tableView.insertRows(at: [indexPath], with: .automatic)
            }
        }
    }
}

Se um usuário digita "cessar" como uma palavra que pode ser feita a partir da nossa palavra iniciada 
"agências", fica claro que está correto porque há um "c", dois "e"s, um "a" e um "s". Mas e se eles 
digitarem "Cease"? Agora ele tem um C maiúsculo, e "agências" não tem um C maiúsculo. Sim, isso mesmo: 
strings diferenciam maiúsculas de minúsculas, o que significa que Cessar não é cessar não é CeasE não é CeAsE.

The solution to this is quite simple: all the starter words are lowercase, so when we check the player's 
answer we immediately lowercase it using its lowercased() method. This is stored in the lowerAnswer constant 
because we want to use it several times.

Então temos três declarações if, uma dentro da outra. Estas são chamadas de declarações aninhadas, porque 
você se aninha uma dentro da outra. Somente se todas as três declarações forem verdadeiras (a palavra é 
possível, a palavra ainda não foi usada e a palavra é uma palavra real), o bloco principal de código é executado.

Once we know the word is good, we do three things: insert the new word into our usedWords array at index 0.
 This means "add it to the start of the array," and means that the newest words will appear at the top of the table view.

As próximas duas coisas estão relacionadas: inserimos uma nova linha na visualização da tabela. 
Dado que a visualização da tabela obtém todos os seus dados da matriz de palavras usada, isso pode 
parecer estranho. Afinal, acabamos de inserir a palavra na matrizusedWords, então por que precisamos 
inserir alguma coisa na visualização da tabela?

The answer is animation. Like I said, we could just call the reloadData() method and have the table do a 
full reload of all rows, but it means a lot of extra work for one small change, and also causes a jump – 
the word wasn't there, and now it is.

This can be hard for users to track visually, so using insertRows() lets us tell the table view that a new 
row has been placed at a specific place in the array so that it can animate the new cell appearing. Adding 
one cell is also significantly easier than having to reload everything, as you might imagine!

There are two quirks here that require a little more detail. First, IndexPath is something we looked at briefly 
in project 1, as it contains a section and a row for every item in your table. As with project 1 we aren't 
using sections here, but the row number should equal the position we added the item in the array – 
position 0, in this case.

Second, the with parameter lets you specify how the row should be animated in. Whenever you're adding 
and removing things from a table, the .automatic value means "do whatever is the standard system animation 
for this change." In this case, it means "slide the new row in from the top."

Nossos três métodos de verificação sempre retornam verdadeiros, independentemente da palavra inserida, mas, 
além disso, o jogo está começando a se unir. Pressione Cmd+R para reproduzir o que você tem: você deve ser 
capaz de tocar no botão + e inserir palavras no alerta.



---------- CHECKING FOR VALID ANSWERS 

As you’ve seen, the return keyword exits a method at any time it's used. If you use return by itself, 
it exits the method and does nothing else. But if you use return with a value, it sends that value back 
to whatever called the method. We’ve used it previously to send back the number of rows in a table, for example.

Antes de enviar um valor de volta, você precisa dizer à Swift que espera retornar um valor. A Swift 
verificará automaticamente se um valor é retornado e se é do tipo de dados certo, então isso é importante. 
Acabamos de colocar stubs (métodos vazios que não fazem nada) para três novos métodos, cada um dos quais 
retorna um valor. Vamos dar uma olhada em um com mais detalhes:

func isOriginal(word: String) -> Bool {
    return true
}

The method is called isOriginal(), and it takes one parameter that's a string. But before the opening brace 
there's something important: -> Bool. This tells Swift that the method will return a boolean value, which is 
the name for a value that can be either true or false.

The body of the method has just one line of code: return true. This is how the return statement is used to 
send a value back to its caller: we're returning true from this method, so the caller can use this method 
inside an if statement to check for true or false.

This method can have as much code as it needs in order to evaluate fully whether the word has been used or not, 
including calling any other methods it needs. We're going to change it so that it calls another method, which 
will check whether our usedWords array already contains the word that was provided. Replace its current return 
true code with this:

return !usedWords.contains(word)

There are two new things here. First, contains() is a method that checks whether the array it’s called on 
(usedWords) contains the value specified in parameter 2 (word). If it does contain the value, contains() 
returns true; if not, it returns false. Second, the ! symbol. You've seen this before as the way to force 
unwrap optional variables, but here it's something different: it means not.

The difference is small but important: when used before a variable or constant, ! means "not" or "opposite".
So if contains() returns true, ! flips it around to make it false, and vice versa. When used after a variable 
or constant, ! means "force unwrap this optional variable."

This is used because our method is called isOriginal(), and should return true if the word has never been used 
before. If we had used return usedWords.contains(word), then it would do the opposite: it would return true if 
the word had been used and false otherwise. So, by using ! we're flipping it around so that the method returns 
true if the word is new.

That's one method down. Next is the isPossible(), which also takes a string as its only parameter and returns 
a Bool – true or false. This one is more complicated, but I've tried to make the algorithm as simple as possible.

Como podemos ter certeza de que a "cessa" pode ser feita a partir de "agências", usando cada letra apenas uma vez? 
A solução que adotei é percorrer todas as letras da resposta do jogador, vendo se elas existem na palavra inicial 
de oito letras com a qual estamos brincando. Se existir, removemos a letra da palavra inicial e, em seguida, 
continuamos o loop. Então, se tentarmos usar uma letra duas vezes, ela existirá pela primeira vez, mas depois 
será removida para que ela não exista da próxima vez, e a verificação falhará.

In project 4 we used the contains() method to see if one string exists inside another. Here we need something 
more precise: if it exists, where? That extra information allows us to remove the character from our word so 
that it won’t be used twice. Swift has a separate method for this called firstIndex(of:), which will return 
the first position of the substring if it exists or nil otherwise.

Para colocar isso em prática, aqui está o método isPossible():

func isPossible(word: String) -> Bool {
    guard var tempWord = title?.lowercased() else { return false }

    for letter in word {
        if let position = tempWord.firstIndex(of: letter) {
            tempWord.remove(at: position)
        } else {
            return false
        }
    }

    return true
}

If the letter was found in the string, we use remove(at:) to remove the used letter from the tempWord variable. 
This is why we need the tempWord variable at all: because we'll be removing letters from it so we can check again 
the next time the loop goes around.

The method ends with return true, because this line is reached only if every letter in the user's word was found 
in the start word no more than once. If any letter isn't found, or is used more than possible, one of the return 
false lines would have been hit, so by this point we're sure the word is good.

Importante: dissemos à Swift que estamos retornando um valor booleano desse método, e ele verificará todos os 
resultados possíveis do código para garantir que um valor booleano seja retornado, não importa o que aconteça.

Time for the final method. Replace the current isReal() method with this:

func isReal(word: String) -> Bool {
    let checker = UITextChecker()
    let range = NSRange(location: 0, length: word.utf16.count)
    let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")

    return misspelledRange.location == NSNotFound
}

There's a new class here, called UITextChecker. This is an iOS class that is designed to spot spelling errors, 
which makes it perfect for knowing if a given word is real or not. We're creating a new instance of the class 
and putting it into the checker constant for later.

Há um novo tipo aqui também, chamado NSRange. Isso é usado para armazenar um intervalo de cadeias de caracteres, 
que é um valor que contém uma posição inicial e um comprimento. Queremos examinar toda a string, então usamos 0 para 
a posição inicial e o comprimento da string para o comprimento.

Next, we call the rangeOfMisspelledWord(in:) method of our UITextChecker instance. This wants five parameters, but 
we only care about the first two and the last one: the first parameter is our string, word, the second is our range 
to scan (the whole string), and the last is the language we should be checking with, where en selects English.

Parameters three and four aren't useful here, but for the sake of completeness: parameter three selects a point 
in the range where the text checker should start scanning, and parameter four lets us set whether the UITextChecker 
should start at the beginning of the range if no misspelled words were found starting from parameter three. 
Neat, but not helpful here.

Calling rangeOfMisspelledWord(in:) returns another NSRange structure, which tells us where the misspelling 
was found. But what we care about was whether any misspelling was found, and if nothing was found our NSRange 
will have the special location NSNotFound. Usually location would tell you where the misspelling started, 
but NSNotFound is telling us the word is spelled correctly – i.e., it's a valid word.

Note: In case you were curious, NSRange pre-dates Swift, and therefore doesn’t have access to optionals – 
NSNotFound is effectively a magic number that means “not found”, assigned to a constant to make it easier to use.

Here the return statement is used in a new way: as part of an operation involving ==. This is a very common 
way to code, and what happens is that == returns true or false depending on whether misspelledRange.location 
is equal to NSNotFound. That true or false is then given to return as the return value for the method.

Poderíamos ter escrito essa mesma linha em várias linhas, mas não é comum:

if misspelledRange.location == NSNotFound {
    return true
} else {
    return false
}

Isso completa o terceiro dos nossos métodos que faltam, então o projeto está quase completo. 
Execute agora e faça um teste completo!

Antes de continuarmos, há uma pequena coisa que eu quero abordar brevemente. No método isPossible(), 
repetimos cada letra tratando a palavra como uma matriz, mas neste novo código usamos word.utf16. Por quê?

A resposta é uma peculiaridade irritante de compatibilidade com versões anteriores: as strings de Swift 
armazenam nativamente caracteres internacionais como caracteres individuais, por exemplo, a letra "é" é 
armazenada exatamente assim. No entanto, o UIKit foi escrito em Objective-C antes das strings de Swift 
aparecerem, e usa um sistema de caracteres diferente chamado UTF-16 - abreviação de Formato de Transformação 
Unicode de 16 bits - onde o acento e a letra são armazenados separadamente.

It’s a subtle difference, and often it isn’t a difference at all, but it’s becoming increasingly problematic 
because of the rise of emoji – those little images that are frequently used in messages. Emoji are actually 
just special character combinations behind the scenes, and they are measured differently with Swift strings 
and UTF-16 strings: Swift strings count them as 1-letter strings, but UTF-16 considers them to be 2-letter 
strings. This means if you use count with UIKit methods, you run the risk of miscounting the string length.

I realize this seems like pointless additional complexity, so let me try to give you a simple rule: when 
you’re working with UIKit, SpriteKit, or any other Apple framework, use utf16.count for the character count. 
If it’s just your own code - i.e. looping over characters and processing each one individually – then use 
count instead.



---------- OR ELSE WHAT? 

Ainda há um problema a ser corrigido com o nosso código, e é um problema bastante tedioso. Se a palavra for 
possível, original e real, nós a adicionamos à lista de palavras encontradas e a inserimos na visualização da 
tabela. Mas e se a palavra não for possível? Ou se for possível, mas não original? Nesse caso, rejeitamos a 
palavra e não dizemos por quê, para que o usuário não receba feedback.

So, the final part of our project is to give users feedback when they make an invalid move. This is tedious 
because it's just adding else statements to all the if statements in submit(), each time configuring a message 
to show to users.

Aqui está o método ajustado:

func submit(answer: String) {
    let lowerAnswer = answer.lowercased()

    let errorTitle: String
    let errorMessage: String

    if isPossible(word: lowerAnswer) {
        if isOriginal(word: lowerAnswer) {
            if isReal(word: lowerAnswer) {
                usedWords.insert(answer, at: 0)

                let indexPath = IndexPath(row: 0, section: 0)
                tableView.insertRows(at: [indexPath], with: .automatic)

                return
            } else {
                errorTitle = "Word not recognised"
                errorMessage = "You can't just make them up, you know!"
            }
        } else {
            errorTitle = "Word used already"
            errorMessage = "Be more original!"
        }
    } else {
        guard let title = title?.lowercased() else { return }
        errorTitle = "Word not possible"
        errorMessage = "You can't spell that word from \(title)"
    }

    let ac = UIAlertController(title: errorTitle, message: errorMessage, preferredStyle: .alert)
    ac.addAction(UIAlertAction(title: "OK", style: .default))
    present(ac, animated: true)
}

As you can see, every if statement now has a matching else statement so that the user gets appropriate feedback.
 All the elses are effectively the same (albeit with changing text): set the values for errorTitle and errorMessage 
 to something useful for the user. The only interesting exception is the last one, where we use string interpolation 
 to show the view controller's title as a lowercase string.

If the user enters a valid answer, a call to return forces Swift to exit the method immediately once the table 
has been updated. This is helpful, because at the end of the method there is code to create a new UIAlertController 
with the error title and message that was set, add an OK button without a handler (i.e., just dismiss the alert), 
then show the alert. So, this error will only be shown if something went wrong.

This demonstrates one important tip about Swift constants: both errorTitle and errorMessage were declared as constants, 
which means their value cannot be changed once set. I didn't give either of them an initial value, and that's OK – 
Swift lets you do this as long as you do provide a value before the constants are read, and also as long as you don't 
try to change the value again later on.

