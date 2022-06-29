// 29/06/2022


PROJECT 6, PART TWO 


Uma das três leis estabelecidas pelo escritor britânico de ficção científica Arthur C. 
Clarke é particularmente conhecido: “qualquer tecnologia suficientemente avançada é indistinguível da magia.”

É possível que você esteja pensando que o Layout Automático é um pouco uma caixa preta, onde a magia 
acontece para garantir que todas as suas regras sejam seguidas. Mas não é: o Layout Automático é realmente 
direto na maioria das vezes, e desde que você se certifique de que suas restrições sejam a) completas e b) 
não contraditórias, você não deve ter muitos problemas.

Today you have three topics to work through, and you’ll learn about advanced Visual Formatting Language and 
Auto Layout anchors. Once you’re done, please complete the project review then work through all three of its challenges.



---------- AUTO LAYOUT METRICS AND PRIORITIES: CONSTRAINTS(withVisualFormat:)

Temos um layout funcional agora, mas é bastante básico: os rótulos não são muito altos e, sem uma regra 
sobre a parte inferior do último rótulo, é possível que as visualizações possam ser empurradas para fora 
da borda inferior.

Para começar a corrigir esse problema, vamos adicionar uma restrição para a borda inferior dizendo que a 
parte inferior do nosso último rótulo deve estar a pelo menos 10 pontos de distância da parte inferior da 
vista do controlador de visualização. Também diremos ao Layout Automático que queremos que cada um dos 
cinco rótulos tenha 88 pontos de altura. Substitua as restrições verticais anteriores por estas:

view.addConstraints( NSLayoutConstraint.constraints(withVisualFormat: "V:|[label1(==88)]-[label2(==88)]-
[label3(==88)]-[label4(==88)]-[label5(==88)]-(>=10)-|", options: [], metrics: nil, views: viewsDictionary))


The difference here is that we now have numbers inside parentheses: (==88) for the labels, and (>=10) for 
the space to the bottom. Note that when specifying the size of a space, you need to use the - before and 
after the size: a simple space, -, becomes -(>=10)-.

We are specifying two kinds of size here: == and >=. The first means "exactly equal" and the second "greater 
than or equal to." So, our labels will be forced to be an exact size, and we ensure that there's some space 
at the bottom while also making it flexible – it will definitely be at least 10 points, but could be 100 or 
more depending on the situation.

Na verdade, espere um minuto. Eu não queria 88 pontos para o tamanho da etiqueta, eu quis dizer 80 pontos. 
Vá em frente e mude todos os rótulos para 80 pontos de altura.

Uau! Parece que você acabou de receber um e-mail do seu diretor de TI: ele acha que 80 pontos é um tamanho 
bobo para as etiquetas; eles precisam ser de 64 pontos, porque todos os bons tamanhos têm um poder de 2.

E agora parece que seu designer e diretor de TI estão brigando sobre o tamanho certo. Alguns socos depois, 
eles decidem dividir a diferença e escolher um número no meio: 72. Então, por favor, vá em frente e faça com 
que os rótulos tenham 72 pontos de altura.

Já está entediado? Você deveria estar. E, no entanto, esse é o tipo de empurrar pixels em que é fácil de cair, 
especialmente se o seu aplicativo estiver sendo projetado pelo comitê.

Auto Layout has a solution, and it's called metrics. All these calls to constraints(withVisualFormat:) have 
been sent nil for their metrics parameter, but that's about to change. You see, you can give VFL a set of 
sizes with names, then use those sizes in the VFL rather than hard-coding numbers. For example, we wanted 
our label height to be 88, so we could create a metrics dictionary like this:

let metrics = ["labelHeight": 88]
Então, sempre que tínhamos escrito anteriormente ==88, agora podemos apenas escrever labelHeight. Então, 
altere suas restrições verticais atuais para ser assim:

view.addConstraints( NSLayoutConstraint.constraints(withVisualFormat: "V:|[label1(labelHeight)]-[label2(
    labelHeight)]-[label3(labelHeight)]-[label4(labelHeight)]-[label5(labelHeight)]->=10-|", options: [], 
    metrics: metrics, views: viewsDictionary))

Então, quando seu designer / gerente / requerente interno decidir que 88 pontos está errado e você quer 
algum outro número, você pode alterá-lo em um só lugar para que tudo seja atualizado.

Antes de terminarmos, vamos fazer mais uma mudança que torna toda a interface do usuário muito melhor, 
porque agora ainda é imperfeita. Para ser mais específico, estamos forçando todos os rótulos a ter uma 
altura específica e, em seguida, adicionando restrições à parte superior e inferior. Isso ainda funciona 
bem no retrato, mas na paisagem é improvável que você tenha espaço suficiente para satisfazer todas as restrições.

