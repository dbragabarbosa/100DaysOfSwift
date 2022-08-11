30/07/2022


Today you have two topics to work through, and you’ll learn about text alignment, layout margins, UIFont, and more.


---------- SETTING UP 

This is one of the last games you'll be making with UIKit; almost every game after this one 
will use Apple's SpriteKit framework for high-performance 2D drawing.

We’re going to be making a word game based on the popular indie game 7 Little Words. Users are 
going to see a list of hints and an array of buttons with different letters on, and need to use 
those buttons to enter words matching the hints.

Of course I’ll also be using this project to teach lots of important concepts, in particular how 
to use Auto Layout to create user interfaces entirely in code – no storyboard needed. Being able 
to use storyboards is a great skill, and being able to create user interfaces in code is also a 
great skill. Best of all, though, is knowing how to do both, so you can pick whichever works best 
on a case-by-case basis.

I should warn you ahead of time: although creating UI in code isn’t hard, it does take a lot of 
time. As you’ll see I encourage you to run your code regularly so you can see the parts come 
together, because otherwise this can feel endless!

Anyway, enough chat: go ahead and create a new Single View App project in Xcode, name it Project8, 
then save it somewhere. Now go to the project editor and change its device from Universal to iPad, 
because we’re going to need all the space we can get!

What's that? You don't know where the project editor is? I'm sure I told you to remember where the 
project editor was! OK, here's how to find it, one last time, quoted from project 6:

Press Cmd+1 to show the project navigator on the left of your Xcode window, select your project 
(it's the first item in the pane), then to the right of where you just clicked will appear another 
pane showing "PROJECT" and "TARGETS", along with some more information in the center. The left pane 
can be hidden by clicking the disclosure button in the top-left of the project editor, but hiding it 
will only make things harder to find, so please make sure it's visible!

This view is called the project editor, and contains a huge number of options that affect the way 
your app works. You'll be using this a lot in the future, so remember how to get here! Select Project 6 
under TARGETS, then choose the General tab, and scroll down until you see four checkboxes called Device 
Orientation. You can select only the ones you want to support.

Obviously now that we’re in project 8, you should look for Project 8 under “TARGETS”, 
otherwise all that still applies.



--------- BUILDING A UIKit USER INTERFACE PROGRAMMATICALLY 

Nossa interface de usuário para este jogo será bastante complicada, mas podemos montá-lo peça por peça e fazer 
com que o Layout Automático faça a maior parte do trabalho por nós.

A parte principal da interface do usuário serão dois rótulos grandes: um contendo as pistas que o usuário 
precisa descobrir e outro mostrando quantas letras estão na palavra para cada pista. Então, pode dizer "Uma vaca 
em um tornado" em um rótulo e "9 Letras" no outro - com a resposta sendo "shake de leite". À medida que o jogador 
resolve cada pista, a contagem de letras será substituída por essa resposta, para que eles possam ver rapidamente 
quais resolveram.

Logo acima e à direita desses dois rótulos, haverá um rótulo extra, agradável e pequeno, que mostrará a pontuação 
do usuário.

No meio da tela haverá um UITextField, onde armazenaremos a resposta atual do usuário, além dos botões abaixo para 
enviar a resposta ou limpá-la.

Finally, at the bottom we’re going to make 20 (yes, twenty!) buttons, each containing different parts of the clues. 
So, there will be one with MIL, one with KSH, and one with AKE – the user needs to tap all three to spell MILKSHAKE. 
To make our layout a little easier, we’re going to place those buttons inside another UIView that we can position 
centered on the screen.

A imagem abaixo mostra como deve ficar o layout finalizado se você seguiu todas as instruções. Se você está vendo 
algo um pouco diferente, tudo bem. Se você está vendo algo muito diferente, provavelmente deveria tentar novamente!

Nosso jogo foi projetado para iPads porque temos muitas informações que queremos colocar. Mais tarde, você pode tentar 
criar um segundo layout especificamente para o iPhone, e é possível - é preciso muito mais pensar!

A primeira coisa que vamos fazer é criar cinco propriedades para armazenar as partes importantes da nossa interface de 
usuário: o rótulo de pistas, o rótulo de respostas, a resposta atual do jogador (a palavra que ele está soletrando), 
sua pontuação e todos os botões que mostram peças de palavras.

Então, abra ViewController.swift e adicione estas cinco propriedades à classe ViewController:

var cluesLabel: UILabel!
var answersLabel: UILabel!
var currentAnswer: UITextField!
var scoreLabel: UILabel!
var letterButtons = [UIButton]()

Just like in projects 4 and 7, we’re going to write a custom loadView() method that creates our user interface in code. 
This will involve much more work than just creating a WKWebView, though – we have lots of UI to create! So, we’ll tackle 
it piece by piece so you can see it coming together as we go.

Let’s start nice and easy: we’re going to create the main view itself as a big and white empty space. This is just a 
matter of creating a new instance of UIView, giving it a white background color, and assigning that to our view 
controller’s view property:

override func loadView() {
    view = UIView()
    view.backgroundColor = .white

    // more code to come!
}

UIView is the parent class of all of UIKit’s view types: labels, buttons, progress views, and more. Previously we assigned 
a WKWebView instance directly as our view, meaning that it automatically took up all the space. Here, though, we’re going 
to be adding lots of child views and positioning them by hand, so we need a big, empty canvas to work with.

Colocando três etiquetas na parte superior

Next, let’s create and add the score label. This uses similar code to what you learned in project 6, although now we’re 
going to set the label’s textAlignment property so the text is right-aligned.

Adicione isso abaixo do código anterior, no lugar do // more code to come! Comentário:

scoreLabel = UILabel()
scoreLabel.translatesAutoresizingMaskIntoConstraints = false
scoreLabel.textAlignment = .right
scoreLabel.text = "Score: 0"
view.addSubview(scoreLabel)

We need to add some Auto Layout constraints to make that label be positioned neatly on the screen, and we’re going to 
be using anchors just like we did in project 6. These let us very clearly and descriptively place views relative to 
each other, however this time I want to show you one important difference: because we’ll be creating lots of constraints 
at the same time, we’ll be activating them all at once rather than setting isActive = true multiple times.

Isso é feito usando o método NSLayoutConstraint.activate(), que aceita uma matriz de restrições. Isso os reunirá 
de uma só vez, então adicionaremos mais restrições a essa chamada ao longo do tempo.

UIKit gives us several guides that we can anchor our views to. One of the most common is the safeAreaLayoutGuide of 
our main view, which is the space available once you subtract any rounded corners or notches. Inside that is the 
layoutMarginsGuide, which adds some extra margin so that views don’t run to the left and right edges of the screen.

In this app we’re going to be using the layoutMarginsGuide so that our views are indented a little on each edge, but 
we’ll also be adding some extra indenting to make the whole thing look better on-screen.

Então, adicione isso abaixo do código anterior:

NSLayoutConstraint.activate([
    scoreLabel.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
    scoreLabel.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),

    // more constraints to be added here!
])

