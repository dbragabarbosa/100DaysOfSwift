08/09/2022


PROJECT 11, PART ONE 


É hora de outro projeto de jogo, mas desta vez faremos algo bem diferente: não usaremos o UIKit. Em vez disso, usaremos 
o SpriteKit, que é o kit de ferramentas de desenho de alto desempenho da Apple que nos permite criar jogos 2D avançados 
com relativa facilidade.

Por um lado, isso significa que você estará aprendendo um monte de novas habilidades úteis, como detectar toques, como 
adicionar física e muito mais. Por outro lado, pode parecer um pouco desconcertante no início, porque a maior parte do 
conhecimento do UIKit que você acumulou até agora não será usado - você precisa aprender a se adaptar à maneira de 
trabalhar do SpriteKit.

É aqui que se torna mais importante do que nunca trabalhar duro. Aqui está uma citação de Michael Jordan, que sabe mais 
do que sua parte, tanto sobre a importância dos jogos quanto sobre a importância do trabalho duro diante da adversidade:

“Eu perdi mais de 9000 tiros na minha carreira. Perdi quase 300 jogos. 26 vezes, fui confiável para tirar o tiro vencedor 
do jogo e perdi. Eu falhei uma e outra vez na minha vida. E é por isso que eu tenho sucesso.”

O sucesso é algo pelo qual você precisa lutar. Espero que hoje pareça mais divertido do que lutar, mas não se surpreenda 
se você voltar ao projeto 12 com um novo interesse em voltar ao UIKit!

Today you have three topics to work through, and you’ll learn about SKSpriteNode, SKPhysicsBody, and more.



---------- Setting up 

Este projeto vai parecer um pouco de reset para você, porque vamos voltar ao básico. Isso não é porque eu gosto de me 
repetir, mas sim porque você vai aprender uma tecnologia totalmente nova chamada SpriteKit.

Até agora, tudo o que você fez foi baseado no UIKit, o kit de ferramentas de interface de usuário da Apple para iOS. 
Fizemos vários jogos com ele, e ele realmente é muito poderoso, mas até o UIKit tem seus limites - e os jogos 2D não 
são seu ponto forte.

Uma solução muito melhor é chamada SpriteKit, e é o kit de ferramentas rápido e fácil da Apple projetado especificamente 
para jogos 2D. Inclui sprites, fontes, física, efeitos de partículas e muito mais, e é integrado a todos os dispositivos 
iOS. O que é não gostar?

Então, este vai ser um longo tutorial porque você vai aprender muito. Para ajudar a mantê-lo são, tentei tornar o projeto 
o mais iterativo possível. Isso significa que vamos fazer uma pequena mudança e discutir os resultados, depois fazer outra 
pequena mudança e discutir os resultados, até que o projeto seja concluído.

E o que estamos construindo? Bem, vamos produzir um jogo semelhante ao pachinko, embora muitas pessoas o conheçam pelo 
nome "Peggle". Para começar, crie um novo projeto no Xcode e escolha Jogo. Nomeie-o Project11, defina sua Tecnologia de 
Jogos como SpriteKit e, em seguida, certifique-se de que todas as caixas de seleção estejam desmarcadas antes de salvá-lo 
em algum lugar.

Antes de começarmos, configure seu projeto para que ele seja executado apenas para iPads no modo paisagem.

Aviso: Ao trabalhar com projetos SpriteKit, recomendo fortemente que você use um dispositivo real para testar seus 
projetos, porque o simulador do iPad é extraordinariamente lento para jogos. Se você não tiver um dispositivo, escolha 
o simulador de iPad de menor especificação disponível para você, mas esteja preparado para um desempenho terrível que 
não seja indicativo de um dispositivo real.



---------- Falling boxes: SKSpriteNode, UITouch, SKPhysicsBody 

A primeira coisa que você deve fazer é executar seu jogo e ver como é um jogo de modelo padrão do SpriteKit. Você deve 
ver uma grande janela cinza dizendo "Olá, Mundo!", e quando você toca em duas caixas giratórias devem aparecer. No canto 
inferior direito está uma contagem de nós (quantas coisas estão na tela agora) e uma taxa de quadros. Você está visando 
60 quadros por segundo o tempo todo, se possível.

