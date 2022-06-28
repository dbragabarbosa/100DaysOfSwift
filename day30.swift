28/06/2022


PROJECT 6, PART ONE 


A famosa estilista francesa Coco Chanel disse uma vez que "moda é arquitetura: é uma questão de proporções". 
O mesmo vale para o design da interface do usuário: nosso objetivo é disponibilizar todas as nossas funcionalidades 
importantes para o usuário sem fazer com que ele se sinta esmagado ou espremido.

Hoje estamos começando um novo projeto de técnica, onde veremos como o Layout Automático nos permite definir algumas 
regras bastante complicadas para tornar nossa interface do usuário ótima. Existem várias maneiras diferentes de fazer 
isso, e eu vou te mostrar todas elas neste projeto - eu prefiro que você mesmo as experimentasse e decidisse qual 
funcionou melhor para você, em vez de eu tentar escolher com base em minhas próprias preferências.

Independentemente de qual você escolher, como você verá, o resultado final é que temos um poder extraordinário sobre a 
maneira como nossa interface de usuário se adapta a diferentes dispositivos e mudanças de rotação.



---------- SETTING UP 

Neste projeto de técnica, você aprenderá mais sobre o Layout Automático, a maneira poderosa e expressiva como o 
iOS permite projetar seus layouts. Nós o usamos no projeto 2 para garantir que nossos botões de bandeira estivessem 
posicionados corretamente, mas esse projeto tem um problema: se você girar seu dispositivo, as bandeiras não cabem na tela!

Então, primeiro vamos corrigir o projeto 2 para que ele demonstre técnicas mais avançadas de Layout Automático 
(ao mesmo tempo em que faz com que as bandeiras permaneçam na tela corretamente!), depois dê uma olhada nas 
maneiras de usar o Layout Automático no código.

Primeiro: pegue uma cópia do projeto 2, chame-o de project6a e abra-o no Xcode. Tudo pronto? Então vamos começar...



---------- ADVANCED AUTO LAYOUT 

Quando você executa o projeto, ele fica bem em retrato, mas não pode ser reproduzido na paisagem porque 
alguns dos botões estão ocultos. Você tem duas opções: desativar o modo paisagem ou fazer com que seu layout 
funcione em ambas as direções.

Desativar orientações não é uma ótima solução, mas às vezes é a solução certa. A maioria dos jogos, 
por exemplo, corrige sua orientação porque simplesmente não faz sentido suportar ambos. Se você quiser 
fazer isso, pressione Cmd+1 para mostrar o navegador do projeto à esquerda da janela do Xcode, selecione
seu projeto (é o primeiro item no painel) e, à direita de onde você acabou de clicar, aparecerá outro 
painel mostrando "PROJETO" e "TARGETS", juntamente com mais algumas informações no centro.

Observação: Este projeto e a lista de alvos podem ser ocultos clicando no botão de divulgação no canto superior
esquerdo do editor de projetos (diretamente abaixo do ícone com quatro quadrados), e você pode achar que o seu 
já está oculto. Eu recomendo fortemente que você mostre esta lista - escondê-la só tornará as coisas mais difíceis 
de encontrar, portanto, certifique-se de que ela esteja visível!

Na imagem abaixo, você pode ver o editor de projetos, com as orientações do dispositivo na parte inferior. 
Esta é a visualização recolhida de projetos e alvos, então há uma seta suspensa na parte superior que diz "Projeto2" 
(logo acima de onde diz Identidade em negrito), e à esquerda disso está o botão para mostrar a lista de projetos e alvos.

Essa visualização é chamada de editor de projetos e contém um grande número de opções que afetam a maneira 
como seu aplicativo funciona. Você usará muito isso no futuro, então lembre-se de como chegar aqui! Selecione 
Projeto 2 em ALVOS, escolha a guia Geral e role para baixo até ver quatro caixas de seleção chamadas Orientação 
do Dispositivo. Você pode selecionar apenas aqueles que deseja oferecer suporte.

Você precisará suportar orientações seletivas em alguns projetos posteriores, mas por enquanto vamos pegar 
a solução inteligente: adicione regras extras ao Layout Automático para que ele possa fazer com que o layout 
funcione muito bem no modo paisagem.