Notice the way I’m pinning the label to view.layoutMarginsGuide – that will make the score label have a little distance 
from the right edge of the screen.

Dica: Lembre-se de que você está definindo âncoras como uma matriz, portanto, certifique-se de incluir uma vírgula após cada uma.

Para evitar confusão, aqui está o que você deve ter até agora:

override func loadView() {
    view = UIView()
    view.backgroundColor = .white

    scoreLabel = UILabel()
    scoreLabel.translatesAutoresizingMaskIntoConstraints = false
    scoreLabel.textAlignment = .right
    scoreLabel.text = "Score: 0"
    view.addSubview(scoreLabel)

    NSLayoutConstraint.activate([
        scoreLabel.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
        scoreLabel.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor, constant: 0),
    ])
}

Adicionaremos muito mais código de visualização antes da chamada para NSLayoutConstraint.activate(), e muito mais 
código de restrições dentro dessa matriz sendo passado para NSLayoutConstraint.activate().

Se você executar o aplicativo agora, verá "Pontuação: 0" aninhado no canto superior direito. Se você não vir isso, 
verifique seu código, caso contrário, o resto deste projeto será realmente muito confuso!

Next we’re going to add the clues and answers labels. This will involve similar code to the score label, except 
we’re going to set two extra properties: font and numberOfLines. The font property describes what kind of text 
font is used to render the label, and is provided as a dedicated type that describes a font face and size: UIFont. 
numberOfLines is an integer that sets how many lines the text can wrap over, but we’re going to set it to 0 – a 
magic value that means “as many lines as it takes.”