Com a nossa configuração atual, você verá esta mensagem quando o aplicativo for girado para paisagem: 
"Não é possível satisfazer restrições simultaneamente". Isso significa que suas restrições simplesmente 
não funcionam, dado a quantidade de espaço na tela que existe, e é aí que entra a prioridade. Você pode 
dar prioridade a qualquer restrição de layout, e o Layout Automático fará o seu melhor para fazê-lo funcionar.

A prioridade de restrição é um valor entre 1 e 1000, onde 1000 significa "isso é absolutamente necessário" 
e qualquer coisa a menos é opcional. Por padrão, todas as restrições que você tem são prioridade 1000, 
portanto, o Layout Automático não encontrará uma solução em nosso layout atual. Mas se tornarmos a altura 
opcional - mesmo tão alta quanto a prioridade 999 - isso significa que o Layout Automático pode encontrar 
uma solução para o nosso layout: encolher as etiquetas para que elas se encaixem.

É importante entender que o Layout Automático não apenas descarta regras que não pode cumprir - ele ainda 
faz o seu melhor para atendê-las. Então, no nosso caso, se tornarmos nossa altura de 88 pontos opcional, 
o Layout Automático pode torná-los 78 ou algum outro número. Ou seja, ainda fará o seu melhor para torná-los 
o mais próximo possível de 88. TL;DR: as restrições são avaliadas da prioridade mais alta até a mais baixa, 
mas todas são levadas em consideração.

Então, vamos fazer com que a altura do rótulo tenha prioridade 999 (ou seja, muito importante, mas não 
obrigatória). Mas também vamos fazer outra alteração, que é dizer ao Layout Automático que queremos que 
todos os rótulos tenham a mesma altura. Isso é importante, porque se todos eles tiverem alturas opcionais 
usando labelHeight, o Layout Automático pode resolver o layout encolhendo um rótulo e fazendo outro 88.

From its point of view it has at least managed to make some of the labels 88, so it's probably quite 
pleased with itself, but it makes our user interface look uneven. So, we're going to make the first 
label use labelHeight at a priority of 999, then have the other labels adopt the same height as the 
first label. Here's the new VFL line:

"V:|[label1(labelHeight@999)]-[label2(label1)]-[label3(label1)]-[label4(label1)]-[label5(label1)]->=10-|"

It's the @999 that assigns priority to a given constraint, and using (label1) for the sizes of the other 
labels is what tells Auto Layout to make them the same height.

É isso aí: sua configuração de Layout Automático está completa e o aplicativo agora pode ser executado 
com segurança em retrato e paisagem.



---------- AUTO LAYOUT ANCHORS 

Você já viu como criar restrições de Layout Automático tanto no Interface Builder quanto na Linguagem de 
Formato Visual, mas há mais uma opção aberta para você e geralmente é a melhor escolha.

Every UIView has a set of anchors that define its layouts rules. The most important ones are widthAnchor, 
heightAnchor, topAnchor, bottomAnchor, leftAnchor, rightAnchor, leadingAnchor, trailingAnchor, centerXAnchor, 
and centerYAnchor.

Most of those should be self-explanatory, but it’s worth clarifying the difference between leftAnchor, 
rightAnchor, leadingAnchor, and trailingAnchor. For me, left and leading are the same, and right and 
trailing are the same too. This is because my devices are set to use the English language, which is 
written and read left to right. However, for right-to-left languages such as Hebrew and Arabic, leading 
and trailing flip around so that leading is equal to right, and trailing is equal to left.

In practice, this means using leadingAnchor and trailingAnchor if you want your user interface to flip 
around for right to left languages, and leftAnchor and rightAnchor for things that should look the same 
no matter what environment.

A melhor parte de trabalhar com âncoras é que elas podem ser criadas em relação a outras âncoras. 
Ou seja, você pode dizer "a âncora de largura deste rótulo é igual à largura de seu recipiente" ou 
"a âncora superior deste botão é igual à âncora inferior deste outro botão".

Para demonstrar âncoras, comente seu código VFL de Layout Automático existente e substitua-o por este:

for label in [label1, label2, label3, label4, label5] {
    label.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
    label.heightAnchor.constraint(equalToConstant: 88).isActive = true
}

Isso percorre cada um dos cinco rótulos, definindo-os para ter a mesma largura da nossa visão principal 
e ter uma altura de exatamente 88 pontos.

No entanto, ainda não definimos âncoras superiores, então o layout ainda não parecerá correto. O que 
queremos é que a âncora superior de cada rótulo seja igual à âncora inferior do rótulo anterior no loop.
Claro, a primeira vez que o loop circula, não há rótulo anterior, para que possamos modelar isso usando opcionais:

var previous: UILabel?

The first time the loop goes around that will be nil, but then we’ll set it to the current item in the 
loop so the next label can refer to it. If previous is not nil, we’ll set a topAnchor constraint.

Substitua suas âncoras de Layout Automático existentes por esta:

var previous: UILabel?