Abra Main.storyboard no Interface Builder, selecione o sinalizador inferior e, em seguida, arraste com a tecla 
Ctrl pressionada do sinalizador para o espaço em branco diretamente abaixo do sinalizador - no próprio controlador 
de visualização. A direção que você arrasta é importante, então arraste direto para baixo.

Quando você soltar o botão do mouse, aparecerá um pop-up que inclui a opção "Espaço Inferior para Área Segura" - 
selecione isso. Isso cria uma nova restrição de Layout Automático de que a parte inferior do sinalizador deve 
estar a pelo menos X pontos de distância da parte inferior do controlador de visualização, onde X é igual a 
qualquer espaço que haja lá agora.

Embora esta seja uma regra válida, ela estragará seu layout porque agora temos um conjunto completo de regras 
verticais exatas: o sinalizador superior deve estar a 36 pontos de cima, o segundo 30 do primeiro, o terceiro 
30 do segundo e o terceiro X de baixo. É 207 para mim, mas o seu pode ser diferente.

Como dissemos ao Layout Automático exatamente o quão grandes todos os espaços devem ser, ele os adicionará e 
dividirá o espaço restante entre as três bandeiras da maneira que achar melhor. Ou seja, as bandeiras agora 
devem ser esticadas verticalmente para preencher o espaço, o que é quase certamente o que não queremos.

Em vez disso, vamos dizer ao Layout Automático onde há alguma flexibilidade, e isso está na nova regra inferior 
que acabamos de criar. A bandeira inferior não precisa estar precisamente a 207 pontos de distância da parte 
inferior da área segura - ela só precisa estar a alguma distância, para que não toque na borda. Se houver mais 
espaço, ótimo, o Layout Automático deve usá-lo, mas tudo o que nos importa é o mínimo.

Selecione o terceiro sinalizador para ver sua lista de restrições desenhadas em azul e, em seguida, (cuidado!) 
selecione a restrição inferior que acabamos de adicionar. Na visualização de utilitários à direita, escolha o 
inspetor de atributos (Alt+Cmd+4), e você deve ver Relação definida como Igual e Constante definida como 207 
(ou algum outro valor, dependendo do seu layout).

O que você precisa fazer é alterar Igual para "Maior que ou Igual", depois alterar o valor Constante para 20. 
Isso define a regra "torne pelo menos 20, mas você pode torná-lo mais para preencher espaço". O layout não 
mudará visualmente enquanto você estiver fazendo isso, porque o resultado final é o mesmo. Mas pelo menos agora 
que o Layout Automático sabe que tem alguma flexibilidade além de apenas esticar as bandeiras!

No entanto, nosso problema ainda não foi corrigido: na paisagem, um iPhone SE tem apenas 320 pontos de espaço 
para trabalhar, então o Layout Automático fará com que nossas bandeiras se encaixem esmagando uma ou talvez até 
duas delas. Bandeiras esmagadas não são boas, e ter tamanhos irregulares de bandeiras também não é bom, então 
vamos adicionar mais algumas regras.

Selecione o segundo botão e, em seguida, arraste com a tecla Ctrl pressionada para o primeiro botão. Quando 
receber a lista de opções, escolha Alturas Iguais. Agora faça o mesmo do terceiro botão para o segundo botão. 
Esta regra garante que, em todos os momentos, os três sinalizadores tenham a mesma altura, para que o Layout 
Automático não possa mais esmagar um botão para que tudo se encaixe e, em vez disso, tenha que esmagar todos 
os três igualmente.

Isso resolve parte do problema, mas em alguns aspectos piorou as coisas. Em vez de ter uma bandeira esmagada, 
agora temos três! Mas com mais uma regra, podemos impedir que as bandeiras sejam esmagadas para sempre. Selecione 
o primeiro botão e, em seguida, arraste um pouco para cima com a tecla Ctrl - mas fique dentro do botão! Ao 
soltar o botão do mouse, você verá a opção "Proporção de Aspectos", então escolha-a.

A restrição da Proporção resolve a esmagamento de uma vez por todas: isso significa que, se o Layout Automático 
for forçado a reduzir a altura do sinalizador, ele reduzirá sua largura na mesma proporção, o que significa que 
o sinalizador sempre parecerá correto. Adicione a restrição de Proporção aos outros dois sinalizadores e execute 
seu aplicativo novamente. Deve funcionar muito bem em retrato e paisagem, tudo graças ao Layout Automático!



---------- AUTO LAYOUT IN CODE: addConstraints() with Visual Format Language 

Crie um novo projeto de aplicativo de visualização única no Xcode, nomeando-o Project6b. Vamos criar algumas 
visualizações manualmente e, em seguida, posicioná-las usando o Layout Automático. Coloque isso no seu método viewDidLoad():

override func viewDidLoad() {
    super.viewDidLoad()

    let label1 = UILabel()
    label1.translatesAutoresizingMaskIntoConstraints = false
    label1.backgroundColor = UIColor.red
    label1.text = "THESE"
    label1.sizeToFit()

    let label2 = UILabel()
    label2.translatesAutoresizingMaskIntoConstraints = false
    label2.backgroundColor = UIColor.cyan
    label2.text = "ARE"
    label2.sizeToFit()

    let label3 = UILabel()
    label3.translatesAutoresizingMaskIntoConstraints = false
    label3.backgroundColor = UIColor.yellow
    label3.text = "SOME"
    label3.sizeToFit()

    let label4 = UILabel()
    label4.translatesAutoresizingMaskIntoConstraints = false
    label4.backgroundColor = UIColor.green
    label4.text = "AWESOME"
    label4.sizeToFit()

    let label5 = UILabel()
    label5.translatesAutoresizingMaskIntoConstraints = false
    label5.backgroundColor = UIColor.orange
    label5.text = "LABELS"
    label5.sizeToFit()        

    view.addSubview(label1)
    view.addSubview(label2)
    view.addSubview(label3)
    view.addSubview(label4)
    view.addSubview(label5)
}

Todo esse código cria cinco objetos UILabel, cada um com texto exclusivo e uma cor de fundo única. 
Todas as cinco visualizações são adicionadas à visualização pertencente ao nosso controlador de 
visualização usando view.addSubview().

We also set the property translatesAutoresizingMaskIntoConstraints to be false on each label, because by 
default iOS generates Auto Layout constraints for you based on a view's size and position. We'll be doing 
it by hand, so we need to disable this feature.

If you run the app now, you'll see seem some colorful labels at the top, overlapping so it looks like it 
says "LABELS ME". That's because our labels are placed in their default position (at the top-left of the screen) 
and are all sized to fit their content thanks to us calling sizeToFit() on each of them.

Vamos adicionar algumas restrições que dizem que cada rótulo deve começar na borda esquerda de sua 
supervisão e terminar na borda direita. Além disso, vamos fazer isso usando uma técnica chamada Auto 
Layout Visual Format Language (VFL), que é uma espécie de maneira de desenhar o layout que você deseja 
com uma série de símbolos de teclado.

Antes de fazermos isso, precisamos criar um dicionário das visões que queremos expor. A razão pela qual 
isso é necessário para a VFL ficará clara em breve, mas primeiro aqui está o dicionário que você precisa 
adicionar abaixo da última chamada para addSubview():

let viewsDictionary = ["label1": label1, "label2": label2, "label3": label3, "label4": label4, "label5": label5]

Isso cria um dicionário com strings para suas chaves e nossos rótulos como seus valores (os valores). 
Então, para ter acesso ao label1, agora podemos usar viewsDictionary["label1"] Isso pode parecer redundante, 
mas espere um momento a mais: é hora de alguma Linguagem de Formato Visual!

Add these lines directly below the viewsDictionary that was just created:

view.addConstraints( NSLayoutConstraint.constraints(withVisualFormat: "H:|[label1]|", options: [], metrics: nil, views: viewsDictionary))
view.addConstraints( NSLayoutConstraint.constraints(withVisualFormat: "H:|[label2]|", options: [], metrics: nil, views: viewsDictionary))
view.addConstraints( NSLayoutConstraint.constraints(withVisualFormat: "H:|[label3]|", options: [], metrics: nil, views: viewsDictionary))
view.addConstraints( NSLayoutConstraint.constraints(withVisualFormat: "H:|[label4]|", options: [], metrics: nil, views: viewsDictionary))
view.addConstraints( NSLayoutConstraint.constraints(withVisualFormat: "H:|[label5]|", options: [], metrics: nil, views: viewsDictionary))

