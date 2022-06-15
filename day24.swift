15/06/2022


PROJECT 4, PART ONE 

Alexis Ohanian, fundador do Reddit, disse uma vez que "para se juntar à revolução industrial, você precisava 
abrir uma fábrica; na revolução da Internet, você precisa abrir um laptop". Bem, graças ao iOS, temos algo ainda 
mais fácil: você só precisa tocar em um botão no seu iPhone.

A Apple nos dá a capacidade de renderizar qualquer tipo de conteúdo da web, assim como o Safari, tudo alimentado 
por meio de sua estrutura WebKit de código aberto. Isso é multiplataforma, o que significa que podemos usá-lo no 
macOS e iOS da mesma forma, e também é incrivelmente rápido, como você verá em um momento.

Neste projeto, vamos criar um navegador da web simples usando o WebKit. A coisa toda leva apenas cerca de 60 
linhas de código depois que você remove comentários e linhas vazias, o que mostra o quão fácil é usar o WebKit.

Hoje você tem três tópicos para trabalhar e conhecerá o WKWebView, folhas de ação e muito mais.


---------- 1. SETTING UP 

In this project you're going to build on your new knowledge of UIBarButtonItem and UIAlertController by producing 
a simple web browser app. Yes, I realize this is another easy project, but learning is as much about tackling new 
challenges as going over what you've already learned.

To sweeten the deal, I'm going to use this opportunity to teach you lots of new things: WKWebView (Apple's extraordinary 
web widget), UIToolbar (a toolbar component that holds UIBarButtonItems), UIProgressView, delegation, key-value observing, 
and how to create your views in code. Plus, this is the last easy app project, so enjoy it while it lasts!

Para começar, crie um novo projeto Xcode usando o modelo Single View App e chame-o de Project4. Certifique-se de que Swift 
esteja selecionado para o idioma e salve o projeto na sua área de trabalho.

Abra Main.storyboard, selecione o controlador de visualização e escolha Editor > Incorporar > Controlador de Navegação - 
esse é o nosso storyboard concluído. Legal!



---------- 2. CREATING A SIMPLE BROWSER WITH WK WebView 

Em nossos dois primeiros projetos, usamos o Interface Builder para muito trabalho de layout, mas aqui nosso layout será 
tão simples que podemos fazer tudo em código. Você vê, antes de adicionarmos botões e imagens à nossa visualização, mas 
neste projeto a visualização da web ocupará todo o espaço, então pode muito bem ser a visão principal do controlador de visualização.

So far, we've been using the viewDidLoad() method to configure our view once its layout has loaded. This time we need to 
override the actual loading of the view because we don't want that empty thing on the storyboard, we want our own code. 
It will still be placed inside the navigation controller, but the rest is up to us.

O iOS tem duas maneiras diferentes de trabalhar com visualizações da web, mas a que usaremos para este projeto se chamaWKWebView. 
Faz parte do framework WebKit em vez do framework UIKit, mas podemos importá-lo adicionando esta linha ao topo do ViewController.swift:

import WebKit

Quando criamos a visualização da web, precisamos armazená-la como uma propriedade para que possamos referenciá-la mais tarde. 
Então, adicione esta propriedade à classe agora:

var webView: WKWebView!

Finalmente, adicione este novo método antes de viewDidLoad():

override func loadView() {
    webView = WKWebView()
    webView.navigationDelegate = self
    view = webView
}

Esse código acionará um erro do compilador por enquanto, mas vamos corrigi-lo em um momento.

