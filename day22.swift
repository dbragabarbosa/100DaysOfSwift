30/05/2022


PROJECT 3

O famoso autor brasileiro Paulo Coelho disse: “O Twitter é o meu bar: eu me sento no balcão e ouço as conversas, 
iniciando outras, sentindo a atmosfera.” Quer você use muito ou não, as mídias sociais são uma enorme força 
motriz para a mudança em nosso mundo.

Para os desenvolvedores de aplicativos, as mídias sociais também são uma chance para nossos usuários falarem 
sobre nosso aplicativo: compartilhar coisas que encontraram, ou talvez apenas dizer ao mundo o quanto eles adoram. 
Isso ajuda a quebrar a sensação de que nosso aplicativo está contido no dispositivo deles - se pudermos ajudá-los 
a se comunicar com amigos on-line, eles nos agradecerão por isso.

Então, hoje você vai conhecer seu primeiro projeto de técnica: um projeto especificamente dedicado ao ensino de 
uma habilidade específica do iOS ou Swift. Isso às vezes envolve novos projetos, e outras vezes envolve a mudança 
de projetos existentes, mas você sempre aprenderá algo novo.

Today you have three topics to work through, and you’ll meet UIBarButtonItem and UIActivityViewController. 
Once that’s done, complete the chapter review, then work through all three of its challenges.


---------- 1. ABOUT TECHNIQUE PROJECTS 

Como você deve saber, esta série segue o aplicativo de pedidos, o jogo, a técnica. O Project 1 era um 
aplicativo que permitia os usuários navegarem por imagens em seus telefones, o Project 2 era um jogo que 
permite que os jogadores adivinharem bandeiras, então agora é hora do primeiro projeto de técnica.

O objetivo dos projetos técnicos é escolher uma tecnologia iOS e se concentrar nela em profundidade. 
Alguns serão fáceis, outros nem tanto, mas prometo tentar mantê-los o mais curto possível, porque sei 
que você quer se concentrar em fazer coisas reais.

Este primeiro projeto de técnica vai ser muito simples, porque vamos modificar o projeto 1 para fazer algo 
que ele não faz atualmente: permitir que os usuários compartilhem imagens com seus amigos.



---------- 2. UIActivityViewController explained 

Compartilhar coisas usando o iOS usa um componente poderoso e padrão ao qual outros apps podem se conectar. Como resultado, 
deve ser sua primeira porta de chamada ao adicionar compartilhamento a um aplicativo. Este componente é chamado UIActivityViewController: 
você diz a ele que tipo de dados deseja compartilhar e descobre a melhor forma de compartilhá-los.

As we're working with images, UIActivityViewController will automatically give us functionality to share by iMessage, by 
email and by Twitter and Facebook, as well as saving the image to the photo library, assigning it to contact, printing it 
out via AirPrint, and more. It even hooks into AirDrop and the iOS extensions system so that other apps can read the image 
straight from us.

O melhor de tudo é que são necessárias apenas algumas linhas de código para que tudo funcione. Mas antes de tocarmos no 
UIActivityViewController, primeiro precisamos dar aos usuários uma maneira de acionar o compartilhamento, e a maneira como 
vamos usá-lo é adicionar um item de botão de barra.

Project 1, if you recall, used a UINavigationController to let users move between two screens. By default, a UINavigationController 
has a bar across the top, called a UINavigationBar, and as developers we can add buttons to this navigation bar that call our methods.

Let's create one of those buttons now. First, take a copy of your existing Project1 folder (the whole thing), and rename it 
to be Project3. Now launch it in Xcode, open the file DetailViewController.swift, and find the viewDidLoad() method. Directly 
beneath the title = line,

navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))

Você receberá um erro por um momento, mas tudo bem; continue lendo.

This is easily split into two parts: on the left we're assigning to the rightBarButtonItem of our view controller's navigationItem. 
This navigation item is used by the navigation bar so that it can show relevant information. In this case, we're setting the 
right bar button item, which is a button that appears on the right of the navigation bar when this view controller is visible.

