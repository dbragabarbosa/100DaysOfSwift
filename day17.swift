// 18/05/2022


PROJECT 1, PART TWO 

Ontem você completou o básico do nosso aplicativo, mas é claro que está faltando um componente importante: 
ele não está desenhando nenhuma imagem! Para um aplicativo chamado Storm Viewer, essa parte parece bastante importante - 
como disse Walt Disney, "de todas as nossas invenções para comunicação de massa, as imagens ainda falam a linguagem mais 
universalmente compreendida".

Então, hoje você concluirá o projeto um adicionando uma tela de detalhes que pode carregar imagens, fazendo com que essa tela seja 
animada quando o usuário selecionar um nome de imagem e, em seguida, adicionando alguns ajustes para polir a interface do usuário.

Today you have three topics to work through, and you’ll meet UIImageView, UIImage, UINavigationBar, and more.


---------- 1. BUILDING A DETAIL SCREEN 

Neste ponto do nosso aplicativo, temos uma lista de fotos para escolher, mas, embora possamos tocar nelas, nada acontece. 
Nosso próximo objetivo é criar uma nova tela que será exibida quando o usuário tocar em qualquer linha. Faremos com que ele mostre a 
imagem selecionada em tela cheia, e ele deslizará automaticamente quando uma imagem for tocado.

Esta tarefa pode ser dividida em duas tarefas menores. Primeiro, precisamos criar um novo código que hospede esta tela de detalhes. 
Em segundo lugar, precisamos desenhar a interface do usuário para esta tela dentro do Interface Builder.

Vamos começar com a parte fácil: crie um novo código para hospedar a tela de detalhes. Na barra de menus, vá para o menu 
Arquivo e escolha Novo > Arquivo, e uma janela cheia de opções aparecerá. Nessa lista, escolha iOS > Aula de Toque de Cacau e clique em Próximo.

Você será solicitado a nomear a nova tela e também dizer ao iOS sobre o que ela deve se basear. Digite "DetailViewController" 
para o nome e "UIViewController" para "Subclasse de". Certifique-se de que "Também criar arquivo XIB" esteja desmarcado e clique 
em Avançar e Criar para adicionar o novo arquivo.

Esse é o primeiro trabalho feito - temos um novo arquivo que conterá código para a tela de detalhes.

A segunda tarefa requer um pouco mais de reflexão. Volte para Main.storyboard e você verá nossos dois controladores de visualização existentes lá: 
esse é o controlador de visualização de navegação à esquerda e o controlador de visualização de tabela à direita. Vamos adicionar um 
novo controlador de visualização - uma nova tela - agora, que será nossa tela de detalhes.

Primeiro, abra a biblioteca de objetos e encontre "Controlador de Visualização" lá. Arraste-o para o espaço à direita do seu controlador 
de visualização existente. Você pode colocá-lo em qualquer lugar, na verdade, mas é bom organizar suas telas para que elas fluam logicamente 
da esquerda para a direita.

Agora, se você olhar no esboço do documento, verá que uma segunda "cena do Controlador de Visualização" apareceu: uma para a visualização 
da tabela e outra para a visualização de detalhes. Se você não tiver certeza de qual é qual, basta clicar na nova tela - no grande espaço 
vazio branco que acabou de ser criado - e ele deve selecionar a cena correta no contorno do documento.

Quando criamos nossa célula de visualização de tabela anteriormente, demos a ela um identificador para que pudéssemos carregá-la no código. 
Precisamos fazer a mesma coisa para esta nova tela. Quando você o selecionou há pouco, ele deveria ter destacado "Visualizar" no esboço do 
documento. Acima disso estará "Controlador de Visualização" com um ícone amarelo ao lado - clique nele para selecionar todo o controlador 
de visualização agora.

Para dar um nome a este controlador de visualização, vá para o inspetor de identidade pressionando Cmd+Alt+3 ou usando o menu. 
Agora digite "Detalhe", onde diz "ID do quadro de histórias". É isso aí: agora podemos nos referir a este controlador de visualização 
como "Detalhe" no código. Enquanto estiver lá, clique na seta ao lado da caixa Classe e selecione "DetailViewController" para que nossa 
interface de usuário esteja conectada ao novo código que fizemos anteriormente.

