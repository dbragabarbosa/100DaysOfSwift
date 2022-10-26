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