for label in [label1, label2, label3, label4, label5] {
    label.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
    label.heightAnchor.constraint(equalToConstant: 88).isActive = true

    if let previous = previous {
        // we have a previous label – create a height constraint
        label.topAnchor.constraint(equalTo: previous.bottomAnchor, constant: 10).isActive = true
    }

    // set the previous label to be the current one, for the next loop iteration
    previous = label
}

Essa terceira âncora combina uma âncora diferente com um valor constante para obter espaçamento 
entre as vistas - essas coisas são realmente flexíveis.

Execute o aplicativo agora e você verá todos os rótulos se encaixarem perfeitamente. Espero que você 
concorde que as âncoras tornam o código de layout automático muito simples de ler e escrever!

As âncoras também nos permitem controlar bem a área segura. A "área segura" é o espaço que é realmente 
visível dentro das inserções do iPhone X e de outros dispositivos semelhantes - com seus cantos arredondados, 
entalhe e similares. É um espaço que exclui essas áreas, para que os rótulos não sejam mais executados 
abaixo do entalhe ou cantos arredondados.

We can fix that using constraints. In our current code we’re saying “if we have a previous label, 
make the top anchor of this label equal to the bottom anchor of the previous label plus 10.” But 
if we add an else block we can push the first label away from the top of the safe area, so it doesn’t 
sit under the notch, like this:

if let previous = previous {
    // we have a previous label – create a height constraint
    label.topAnchor.constraint(equalTo: previous.bottomAnchor, constant: 10).isActive = true
} else {
    // this is the first label
    label.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
}

Se você executar esse código agora, verá todas as cinco etiquetas começarem abaixo do entalhe em dispositivos estilo iPhone X.



---------- WRAP UP 

Existem dois tipos de desenvolvedores iOS no mundo: aqueles que usam o Layout Automático e pessoas que 
gostam de perder tempo. Tem uma curva de aprendizado um pouco íngreme (e nem usamos a maneira mais difícil 
de adicionar restrições!), mas é uma maneira extremamente expressiva de criar ótimos layouts que se adaptam 
automaticamente a qualquer dispositivo em que se encontrem em execução - agora e no futuro.

A maioria das pessoas recomenda que você faça o máximo que puder dentro do Interface Builder, e por um bom 
motivo - você pode arrastar linhas até ficar feliz, você obtém uma visualização instantânea de como tudo 
parece, e isso irá avisá-lo se houver algum problema (e ajudá-lo a corrigi-lo). Mas, como você viu, criar 
restrições no código é extremamente fácil graças à linguagem Visual Format e âncoras, então você pode se 
encontrar misturando todas elas para obter os melhores resultados.

Desafio

Uma das melhores maneiras de aprender é escrever seu próprio código o mais rápido possível, então aqui 
estão três maneiras pelas quais você deve tentar estender este aplicativo para garantir que você entenda 
completamente o que está acontecendo:

1. Try replacing the widthAnchor of our labels with leadingAnchor and trailingAnchor constraints, which more 
explicitly pin the label to the edges of its parent.

2. Once you’ve completed the first challenge, try using the safeAreaLayoutGuide for those constraints. You can 
see if this is working by rotating to landscape, because the labels won’t go under the safe area.

3. Tente tornar a altura dos seus rótulos igual a 1/5 da vista principal, menos 10 para o espaçamento. 
Este é difícil, mas incluí dicas abaixo!

Dicas

É vital para o seu aprendizado que você experimente os desafios acima de si mesmo, e não apenas por 
alguns minutos antes de desistir.

Toda vez que você tenta algo errado, você descobre que está errado e vai se lembrar que está errado. 
Quando você encontrar a solução correta, você se lembrará muito mais profundamente, ao mesmo tempo em 
que se lembrará de muitas das curvas erradas que tomou.

Isso é o que quero dizer com "não há aprendizado sem luta": se algo vier facilmente para você, pode ir 
com a mesma facilidade. Mas quando você tem que lutar mentalmente por algo, ele vai ficar muito mais tempo.

Mas se você já trabalhou duro nos desafios acima e ainda está lutando para implementá-los, vou escrever 
algumas dicas abaixo que devem guiá-lo para a resposta correta.

Se você me ignorar e ler essas dicas sem ter passado pelo menos 30 minutos tentando os desafios acima, a 
única pessoa que você está traindo é você mesmo.

Still here? OK. If you’re stuck on the last challenge, try looking at Xcode’s code completion options for 
the constraint() method. We’re using the equalToConstant option right now, but there are others – the equalTo 
option lets you specify another height anchor as its first parameter, along with a multiplier and a constant.

Quando você usa um multiplicador e uma constante, o multiplicador é levado em consideração primeiro e depois 
na constante. Então, se você quiser fazer uma visualização com metade da largura da vista principal mais 50, 
você pode escrever algo assim:

yourView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor