27/05/2022


PROJECT 2, PART TWO


---------- 1. GUESS WHICH FLAG: RANDOM NUMBERS 

Nosso código atual escolhe os três primeiros itens na matriz de países e os coloca nos três botões do nosso controlador 
de visualização. Isso é bom para começar, mas realmente precisamos escolher países aleatórios de cada vez. 
Existem duas maneiras de fazer isso:

1. Escolha três números aleatórios e use-os para ler os sinalizadores da matriz.

2. Embaralhe a ordem da matriz e, em seguida, escolha os três primeiros itens.

Ambas as abordagens são válidas, mas a primeira dá um pouco mais de trabalho porque precisamos garantir que 
todos os três números sejam diferentes - este jogo seria ainda menos divertido se todas as três bandeiras fossem as mesmas!

The second approach is easier to do, because Swift has built-in methods for shuffling arrays: shuffle() for in-place shuffling, 
and shuffled() to return a new, shuffled array.

No início do método askQuestion(), pouco antes de chamar o primeiro método setImage(), adicione esta linha de código:

countries.shuffle()

That will automatically randomize the order of the countries in the array, meaning that countries[0], countries[1] 
and countries[2] will refer to different flags each time the askQuestion() method is called. To try it out, press Cmd+R 
to run your program a few times to see different flags each time.

O próximo passo é rastrear qual resposta deve ser a correta e, para isso, criaremos uma nova propriedade para o nosso 
controlador de visualização chamada correctAnswer. Coloque isso perto do topo, logo acima da var score = 0:

var correctAnswer = 0

Isso nos dá uma nova propriedade inteira que armazenará se é a bandeira 0, 1 ou 2 que contém a resposta correta.

To choose which should be the right answer requires using Swift’s random system again, because we need to choose a 
random number for the correct answer. All Swift’s numeric types, such as Int, Double, and CGFloat, have a random(in:) 
method that generates a random number in a range. So, to generate a random number between 0 and 2 inclusive you need 
to put this line just below the three setImage() calls in askQuestion():

correctAnswer = Int.random(in: 0...2)

Now that we have the correct answer, we just need to put its text into the navigation bar. This can be done by 
using the title property of our view controller, but we need to add one more thing: we don't want to write "france" 
or "uk" in the navigation bar, because it looks ugly. We could capitalize the first letter, and that would work great 
for France, Germany, and so on, but it would look poor for “Us” and “Uk”, which should be “US” and “UK”.

The solution here is simple: uppercase the entire string. This is done using the uppercased() method of any string, 
so all we need to do is read the string out from the countries array at the position of correctAnswer, then uppercase 
it. Add this to the end of the askQuestion() method, just after correctAnswer is set:

title = countries[correctAnswer].uppercased()

Com isso feito, você pode executar o jogo e agora é quase jogável: você receberá três bandeiras diferentes de cada 
vez, e a bandeira em que o jogador precisa tocar terá seu nome mostrado na parte superior.

Claro, falta uma peça: o usuário pode tocar nos botões da bandeira, mas na verdade não faz nada. Vamos consertar isso...



---------- 2. FROM OUTLETS TO ACTIONS: CREATING AN IBAction 

I said we'd return to Interface Builder, and now the time has come: we're going to connect the "tap" action of 
our UIButtons to some code. So, select Main.storyboard, then change to the assistant editor so you can see the 
code alongside the layout.

Aviso: leia o seguinte texto com muita atenção. Na minha pressa, eu estrago tudo o tempo todo, e não quero que isso te confunda!

Selecione o primeiro botão e, em seguida, Ctrl+arrastar dele para baixo para o espaço em seu código imediatamente 
após o final do método askQuestion(). Se você estiver fazendo isso corretamente, verá uma dica de ferramenta dizendo: 
"Inserir Outlet, Action ou Outlet Collection". Quando você soltar, verá o mesmo pop-up que normalmente vê ao criar 
tomadas, mas aqui está o problema: não escolha a saída.

Isso mesmo: onde diz "Conexão: Tomada" na parte superior do pop-up, quero que você mude isso para "Ação". Se você escolher 
o Outlet aqui (o que eu faço com muita frequência porque estou com pressa), você causará problemas para si mesmo!

When you choose Action rather than Outlet, the popup changes a little. You'll still get asked for a name, but now you'll 
see an Event field, and the Type field has changed from UIButton to Any. Please change Type back to UIButton, then enter 
buttonTapped for the name, and click Connect.

Veja o que o Xcode escreverá para você:

@IBAction func buttonTapped(_ sender: UIButton) {
}

...e, novamente, observe o círculo cinza com um anel ao redor dele à esquerda, o que significa que isso tem uma conexão no Interface Builder.

Before we look at what this is doing, I want you to make two more connections. This time it's a bit different, 
because we're connecting the other two flag buttons to the same buttonTapped() method. To do that, select each 
of the remaining two buttons, then Ctrl-drag onto the buttonTapped() method that was just created. The whole 
method will turn blue signifying that it's going to be connected, so you can just let go to make it happen. 
If the method flashes after you let go, it means the connection was made.

Então, o que temos? Bem, temos um único método chamado buttonTapped(), que está conectado a todos os três UIButton. 
O evento usado para o anexo é chamado TouchUpInside, que é a maneira iOS de dizer: "o usuário tocou neste botão e, 
em seguida, soltou o dedo enquanto ainda estava sobre ele" - ou seja, o botão foi tocado.

Again, Xcode has inserted an attribute to the start of this line so it knows that this is relevant to Interface Builder, 
and this time it's @IBAction. @IBAction is similar to @IBOutlet, but goes the other way: @IBOutlet is a way of connecting 
code to storyboard layouts, and @IBAction is a way of making storyboard layouts trigger code.

This method takes one parameter, called sender. It's of type UIButton because we know that's what will be calling the 
method. And this is important: all three buttons are calling the same method, so it's important we know which button was 
tapped so we can judge whether the answer was correct.

Mas como sabemos se o botão correto foi tocado? No momento, todos os botões parecem iguais, mas nos bastidores todas as 
visualizações têm um número de identificação especial que podemos definir, chamado Tag. Este pode ser qualquer número que 
você quiser, então vamos dar aos nossos botões os números 0, 1 e 2. Isso não é uma coincidência: nosso código já está 
definido para colocar os sinalizadores 0, 1 e 2 nesses botões, portanto, se dermos a eles as mesmas tags, saberemos 
exatamente qual sinalizador foi tocado.

Selecione o segundo sinalizador (não o primeiro!) e procure no inspetor de atributos (Alt+Cmd+4) a caixa de entrada marcada 
Tag. Talvez você precise rolar para baixo, porque os UIButton têm muitas propriedades para trabalhar! Depois de encontrá-lo 
(é cerca de dois terços do caminho para baixo, logo acima das propriedades de cor e alfa), verifique se está definido como 1.

Agora escolha o terceiro sinalizador e defina sua tag como 2. Não precisamos alterar a tag do primeiro sinalizador porque 0 é o padrão.

Terminamos o Interface Builder por enquanto, então volte para o editor padrão e selecione ViewController.swift - é hora 
de terminar preenchendo o conteúdo do método buttonTapped().

Este método precisa fazer três coisas:

1. Verifique se a resposta estava correta.

2. Ajuste a pontuação do jogador para cima ou para baixo.

3. Mostre uma mensagem dizendo a eles qual é a nova pontuação deles.

The first task is quite simple, because each button has a tag matching its position in the array, and we 
stored the position of the correct answer in the correctAnswer variable. So, the answer is correct if sender.tag 
is equal to correctAnswer.

The second task is also simple, because you've already met the += operator that adds to a value. We'll be using 
that and its counterpart, -=, to add or subtract score as needed. The third task is more complicated, so we're 
going to come to it in a minute.

Coloque este código no método buttonTapped():

var title: String

if sender.tag == correctAnswer {
    title = "Correct"
    score += 1
} else {
    title = "Wrong"
    score -= 1
}