Agora, a parte interessante: queremos que esta tela exiba a imagem selecionada pelo usuário agradável e grande, por isso precisamos 
usar um novo componente de interface do usuário chamado UIImageView. Como você deve ser capaz de dizer pelo nome, isso faz parte do 
UIKit (daí o "UI") e é responsável pela visualização de imagens - perfeito!

Procure na biblioteca de objetos para encontrar a Visualização de Imagem; você pode achar mais fácil usar a caixa de filtro novamente. 
Clique e arraste a visualização da imagem da biblioteca de objetos para o controlador de visualização de detalhes e, em seguida, solte. 
Agora, arraste suas bordas para que ele preencha todo o controlador de visualização.

Esta visualização de imagem não tem conteúdo no momento, por isso está preenchida com um fundo azul pálido e a palavra UIImageView. 
No entanto, não atribuiremos nenhum conteúdo a ele agora - isso é algo que faremos quando o programa for executado. Em vez disso, 
precisamos dizer à visualização da imagem como se dimensionar para a nossa tela, seja iPhone ou iPad.

Isso pode parecer estranho no começo, afinal você acabou de colocá-lo para preencher o controlador de visualização, e ele tem o mesmo 
tamanho que o controlador de visualização, então deve ser isso, certo? Bem, não exatamente. Pense nisso: há muitos dispositivos iOS em 
que seu aplicativo pode ser executado, todos com tamanhos diferentes. Então, como a visualização da imagem deve responder quando está 
sendo mostrada em um 6 Plus ou talvez até mesmo em um iPad?

O iOS tem uma resposta para isso. E é uma resposta brilhante que, de muitas maneiras, funciona como mágica para fazer o que você quer. 
É chamado de Layout Automático: ele permite que você defina regras sobre como suas visualizações devem ser dispostas e garante automaticamente 
que essas regras sejam seguidas.

Mas - e este é um grande mas! - tem duas regras próprias, ambas seguidas por você:

- Suas regras de layout devem estar completas. Ou seja, você não pode especificar apenas uma posição X para alguma coisa, 
você também deve especificar uma posição Y. Se já faz um tempo desde que você estava na escola, "X" é a posição da esquerda da 
tela, e "Y" é a posição da parte superior da tela.

- Suas regras de layout não devem entrar em conflito. Ou seja, você não pode especificar que uma vista deve estar a 10 pontos de 
distância da borda esquerda, a 10 pontos da borda direita e 1000 pontos de largura. A tela do iPhone 5 tem apenas 320 pontos de 
largura, então seu layout é matematicamente impossível. O Layout Automático tentará se recuperar desses problemas quebrando regras 
até encontrar uma solução, mas o resultado final nunca é o que você deseja.

Você pode criar regras de Layout Automático - conhecidas como restrições - inteiramente dentro do Interface Builder, e ele irá avisá-lo 
se você não estiver seguindo as duas regras. Isso até ajudará você a corrigir quaisquer erros que você cometer, sugerindo correções. 
Nota: as correções que ele sugere podem estar corretas, mas podem não estar - pise com cuidado!

Vamos criar quatro restrições agora: uma para cada uma para a parte superior, inferior, esquerda e direita da visualização da imagem, 
para que ela se expanda para preencher o controlador de visualização de detalhes, independentemente do seu tamanho. Existem muitas 
maneiras de adicionar restrições de Layout Automático, mas a maneira mais fácil agora é selecionar a visualização da imagem, depois 
ir para o menu Editor e escolher > Resolver Problemas de Layout Automático > Redefinir para Restrições Sugeridas.

Você verá essa opção listada duas vezes no menu porque existem duas opções sutilmente diferentes, mas, neste caso, não importa 
qual você escolha. Se você preferir atalhos de teclado, pressione Shift+Alt+Cmd+= para fazer a mesma coisa.