Adicione este código abaixo do código para criar o rótulo, mas antes do código de Layout Automático:

cluesLabel = UILabel()
cluesLabel.translatesAutoresizingMaskIntoConstraints = false
cluesLabel.font = UIFont.systemFont(ofSize: 24)
cluesLabel.text = "CLUES"
cluesLabel.numberOfLines = 0
view.addSubview(cluesLabel)

answersLabel = UILabel()
answersLabel.translatesAutoresizingMaskIntoConstraints = false
answersLabel.font = UIFont.systemFont(ofSize: 24)
answersLabel.text = "ANSWERS"
answersLabel.numberOfLines = 0
answersLabel.textAlignment = .right
view.addSubview(answersLabel)

Using UIFont.systemFont(ofSize: 24) will give us a 24-point font in whatever font is currently being used by iOS. This 
was Helvetica in the early days of iOS, then moved to Helvetica Neue and finally San Francisco. Asking for the system 
font means we’ll get whatever is the standard today, but our UI will update automatically if Apple makes more changes 
in the future.

Para posicioná-los de tal forma que fiquem ótimos em uma variedade de tamanhos de iPad - desde o iPad Mini até o 
iPad Pro de 12,9 polegadas - vamos definir algumas âncoras:

- Os topos dos rótulos de pistas e respostas serão fixados na parte inferior do rótulo de pontuação.

- O rótulo das pistas será fixado na borda dianteira da tela, recuado por 100 pontos para que pareça mais limpo.

- O rótulo de pistas terá uma âncora de largura definida como 0,6 da largura da visualização principal, de modo que 
ocupa 60% da tela. Precisamos subtrair 100 disso para contabilizar o recuo.

- O rótulo de respostas será fixado na borda final da tela e, em seguida, também recuado por 100 pontos para 
corresponder ao rótulo de pistas.

- O rótulo de respostas terá uma âncora de largura de 0,4 da largura da visualização principal, de modo que 
ocupa os 40% restantes da tela. Novamente, isso precisa ter 100 levados para contabilizar o recuo.

- Finalmente, faremos com que a altura do rótulo de respostas corresponda à altura do rótulo de pistas.

Eu percebo que pode parecer muito trabalho, mas esse tipo de coisa é onde as âncoras de Layout Automático realmente 
brilham. Lembre-se: ele leva em conta o multiplicador primeiro, depois a constante.

Adicione essas restrições à matriz que estamos ativando - adicionei comentários apenas para ter certeza:

// pin the top of the clues label to the bottom of the score label
cluesLabel.topAnchor.constraint(equalTo: scoreLabel.bottomAnchor),

// pin the leading edge of the clues label to the leading edge of our layout margins, adding 100 for some space
cluesLabel.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor, constant: 100),

// make the clues label 60% of the width of our layout margins, minus 100
cluesLabel.widthAnchor.constraint(equalTo: view.layoutMarginsGuide.widthAnchor, multiplier: 0.6, constant: -100),

// also pin the top of the answers label to the bottom of the score label
answersLabel.topAnchor.constraint(equalTo: scoreLabel.bottomAnchor),

// make the answers label stick to the trailing edge of our layout margins, minus 100
answersLabel.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor, constant: -100),

// make the answers label take up 40% of the available space, minus 100
answersLabel.widthAnchor.constraint(equalTo: view.layoutMarginsGuide.widthAnchor, multiplier: 0.4, constant: -100),

// make the answers label match the height of the clues label
answersLabel.heightAnchor.constraint(equalTo: cluesLabel.heightAnchor),

Se você executar o código agora, verá "PISTAS" e "RESPOSTAS" perto da parte superior da tela.

Temporariamente - apenas para que você possa acompanhar e ver como tudo funciona! - tente adicionar este código 
após a chamada para activateConstraints():

cluesLabel.backgroundColor = .red
answersLabel.backgroundColor = .blue

Isso fará com que nossos dois grandes rótulos se destaquem mais claramente, o que será útil enquanto construímos 
nossa interface do usuário.

Inserindo respostas

Next we’re going to add a UITextField that will show the user’s answer as they are building it. You might think 
this is a good place to use another UILabel particularly because we want players to build words by tapping letter 
buttons rather than typing into a box. However, this lets me introduce you to the placeholder property of text 
fields, which draws gray prompt text that the user can type over – it looks really nice, and gives us space to 
provide some instructions to users.

Tal como acontece com nossos rótulos, também ajustaremos a fonte e o alinhamento do campo de texto, mas também 
desativaremos a interação do usuário para que o usuário não possa tocar nele - não queremos que o teclado do iOS apareça.

Adicione este código ao lado das outras visualizações:

currentAnswer = UITextField()
currentAnswer.translatesAutoresizingMaskIntoConstraints = false
currentAnswer.placeholder = "Tap letters to guess"
currentAnswer.textAlignment = .center
currentAnswer.font = UIFont.systemFont(ofSize: 44)
currentAnswer.isUserInteractionEnabled = false
view.addSubview(currentAnswer)

The only new part is setting isUserInteractionEnabled to false, which is what stops the user from activating the 
text field and typing into it.

Quanto às restrições, vamos tornar este campo de texto centralizado em nossa visão, mas apenas 50% de sua largura - 
dados quantos caracteres ele conterá, isso é mais do que suficiente. Também vamos colocá-lo abaixo do rótulo de 
pistas, com 20 pontos de espaçamento para que os dois não toquem.

Adicione isso à sua matriz de restrições:

currentAnswer.centerXAnchor.constraint(equalTo: view.centerXAnchor),
currentAnswer.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5),
currentAnswer.topAnchor.constraint(equalTo: cluesLabel.bottomAnchor, constant: 20),

Execute o aplicativo novamente e você verá "Toque em letras para adivinhar" em cinza sob os rótulos vermelho e azul - 
isso está se juntando lentamente!

Abaixo do campo de texto, vamos adicionar dois botões: um para o usuário enviar sua resposta (quando inserir todas as 
letras que deseja) e outro para limpar sua resposta para que possa tentar outra coisa.

To create a UIButton in code you need to know two things:

1. Buttons have various built-in styles, but the ones you’ll most commonly use are .custom and .system. We want the 
default button style here, so we’ll use .system.

2. We need to use setTitle() to adjust the title on the button, just like we did with setImage() in project 2.

Adicione isso ao nosso código de criação de visualização:

let submit = UIButton(type: .system)
submit.translatesAutoresizingMaskIntoConstraints = false
submit.setTitle("SUBMIT", for: .normal)
view.addSubview(submit)

let clear = UIButton(type: .system)
clear.translatesAutoresizingMaskIntoConstraints = false
clear.setTitle("CLEAR", for: .normal)
view.addSubview(clear)

Nota: Não precisamos armazená-los como propriedades no controlador de visualização, porque não precisamos ajustá-los mais tarde.

Em termos das restrições a serem adicionadas para esses botões, eles precisam de três cada:

1. Um para definir sua posição vertical. Para o botão enviar, usaremos a parte inferior do campo de texto de 
resposta atual, mas para o botão claro, definiremos sua âncora Y para que ela permaneça alinhada com a posição Y 
do botão enviar. Isso significa que ambos os botões permanecerão alinhados mesmo se movermos um.

2. Vamos centralizar os dois horizontalmente em nossa visão principal. Para impedir que eles se sobreponham, 
subtrairemos 100 da posição X do botão enviar e adicionaremos 100 à posição X do botão claro. "100" não é 
nenhum tipo de número especial - você pode experimentar valores diferentes e ver o que parece bom para você.

3. Vamos forçar ambos os botões a terem uma altura de 44 pontos. O iOS gosta de tornar seus botões muito 
pequenos por padrão, mas, ao mesmo tempo, as diretrizes de interface humana da Apple recomendam que os 
botões sejam pelo menos 44x44 para que possam ser tocados facilmente.

Aqui estão as restrições necessárias para dar vida a essas regras - adicione isso à sua lista de restrições:

submit.topAnchor.constraint(equalTo: currentAnswer.bottomAnchor),
submit.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -100),
submit.heightAnchor.constraint(equalToConstant: 44),

clear.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 100),
clear.centerYAnchor.constraint(equalTo: submit.centerYAnchor),
clear.heightAnchor.constraint(equalToConstant: 44),

Botões... botões em todos os lugares!

Você já está se sentindo cansado? É um trabalho duro, não é? Não me entenda mal - construir uma interface de 
usuário programaticamente tem muitas vantagens, mas certamente é detalhado.