Note: You don’t need to put loadView() before viewDidLoad(), and in fact you could put it anywhere between class ViewController: 
UIViewController { down to the last closing brace in the file. However, I encourage you to structure your methods in an organized 
way, and because loadView() gets called before viewDidLoad() it makes sense to position the code above it too.

De qualquer forma, há apenas três coisas com as quais nos preocupamos, porque agora você deve entender por que precisamos usar 
a palavra-chave override. (Dica: é porque há uma implementação padrão, que é carregar o layout do storyboard.)

First, we create a new instance of Apple's WKWebView web browser component and assign it to the webView property. Third, we 
make our view (the root view of the view controller) that web view.

Sim, eu perdi a segunda linha, e isso é porque ela introduz um novo conceito: delegação. Delegação é o que é chamado de padrão 
de programação - uma maneira de escrever código - e é amplamente usado no iOS. E por uma boa razão: é fácil de entender, fácil 
de usar e extremamente flexível.

Um delegado é uma coisa agindo no lugar de outra, respondendo efetivamente a perguntas e respondendo a eventos em seu nome. 
Em nosso exemplo, estamos usando o WKWebView: o renderizador web poderoso, flexível e eficiente da Apple. Mas por mais inteligente 
que seja o WKWebView, ele não sabe (ou se importa) como nosso aplicativo quer se comportar, porque esse é o nosso código personalizado.

The delegation solution is brilliant: we can tell WKWebView that we want to be informed when something interesting happens. 
In our code, we're setting the web view's navigationDelegate property to self, which means "when any web page navigation happens, 
please tell me – the current view controller."

Quando você faz isso, duas coisas acontecem:

1. Você deve estar em conformidade com o protocolo. Esta é uma maneira elegante de dizer: "se você está me dizendo que pode lidar 
com ser meu delegado, aqui estão os métodos que você precisa implementar". No caso donavigationDelegate, todos esses métodos são 
opcionais, o que significa que não precisamos implementar nenhum método.

2. Quaisquer métodos que você implementar agora terão controle sobre o comportamento do WKWebView. Qualquer um que você não implementar 
usará o comportamento padrão do WKWebView.

Before we go any further, it’s time to fix the compilation error. When you set any delegate, you need to conform to the 
protocol that matches the delegate. Yes, all the navigationDelegate protocol methods are optional, but Swift doesn't know that yet. 
All it knows is that we're promising we're a suitable delegate for the web view, and yet haven't implemented the protocol.

A solução para isso é simples, mas vou sequestrá-lo para introduzir outra coisa ao mesmo tempo, porque este é um momento oportuno. 
Primeiro, a correção: encontre esta linha:

class ViewController: UIViewController {

...e mude para isso:

class ViewController: UIViewController, WKNavigationDelegate {

That's the fix. But what I want to discuss is the way ViewController now appears to inherit from two things, which isn’t possible 
in Swift. As you know, when we say class A: B we’re defining a new class called A that builds on the functionality provided by 
class B. However, when we say class A: B, C we’re saying it inherits from UIViewController (the first item in the list), and 
promises it implements the WKNavigationDelegate protocol.

A ordem aqui é realmente importante: a classe pai (superclasse) vem em primeiro lugar, então todos os protocolos implementados 
vêm em seguida, todos separados por vírgulas. Estamos dizendo que estamos em conformidade com apenas um protocolo aqui 
(WKNavigationDelegate), mas você pode especificar quantos precisar.

So, the complete meaning of this line is "create a new subclass of UIViewController called ViewController, and tell 
the compiler that we promise we’re safe to use as a WKNavigationDelegate."

Este programa está quase fazendo algo útil, então antes de executá-lo, vamos adicionar mais três linhas. Por favor, 
coloque-os no método viewDidLoad(), logo após a super:

let url = URL(string: "https://www.hackingwithswift.com")!
webView.load(URLRequest(url: url))
webView.allowsBackForwardNavigationGestures = true

A primeira linha cria um novo tipo de dados chamado URL, que é a maneira da Swift de armazenar a localização dos arquivos. 
Você provavelmente já está familiarizado com URLs usadas on-line, como com https://www.hackingwithswift.com, mas elas 
também são tão importantes para armazenar nomes de arquivos locais - são pequenas coisas flexíveis!

Even though we’re used to URLs being strings of text, Swift stores URLs in a specific URL data type that adds a lot 
of extra functionality. So, that first line of code creates a new URL out of the string “https://www.hackingwithswift.com”. 
I'm using hackingwithswift.com as an example website, but please change it to something you like.

Aviso: você precisa garantir que usa https:// para seus sites, porque o iOS não gosta de aplicativos que enviem ou recebam 
dados de forma insegura. Se isso é algo que você deseja substituir, escrevi um artigo especificamente sobre o App Transport 
Security: </example-code/system/how-to-handle-the-https-requirements-in-ios-9-with-app-transport-security>.

The second line does two things: it creates a new URLRequest object from that URL, and gives it to our web view to load.

Now, this probably seems like pointless obfuscation from Apple, but WKWebViews don't load websites from strings 
like www.hackingwithswift.com, or even from a URL made out of those strings. You need to turn the string into a URL, 
then put the URL into an URLRequest, and WKWebView will load that. Fortunately it's not hard to do!

Aviso: Seu URL deve estar completo e válido para que esse processo funcione. Isso significa incluir a parte https://.

A terceira linha permite uma propriedade na visualização da web que permite que os usuários deslizem da borda esquerda 
ou direita para se mover para trás ou para frente em sua navegação na web. Esse é um recurso do navegador Safari no qual 
muitos usuários confiam, por isso é bom mantê-lo por perto.

É hora de executar o aplicativo, então pressione Cmd+R para executar seu aplicativo, e você poderá visualizar seu site. 
Primeiro passo feito!



---------- 3. CHOOSING A WEBSITE: UIAlertController ACTION SHEETS 

Vamos bloquear este aplicativo para que ele abra sites selecionados pelo usuário. O primeiro passo para fazer isso é 
dar ao usuário a opção de escolher entre um de nossos sites selecionados, e isso significa adicionar um botão à barra de navegação.

Somewhere in viewDidLoad() (but always after it has called super.viewDidLoad()), add this:

navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Open", style: .plain, target: self, action: #selector(openTapped))

We did exactly this in the previous project, except here we're using a custom title for our bar button rather than a 
system icon. It’s going to call the openTapped() method when the button is tapped, so let's add that now. 
Put this method below viewDidLoad():

@objc func openTapped() {
    let ac = UIAlertController(title: "Open page…", message: nil, preferredStyle: .actionSheet)
    ac.addAction(UIAlertAction(title: "apple.com", style: .default, handler: openPage))
    ac.addAction(UIAlertAction(title: "hackingwithswift.com", style: .default, handler: openPage))
    ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
    ac.popoverPresentationController?.barButtonItem = self.navigationItem.rightBarButtonItem
    present(ac, animated: true)
}

We haven’t written the openPage() method yet, so ignore any warnings you see about it for the time being. 
Just like in project 3 we’re calling openTapped() from Apple’s own Objective-C code in UIBarButtonItem, 
so the method must be marked @objc.

Just like in project 3, setting the alert controller’s popoverPresentationController?.barButtonItem property is 
used only on iPad, and tells iOS where it should make the action sheet be anchored.

We used the UIAlertController class in project 2, but here it's slightly different for three reason:

1. We're using nil for the message, because this alert doesn't need one.

2. We're using the preferredStyle of .actionSheet because we're prompting the user for more information.

3.Estamos adicionando um botão Cancelar dedicado usando o estilo .cancel. Ele não fornece um parâmetro handler, 
o que significa que o iOS simplesmente descartará o controlador de alerta se ele estiver tocado.

Both our website buttons point to the openPage() method, which, again, doesn't exist yet. This is going to be very 
similar to how we loaded the web page before, but now you will at least see why the handler method of UIAlertAction 
takes a parameter telling you which action was selected!

Add this method directly beneath the openTapped() method you just made:

func openPage(action: UIAlertAction) {
    let url = URL(string: "https://" + action.title!)!
    webView.load(URLRequest(url: url))
}

This method takes one parameter, which is the UIAlertAction object that was selected by the user. 
Obviously it won't be called if Cancel was tapped, because that had a nil handler rather than openPage.

What the method does is use the title property of the action (apple.com, hackingwithswift.com), put "https://" in front of 
it to satisfy App Transport Security, then construct a URL out of it. It then wraps that inside an URLRequest, and gives it 
to the web view to load. All you need to do is make sure the websites in the UIAlertController are correct, and this method 
will load anything.

Você pode ir em frente e testar o aplicativo agora, mas há uma pequena mudança que podemos adicionar para tornar toda a 
experiência mais agradável: definir o título na barra de navegação. Agora, somos o delegado de navegação da visualização 
da web, o que significa que seremos informados quando qualquer navegação interessante acontecer, como quando a página da 
web terminar de carregar. Vamos usar isso para definir o título da barra de navegação.

As soon as we told Swift that our ViewController class conformed to the WKNavigationDelegate protocol, Xcode updated its 
code completion system to support all the WKNavigationDelegate methods that can be called. As a result, if you go below 
the openPage() method and start typing "web" you'll see a list of all the WKNavigationDelegate methods we can use.

Scroll through the list of options until you see didFinish and press return to have Xcode fill in the method for you. 
Now modify it to this:

func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
    title = webView.title
}

All this method does is update our view controller's title property to be the title of the web view, which will 
automatically be set to the page title of the web page that was most recently loaded.

Pressione Cmd+R agora para executar o aplicativo, e você verá que as coisas estão começando a se unir: sua página da 
web inicial será carregada e, quando a carga terminar, você verá o título da página na barra de navegação.