No navegador do projeto, encontre e abra o GameScene.swift e substitua todo o seu conteúdo com este:

import SpriteKit

class GameScene: SKScene {
    override func didMove(to view: SKView) {
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    }
}

Isso remove quase todo o código, porque simplesmente não é necessário.

O equivalente do SpriteKit de Interface Builder é chamado de Editor de Cena, e é onde está o grande rótulo “Hello World”. 
Selecione GameScene.sks para abrir o editor de cenas agora, clique no rótulo "Hello World" e exclua-o.

Enquanto você estiver no editor de cenas, há mais uma mudança que eu gostaria de fazer, e isso ajudará a simplificar um 
pouco nosso posicionamento. Com a cena selecionada, olhe no inspetor de atributos (nota: seu ícone é diferente aqui!) 
para Anchor Point. Isso determina quais coordenadas o SpriteKit usa para posicionar os filhos e é X:0.5 Y:0.5 por padrão.

Isso é diferente do UIKit: significa “posicione-me com base no meu centro”, enquanto o UIKit posiciona as coisas com base 
no canto superior esquerdo. Isso geralmente é bom, mas ao trabalhar com a cena principal, é mais fácil definir esse valor 
como X:0 Y:0. Então, por favor, faça essa alteração agora - o ponto de ancoragem deve ser 0 para X e Y.

Nota: O SpriteKit considera que Y:0 é a parte inferior da tela, enquanto o UIKit considera que é a parte superior - oi 
pela uniformidade!

Eu também gostaria que você mudasse o tamanho da cena, que está logo acima do ponto âncora. Isso provavelmente é 750x1334 
por padrão; altere-o para 1024x768 para corresponder ao tamanho da paisagem do iPad.

Dica: O iPad de 9,7 polegadas tem 1024 pontos de largura e 768 de altura, mas os de 10,5 polegadas e 12,9 polegadas são 
maiores. De forma útil, o SpriteKit cuida disso para nós: acabamos de pedir uma tela 1024x768 e ela nos dará uma, 
independentemente do dispositivo em que nosso jogo é executado - legal!

A última alteração que eu gostaria que você fizesse é selecionar Actions.sks e tocar no botão de backspace para excluí-lo 
- selecione "Mover para o Lixo" quando o Xcode perguntar o que você deseja fazer.

Todas essas mudanças limparam efetivamente o projeto, redefinindo-o de volta a um estado de baunilha no qual podemos 
construir.

Com o material do modelo excluído, eu gostaria que você importasse os ativos para o projeto. Se você ainda não baixou 
o código para este projeto, faça-o agora. Você deve copiar toda a pasta Conteúdo do projeto de exemplo para o seu próprio, 
certificando-se de que a caixa "Copiar itens, se necessário" esteja marcada.

Vamos começar este projeto abandonando o fundo simples e substituindo-o por uma imagem. Se você quiser colocar uma imagem 
no seu jogo, a classe a ser usada é chamada SKSpriteNode, e pode carregar qualquer imagem do seu pacote de aplicativos, 
assim como UIImage.

Para colocar uma imagem de fundo, precisamos carregar o arquivo chamado background.jpg e, em seguida, posicioná-lo no 
centro da tela. Lembre-se, ao contrário do UIKit SpriteKit posiciona as coisas com base em seu centro - ou seja, o ponto 
0,0 refere-se ao centro horizontal e vertical de um nó. E também ao contrário do UIKit, o eixo Y do SpriteKit começa na 
borda inferior, então um número Y maior coloca um nó mais alto na tela. Então, para colocar a imagem de fundo no centro 
de um iPad paisagem, precisamos colocá-la na posição X:512, Y:384.

We're going to do two more things, both of which are only needed for this background. First, we're going to give it the 
blend mode .replace. Blend modes determine how a node is drawn, and SpriteKit gives you many options. The .replace option 
means "just draw it, ignoring any alpha values," which makes it fast for things without gaps such as our background. We're 
also going to give the background a zPosition of -1, which in our game means "draw this behind everything else."

To add any node to the current screen, you use the addChild() method. As you might expect, SpriteKit doesn't use 
UIViewController like our UIKit apps have done. Yes, there is a view controller in your project, but it's there to host 
your SpriteKit game. The equivalent of screens in SpriteKit are called scenes.

Quando você adiciona um nó à sua cena, ele se torna parte da árvore de nós. Usando addChild(), você pode adicionar nós 
a outros nós para fazer uma árvore mais complicada, mas neste jogo vamos mantê-lo simples.

Add this code to the didMove(to:) method, which is sort of the equivalent of SpriteKit's viewDidLoad() method:

let background = SKSpriteNode(imageNamed: "background.jpg")
background.position = CGPoint(x: 512, y: 384)
background.blendMode = .replace
background.zPosition = -1
addChild(background)

Se você executar o aplicativo agora, verá uma imagem azul escuro para o fundo em vez de cinza liso - dificilmente uma 
melhoria maciça, mas isso é apenas o começo.

Vamos fazer algo um pouco mais interessante, então adicione isso ao método touchesBegan():

if let touch = touches.first {
    let location = touch.location(in: self)
    let box = SKSpriteNode(color: UIColor.red, size: CGSize(width: 64, height: 64))
    box.position = location
    addChild(box)
}

We haven't used touchesBegan() before, so the first two lines needs to be explained. This method gets called (in UIKit 
and SpriteKit) whenever someone starts touching their device. It's possible they started touching with multiple fingers 
at the same time, so we get passed a new data type called Set. This is just like an array, except each object can appear 
only once.

We want to know where the screen was touched, so we use a conditional typecast plus if let to pull out any of the screen 
touches from the touches set, then use its location(in:) method to find out where the screen was touched in relation to 
self - i.e., the game scene. UITouch is a UIKit class that is also used in SpriteKit, and provides information about a 
touch such as its position and when it happened.

The third line is also new, but it's still SKSpriteNode. We're just writing some example code for now, so this line 
generates a node filled with a color (red) at a size (64x64). The CGSize struct is new, but also simple: it just holds 
a width and a height in a single structure.

O código define a posição da nova caixa para estar onde a torneira aconteceu e, em seguida, a adiciona à cena. Chega de 
conversa: pressione Cmd+R para garantir que tudo funcione e, em seguida, toque na tela para fazer as caixas aparecerem.

OK, eu admito: isso ainda é muito chato. Vamos torná-lo ainda mais interessante - você está pronto para ver o quão 
poderoso o SpriteKit é? Pouco antes de definir a posição da nossa nova caixa, adicione esta linha:

box.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 64, height: 64))
And just before the end of didMove(to:), add this:

physicsBody = SKPhysicsBody(edgeLoopFrom: frame)

A primeira linha de código adiciona um corpo físico à caixa que é um retângulo do mesmo tamanho da caixa. A segunda linha 
de código adiciona um corpo físico a toda a cena que é uma linha em cada borda, agindo efetivamente como um recipiente 
para a cena.

Se você executar a cena agora, espero que não possa deixar de ficar impressionado: você pode tocar na tela para criar 
caixas, mas agora elas cairão no chão e saltarão. Eles também se acumularão à medida que você toca com mais frequência 
e cairão de forma realista se o seu objetivo não estiver certo.

Este é o poder do SpriteKit: é tão rápido e fácil fazer jogos que realmente não há nada que o impeça. Mas estamos apenas 
nos aquecendo!



---------- Bouncing balls: circleOfRadius 

You're not going to get rich out of red rectangles, so let's use balls instead. Take the box code out (everything after 
let location = in touchesBegan()) and replace it with this instead:

let ball = SKSpriteNode(imageNamed: "ballRed")
ball.physicsBody = SKPhysicsBody(circleOfRadius: ball.size.width / 2.0)
ball.physicsBody?.restitution = 0.4
ball.position = location
addChild(ball)