Agora, para a parte difícil: vamos usar um novo tipo de dados chamado UIAlertController(). Isso é usado para mostrar 
um alerta com opções para o usuário. Para fazer isso funcionar, você precisará usar um fechamento - algo que você 
aprendeu em teoria, mas finalmente pode usar na prática.

Se você se lembra, closures é um tipo especial de bloco de código que pode ser usado como uma variável - Swift literalmente 
pega uma cópia do bloco de código para que ele possa ser chamado mais tarde. Swift também copia qualquer coisa mencionada 
dentro do código, então você precisa ter cuidado com a forma como usá-la. Usaremos fechamentos extensivamente mais tarde, 
mas por enquanto usaremos dois atalhos.

Digite isso pouco antes do final do método buttonTapped():

let ac = UIAlertController(title: title, message: "Your score is \(score).", preferredStyle: .alert)
ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion))
present(ac, animated: true)

Esse código produzirá um erro por um momento, mas tudo bem.

The title variable was set in our if statement to be either "correct" or "wrong", and you've already learned about 
string interpolation, so the first new thing there is the .alert parameter being used for preferredStyle. UIAlertController() 
gives us two kinds of style: .alert, which pops up a message box over the center of the screen, and .actionSheet, which 
slides options up from the bottom. They are similar, but Apple recommends you use .alert when telling users about a 
situation change, and .actionSheet when asking them to choose from a set of options.

The second line uses the UIAlertAction data type to add a button to the alert that says "Continue", and gives it the 
style “default". There are three possible styles: .default, .cancel, and .destructive. What these look like depends 
on iOS, but it's important you use them appropriately because they provide subtle user interface hints to users.

The sting in the tail is at the end of that line: handler: askQuestion. The handler parameter is looking for a closure, 
which is some code that it can execute when the button is tapped. You can write custom code in there if you want, but 
in our case we want the game to continue when the button is tapped, so we pass in askQuestion so that iOS will call 
our askQuestion() method.

Warning: We must use askQuestion and not askQuestion(). If you use the former, it means "here's the name of the method to run," 
but if you use the latter it means "run the askQuestion() method now, and it will tell you the name of the method to run."

There are many good reasons to use closures, but in the example here just passing in askQuestion is a neat shortcut – 
although it does break something that we'll need to fix in a moment.

The final line calls present(), which takes two parameters: a view controller to present and whether to animate the presentation. 
It has an optional third parameter that is another closure that should be executed when the presentation animation has finished, 
but we don’t need it here. We send our UIAlertController for the first parameter, and true for the second because animation 
is always nice.

Antes que o código seja concluído, há um problema, e o Xcode provavelmente está dizendo o que é: "Não é possível converter o 
valor do tipo '() -> ()' para o tipo de argumento esperado '((UIAlertAction) -> Void)?'."

This is a good example of Swift's terrible error messages, and it's something I'm afraid you'll have to get used to. What 
it means to say is that using a method for this closure is fine, but Swift wants the method to accept a UIAlertAction parameter 
saying which UIAlertAction was tapped.

To make this problem go away, we need to change the way the askQuestion() method is defined. So, scroll up and change 
askQuestion() from this:

func askQuestion() {

...para isso:

func askQuestion(action: UIAlertAction!) {

That will fix the UIAlertAction error. However, it will introduce another problem: when the app first runs, 
we call askQuestion() inside viewDidLoad(), and we don't pass it a parameter. There are two ways to fix this:

When using askQuestion() in viewDidLoad(), we could send it the parameter nil to mean "there is no UIAlertAction for this."

We could redefine askQuestion() so that the action has a default parameter of nil, meaning that if it isn't specified 
it automatically becomes nil.

There's no right or wrong answer here, so I'll show you both and you can choose. If you want to go with the first option, 
change the askQuestion() call in viewDidLoad() to this:

askQuestion(action: nil)

And if you want to go with the second option, change the askQuestion() method definition to this:

func askQuestion(action: UIAlertAction! = nil) {

Agora, vá em frente e execute seu programa no simulador, porque está feito!