Felizmente, estamos perto do fim agora, e tudo o que resta é adicionar botões de letras na parte inferior da 
interface do usuário. Precisamos de muitos deles - 20, para ser mais preciso - e precisamos garantir que eles 
estejam bem posicionados na tela.

Com layouts complicados como este, a coisa mais inteligente a fazer é envolver as coisas em uma visualização de 
contêiner. No nosso caso, isso significa que vamos criar uma visualização de contêiner que abrigará todos os 
botões e, em seguida, fornecerá restrições de visualização para que ela seja posicionada corretamente na tela.

This is just going to be a plain UIView – it does nothing special other than host our buttons. So, add this 
code below our previous view creation code:

let buttonsView = UIView()
buttonsView.translatesAutoresizingMaskIntoConstraints = false
view.addSubview(buttonsView)

Como essa coisa é a última visualização em nossa visualização (excluindo os botões dentro dela, mas eles não 
desempenham um papel em nossas restrições de Layout Automático), precisamos dar mais restrições para que o 
Layout Automático saiba que nossa hierarquia está completa:

1. Vamos dar a ele uma largura e altura de 750x320 para que ele contenha precisamente os botões dentro dele.

2. Será centralizado horizontalmente.

3. Vamos definir sua âncora superior para ser a parte inferior do botão enviar, além de 20 pontos para 
adicionar um pouco de espaçamento.

4. Vamos fixá-lo na parte inferior de nossas margens de layout, -20 para que ele não corra até a borda.

Adicione estas restrições finais à nossa matriz de restrições:

buttonsView.widthAnchor.constraint(equalToConstant: 750),
buttonsView.heightAnchor.constraint(equalToConstant: 320),
buttonsView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
buttonsView.topAnchor.constraint(equalTo: submit.bottomAnchor, constant: 20),
buttonsView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor, constant: -20)

Apenas para fins de teste, dê a essa nova visualização uma cor de fundo verde:

buttonsView.backgroundColor = .green

Ainda não adicionamos os botões dentro dessa visualização, mas execute o aplicativo agora - 
acho que você achará o resultado interessante.

O que você verá é que nosso layout mudou drasticamente: tudo o que costumava ser fixado no topo agora 
foi puxado para baixo. Isso não é um erro ou um bug de Layout Automático, mas é o resultado natural de 
todas as regras que estabelecemos:

- Nossa visualização de botões deve ser fixada na parte inferior e ter exatamente 320 pontos de altura.

- O botão enviar deve estar acima da visualização de botões.

- O campo de texto de resposta atual deve estar acima do botão Enviar.

- O rótulo de respostas deve estar acima do campo de texto de resposta atual.

- O rótulo da pontuação deve estar acima do rótulo de respostas.

- O rótulo da pontuação deve ser fixado no topo da nossa visão.

Em suma, temos a visualização de botões fixada na parte inferior e o rótulo da pontuação fixado na parte superior, 
com todas as nossas outras visualizações no meio.

Antes de adicionarmos a visualização final dos botões, o Auto Layout não tinha ideia especial do tamanho de qualquer 
uma das visualizações, por isso usou algo chamado tamanho do conteúdo intrínseco - o tamanho de cada visualização 
precisa ser para mostrar seu conteúdo. Isso resultou em nossos pontos de vista sendo bem organizados no topo. Mas 
agora temos uma pilha vertical completa, fixada na parte superior e inferior, então o UIKit precisa preencher o 
espaço entre eles, estendendo uma ou mais visualizações.

Cada visualização em todos os nossos layouts do UIKit tem duas propriedades importantes que dizem ao UIKit como ele 
pode esmagá-los ou esticá-los para satisfazer restrições:

- A prioridade de abraço de conteúdo determina a probabilidade de essa visualização ser maior do que o tamanho 
do conteúdo intrínseco. Se essa prioridade for alta, significa que o Layout Automático prefere não esticá-lo; 
se for baixo, será mais provável que seja esticado.

- A prioridade de resistência à compressão de conteúdo determina o quanto estamos felizes por essa visualização 
ser menor do que seu tamanho de conteúdo intrínseco.

Ambos os valores têm um padrão: 250 para abraço de conteúdo e 750 para resistência à compressão de conteúdo. 
Lembre-se, prioridades mais altas significam que o Layout Automático trabalha mais difícil para satisfazê-las, 
para que você possa ver que as visualizações geralmente estão bastante felizes em serem esticadas, mas preferem 
não serem esmagadas. Como todas as visualizações têm as mesmas prioridades para esses dois valores, o Layout 
Automático é forçado a escolher um para esticar - a pontuação no topo.