There are two new things there. First, we're using the circleOfRadius initializer for SKPhysicsBody to add circular 
physics to this ball, because using rectangles would look strange. Second, we're giving the ball's physics body a 
restitution (bounciness) level of 0.4, where values are from 0 to 1.

Nota: o corpo físico de um nó é opcional, porque pode não existir. Sabemos que existe porque acabamos de criá-lo, então 
não é incomum ver o physicsBody! para forçar o desembrulho do opcional.

Quando você executar o jogo agora, poderá tocar na tela para soltar bolas insufláveis. É fracionalmente mais 
interessante, mas vamos enfrentá-lo: este ainda é um jogo terrível.

Para torná-lo mais emocionante, vamos adicionar algo para as bolas saltarem. Na pasta Conteúdo que lhe forneci há uma 
imagem chamada "bouncer.png", então vamos colocar isso no jogo agora.

Just before the end of the didMove(to:) method, add this:

let bouncer = SKSpriteNode(imageNamed: "bouncer")
bouncer.position = CGPoint(x: 512, y: 0)
bouncer.physicsBody = SKPhysicsBody(circleOfRadius: bouncer.size.width / 2.0)
bouncer.physicsBody?.isDynamic = false
addChild(bouncer)

Há um novo tipo de dados lá chamado CGPoint, mas, como o CGSize, é muito simples: ele apenas contém coordenadas X/Y. 
Lembre-se, as posições do SpriteKit começam a partir do centro dos nós, então X:512 Y:0 significa "centrado horizontalmente 
na borda inferior da cena".

Also new is the isDynamic property of a physics body. When this is true, the object will be moved by the physics 
simulator based on gravity and collisions. When it's false (as we're setting it) the object will still collide with 
other things, but it won't ever be moved as a result.

Usando este código, o nó bouncer será colocado na tela e suas bolas podem colidir com ele - mas não se moverá. 
Experimente agora.

Adicionar um segurança levou cinco linhas de código, mas nosso jogo precisa de mais de um segurança. Na verdade, eu 
quero cinco deles, uniformemente distribuídos pela tela. Agora, você pode simplesmente copiar e colar o código cinco 
vezes e depois alterar as posições, mas espero que você perceba que há uma maneira melhor: criar um método que faça 
todo o trabalho e, em seguida, chamar esse método toda vez que quisermos um segurança.

The method code itself is nearly identical to what you just wrote, with the only change being that we need to position 
the box at the CGPoint specified as a parameter:

func makeBouncer(at position: CGPoint) {
    let bouncer = SKSpriteNode(imageNamed: "bouncer")
    bouncer.position = position
    bouncer.physicsBody = SKPhysicsBody(circleOfRadius: bouncer.size.width / 2.0)
    bouncer.physicsBody?.isDynamic = false
    addChild(bouncer)
}

With that method in place, you can place a bouncer in one line of code: just call makeBouncer(at:) with a position, 
and it will be placed and given a non-dynamic physics body automatically.

You might have noticed that the parameter to makeBouncer(at:) has two names: at and position. This isn’t required, but 
it makes your code more readable: the first name is the one you use when calling the method, and the second name is the 
one you use inside the method. That is, you write makeBouncer(at:) to call it, but inside the method the parameter is 
named position rather than at. This is identical to cellForRowAt indexPath in table views.

To show this off, delete the bouncer code from didMove(to:), and replace it with this:

makeBouncer(at: CGPoint(x: 0, y: 0))
makeBouncer(at: CGPoint(x: 256, y: 0))
makeBouncer(at: CGPoint(x: 512, y: 0))
makeBouncer(at: CGPoint(x: 768, y: 0))
makeBouncer(at: CGPoint(x: 1024, y: 0))

Se você executar o jogo agora, verá cinco seguranças uniformemente espalhados pela tela, e as bolas que você deixar 
saltam em qualquer uma delas. Ainda não é um jogo, mas estamos chegando lá. Agora, para adicionar algo entre os seguranças...