Visually, your layout will look pretty much identical once you've added the constraints, but there are two subtle differences. 
First, there's a thin blue line surrounding the UIImageView on the detail view controller, which is Interface Builder's way of 
showing you that the image view has a correct Auto Layout definition.

Em segundo lugar, no painel de estrutura de tópicos do documento, você verá uma nova entrada para "Restrições" abaixo da visualização 
da imagem. Todas as quatro restrições que foram adicionadas estão ocultas sob esse item Restrições, e você pode expandi-lo para visualizá-las 
individualmente se estiver curioso.

Com as restrições adicionadas, há mais uma coisa a fazer aqui antes de terminarmos com o Interface Builder, e isso é conectar nossa 
nova visualização de imagem a algum código. Você vê, ter a visualização de imagem dentro do layout não é suficiente - se realmente 
quisermos usar a visualização de imagem dentro do código, precisamos criar uma propriedade para ela que esteja anexada ao layout.

This property is like the pictures array we made previously, but it has a little bit more “interesting” Swift syntax we need to cover. 
Even more cunningly, it’s created using a really bizarre piece of user interface design that will send your brain for a loop if you’ve 
used other graphical IDEs.

Vamos mergulhar e eu explico no caminho. O Xcode tem um layout de exibição especial chamado Editor Assistente, que divide seu editor 
Xcode em dois: a visualização que você tinha antes na parte superior e uma visualização relacionada na parte inferior. Nesse caso, 
ele nos mostrará o Interface Builder na parte superior e o código para o controlador de visualização detalhada abaixo.

O Xcode decide qual código mostrar com base no item selecionado no Interface Builder, portanto, verifique se a visualização da imagem 
ainda está selecionada e escolha Exibir > Editor Assistente > Mostrar Editor Assistente no menu. Você também pode usar o atalho de 
teclado Alt+Cmd+Return, se preferir.

O Xcode pode exibir o editor assistente como dois painéis verticais em vez de dois painéis horizontais. Acho os painéis horizontais 
mais fáceis - ou seja, um acima do outro. Você pode alternar entre eles indo para Exibir > Editor Assistente e escolhendo Editores 
Assistentes à Direita ou Editores Assistentes na Parte Inferior.

Independentemente de qual você preferir, agora você deve ver o controlador de visualização de detalhes no Interface Builder em um 
painel e, no outro painel, o código-fonte de DetailViewController.swift. O Xcode sabe carregar DetailViewController.swift porque 
você mudou a classe para esta tela para "DetailViewController" logo depois de alterar seu ID de storyboard.

Agora, a peça bizarra da interface do usuário. O que eu quero que você faça é o seguinte:

1. Certifique-se de que a visualização da imagem esteja selecionada.

2. Mantenha pressionada a tecla Ctrl no seu teclado.

3. Pressione o botão do mouse na visualização da imagem, mas mantenha-o pressionado - não o solte.

4. Enquanto continua pressionando Ctrl e o botão do mouse, arraste da visualização da imagem para o seu código - para o 
outro painel do editor assistente.

5. As you move your mouse cursor, you should see a blue line stretch out from the image view into your code. Stretch that line 
so that it points between class DetailViewController: UIViewController { and override func viewDidLoad() {.

6. Quando você está entre esses dois, uma linha azul horizontal deve aparecer, juntamente com uma dica de ferramenta dizendo Inserir 
Conexão de Saída ou Tomada. Quando você vir isso, solte Ctrl e o botão do mouse. (Não importa qual você libere primeiro.)

Se você seguir essas etapas, um balão deve aparecer com cinco campos: Conexão, Objeto, Nome, Tipo e Armazenamento.



---------- 2. LOADING IMAGES WITH UIIMAGE 

Neste ponto, temos nosso controlador de visualização de mesa original cheio de imagens para selecionar, além de um controlador de 
visualização de detalhes em nosso storyboard. O próximo objetivo é mostrar a tela de detalhes quando qualquer linha da tabela for 
tocado e fazer com que ela mostre a imagem selecionada.

To make this work we need to add another specially named method to ViewController. This one is called tableView(_, didSelectRowAt:), 
which takes an IndexPath value just like cellForRowAt that tells us what row we’re working with. This time we need to do a bit more work:

1. We need to create a property in DetailViewController that will hold the name of the image to load.

2. We’ll implement the didSelectRowAt method so that it loads a DetailViewController from the storyboard.

3. Finally, we’ll fill in viewDidLoad() inside DetailViewController so that it loads an image into its image view based on the name we set earlier.

Let’s solve each of those in order, starting with the first one: creating a property in DetailViewController that will hold 
the name of the image to load.

Esta propriedade será uma string - o nome da imagem a ser carregada - mas precisa ser uma string opcional porque quando o controlador 
de visualização for criado pela primeira vez, ele não existirá. Vamos configurá-lo imediatamente, mas ainda começa a vida vazia.

So, add this property to DetailViewController now, just below the existing @IBOutlet line:

var selectedImage: String?

That’s the first task done, so onto the second: implement didSelectRowAt so that it loads a DetailViewController from the storyboard.

Quando criamos o controlador de visualização de detalhes, você deu a ele o ID do storyboard "Detail", que nos permite carregá-lo a partir 
do storyboard usando um método chamado instantiateViewController(withIdentifier:) Todo controlador de visualização tem uma propriedade 
chamada storyboard, que é o storyboard do qual foi carregado ou nulo. No caso do ViewController, será Main.storyboard, que é o mesmo 
storyboard que contém o controlador de visualização de detalhes, então estaremos carregando a partir daí.

Podemos dividir essa tarefa em três tarefas menores, duas das quais são novas:

1. Carregue o layout do controlador de visualização detalhada do nosso storyboard.

2. Set its selectedImage property to be the correct item from the pictures array.

3. Mostre o novo controlador de visualização.

The first of those is done by calling instantiateViewController, but it has two small complexities. 
First, we call it on the storyboard property that we get from Apple’s UIViewController type, but it’s optional because Swift 
doesn’t know we came from a storyboard. So, we need to use ? just like when we were setting the text label of our cell: “try doing 
this, but do nothing if there was a problem.”

Second, even though instantiateViewController() will send us back a DetailViewController if everything worked correctly, 
Swift thinks it will return back a UIViewController because it can’t see inside the storyboard to know what’s what.

Isso vai parecer confuso se você for novo em programação, então deixe-me tentar explicar usando uma analogia. Digamos que você queira 
sair para um encontro hoje à noite, então você me pede para organizar alguns ingressos para um evento. Eu saio, encontro ingressos e 
depois os entrego a você em um envelope. Eu cumpri minha parte do acordo: você pediu ingressos, eu comprei ingressos para você. Mas 
quais são os ingressos - ingressos para um evento esportivo? Ingressos para uma ópera? Passagens de trem? A única maneira de você 
descobrir é abrir o envelope e olhar.

Swift has the same problem: instantiateViewController() has the return type UIViewController, so as far as Swift is concerned any 
view controller created with it is actually a UIViewController. This causes a problem for us because we want to adjust the property 
we just made in DetailViewController. The solution: we need to tell Swift that what it has is not what it thinks it is.

O termo técnico para isso é "typecasting": pedir à Swift para tratar um valor como um tipo diferente. Swift tem várias maneiras de fazer 
isso, mas vamos usar a versão mais segura: isso efetivamente significa: "por favor, tente tratar isso como um DetailViewController, mas 
se falhar, não faça nada e siga em frente".

Once we have a detail view controller on our hands, we can set its selectedImage property to be equal to pictures[indexPath.row] just 
like we were doing in cellForRowAt – that’s the easy bit.

The third mini-step is to make the new screen show itself. You already saw that view controllers have an optional storyboard property 
that either contains the storyboard they were loaded from or nil. Well, they also have an optional navigationController property that 
contains the navigation controller they are inside if it exists, or nil otherwise.

Isso é perfeito para nós, porque os controladores de navegação são responsáveis por mostrar telas. Claro, eles fornecem aquela boa barra 
cinza na parte superior que você vê em muitos aplicativos, mas também são responsáveis por manter uma grande pilha de telas pelas quais 
os usuários navegam.

Por padrão, eles contêm o primeiro controlador de visualização que você criou para eles no storyboard, mas quando novas telas são criadas, 
você pode enviá-las para a pilha do controlador de navegação para que elas deslizem sem problemas, assim como você vê em Configurações. 
À medida que mais telas são pressionadas, elas continuam deslizando. Quando os usuários voltam uma tela - ou seja, tocando em Voltar ou 
deslizando da esquerda para a direita - o controlador de navegação destruirá automaticamente o controlador de visualização antigo e 
liberará sua memória.

Essas três minietapas completam o novo método, então é hora do código. Adicione este método ao ViewController.swift - Adicionei comentários 
para facilitar a compreensão:

override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    // 1: try loading the "Detail" view controller and typecasting it to be DetailViewController
    if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
        // 2: success! Set its selectedImage property
        vc.selectedImage = pictures[indexPath.row]

        // 3: now push it onto the navigation controller
        navigationController?.pushViewController(vc, animated: true)
    }
}