On the right we create a new instance of the UIBarButtonItem data type, setting it up with three parameters: a system item, 
a target, and an action. The system item we specify is .action, but you can type . to have code completion tell you the many 
other options available. The .action system item displays an arrow coming out of a box, signaling the user can do something 
when it's tapped.

The target and action parameters go hand in hand, because combined they tell the UIBarButtonItem what method 
should be called. The action parameter is saying "when you're tapped, call the shareTapped() method," and the 
target parameter tells the button that the method belongs to the current view controller – self.

The part in #selector bears explaining a bit more, because it's new and unusual syntax. What it does is tell the 
Swift compiler that a method called "shareTapped" will exist, and should be triggered when the button is tapped. 
Swift will check this for you: if we had written "shareTaped" by accident – missing the second P – Xcode will 
refuse to build our app until we fix the typo.

Se você não gosta da aparência dos vários itens de botão da barra do sistema disponíveis, você pode criar um com seu 
próprio título ou imagem. No entanto, geralmente é preferível usar os itens do sistema sempre que possível, porque 
os usuários já sabem o que fazem.

Com o botão de barra criado, é hora de criar o método shareTapped(). Você está pronto para essa quantidade enorme e 
complicada de código? Aqui vai! Coloque isso logo após o método viewWillDisappear():

@objc func shareTapped() {
    guard let image = imageView.image?.jpegData(compressionQuality: 0.8) else {
        print("No image found")
        return
    }

    let vc = UIActivityViewController(activityItems: [image], applicationActivities: [])
    vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
    present(vc, animated: true)
}

That's it. With those handful of lines of code, shareTapped() can send photos via AirDrop, post to Twitter, 
and much more. You have to admit, iOS can be pretty amazing sometimes!

A lot of that code is old; we already learned about present() in project 2. However, some other parts are new, 
so let me explain what they do:

- We start with the method name, marked with @objc because this method will get called by the underlying 
Objective-C operating system (the UIBarButtonItem) so we need to mark it as being available to Objective-C code. 
When you call a method using #selector you’ll always need to use @objc too.

