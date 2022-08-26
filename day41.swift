26/08/2022


MARCO: PROJETOS 7 - 9



Há alguma pseudociência que afirma que a segunda ou terceira segunda-feira de janeiro é a "segunda-feira azul" - o dia 
mais deprimente do ano. As razões dadas incluem as condições climáticas no hemisfério norte sendo sombrias, a quantidade 
de tempo desde o feriado de Natal, o número de pessoas que desistem das resoluções de Ano Novo e muito mais.

É, é claro, bobagem, mas tem um grão de verdade: é fácil desanimar quando você está no meio de algo, porque a novidade 
inicial passou e ainda há muito mais trabalho pela frente.

É onde você está hoje. Você está a menos da metade dos 100 Dias de Swift, mas já está sendo solicitado a abordar tópicos 
complicados em vários dias consecutivos - o nível de dificuldade está aumentando, o ritmo provavelmente parece um pouco 
mais rápido e a quantidade de código que você está sendo solicitado a escrever também está aumentando.

Eu sei que alguns dos dias que você enfrentou foram mais difíceis do que outros, e também sei que você provavelmente está 
se sentindo cansado - você está desistindo de muito tempo para que isso aconteça. Mas quero encorajá-lo a continuar 
avançando: você está quase no meio do caminho agora, e os aplicativos que agora é capaz de criar são genuinamente úteis - 
você percorreu um longo caminho!

Helpfully, today is another consolidation day, which is partly a chance for us to go over some topics again to make sure 
you really understand them, partly a chance for me to dive into specific topics such as enumerated() and GCD’s 
background/foreground bounce, and partly a chance for you to try making your own app from scratch.

Como sempre, o desafio que você enfrentará está absolutamente dentro do seu nível de habilidade atual, e lhe dá a chance 
de ver o quão longe você chegou para si mesmo. Ricky Mondello – um dos times que constrói o Safari na Apple – disse uma 
vez: “uma das minhas coisas favoritas sobre engenharia de software, ou qualquer tipo de crescimento, é voltar a algo que 
você já pensou ser muito difícil e saber que pode fazê-lo.”

Hoje você tem três tópicos para trabalhar, um dos quais é o seu desafio.


---------- WHAT YOU LEARNED 

Os projetos 7, 8 e 9 foram os primeiros da série que considero "difíceis": você teve que analisar dados JSON, teve que criar 
um layout complexo para 7 Swifty Words e deu seus primeiros passos para criar código multithread - código que faz com que o 
iOS faça mais de uma coisa de cada vez.

None of those things were easy, but I hope you felt the results were worth the effort. And, as always, don’t worry if 
you’re not 100% on them just – we’ll be using Codable and GCD more in future projects, so you’ll have ample chance to 
practice.

- Você já conheceu o UITabBarController, que é outro componente principal do iOS - você o vê na App Store, Música, iBooks, 
Saúde, Atividade e muito mais.

- Each item on the tab bar is represented by a UITabBarItem that has a title and icon. If you want to use one of Apple’s 
icons, it means using Apple’s titles too.

- We used Data to load a URL, with its contentsOf method. That then got fed to JSONDecoder so that we could read it in code.

- We used WKWebView again, this time to show the petition content in the app. This time, though, we wanted to load our own 
HTML rather than a web site, so we used the loadHTMLString() method.

- Em vez de conectar muitas ações no Interface Builder, você viu como poderia escrever interfaces de usuário em código. 
Isso foi particularmente útil para os botões de letra de 7 Swifty Words, porque poderíamos usar um loop aninhado.

- In project 8 we used property observers, using didSet. This meant that whenever the score property changed, we automatically 
updated the scoreLabel to reflect the new score.

- You learned how to execute code on the main thread and on background threads using DispatchQueue, and also met the 
performSelector(inBackground:) method, which is the easiest way to run one whole method on a background thread.

- Finally, you learned several new methods, not least enumerated() for looping through arrays, joined() for bringing an 
array into a single value, and replacingOccurrences() to change text inside a string.



---------- KEY POINTS 

Existem três recursos Swift que são tão importantes - e tão comumente usados - que vale a pena revisá-los para garantir 
que você esteja confortável com eles.

O primeiro código que eu gostaria de ver é este:

for (index, line) in lines.enumerated() {
    let parts = line.components(separatedBy: ": ")

This might seem like a new way of writing a loop, but really it’s just a variation of the basic for loop. A regular for 
loop returns one value at a time from an array for you to work with, but this time we’re calling the enumerated() method 
on the array, which causes it to return two things for each item in the array: the item’s position in the array, as well 
as the item itself.

It’s common to see enumerated() in a loop, because its behavior of delivering both the item and its position is so useful. 
For example, we could use it to print out the results of a race like this:

let results = ["Paul", "Sophie", "Lottie", "Andrew", "John"]

for (place, result) in results.enumerated() {
    print("\(place + 1). \(result)")
}

Note that I used \(place + 1) to print out each person’s place in the results, because array positions all count from 0.

O segundo código que vamos revisar é este:

var score: Int = 0 {
    didSet {
        scoreLabel.text = "Score: \(score)"
    }
}

This is a property observer, and it means that whenever the score integer changes the label will be updated to match. There 
are other ways you could ensure the two remain in sync: we could have written a setScore() method, for example, or we could 
just have updated the scoreLabel text by hand whenever the score property changed.

The former isn’t a bad idea, but you do need to police yourself to ensure you never set score directly - and that’s harder 
than you think! The second is a bad idea, however: duplicating code can be problematic, because if you need to change something 
later you need to remember to update it everywhere it’s been duplicated.

O último código que eu gostaria de ver novamente é este:

DispatchQueue.global().async { [weak self] in
    // do background work

    DispatchQueue.main.async {
        // do main thread work
    }
}

Esse código usa o Grand Central Dispatch para realizar algum trabalho em segundo plano e, em seguida, realizar mais algum 
trabalho no thread principal. Isso é extremamente comum, e você verá esse mesmo código aparecer em muitos projetos à medida 
que suas habilidades avançam.

A primeira parte do código diz ao GCD para fazer o seguinte trabalho em um thread em segundo plano. Isso é útil para 
qualquer trabalho que leve mais do que alguns milissegundos para ser executado, então isso tem tudo a ver com a internet, 
por exemplo, mas também sempre que você quiser fazer operações complexas, como consultar um banco de dados ou carregar 
arquivos.

A segunda parte do código é executada após a conclusão do seu trabalho em segundo plano e envia o trabalho restante 
de volta para o thread principal. É aqui que você apresenta ao usuário os resultados do seu trabalho: os resultados 
do banco de dados que corresponderam à pesquisa dele, o arquivo remoto que você buscou e assim por diante.

É extremamente importante que você atualize sua interface de usuário apenas a partir do thread principal - tentar fazê-lo 
a partir de um thread em segundo plano fará com que seu aplicativo falhe na melhor das hipóteses ou - muito pior - cause 
inconsistências estranhas em seu aplicativo.



---------- CHALLENGE

Este é o primeiro desafio que envolve a criação de um jogo. No entanto, você ainda estará usando o UIKit, por isso 
é uma boa chance de praticar suas habilidades de aplicativo também.

O desafio é este: faça um jogo de carrasco usando o UIKit. Como lembrete, isso significa escolher uma palavra aleatória 
de uma lista de possibilidades, mas apresentá-la ao usuário como uma série de sublinhados. Então, se a sua palavra fosse 
“RITMO”, o usuário veria “??????”.

O usuário pode então adivinhar letras uma de cada vez: se eles adivinharem uma letra que está na palavra, por exemplo. 
H, é revelado para fazer “? H?? H?” ; se eles adivinharem uma letra incorreta, eles se aproximam da morte. Se eles tiverem 
sete respostas incorretas, perdem, mas se conseguirem soletrar a palavra completa antes disso, eles ganham.

Esse é o jogo: você consegue? Não subestime este: é chamado de desafio por um motivo - deveria esticá-lo!

A principal complexidade que você encontrará é que a Swift tem um tipo de dados especial para letras individuais, 
chamado Character. É fácil criar strings a partir de caracteres e vice-versa, mas você precisa saber como isso é feito.

First, the individual letters of a string are accessible simply by treating the string like an array – it’s a bit like 
an array of Character objects that you can loop over, or read its count property, just like regular arrays.

When you write for letter in word, the letter constant will be of type Character, so if your usedLetters array contains 
strings you will need to convert that letter into a string, like this:

let strLetter = String(letter)

Observação: ao contrário das matrizes regulares, você não pode ler letras em cadeias de caracteres apenas usando suas 
posições inteiras - elas armazenam cada letra de uma maneira complicada que proíbe esse comportamento.

Once you have the string form of each letter, you can use contains() to check whether it’s inside your usedLetters array.

Isso é o suficiente para você começar este desafio sozinho. Como de costume, há algumas dicas abaixo, mas é sempre uma 
boa ideia experimentar você mesmo antes de lê-las.

- Você já sabe como carregar uma lista de palavras do disco e escolher uma, porque foi exatamente isso que fizemos no tutorial 5.

- You know how to prompt the user for text input, again because it was in tutorial 5. Obviously this time you should 
only accept single letters rather than whole words – use someString.count for that.

- You can display the user’s current word and score using the title property of your view controller.

- Você deve criar uma matriz usedLetters, bem como um inteiro wrongAnswers.

- When the player wins or loses, use UIAlertController to show an alert with a message.

Ainda preso? Aqui estão alguns exemplos de código que você pode achar útil:

let word = "RHYTHM"
var usedLetters = ["R", "T"]
var promptWord = ""

for letter in word.characters {
    let strLetter = String(letter)

    if usedLetters.contains(strLetter) {
        promptWord += strLetter
    } else {
        promptWord += "?"
    }
}

print(promptWord)