Let’s look at the if let line a bit more closely for a moment. There are three parts of it that might fail: the storyboard 
property might be nil (in which case the ? will stop the rest of the line from executing), the instantiateViewController() call 
might fail if we had requested “Fzzzzz” or some other invalid storyboard ID, and the typecast – the as? part – also might fail, 
because we might have received back a view controller of a different type.

So, three things in that one line have the potential to fail. If you’ve followed all my steps correctly they won’t fail, but they 
have the potential to fail. That’s where if let is clever: if any of those things return nil (i.e., they fail), then the code inside 
the if let braces won’t execute. This guarantees your program is in a safe state before any action is taken.

Só resta uma pequena coisa a fazer antes que você possa dar uma olhada nos resultados: precisamos fazer com que a imagem realmente 
seja carregada na visualização da imagem no DetailViewController.

This new code will draw on a new data type, called UIImage. This doesn't have "View" in its name like UIImageView does, so it's not 
something you can view – it's not something that's actually visible to users. Instead, UIImage is the data type you'll use to load 
image data, such as PNG or JPEGs.

When you create a UIImage, it takes a parameter called named that lets you specify the name of the image to load. UIImage then looks 
for this filename in your app's bundle, and loads it. By passing in the selectedImage property here, which was sent from ViewController, 
this will load the image that was selected by the user.

However, we can’t use selectedImage directly. If you remember, we created it like this:

var selectedImage: String?

That ? means it might have a value or it might not, and Swift doesn’t let you use these “maybes” without checking them first. 
This is another opportunity for if let: we can check that selectedImage has a value, and if so pull it out for usage; otherwise, do nothing.

Add this code to viewDidLoad() inside DetailViewController, after the call to super.viewDidLoad():

if let imageToLoad = selectedImage {
    imageView.image  = UIImage(named: imageToLoad)
}

The first line is what checks and unwraps the optional in selectedImage. If for some reason selectedImage is nil (which it should never be, 
in theory) then the imageView.image line will never be executed. If it has a value, it will be placed into imageToLoad, then passed to 
UIImage and loaded.

OK, é isso aí: pressione play ou Cmd+R agora para executar o aplicativo e experimentá-lo! Você deve ser capaz de selecionar qualquer 
uma das imagens para que elas deslizem e sejam exibidas em tela cheia.

Observe que temos um botão Voltar na barra de navegação que nos permite voltar ao ViewController. Se você clicar e arrastar com cuidado, 
descobrirá que também pode criar um gesto de deslizar - clique na borda esquerda da tela e arraste para a direita, assim como faria com o 
polegar em um telefone.



---------- 3. FINAL TWEAKS: hidesBarsOnTap AND LARGE TITLES 

Neste ponto, você tem um projeto de trabalho: você pode pressionar Cmd+R para executá-lo, percorrer as imagens na tabela e tocar 
em um para visualizá-lo. Mas antes que este projeto seja concluído, há várias outras pequenas mudanças que faremos que tornam o 
resultado final um pouco mais polido.