- Our image view may or may not have an image inside, so we’ll read it out safely and convert it to JPEG data. 
This has a compressionQuality parameter where you can specify a value between 1.0 (maximum quality) and 0.0 (minimum quality_.

- Em seguida, criamos um UIActivityViewController, que é o método iOS de compartilhar conteúdo com outros aplicativos e serviços.

- Finalmente, dizemos ao iOS onde o controlador de visualização de atividades deve estar ancorado - de onde ele deve aparecer.

No iPhone, os controles de visualização de atividade ocupam automaticamente a tela cheia, mas no iPad eles aparecem como um 
popover que permite que o usuário veja no que estava trabalhando abaixo. Esta linha de código diz ao iOS para ancorar o 
controlador de visualização de atividades no item do botão da barra direita (nosso botão de compartilhamento), mas isso 
só tem um efeito no iPad - no iPhone é ignorado.

Tip: In case you were wondering, when you use @IBAction to make storyboards call your code, that automatically implies @objc – 
Swift knows that no @IBAction makes sense unless it can be called by Objective-C code.

Vamos nos concentrar em como os controladores de visualização de atividade são criados. Como você pode ver no código, 
você passa dois itens: uma matriz de itens que deseja compartilhar e uma matriz de qualquer um dos serviços do seu próprio 
aplicativo que você deseja garantir que estejam na lista. Estamos passando um array vazio para o segundo parâmetro, 
porque nosso aplicativo não tem nenhum serviço a oferecer. Mas se você estendesse este aplicativo para ter algo como 
"Outras imagens como esta", por exemplo, então você incluiria essa funcionalidade aqui.

Então, o foco real está no primeiro parâmetro: estamos passando [image] Esses dados são os dados JPEG que descrevem 
a imagem selecionada pelo usuário, e o iOS entende que é uma imagem para que possa publicá-la no Twitter, Facebook e 
em outros lugares.

E... é isso. Não, sério. Estamos praticamente prontos: seu aplicativo agora suporta compartilhamento.

Don’t worry if you’re not sure about @objc just yet – we’ll be coming back to it again and again. The main thing to 
remember is that when Swift code calls a Swift method that method doesn’t need to be marked @objc. On the other hand, 
when Objective-C code needs to call a Swift method – and that’s any time it gets called by one of Apple’s UI components, 
for example – then the @objc is required.


Corrigindo um pequeno bug

Há um bug pequeno, mas importante, com o código atual: se você selecionar Salvar Imagem dentro do controlador de 
visualização de atividades, verá o aplicativo travar imediatamente. O que está acontecendo aqui é que nosso aplicativo 
tenta acessar a biblioteca de fotos do usuário para que ele possa gravar a imagem lá, mas isso não é permitido no iOS, 
a menos que o usuário conceda permissão primeiro.

Para corrigir isso, precisamos editar o arquivo Info.plist do nosso projeto. Ainda não tocamos nisso, mas ele foi 
projetado para manter as configurações do seu aplicativo que nunca mudarão ao longo do tempo.

Selecione Info.plist no navegador do projeto e, quando vir uma grande tabela cheia de dados, clique com o botão direito 
do mouse no espaço em branco abaixo disso. Clique em "Adicionar Linha" no menu que aparece, e você verá uma nova lista 
de opções que começa com "Categoria de Aplicativos".

O que eu gostaria que você fizesse é rolar para baixo nessa lista e encontrar o nome "Privacidade - Descrição de Uso de Adições à Fototeca". 
Isso é o que será mostrado ao usuário quando seu aplicativo precisar adicionar à sua biblioteca de fotos.

Ao selecionar "Privacidade - Descrição de Uso de Adições à Fototeca", você verá "String" aparecer à direita dela, 
e à direita de "String" haverá um espaço em branco vazio. Esse espaço em branco é onde você pode digitar algum texto 
para mostrar ao usuário que explique o que seu aplicativo pretende fazer com sua biblioteca de fotos.

Neste aplicativo, só precisamos salvar imagens, então coloque este texto na caixa: "Precisamos salvar as fotos que você gosta".

Agora tente executar o aplicativo novamente, e desta vez selecionar "Salvar Imagem" mostrará uma mensagem perguntando 
se o usuário está bem com o aplicativo escrevendo em suas fotos - muito melhor!



---------- 3. WRAP UP 

This was a deliberately short technique project taking an existing app and making it better. 
I hope you didn't get too bored, and hope even more that some of the new material sunk in because we 
covered UIBarButtonItem and UIActivityViewController.

Como você viu, é realmente trivial adicionar mídias sociais aos seus aplicativos, e isso pode fazer uma enorme 
diferença para ajudar a divulgar seu trabalho assim que seus aplicativos estiverem na App Store. Tudo bem, este 
projeto também mostrou como é fácil voltar aos projetos anteriores e melhorá-los com apenas um pouco de esforço extra.


Revise o que você aprendeu

Qualquer um pode assistir a um tutorial, mas é preciso trabalho real para lembrar o que foi ensinado. 
É meu trabalho garantir que você aproveite o máximo possível desses tutoriais, então preparei uma breve 
revisão para ajudá-lo a verificar seu aprendizado.


Desafio

Uma das melhores maneiras de aprender é escrever seu próprio código o mais rápido possível, então aqui estão 
três maneiras de aplicar seu conhecimento para garantir que você entenda completamente o que está acontecendo:

1. Try adding the image name to the list of items that are shared. The activityItems parameter is an array, 
so you can add strings and other things freely. Note: Facebook won’t let you share text, but most other share 
options will.

2. Volte ao projeto 1 e adicione um item de botão de barra ao controlador de visualização principal que recomenda 
o aplicativo a outras pessoas.

3. Volte ao projeto 2 e adicione um item de botão de barra que mostre sua pontuação quando tocado.