Isso é muito código, mas na verdade é a mesma coisa cinco vezes. Como resultado, poderíamos facilmente reescrevê-los em um loop, assim:

for label in viewsDictionary.keys {
    view.addConstraints( NSLayoutConstraint.constraints(withVisualFormat: "H:|[\(label)]|", options: [], metrics: nil, views: viewsDictionary))
}

Observe que estamos usando interpolação de string para colocar a chave ("label1", etc.) na VFL.

Vamos eliminar as coisas fáceis e depois nos concentrar no que resta.

- view.addConstraints(): isso adiciona uma matriz de restrições à visualização do nosso controlador de visualização. 
Esta matriz é usada em vez de uma única restrição porque a VFL pode gerar várias restrições de cada vez.

- NSLayoutConstraint.constraints(withVisualFormat:)é o método de Layout Automático que converte VFL em uma matriz de 
restrições. Aceita muitos parâmetros, mas os mais importantes são os primeiros e os últimos.

- We pass [] (an empty array) for the options parameter and nil for the metrics parameter. You can use these options 
to customize the meaning of the VFL, but for now we don't care.

Essa é a coisa mais fácil. Então, vamos dar uma olhada na própria Linguagem de Formato Visual: "H:|[label1]|" Como 
você pode ver, é uma string, e essa string descreve como queremos que o layout fique. Essa VFL é convertida em restrições 
de Layout Automático e, em seguida, adicionada à visualização.

The H: parts means that we're defining a horizontal layout; we'll do a vertical layout soon. The pipe symbol, |, means 
"the edge of the view." We're adding these constraints to the main view inside our view controller, so this effectively 
means "the edge of the view controller." Finally, we have [label1], which is a visual way of saying "put label1 here". 
Imagine the brackets, [ and ], are the edges of the view.

So, "H:|[label1]|" means "horizontally, I want my label1 to go edge to edge in my view." But there's a hiccup: what is 
"label1"? Sure, we know what it is because it's the name of our variable, but variable names are just things for humans 
to read and write – the variable names aren't actually saved and used when the program runs.

This is where our viewsDictionary dictionary comes in: we used strings for the key and UILabels for the value, then set 
"label1" to be our label. This dictionary gets passed in along with the VFL, and gets used by iOS to look up the names 
from the VFL. So when it sees [label1], it looks in our dictionary for the "label1" key and uses its value to generate 
the Auto Layout constraints.

Essa é toda a linha VFL explicada: cada um dos nossos rótulos deve se esticar de ponta a ponta em nossa visão. 
Se você executar o programa agora, é isso que verá, embora destaque nosso segundo problema: não temos um layout 
vertical no lugar, portanto, embora todos os rótulos fiquem de ponta a ponta na visualização, todos eles se sobrepõem.

Vamos consertar isso com outro conjunto de restrições, mas desta vez é apenas uma linha (longa).

view.addConstraints( NSLayoutConstraint.constraints(withVisualFormat: "V:|[label1]-[label2]-[label3]-[label4]-[label5]", options: [], metrics: nil, views: viewsDictionary))

Isso é idêntico aos cinco anteriores, exceto pela parte VFL. Desta vez, estamos especificando V:, o que significa 
que essas restrições são verticais. E temos várias visualizações dentro da VFL, então muitas restrições serão geradas.
A novidade na VFL desta vez é o símbolo -, que significa "espaço". São 10 pontos por padrão, mas você pode personalizá-lo.

Observe que nossa VFL vertical não tem um tubo no final, por isso não estamos forçando a última etiqueta a se 
esticar até a borda da nossa visão. Isso deixará espaços em branco após o último rótulo, que é o que queremos agora.

Se você executar seu programa agora, verá todos os cinco rótulos se estendendo de ponta a ponta horizontalmente 
e, em seguida, espaçados verticalmente. Teria sido necessário muito Ctrl-dragging no Interface Builder para fazer 
esse mesmo layout, então espero que você possa apreciar o quão poderosa é a VFL!