Agora, tudo isso importa porque vamos ajustar a prioridade de abraço de conteúdo para nossos rótulos de pistas e 
respostas. Mais especificamente, vamos dar a eles uma prioridade de 1, de modo que, quando o Layout Automático tiver 
que decidir qual visualização esticar, eles são os primeiros da fila.

Add these two lines of code after the code that creates cluesLabel and answersLabel:

cluesLabel.setContentHuggingPriority(UILayoutPriority(1), for: .vertical)
answersLabel.setContentHuggingPriority(UILayoutPriority(1), for: .vertical)

Execute o aplicativo agora e você verá uma grande diferença: os dois rótulos agora ocupam muito mais espaço, e o 
resto da nossa interface de usuário parece mais normal.

Agora que nossa interface de usuário parece como deveria, vamos criar a parte final do nosso layout: os botões 
de letra que ficam dentro dos buttonsView.

Temos 20 botões para criar em quatro linhas e cinco colunas, o que é o momento perfeito para usar alguns loops 
aninhados: crie e configure cada botão e, em seguida, posicione-o dentro da visualização de botões.

However, we’re going to rely on a lovely feature of Auto Layout to make this whole process much easier: we’re 
not going to set translatesAutoresizingMaskIntoConstraints to false for these buttons, which means we can give 
them a specific position and size and have UIKit figure out the constraints for us.

Então, essa criação real de botões não é tão difícil quanto você imagina:

1. Defina constantes para representar a largura e a altura dos nossos botões para facilitar a referência.

2. Percorra as linhas 0, 1, 2 e 3.

3. Percorra as colunas 0, 1, 2, 3 e 4.

4. Crie um novo botão com uma fonte agradável e grande - podemos ajustar a fonte do rótulo de um botão 
usando a propriedade itstitleLabel.

5. Calcule a posição X do botão como sendo nosso número de coluna multiplicado pela largura do botão.

6. Calcule a posição Y do botão como sendo nosso número de linha multiplicado pela altura do botão.

7. Add the button to our buttonsView rather than the main view.

As a bonus, we’re going to add each button to our letterButtons array as we create them, so that we can 
control them later in the game.

Calculating positions of views by hand isn’t something we’ve done before, because we’ve been relying on Auto 
Layout for everything. However, it’s no harder than sketching something out on graph paper: we create a 
rectangular frame that has X and Y coordinates plus width and height, then assign that to the frame property 
of our view. These rectangles have a special type called CGRect, because they come from Core Graphics.

Por exemplo, calcularemos a posição X de um botão multiplicando nossa largura fixa do botão (150) pela posição 
da coluna. Então, para a coluna 0 que dará uma coordenada X de 150x0, que é 0, e para a coluna 1 que dará uma 
coordenada X de 150x1, que é 150 - eles se alinharão ordenadamente.

Adicione este código após a chamada para NSLayoutConstraint.activate():

// set some values for the width and height of each button
let width = 150
let height = 80

// create 20 buttons as a 4x5 grid
for row in 0..<4 {
    for col in 0..<5 {
        // create a new button and give it a big font size
        let letterButton = UIButton(type: .system)
        letterButton.titleLabel?.font = UIFont.systemFont(ofSize: 36)

        // give the button some temporary text so we can see it on-screen
        letterButton.setTitle("WWW", for: .normal)

        // calculate the frame of this button using its column and row
        let frame = CGRect(x: col * width, y: row * height, width: width, height: height)
        letterButton.frame = frame

        // add it to the buttons view
        buttonsView.addSubview(letterButton)

        // and also to our letterButtons array
        letterButtons.append(letterButton)
    }
}

That’s the last of our code complete, so please remove the temporary background colors we gave to cluesLabel, 
answersLabel, and buttonsView, then run your code to see how it all looks.

Valeu a pena?

Ao construir esta interface do usuário, é possível que você tenha parado mais de uma vez e pensado consigo mesmo 
"isso realmente vale a pena?" Certamente é verdade que construir essa interface de usuário em um storyboard teria 
sido mais fácil, mas aprender a construir interfaces de usuário em código é uma habilidade muito importante.