Primeiro, você deve ter notado que todas as imagens estão sendo esticadas para caber na tela. Isso não é um acidente - é a configuração 
padrão do UIImageView.

Isso leva apenas alguns cliques para corrigir: escolha Main.storyboard, selecione a visualização da imagem no controlador de 
visualização de detalhes e, em seguida, escolha o inspetor de atributos. Isso está no painel direito, perto do topo, e é o quarto 
de seis inspetores, logo à esquerda do ícone da régua.

Se você não gosta de caçar por aí, basta pressionar Cmd+Alt+4 para trazê-lo à tona. O alongamento é causado pelo modo de visualização, 
que é um botão suspenso que usa como padrão "Ajuste de aspecto" ou "Preenchimento de aspecto", dependendo da sua versão do Xcode. Tente 
mudar isso para "Preenchimento de aspecto" para ver a imagem dimensionada para se adequar ao espaço disponível.

Se você estava se perguntando, o Aspect Fit dimensiona a imagem para que tudo fique visível. Há também Scale to Fill, que dimensiona a 
imagem para que não haja espaço em branco, esticando-a em ambos os eixos. Se você usar o Aspect Fill, a imagem ficará efetivamente fora 
de sua área de visualização, portanto, certifique-se de ativar o Clip To Bounds para evitar o derramamento excessivo da imagem.

The second change we're going to make is to allow users to view the images fullscreen, with no navigation bar getting in their way. 
There's a really easy way to make this happen, and it's a property on UINavigationController called hidesBarsOnTap. When this is set 
to true, the user can tap anywhere on the current view controller to hide the navigation bar, then tap again to show it.

Esteja avisado: você precisa configurá-lo com cuidado ao trabalhar com iPhones. Se o tivéssemos configurado o tempo todo, isso afetaria 
os toques na visualização da tabela, o que causaria estragos quando o usuário tentasse selecionar coisas. Portanto, precisamos ativá-lo 
ao mostrar o controlador de visualização detalhada e, em seguida, desativá-lo ao se esconder.

You already met the method viewDidLoad(), which is called when the view controller's layout has been loaded. There are several others 
that get called when the view is about to be shown, when it has been shown, when it's about to go away, and when it has gone away. 
These are called, respectively, viewWillAppear(), viewDidAppear(), viewWillDisappear() and viewDidDisappear(). We're going to use 
viewWillAppear() and viewWillDisappear() to modify the hidesBarsOnTap property so that it's set to true only when the detail view 
controller is showing.

Abra DetailViewController.swift e adicione estes dois novos métodos diretamente abaixo do final do método viewDidLoad():

override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    navigationController?.hidesBarsOnTap = true
}

override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    navigationController?.hidesBarsOnTap = false
}

Há algumas coisas importantes a serem observadas lá:

- We're using override for each of these methods, because they already have defaults defined in UIViewController and we're asking 
it to use ours instead. Don't worry if you aren't sure when to use override and when not, because if you don't use it and it's 
required Xcode will tell you.

- Ambos os métodos têm um único parâmetro: se a ação é animada ou não. Nós realmente não nos importamos neste caso, então ignoramos isso.

- Both methods use the super prefix again: super.viewWillAppear() and super.viewWillDisappear(). This means "tell my parent data 
type that these methods were called." In this instance, it means that it passes the method on to UIViewController, which may do its 
own processing.

- We’re using the navigationController property again, which will work fine because we were pushed onto the navigation controller 
stack from ViewController. We’re accessing the property using ?, so if somehow we weren’t inside a navigation controller the hidesBarsOnTap 
lines will do nothing.

Se você executar o aplicativo agora, verá que pode tocar para ver uma imagem em tamanho real, e ela não será mais esticada. 
Enquanto visualiza uma imagem, você pode tocar para ocultar a barra de navegação na parte superior e, em seguida, tocar para mostrá-la novamente.

