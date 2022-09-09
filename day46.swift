09/09/2022


Project 11, part two 


“In the beginning there was nothing, which exploded.” That’s a quote from Terry Pratchett’s book Lords and Ladies, and gives 
us an inkling of just how complicated physics is in the real world.

Fortunately, SpriteKit’s version of physics is much easier. You’ve already seen how it lets us create boxes and balls easily 
enough, but today we’re going to look at the way it reports collisions back to us so we can take action.

This does mean learning a few new things, but I’ve tried to take a few shortcuts to lessen the learning curve. I’m not 
skipping them entirely, though: we’re going to return to concepts such as bitmasks in future days, because they are important.

Today you have three topics to work through, and you’ll learn about SKAction, SKPhysicsContactDelegate, SKLabelNode, and more.



---------- Spinning slots: SKAction 

O objetivo do jogo será soltar suas bolas de tal forma que elas caiam em slots bons e não ruins. Temos seguranças no lugar, mas 
precisamos preencher as lacunas entre eles com algo para que o jogador saiba para onde mirar.

Vamos preencher as lacunas com dois tipos de slots de destino: bons (de cor verde) e ruins (de cor vermelha). Tal como acontece 
com os seguranças, precisaremos colocar alguns desses, o que significa que precisamos fazer um método. Isso precisa carregar o 
gráfico base do slot, posicioná-lo onde dissemos e, em seguida, adicioná-lo à cena, assim:

func makeSlot(at position: CGPoint, isGood: Bool) {
    var slotBase: SKSpriteNode

    if isGood {
        slotBase = SKSpriteNode(imageNamed: "slotBaseGood")
    } else {
        slotBase = SKSpriteNode(imageNamed: "slotBaseBad")
    }

    slotBase.position = position
    addChild(slotBase)
}

Unlike makeBouncer(at:), this method has a second parameter – whether the slot is good or not – and that affects which image 
gets loaded. But first, we need to call the new method, so add these lines just before the calls to makeBouncer(at:) in didMove(to:):

makeSlot(at: CGPoint(x: 128, y: 0), isGood: true)
makeSlot(at: CGPoint(x: 384, y: 0), isGood: false)
makeSlot(at: CGPoint(x: 640, y: 0), isGood: true)
makeSlot(at: CGPoint(x: 896, y: 0), isGood: false)

As posições X estão exatamente entre os seguranças, então, se você executar o jogo agora, verá segurança / slot / segurança 
/ slot e assim por diante.

Uma das coisas óbvias, mas agradáveis, sobre o uso de métodos para criar os seguranças e slots é que, se quisermos mudar a 
aparência dos slots, só precisamos alterá-lo em um só lugar. Por exemplo, podemos fazer com que as cores do slot pareçam mais 
óbvias adicionando uma imagem brilhante atrás delas:

func makeSlot(at position: CGPoint, isGood: Bool) {
    var slotBase: SKSpriteNode
    var slotGlow: SKSpriteNode

    if isGood {
        slotBase = SKSpriteNode(imageNamed: "slotBaseGood")
        slotGlow = SKSpriteNode(imageNamed: "slotGlowGood")
    } else {
        slotBase = SKSpriteNode(imageNamed: "slotBaseBad")
        slotGlow = SKSpriteNode(imageNamed: "slotGlowBad")
    }

    slotBase.position = position
    slotGlow.position = position

    addChild(slotBase)
    addChild(slotGlow)
}

Isso basicamente dobra todas as linhas de código, alterando "Base" para "Glow", mas o resultado final é bastante agradável 
e está claro agora quais slots são bons e quais são ruins.

Poderíamos até fazer os slots girarem lentamente usando uma nova classe chamada SKAction. As ações do SpriteKit são 
ridiculamente poderosas e vamos fazer algumas coisas boas com elas em projetos posteriores, mas por enquanto só queremos 
que o brilho gire muito suavemente.

Antes de olharmos para o código para que isso aconteça, você precisa aprender algumas coisas antecipadamente:

- Os ângulos são especificados em radianos, não em graus. Isso também é verdade no UIKit. 360 graus é igual ao valor 
de 2 x Pi - ou seja, o valor matemático π. Portanto, os raios π são iguais a 180 graus.

