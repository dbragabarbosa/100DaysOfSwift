12/09/2022


Project 11, part three 


Hoje chegamos ao final do projeto 11, o que significa que é hora de mais alguns desafios. Eu sei que a pista está bem 
ali no nome, mas esses desafios são projetados para serem desafiadores - você precisa pensar sobre os problemas anteriores 
que resolveu em outros projetos e, em seguida, aplicar esse conhecimento de uma maneira nova e diferente aqui.

Esses desafios são projetados para ajudá-lo a aprender, porque uma coisa é seguir minhas instruções e outra é aplicar 
seu conhecimento a novos problemas. No entanto, se você os achar complicados, não se preocupe se vir pessoas on-line 
resolvendo-os rapidamente - elas estão aqui para ajudá-lo a aprender, não como algum tipo de maneira de se medir contra 
os outros. Como Shakuntala Devi disse uma vez, “ninguém me desafia - eu me desafio”.

Today you should work through the SKEmitterNode and wrap up chapters for project 11, complete its review, then work through 
all three of its challenges.



---------- Special effects: SKEmitterNode

Our current destroy() method does nothing much, it just removes the ball from the game. But I made it a method for 
a reason, and that's so that we can add some special effects now, in one place, so that however a ball gets destroyed 
the same special effects are used.

Perhaps unsurprisingly, it's remarkably easy to create special effects with SpriteKit. In fact, it has a built-in particle 
editor to help you create effects like fire, snow, rain and smoke almost entirely through a graphical editor. I already 
created an example particle effect for you (which you can customize soon, don't worry!) so let's take a look at the code 
first.

Modify your destroy() method to this:

func destroy(ball: SKNode) {
    if let fireParticles = SKEmitterNode(fileNamed: "FireParticles") {
        fireParticles.position = ball.position
        addChild(fireParticles)
    }

    ball.removeFromParent()
}

The SKEmitterNode class is new and powerful: it's designed to create high-performance particle effects in SpriteKit 
games, and all you need to do is provide it with the filename of the particles you designed and it will do the rest. 
Once we have an SKEmitterNode object to work with, we position it where the ball was then use addChild() to add it to 
the scene.

If you run the app now, you'll see the balls explode in a fireball when they touch a slot – a pretty darn amazing 
effect given how little code was written!

But the real fun is yet to come, because the code for this project is now all done and you get to play with the 
particle editor. In Xcode, look in the Content folder you dragged in and select the FireParticles.sks file to load 
the particle editor.

The particle editor is split in two: the center area shows how the current particle effect looks, and the right pane 
shows one of three inspectors. Of those three inspectors, only the third is useful because that's where you'll see all 
the options you can use to change the way your particles look.

At the time of writing, Xcode's particle editor is a little buggy, so I suggest you change the Maximum value to 0 
before beginning otherwise you might see nothing at all.

Confused by all the options? Here's what they do:

- Particle Texture: what image to use for your particles.

- Particles Birthrate: how fast to create new particles.

- Particles Maximum: the maximum number of particles this emitter should create before finishing.

- Lifetime Start: the basic value for how many seconds each particle should live for.

- Lifetime Range: how much, plus or minus, to vary lifetime.

- Position Range X/Y: how much to vary the creation position of particles from the emitter node's position.

- Angle Start: which angle you want to fire particles, in degrees, where 0 is to the right and 90 is straight up.

- Angle Range: how many degrees to randomly vary particle angle.

- Speed Start: how fast each particle should move in its direction.

- Speed Range: how much to randomly vary particle speed.

- Acceleration X/Y: how much to affect particle speed over time. This can be used to simulate gravity or wind.

- Alpha Start: how transparent particles are when created.

- Alpha Range: how much to randomly vary particle transparency.

- Alpha Speed: how much to change particle transparency over time. A negative value means "fade out."

- Scale Start / Range / Speed: how big particles should be when created, how much to vary it, and how much it should 
change over time. A negative value means "shrink slowly."

- Rotation Start / Range / Speed: what Z rotation particles should have, how much to vary it, and how much they should 
spin over time.

- Color Blend Factor / Range / Speed: how much to color each particle, how much to vary it, and how much it should 
change over time.

Note: Once you've finished editing your particles, make sure you put a maximum value back on them otherwise they'll 
never go away!

It's worth adding that you can create particles from one of Xcode's built-in particle template. Add a new file, but 
this time choose "Resource" under the iOS heading, then choose "SpriteKit Particle File" to see the list of options.



---------- Wrap up

Este projeto está feito, e tem sido longo, mas espero que você olhe para os resultados e ache que valeu a pena. 
Além disso, você mais uma vez aprendeu muito: SpriteKit, física, modos de mistura, radianos e CGFloat.

Você tem as bases firmes de um jogo de verdade aqui, mas há muito mais que você pode fazer para torná-lo ainda melhor.


- Desafio

Uma das melhores maneiras de aprender é escrever seu próprio código com a maior frequência possível, então aqui 
estão três maneiras de experimentar seu novo conhecimento para garantir que você entenda completamente o que está 
acontecendo:

1. As fotos que estamos usando têm outras fotos de bola em vez de apenas “ballRed”. Tente escrever o código para usar 
uma cor de bola aleatória toda vez que eles tocarem na tela.

2. No momento, os usuários podem tocar em qualquer lugar para ter uma bola criada lá, o que torna o jogo muito fácil. 
Tente forçar o valor Y de novas bolas para que elas estejam perto da parte superior da tela.

3. Dê aos jogadores um limite de cinco bolas e, em seguida, remova as caixas de obstáculos quando forem atingidos. 
Eles podem limpar todos os pinos com apenas cinco bolas? Você poderia fazer isso para que pousar em um slot verde lhes 
desse uma bola extra.




That’s another project finished, and your first using SpriteKit! Why not record a video of your finished product and 
show it around?