A terceira mudança é pequena, mas importante. Se você olhar para outros aplicativos que usam visualizações de tabela e controladores 
de navegação para exibir telas (novamente, Configurações é ótimo para isso), poderá notar setas cinza à direita das células da 
visualização de tabela. Isso é chamado de indicador de divulgação, e é uma dica sutil da interface do usuário de que tocar nesta 
linha mostrará mais informações.

São necessários apenas alguns cliques no Interface Builder para obter esta seta de divulgação em nossa visualização de tabela. 
Abra Main.storyboard e clique na célula de visualização de tabela - essa é a que diz "Título", logo abaixo de "Células de protótipo". 
A visualização de tabela contém uma célula, a célula contém uma visualização de conteúdo e a visualização de conteúdo contém um rótulo 
chamado "Título", por isso é fácil selecionar a coisa errada. Como resultado, é provável que você ache mais fácil usar o esboço do 
documento para selecionar exatamente a coisa certa - você deseja selecionar a coisa marcada como "Imagem", que é o identificador 
de reutilização que anexamos à nossa célula de visualização de tabela.

Quando isso for selecionado, você poderá ir ao inspetor de atributos e ver "Estilo: Básico", "Identificador: Imagem" e assim por diante. 
Você também verá "Acessório: Nenhum" - altere isso para "Indicador de Divulgação", o que fará com que a seta cinza apareça.

The fourth is small but important: we’re going to place some text in the gray bar at the top. You’ve already seen that view 
controllers have storyboard and navigationController properties that we get from UIViewController. Well, they also have a title 
property that automatically gets read by navigation controller: if you provide this title, it will be displayed in the gray navigation 
bar at the top.

In ViewController, add this code to viewDidLoad() after the call to super.viewDidLoad():

title = "Storm Viewer"

Este título também é usado automaticamente para o botão "Voltar", para que os usuários saibam para o que estão voltando.

No DetailViewController, poderíamos adicionar algo assim ao viewDidLoad():

title = "View Picture"

Isso funcionaria bem, mas, em vez disso, vamos usar algum texto dinâmico: em vez disso, exibiremos o nome da imagem selecionada.

Add this to viewDidLoad() in DetailViewController:

title = selectedImage

We don’t need to unwrap selectedImage here because both selectedImage and title are optional strings – we’re assigning one optional 
string to another. title is optional because it’s nil by default: view controllers have no title, thus showing no text in the navigation bar.

Títulos grandes

Esta é uma mudança totalmente opcional, mas eu queria apresentá-la a você bem cedo para que você possa experimentá-la por si mesmo e 
ver o que acha.

Uma das diretrizes de design da Apple é o uso de títulos grandes - o texto que aparece na barra cinza na parte superior dos aplicativos. 
O estilo padrão é o texto pequeno, que é o que tivemos até agora, mas com algumas linhas de código podemos adotar o novo design.

First, add this to viewDidLoad() in ViewController.swift:

navigationController?.navigationBar.prefersLargeTitles = true

Isso permite títulos grandes em todo o nosso aplicativo, e você verá uma diferença imediata: "Visualizador de Tempestade" 
se torna muito maior e, no controlador de visualização de detalhes, todos os títulos de imagem também são grandes. 
Você também notará que o título também não é mais estático - se você puxar suavemente, verá que ele se estica um pouco, 
e se você tentar rolar para cima em nossa visualização de tabela, verá os títulos encolherem.

A Apple recomenda que você use títulos grandes apenas quando faz sentido, e isso geralmente significa apenas na primeira tela 
do seu aplicativo. Como você viu, o comportamento padrão quando ativado é ter títulos grandes em todos os lugares, mas isso 
ocorre porque cada novo controlador de visualização que empurrou para a pilha do controlador de navegação herda o estilo de seu antecessor.

In this app we want “Storm Viewer” to appear big, but the detail screen to look normal. To make that happen we need to add a 
line of code to viewDidLoad() in DetailViewController.swift:

navigationItem.largeTitleDisplayMode = .never

Isso é tudo o que é preciso - os títulos grandes devem se comportar corretamente agora.