- Em vez de tentar memorizá-lo, há um valor interno de π chamado CGFloat.pi.

- Yes CGFloat is yet another way of representing decimal numbers, just like Double and Float. Behind the scenes, CGFloat 
can be either a Double or a Float depending on the device your code runs on. Swift also has Double.pi and Float.pi for 
when you need it at different precisions.

- When you create an action it will execute once. If you want it to run forever, you create another action to wrap the 
first using the repeatForever() method, then run that.

Our new code will rotate the node by 180 degrees (available as the constant CGFloat.pi or just .pi) over 10 seconds, 
repeating forever. Put this code just before the end of the makeSlot(at:) method:

let spin = SKAction.rotate(byAngle: .pi, duration: 10)
let spinForever = SKAction.repeatForever(spin)
slotGlow.run(spinForever)

Se você executar o jogo agora, verá que o brilho gira muito suavemente. É um efeito simples, mas faz uma grande diferença.



---------- Collision detection: SKPhysicsContactDelegate

Apenas adicionando um corpo físico às bolas e seguranças, já temos alguma detecção de colisão porque os objetos 
saltam um do outro. Mas não está sendo detectado por nós, o que significa que não podemos fazer nada sobre isso.

Neste jogo, queremos que o jogador ganhe ou perca, dependendo de quantos slots verdes ou vermelhos ele acertar, 
então precisamos fazer algumas mudanças:

1. Adicione física de retângulo aos nossos slots.

2. Nomeie os slots para sabermos qual é qual, depois nomeie as bolas também.

3. Faça da nossa cena o delegado de contato do mundo da física - isso significa "nos diz quando o contato 
ocorre entre dois corpos".

4. Crie um método que lide com contatos e faça algo apropriado.

The first step is easy enough: add these two lines just before you call addChild() for slotBase:

slotBase.physicsBody = SKPhysicsBody(rectangleOf: slotBase.size)
slotBase.physicsBody?.isDynamic = false
A base do slot precisa ser não dinâmica porque não queremos que ela saia do caminho quando uma bola de jogador bate.

O segundo passo também é fácil, mas tem alguma explicação. Assim como no UIKit, é fácil armazenar uma variável 
apontando para nós específicos em sua cena para quando você quiser fazer algo acontecer, e há muitas vezes em 
que essa é a solução certa.

But for general use, Apple recommends assigning names to your nodes, then checking the name to see what node 
it is. We need to have three names in our code: good slots, bad slots and balls. This is really easy to do – 
just modify your makeSlot(at:) method so the SKSpriteNode creation looks like this:

if isGood {
    slotBase = SKSpriteNode(imageNamed: "slotBaseGood")
    slotGlow = SKSpriteNode(imageNamed: "slotGlowGood")
    slotBase.name = "good"
} else {
    slotBase = SKSpriteNode(imageNamed: "slotBaseBad")
    slotGlow = SKSpriteNode(imageNamed: "slotGlowBad")
    slotBase.name = "bad"
}

Em seguida, adicione isso ao código onde você cria as bolas:

ball.name = "ball"

Não precisamos nomear os seguranças, porque realmente não nos importamos quando suas colisões acontecem.

Now comes the tricky part, which is setting up our scene to be the contact delegate of the physics world. The 
initial change is easy: we just need to conform to the SKPhysicsContactDelegate protocol then assign the physics 
world's contactDelegate property to be our scene. But by default, you still won't get notified when things collide.

What we need to do is change the contactTestBitMask property of our physics objects, which sets the contact 
notifications we want to receive. This needs to introduce a whole new concept – bitmasks – and really it doesn't 
matter at this point, so we're going to take a shortcut for now, then return to it in a later project.

Vamos configurar todos os delegados de contato e máscaras agora. Primeiro, faça sua turma estar em conformidade 
com o protocolo SKPhysicsContactDelegate, modificando sua definição para isso:

