26/10/2022


Project 13, part one


Estamos de volta à nossa programação regular hoje, começando com outro aplicativo totalmente novo chamado Instafilter. 
Você conhecerá um importante componente UIKit chamado UISlider, mas, mais importante, você aprenderá como o Core Image 
nos permite criar efeitos de imagem em tempo real.

Como você verá, o Core Image é uma das estruturas mais avançadas disponíveis no iOS, permitindo-nos criar todos os tipos 
de efeitos de imagem poderosos com apenas algumas linhas de código. No entanto, também é lento no simulador - enquanto 
você pode experimentá-lo lá fora, se possível, eu recomendaria executar seu código em um dispositivo real. Mesmo um iPhone 
antigo provavelmente terá um desempenho melhor do que o simulador em execução nos Macs mais recentes.

À medida que embarcamos na próxima série de projetos de aplicativos, você verá que as coisas que cobrimos começam a mudar 
um pouco: olhamos para componentes mais avançados e também olhamos para alguns componentes de nicho. Embora estes sejam 
muito menos comumente usados do que coisas como UITableViewController, eu os incluo no curso porque fazem parte de um 
quebra-cabeça maior do desenvolvimento do iOS.

À medida que você progride, o que você descobrirá é raro que você tenha uma ideia de aplicativo que seja totalmente 
coberta por um dos meus projetos aqui. Em vez disso, você vai querer um pedaço de projeto 9, um pedaço de projeto 3, 
um pedaço de projeto 18 e algum trabalho novo seu. Então, ao ampliar seus horizontes com coisas como MapKit, notificações 
e iBeacons, estou lhe dando o conhecimento de longo prazo para ajudar seus próprios sonhos de aplicativos a se tornarem 
realidade no futuro.

Sim, eu sei que é tentador vagar e tentar outra coisa em vez disso, mas fique comigo. Como disse Alexa Hirschfeld, 
“o maior desafio é manter o foco - ter a disciplina quando há tantas coisas concorrentes”.

Today you have three topics to work through, and you’ll learn about UISlider while also getting some practice with 
UIImagePickerController, and more.


---------- Setting up

In project 10 you learned how to use UIImagePickerController to select and import a 
picture from your user's photo library. In this project, we're going to add the reverse: 
writing images back to the photo library. But because you're here to learn as much as possible, 
I'm also going to introduce you to another UIKit component, UISlider, and also a little bit of Core Image, 
which is Apple's high-speed image manipulation toolkit.

O projeto que vamos fazer permitirá que os usuários escolham uma imagem de suas fotos e, em seguida, a manipulem com 
uma série de filtros Core Image. Uma vez felizes, eles podem salvar a imagem processada de volta em sua biblioteca de fotos.

Para começar, crie um novo projeto de Aplicativo de Visualização Única no Xcode e nomeie-o Project13.



---------- Designing the interface

Selecione seu arquivo Main.storyboard para abrir o Interface Builder e, em seguida, incorpore o controlador de 
visualização dentro de um controlador de navegação.

Abra a biblioteca de objetos, depois pesquise por "UIView" e arraste uma visualização para o seu controlador - esta é uma 
visualização regular, não um controlador de visualização ou uma referência de storyboard. Se o Interface Builder já 
estiver usando o dimensionamento do iPhone 8, dê à nova visualização uma largura de 375 e uma altura de 470, com X:0 
e Y:64. Se você não tiver certeza, procure as palavras "Visualizar como: iPhone 8" na parte inferior do Interface Builder 
- se você vir outra coisa, clique nele e selecione iPhone 8 e Retrato.

Tudo bem, usando 375x470 e X:0 Y:64 deve colocar a visão logo abaixo do controlador de navegação, ocupando a maior parte 
da tela. No inspetor de atributos, dê à visualização a cor de fundo "Cor Cinza Escuro".

Crie uma visualização de imagem e coloque-a dentro da visualização que você acabou de criar. Eu gostaria que você recuse 
por 10 pontos em cada lado - ou seja, largura 355, altura 450, X:10, Y:10. Altere o modo de visualização da imagem de 
"Escala para preencher" para "Aspect Fit". Não coloque mais visualizações dentro da visualização cinza - todo o resto 
deve ser colocado diretamente na visualização principal (branca).

Essa é a parte superior da interface do usuário completa. Para a parte inferior, comece criando uma etiqueta com 
largura 72, altura 21, X:16, Y:562. Dê a ele o texto "Intensidade" e faça-o alinhado corretamente. Agora solte um 
controle deslizante ao lado dele, dando-lhe largura 262, X:96, Y:558. Você não pode ajustar a altura dos controles 
deslizantes, então deixe-a no padrão.

Finalmente, coloque dois botões. O primeiro botão deve ter 120 de largura e 44 de altura, com X:16, Y:605. Dê a ele o 
título "Alterar Filtro". O segundo botão deve ter 60 de largura por 44 de altura, com X:300, Y:605. Dê a ele o título 
"Salvar".

Na imagem abaixo, você pode ver como seu layout acabado deve ficar.

Então esse é o layout básico completo, mas é claro que precisamos adicionar restrições de Layout Automático porque 
precisamos de tudo para redimensionar sem problemas em vários dispositivos. Mas, você sabe, estou me sentindo preguiçoso 
- que tal fazermos o Auto Layout fazer o trabalho para nós desta vez?

Selecione o controlador de visualização clicando em "Visualizar Controlador" no esboço do documento, depois vá para o 
menu Editor e escolha Resolver Problemas de Layout Automático > Redefinir para Restrições Sugeridas.

É isso aí! Seu Layout Automático está pronto: o Xcode acabou de adicionar as restrições ideais em todos os lugares para 
que sua interface seja redimensionada perfeitamente. Não acredita em mim? Tente dar à visualização da imagem uma cor de 
fundo vermelha (temporariamente!), em seguida, inicie-a em qualquer dispositivo e gire a tela. Você deve ver tudo 
(incluindo a caixa vermelha) ser posicionado e redimensionado corretamente.

Certifique-se de mudar a visualização da imagem de volta para ter uma cor de fundo clara.

Isso foi notavelmente fácil, e é outro exemplo de que a Apple está fazendo muito trabalho duro para você. Usar o Xcode 
para fazer suas regras de Layout Automático pode ser uma ajuda real, mas não será certo o tempo todo. Afinal, ele só 
faz o seu melhor palpite quanto às suas intenções. Ele também frequentemente adicionará mais restrições do que o 
estritamente necessário para o trabalho, então use-o com cuidado.

Before we leave Interface Builder, I'd like you to add an outlet for the image view and the slider, called respectively 
imageView and intensity. Please also create actions from the two buttons, calling methods changeFilter() and save(). 
You can leave these methods with no code inside them for now.

Finalmente, queremos que a interface do usuário seja atualizada quando o controle deslizante for arrastado, então crie 
uma ação a partir do controle deslizante. Deve dar a você o evento "Valor Alterado" em vez de Touch Up Inside, e é isso 
que queremos. Chame o método da ação intensityChanged().

É isso para o storyboard, então traga ViewController.swift e vamos começar a codificar...



