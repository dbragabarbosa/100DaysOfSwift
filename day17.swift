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