class GameScene: SKScene, SKPhysicsContactDelegate {
Then assign the current scene to be the physics world's contact delegate by putting this line of code in didMove(to:), 
just below where we set the scene's physics body:

physicsWorld.contactDelegate = self

Now for our shortcut: we're going to tell all the ball nodes to set their contactTestBitMask property to be equal 
to their collisionBitMask. Two bitmasks, with confusingly similar names but quite different jobs.

The collisionBitMask bitmask means "which nodes should I bump into?" By default, it's set to everything, which is why 
our ball are already hitting each other and the bouncers. The contactTestBitMask bitmask means "which collisions do you 
want to know about?" and by default it's set to nothing. So by setting contactTestBitMask to the value of collisionBitMask 
we're saying, "tell me about every collision."

This isn't particularly efficient in complicated games, but it will make no difference at all in this current project. 
And, like I said, we'll return to this in a later project to explain more. Until then, add this line just before you 
set each ball's restitution property:

ball.physicsBody!.contactTestBitMask = ball.physicsBody!.collisionBitMask           

Essa é a única mudança necessária para detectarmos colisões, então agora é hora de escrever o código que faz o trabalho duro.

Mas primeiro, uma pequena explicação: quando ocorre contato entre dois corpos físicos, não sabemos em que ordem 
ele virá. Ou seja, a bola atingiu o slot, o slot atingiu a bola ou ambos aconteceram? Eu sei que isso soa como uma 
filosofia inútil, mas é importante porque precisamos saber qual é a bola!

Before looking at the actual contact method, I want to look at two other methods first, because this is our ultimate goal. 
The first one, collisionBetween() will be called when a ball collides with something else. The second one, destroy() is 
going to be called when we're finished with the ball and want to get rid of it.

Coloque esses novos métodos no seu código:

func collisionBetween(ball: SKNode, object: SKNode) {
    if object.name == "good" {
        destroy(ball: ball)
    } else if object.name == "bad" {
        destroy(ball: ball)
    }
}

func destroy(ball: SKNode) {
    ball.removeFromParent()
}

The removeFromParent() method removes a node from your node tree. Or, in plain English, it removes the node from your game.

Você pode olhar para isso e pensar que é totalmente redundante, porque não importa o que aconteça, é efetivamente 
o mesmo que escrever isso:

func collisionBetween(ball: SKNode, object: SKNode) {
    ball.removeFromParent()
}

Mas confie em mim: vamos fazer com que esses métodos façam mais em breve, então pegue agora e ele 
economizará a refatoração mais tarde.

With those two in place, our contact checking method almost writes itself. We'll get told which two bodies collided, 
and the contact method needs to determine which one is the ball so that it can call collisionBetween() with the correct 
parameters. This is as simple as checking the names of both properties to see which is the ball, so here's the new method 
to do contact checking:

func didBegin(_ contact: SKPhysicsContact) {
    if contact.bodyA.node?.name == "ball" {
        collisionBetween(ball: contact.bodyA.node!, object: contact.bodyB.node!)
    } else if contact.bodyB.node?.name == "ball" {
        collisionBetween(ball: contact.bodyB.node!, object: contact.bodyA.node!)
    }
}

If you're particularly observant, you may have noticed that we don't have a special case in there for when both bodies 
are balls – i.e., if one ball collides with another. This is because our collisionBetween() method will ignore that 
particular case, because it triggers code only if the other node is named "good" or "bad".

Execute o jogo agora e você começará a ver as coisas se juntando: você pode soltar bolas nos seguranças e eles saltarão, 
mas se eles tocarem em um dos slots bons ou ruins, as bolas serão destruídas. Funciona, mas é chato. Os jogadores querem 
marcar pontos para que sintam que conseguiram algo, mesmo que esse "algo" esteja apenas inseleando um número em uma CPU.

Antes de seguir em frente, quero voltar à minha pergunta filosófica de antes: “a bola atingiu o slot, o slot atingiu a 
bola ou ambos aconteceram?” Esse último caso não acontecerá o tempo todo, mas acontecerá às vezes, e é importante levar 
isso em conta.

Se o SpriteKit relatar uma colisão duas vezes - ou seja, "balque de tiro e bola de tiro" - então temos um problema. 
Veja esta linha de código:

collisionBetween(ball: contact.bodyA.node!, object: contact.bodyB.node!)

E agora esta linha de código:

ball.removeFromParent()

A primeira vez que o código é executado, forçamos o desembrulhar ambos os nós e removemos a bola - até agora tudo bem. 
A segunda vez que o código é executado (para a outra metade da mesma colisão), nosso problema acontece: tentamos forçar 
a desembrulhar algo que já removemos, e nosso jogo falhará.

To solve this, we’re going to rewrite the didBegin() method to be clearer and safer: we’ll use guard to ensure both 
bodyA and bodyB have nodes attached. If either of them don’t then this is a ghost collision and we can bail out immediately.

func didBegin(_ contact: SKPhysicsContact) {
    guard let nodeA = contact.bodyA.node else { return }
    guard let nodeB = contact.bodyB.node else { return }

    if nodeA.name == "ball" {
        collisionBetween(ball: nodeA, object: nodeB)
    } else if nodeB.name == "ball" {
        collisionBetween(ball: nodeB, object: nodeA)
    }
}

É preciso um pouco mais de explicação e um pouco mais de código, mas o resultado é mais seguro - 
e isso sempre vale a pena lutar!



---------- Scores on the board: SKLabelNode

Para fazer uma pontuação aparecer na tela, precisamos fazer duas coisas: criar um inteiro de pontuação que rastreie 
o próprio valor e, em seguida, criar um novo tipo de nó, SKLabelNode, que exiba o valor para os jogadores.

The SKLabelNode class is somewhat similar to UILabel in that it has a text property, a font, a position, an alignment, 
and so on. Plus we can use Swift's string interpolation to set the text of the label easily, and we're even going to 
use the property observers you learned about in project 8 to make the label update itself when the score value changes.

Declare essas propriedades no topo da sua classe:

var scoreLabel: SKLabelNode!

var score = 0 {
    didSet {
        scoreLabel.text = "Score: \(score)"
    }
}

We're going to use the Chalkduster font, then align the label to the right and position it on the top-right edge of 
the scene. Put this code into your didMove(to:) method, just before the end:

scoreLabel = SKLabelNode(fontNamed: "Chalkduster")
scoreLabel.text = "Score: 0"
scoreLabel.horizontalAlignmentMode = .right
scoreLabel.position = CGPoint(x: 980, y: 700)
addChild(scoreLabel)

That places the label into the scene, and the property observer automatically updates the label as the score value 
changes. But it's not complete yet because we don't ever modify the player's score. Fortunately, we already have 
places in the collisionBetween() method where we can do exactly that, so modify the method to this:

func collisionBetween(ball: SKNode, object: SKNode) {
    if object.name == "good" {
        destroy(ball: ball)
        score += 1
    } else if object.name == "bad" {
        destroy(ball: ball)
        score -= 1
    }
}

The += and -= operators add or subtract one to the variable depending on whether a good or bad slot was struck. 
When we change the variable, the property observer will spot the change and update the label.

Temos uma pontuação, então isso significa que os jogadores têm a conquista que estavam desejando, certo? Bem, não. 
Claramente, tudo o que é preciso para obter um número ainda maior do que as visualizações do YouTube do Gangnam Style 
é sentar e tocar na parte superior da tela diretamente acima de um slot verde.

Vamos adicionar algum desafio real: vamos deixar você colocar obstáculos entre o topo da cena e os slots na parte 
inferior, para que os jogadores tenham que posicionar suas bolas exatamente corretamente para saltar das coisas da 
maneira certa.

Para fazer isso funcionar, vamos adicionar mais duas propriedades. O primeiro conterá um rótulo que diz "Editar" ou 
"Concluído", e outro para conter um booleano que rastreie se estamos no modo de edição ou não. Adicione estes dois ao 
lado das propriedades de pontuação anteriores:

var editLabel: SKLabelNode!

var editingMode: Bool = false {
    didSet {
        if editingMode {
            editLabel.text = "Done"
        } else {
            editLabel.text = "Edit"
        }
    }
}

Then add this to didMove(to:) to create the edit label in the top-left corner of the scene:

editLabel = SKLabelNode(fontNamed: "Chalkduster")
editLabel.text = "Edit"
editLabel.position = CGPoint(x: 80, y: 700)
addChild(editLabel)

Isso é praticamente idêntico à criação do rótulo de pontuação, então nada para ver aqui. Estamos usando um observador 
de propriedade novamente para alterar automaticamente o texto do rótulo de edição quando o modo de edição for alterado.

Mas o que é novo é detectar se o usuário tocou no botão editar/feito ou está tentando criar uma bola. Para que isso 
funcione, vamos pedir ao SpriteKit que nos forneça uma lista de todos os nós no ponto que foi tocado e verifique se 
ele contém nosso rótulo de edição. Se isso acontecer, inverteremos o valor do nosso booleano editingMode; se isso não 
acontecer, queremos executar o código de criação de bola anterior.

We're going to insert this change just after let location = and before let ball =, i.e. right here:

let location = touch.location(in: self)
// new code to go here!
let ball = SKSpriteNode(imageNamed: "ballRed")
Mude isso para ser:

let location = touch.location(in: self)

let objects = nodes(at: location)

if objects.contains(editLabel) {
    editingMode.toggle()
} else {
    let ball = SKSpriteNode(imageNamed: "ballRed")
    // rest of ball code
}

Did you notice I slipped in a small but important new method there? editingMode.toggle() changes editingMode to 
true if it’s currently false, and to false if it was true. We could have written editingMode = !editingMode there 
and it would do the same thing, but toggle() is both shorter and clearer. That change will be picked up by the 
property observer, and the label will be updated to reflect the change.

Obviously the // rest of ball code comment is where the rest of the ball-creating code goes, but note that you 
need to add the new closing brace after you've created the ball, to close the else block.

Now that we have a boolean telling us whether we're in editing mode or not, we're going to extend touchesBegan() 
even further so that if we're in editing mode we add blocks to the screen of random sizes, and if we're not it drops a ball.

Para obter a estrutura certa, é isso que você quer ter:

if objects.contains(editLabel) {
    editingMode.toggle()
} else {
    if editingMode {
        // create a box
    } else {
        // create a ball
    }
}

The // create a ball comment is where your current ball creation code goes. The // create a box comment is 
what we're going to write in just a moment.

Primeiro, vamos usar uma nova propriedade nos nós chamada zRotation. Ao criar a imagem de fundo, demos a ela uma 
posição Z, que ajusta sua profundidade na tela, da frente para trás. Se você imagina enfiar um espeto através da 
posição Z - ou seja, indo diretamente para a sua tela - e através de um nó, então você pode imaginar a rotação Z: 
ele gira um nó na tela como se tivesse sido espetado diretamente através da tela.

To create randomness we’re going to be using both Int.random(in:) for integer values and CGFloat.random(in:) for 
CGFloat values, with the latter being used to create random red, green, and blue values for a UIColor. So, replace 
the // create a box comment with this:

let size = CGSize(width: Int.random(in: 16...128), height: 16)
let box = SKSpriteNode(color: UIColor(red: CGFloat.random(in: 0...1), green: CGFloat.random(in: 0...1), blue: CGFloat.random(in: 0...1), alpha: 1), size: size)
box.zRotation = CGFloat.random(in: 0...3)
box.position = location

box.physicsBody = SKPhysicsBody(rectangleOf: box.size)
box.physicsBody?.isDynamic = false

addChild(box)

So, we create a size with a height of 16 and a width between 16 and 128, then create an SKSpriteNode with 
the random size we made along with a random color, then give the new box a random rotation and place it at 
the location that was tapped on the screen. For a physics body, it's just a rectangle, but we need to make 
it non-dynamic so the boxes don't move when hit.

Neste ponto, quase temos um jogo: você pode tocar em Editar, colocar quantos blocos quiser, depois tocar em 
Concluído e tentar marcar soltando bolas. Não é perfeito porque não forçamos a posição Y de novas bolas a estar 
no topo da tela, mas isso é algo que você pode consertar - de que outra forma você aprenderia, certo?


