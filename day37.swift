12/08/2022 


PROJECT 8, PART TWO 


Como você se saiu com a codificação da interface do usuário de ontem? Depois de concluir os tópicos, houve uma coisa que 
eu pedi que você tivesse em mente: se você prefere fazer interfaces de usuário em storyboards ou programaticamente, é 
importante que você saiba como fazer as duas coisas. Agora que você fez as duas coisas, como você se sente sobre isso?

Esta não é apenas uma pergunta teórica - se você é como eu, é uma pergunta que lhe será muito feita, por isso é importante 
pensar cuidadosamente sobre sua resposta.

Quanto a mim, minha resposta é bem simples: eu faço o que faz sentido em cada cenário individual. Às vezes isso significa 
usar código, às vezes significa usar o Interface Builder, e às vezes significa usar ambos - e tudo bem. O principal é que 
você se lembra das palavras de John Woods: "sempre codifique como se a pessoa que acaba mantendo seu código fosse um psicopata 
violento que sabe onde você mora".

Se isso está tornando sua interface do usuário em storyboards ou em código é acadêmico, na verdade - o que importa é 
que foi a melhor escolha que você poderia fazer para esse problema, dadas as restrições em que você estava trabalhando.

Você ficará feliz em ver o trabalho duro de ontem valer a pena hoje, porque concluiremos nosso jogo em menos de uma hora 
de trabalho. Lançamos todas as bases ontem, então hoje vamos olhar para os níveis de carregamento e responder aos toques 
de botões - chega de Layout Automático por enquanto!

Hoje você tem três tópicos para trabalhar e aprenderá a adicionar alvos a um botão, separar e juntar strings, 
ocultar visualizações e muito mais.


---------- LOADING A LEVEL AND ADDING BUTTON TARGETS 

Depois do nosso gigantesco esforço de construir a interface do usuário em código, é hora de continuar com algo muito 
mais fácil: carregar um nível e mostrar partes de letras em nossos botões.

Este jogo pede aos jogadores que escrevam sete palavras de vários grupos de letras, e cada palavra vem com uma pista 
para eles adivinharem. É importante que o número total de grupos de letras seja de 20, pois são quantos botões você 
tem. Eu criei o primeiro nível para você, e parece assim:

HA|UNT|ED: Ghosts in residence
LE|PRO|SY: A Biblical skin disease
TW|ITT|ER: Short online chirping
OLI|VER: Has a Dickensian twist
ELI|ZAB|ETH: Head of state, British style
SA|FA|RI: The zoological web
POR|TL|AND: Hipster heartland

Como você pode ver, usei o símbolo de tubulação para dividir meus grupos de letras, o que significa que um botão terá "HA", 
outro "UNT" e outro "ED". Há então um cólon e um espaço, seguidos por uma simples pista. Este nível está nos arquivos deste 
projeto que você deve baixar do GitHub em https://github.com/twostraws/HackingWithSwift. Você deve copiar level1.txt para o 
seu projeto Xcode como já fez antes.

Nossa primeira tarefa será carregar o nível e configurar todos os botões para mostrar um grupo de letras. Vamos precisar de 
dois novos arrays para lidar com isso: um para armazenar os botões que estão sendo usados atualmente para soletrar uma resposta 
e outro para todas as soluções possíveis. Também precisamos de dois inteiros: um para manter a pontuação do jogador, que 
começará em 0, mas obviamente mudará durante o jogo, e outro para manter o nível atual.

Então, declare essas propriedades logo abaixo das visualizações que definimos anteriormente:

var activatedButtons = [UIButton]()
var solutions = [String]()

var score = 0
var level = 1
Também precisamos criar três métodos que serão chamados a partir de nossos botões: um quando o envio é tocado, um quando clear 
é tocado e outro quando qualquer um dos botões de letra é tocado. Eles não precisam de nenhum código por enquanto, mas precisamos 
garantir que eles sejam chamados quando nossos botões forem tocados.

Primeiro, adicione estes três métodos vazios abaixo de viewDidLoad():

@objc func letterTapped(_ sender: UIButton) {
}

@objc func submitTapped(_ sender: UIButton) {
}

@objc func clearTapped(_ sender: UIButton) {
}

All three of those have the @objc attribute because they are going to be called by the buttons – by Objective-C code – when they are tapped.

When we used UIBarButtonItem previously, we were able to specify the target and selector of that button right in the initializer. 
This is done a little differently with buttons: they have a dedicated addTarget() method that connects the buttons to some code.

Então, em loadView(), adicione isso onde criamos o botão enviar:

submit.addTarget(self, action: #selector(submitTapped), for: .touchUpInside)

The target, action, and selector parts you know already, but the .touchUpInside part is new – that’s UIKit’s way of saying 
that the user pressed down on the button and lifted their touch while it was still inside. So, altogether that line means 
“when the user presses the submit button, call submitTapped() on the current view controller.”

Agora adicione isso onde o botão de limpar é criado:

clear.addTarget(self, action: #selector(clearTapped), for: .touchUpInside)

That will call the clearTapped() method when the button is triggered.

Finally, we want all the letter buttons to call letterTapped() when they are tapped – they share the same method, much like 
our flag buttons in project 2.

Então, adicione esta linha dentro do nosso loop aninhado, logo abaixo da chamada para letterButtons.append():

letterButton.addTarget(self, action: #selector(letterTapped), for: .touchUpInside)

Claro, adicionar todos esses alvos realmente não fará nada, porque os três métodos que eles estão chamando estão todos vazios.

Vamos preenchê-los mais tarde, mas primeiro vamos nos concentrar em carregar dados de nível no jogo. Vamos isolar o carregamento 
de nível em um único método, chamado loadLevel(). Isso precisa fazer duas coisas:

1. Carregue e analise nosso arquivo de texto de nível no formato que mostrei anteriormente.

2. Atribua aleatoriamente grupos de letras aos botões.

In project 5 you already learned how to create a String using contentsOf to load files from disk, and we'll be using that to 
load our level. In that same project you learned how to use components(separatedBy:) to split up a string into an array, and 
we'll use that too.

Também precisaremos usar o código de embaralhamento de matriz da Swift que já usamos antes. Mas há algumas coisas novas para 
aprender, honestamente!

First, we'll be using the enumerated() method to loop over an array. We haven't used this before, but it's helpful because 
it passes you each object from an array as part of your loop, as well as that object's position in the array.

Há também um novo método de string para aprender, chamado replacingOccurrences(). Isso permite que você especifique dois 
parâmetros e substitua todas as instâncias do primeiro parâmetro pelo segundo parâmetro. Usaremos isso para converter 
"HA|UNT|ED" em HAUNTED, então temos uma lista de todas as nossas soluções.

Before I show you the code, watch out for how I use the method's three variables: clueString will store all the level's 
clues, solutionString will store how many letters each answer is (in the same position as the clues), and letterBits is 
an array to store all letter groups: HA, UNT, ED, and so on.

Agora adicione o método loadLevel():

func loadLevel() {
    var clueString = ""
    var solutionString = ""
    var letterBits = [String]()

    if let levelFileURL = Bundle.main.url(forResource: "level\(level)", withExtension: "txt") {
        if let levelContents = try? String(contentsOf: levelFileURL) {
            var lines = levelContents.components(separatedBy: "\n")
            lines.shuffle()

            for (index, line) in lines.enumerated() {
                let parts = line.components(separatedBy: ": ")
                let answer = parts[0]
                let clue = parts[1]

                clueString += "\(index + 1). \(clue)\n"

                let solutionWord = answer.replacingOccurrences(of: "|", with: "")
                solutionString += "\(solutionWord.count) letters\n"
                solutions.append(solutionWord)

                let bits = answer.components(separatedBy: "|")
                letterBits += bits
            }
        }
    }

    // Now configure the buttons and labels
}

Se você leu tudo isso e fez sentido pela primeira vez, ótimo! Você pode pular os próximos parágrafos e pular para o texto 
em negrito "Tudo pronto!". Se você leu e apenas alguns fizeram sentido, estes próximos parágrafos são para você.

First, the method uses url(forResource:) and contentsOf to find and load the level string from our app bundle. String 
interpolation is used to combine "level" with our current level number, making "level1.txt". The text is then split into 
an array by breaking on the \n character (that's line break, remember), then shuffled so that the game is a little different 
each time.

Our loop uses the enumerated() method to go through each item in the lines array. This is different to how we normally loop 
through an array, but enumerated() is helpful here because it tells us where each item was in the array so we can use that 
information in our clue string. In the code above, enumerated() will place the item into the line variable and its position 
into the index variable.

We already split the text up into lines based on finding \n, but now we split each line up based on finding :, because each 
line has a colon and a space separating its letter groups from its clue. We put the first part of the split line into answer 
and the second part into clue, for easier referencing later.

Next comes our new string method call, replacingOccurrences(of:). We're asking it to replace all instances of | with an empty 
string, so HA|UNT|ED will become HAUNTED. We then use count to get the length of our string then use that in combination with 
string interpolation to add to our solutions string.

Finally, we make yet another call to components(separatedBy:) to turn the string "HA|UNT|ED" into an array of three elements, 
then add all three to our letterBits array.

Tudo pronto!

Time for some more code: our current loadLevel() method ends with a comment saying // Now configure the buttons and labels, 
and we're going to fill that in with the final part of the method. This needs to set the cluesLabel and answersLabel text, 
shuffle up our buttons, then assign letter groups to buttons.

Before I show you the actual code, there's a new string method to introduce: trimmingCharacters(in:) removes any letters you 
specify from the start and end of a string. It's most frequently used with the parameter .whitespacesAndNewlines, which trims 
spaces, tabs and line breaks, and we need exactly that here because our clue string and solutions string will both end up with 
an extra line break.

Coloque este código onde o comentário estava:

cluesLabel.text = clueString.trimmingCharacters(in: .whitespacesAndNewlines)
answersLabel.text = solutionString.trimmingCharacters(in: .whitespacesAndNewlines)

letterBits.shuffle()

if letterBits.count == letterButtons.count {
    for i in 0 ..< letterButtons.count {
        letterButtons[i].setTitle(letterBits[i], for: .normal)
    }
}

That loop will count from 0 up to but not including the number of buttons, which is useful because we have as many items 
in our letterBits array as our letterButtons array. Looping from 0 to 19 (inclusive) means we can use the i variable to 
set a button to a letter group.

Before you run your program, make sure you add a call to loadLevel() in your viewDidLoad() method. Once that's done, you 
should be able to see all the buttons and clues configured correctly. Now all that's left is to let the player, well, play.



---------- ITS PLAY TIME: firstIndex(of:) AND joined()

Precisamos adicionar mais três métodos ao nosso controlador de visualização para dar vida a este jogo: um para lidar 
com botões de letras sendo tocados, outro para lidar com a palavra atual que está sendo limpa e um terceiro para lidar 
com a palavra atual que está sendo enviada. Os dois primeiros são mais fáceis, então vamos fazer isso para que possamos 
entrar nas coisas sérias.

First, we already used the addTarget() method in viewDidLoad() to make all our letter buttons call the method letterTapped(), 
but right now it’s empty. Please fill it in like this:

@objc func letterTapped(_ sender: UIButton) {
    guard let buttonTitle = sender.titleLabel?.text else { return }
    currentAnswer.text = currentAnswer.text?.appending(buttonTitle)
    activatedButtons.append(sender)
    sender.isHidden = true
}

Isso faz quatro coisas:

1. Ele adiciona uma verificação de segurança para ler o título do botão tocado ou sair se não tiver um por algum motivo.

2. Acrescenta o título do botão à resposta atual do jogador.

3. Acrescenta o botão à matriz activatedButtons

4. Oculta o botão que foi tocado.

The activatedButtons array is being used to hold all buttons that the player has tapped before submitting their answer. 
This is important because we're hiding each button as it is tapped, so if the user taps "Clear" we need to know which 
buttons are currently in use so we can re-show them. You already created an empty method for clear being tapped, so fill 
it in like this:

@objc func clearTapped(_ sender: UIButton) {
    currentAnswer.text = ""

    for btn in activatedButtons {
        btn.isHidden = false
    }

    activatedButtons.removeAll()
}

Como você pode ver, este método remove o texto do campo de texto de resposta atual, revela todos os botões ativados e, 
em seguida, remove todos os itens da matriz activatedButtons.

That just leaves one very important method to fill in, and you already created its stub: the submitTapped() method for 
when the player taps the submit button.

This method will use firstIndex(of:) to search through the solutions array for an item and, if it finds it, tells us 
its position. Remember, the return value of firstIndex(of:) is optional so that in situations where nothing is found 
you won't get a value back – we need to unwrap its return value carefully.

Se o usuário receber uma resposta correta, mudaremos o rótulo das respostas para que, em vez de dizer "7 CARTAS", ele 
diga "ASSOMBRADO", para que eles saibam quais já resolveram.

The way we're going to do this is hopefully easy enough to understand: firstIndex(of:) will tell us which solution matched 
their word, then we can use that position to find the matching clue text. All we need to do is split the answer label text 
up by \n, replace the line at the solution position with the solution itself, then re-join the answers label back together.

You've already learned how to use components(separatedBy:) to split text into an array, and now it's time to meet its 
counterpart: joined(separator:). This makes an array into a single string, with each array element separated by the 
string specified in its parameter.

Once that's done, we clear the current answer text field and add one to the score. If the score is evenly divisible by 7, 
we know they have found all seven words so we're going to show a UIAlertController that will prompt the user to go to the 
next level.

Se você se lembra, Swift tem um operador de divisão restante, %, que nos diz qual número permanece quando você divide um 
número uniformemente por outro - isso é perfeito aqui.

That's all the parts explained, so here's the complete submitTapped() method:

@objc func submitTapped(_ sender: UIButton) {
    guard let answerText = currentAnswer.text else { return }

    if let solutionPosition = solutions.firstIndex(of: answerText) {
        activatedButtons.removeAll()

        var splitAnswers = answersLabel.text?.components(separatedBy: "\n")
        splitAnswers?[solutionPosition] = answerText
        answersLabel.text = splitAnswers?.joined(separator: "\n")

        currentAnswer.text = ""
        score += 1

        if score % 7 == 0 {
            let ac = UIAlertController(title: "Well done!", message: "Are you ready for the next level?", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Let's go!", style: .default, handler: levelUp))
            present(ac, animated: true)
        }
    }
}

Ainda não escrevemos um método levelUp(), mas não é tão difícil. Ele precisa:

1. Adicione 1 ao level.

2. Remova todos os itens da matriz de solutions.

3. Call loadLevel() so that a new level file is loaded and shown.

4. Certifique-se de que todos os nossos botões de letra estejam visíveis.

Add this levelUp() method now:

func levelUp(action: UIAlertAction) {
    level += 1
    solutions.removeAll(keepingCapacity: true)

    loadLevel()

    for btn in letterButtons {
        btn.isHidden = false
    }
}
As you can see, that code clears out the existing solutions array before refilling it inside loadLevel(). 
Then of course you'd need to create level2.txt, level3.txt and so on.

Para começar, fiz um exemplo de level2.txt para você dentro dos meus arquivos de exemplo para este projeto - 
tente adicionar isso ao projeto e veja o que você acha. Quaisquer outros níveis devem ser feitos - apenas 
certifique-se de que haja um total de 20 grupos de letras de cada vez!



---------- PROPERTY OBSERVERS: didSet 

Há uma última coisa a cobrir antes que este projeto seja concluído, e é pequeno e fácil: observadores de propriedade. 
Você aprendeu sobre isso quando analisamos os fundamentos da Swift, mas agora é hora de colocá-los em ação.

Right now we have a property called score that is set to 0 when the game is created and increments by one whenever an answer 
is found. But we don't do anything with that score, so our score label is never updated.

One solution to this problem is to use something like scoreLabel.text = "Score: \(score)" whenever the score value is 
changed, and that's perfectly fine to begin with. But what happens if you're changing the score from several places? 
You need to keep all the code synchronized, which is unpleasant.

Swift’s solution is property observers, which let you execute code whenever a property has changed. To make them work, 
we use either didSet to execute code when a property has just been set, or willSet to execute code before a property has been set.

In our case, we want to add a property observer to our score property so that we update the score label whenever the 
score value was changed. So, change your score property to this:

var score = 0 {
    didSet {
        scoreLabel.text = "Score: \(score)"
    }
}

Using this method, any time score is changed by anyone, our score label will be updated. That's it, the project is done!