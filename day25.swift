20/06/2022 


PROJECT 4, PART TWO 


Se há uma citação de Martin Fowler que eu amo, é esta: "Eu não sou um grande programador; sou apenas um bom programador com ótimos hábitos". 
Hoje precisamos adicionar um pouco mais de funcionalidade ao nosso projeto, mas nos deparamos com uma escolha: pegamos a rota 
mais fácil ou pegamos a rota mais difícil?

Como você verá, às vezes a rota "fácil" acaba sendo difícil a longo prazo, porque precisamos manter esse código por um longo tempo. 
O caminho mais difícil requer uma pequena reescrita do nosso código, mas é um dos muitos passos que você tomará para ter melhores 
hábitos de codificação - uma habilidade importante a ter!

Hoje você tem dois tópicos para trabalhar e conhecerá o UIProgressView, a observação de valores-chave e muito mais.


---------- MONITORING PAGE LOADS: UIToolbar AND UIProgressView 

Now is a great time to meet two new UIView subclasses: UIToolbar and UIProgressView. UIToolbar holds and shows a collection 
of UIBarButtonItem objects that the user can tap on. We already saw how each view controller has a rightBarButton item, so 
a UIToolbar is like having a whole bar of these items. UIProgressView is a colored bar that shows how far a task is through 
its work, sometimes called a "progress bar."

The way we're going to use UIToolbar is quite simple: all view controllers automatically come with a toolbarItems array that 
automatically gets read in when the view controller is active inside a UINavigationController.

This is very similar to the way rightBarButtonItem is shown only when the view controller is active. All we need to do is set 
the array, then tell our navigation controller to show its toolbar, and it will do the rest of the work for us.

We're going to create two UIBarButtonItems at first, although one is special because it's a flexible space. This is a unique 
UIBarButtonItem type that acts like a spring, pushing other buttons to one side until all the space is used.

Em viewDidLoad(), coloque este novo código diretamente abaixo, onde definimos o rightBarButtonItem:

let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
let refresh = UIBarButtonItem(barButtonSystemItem: .refresh, target: webView, action: #selector(webView.reload))

toolbarItems = [spacer, refresh]
navigationController?.isToolbarHidden = false

The first line is new, or at least part of it is: we're creating a new bar button item using the special system item 
type .flexibleSpace, which creates a flexible space. It doesn't need a target or action because it can't be tapped. 
The second line you've seen before, although now it's calling the reload() method on the web view rather than using a 
method of our own.

The last two lines are new: the first creates an array containing the flexible space and the refresh button, then sets 
it to be our view controller's toolbarItems array. The second sets the navigation controller's isToolbarHidden property 
to be false, so the toolbar will be shown – and its items will be loaded from our current view.

Esse código será compilado e executado, e você verá o botão de atualização bem alinhado à direita - esse é o efeito do espaço 
flexível ocupar automaticamente o máximo de espaço possível à esquerda.

The next step is going to be to add a UIProgressView to our toolbar, which will show how far the page is through loading. 
However, this requires two new pieces of information:

- You can't just add random UIView subclasses to a UIToolbar, or to the rightBarButtonItem property. Instead, you need to wrap 
them in a special UIBarButtonItem, and use that instead.

- Although WKWebView tells us how much of the page has loaded using its estimatedProgress property, the WKNavigationDelegate 
system doesn't tell us when this value has changed. So, we're going to ask iOS to tell us using a powerful technique called 
key-value observing, or KVO.

First, let's create the progress view and place it inside the bar button item. Begin by declaring the property at the top of the 
ViewController class next to the existing WKWebView property:

var progressView: UIProgressView!

Now place this code directly before the let spacer = line in viewDidLoad():

progressView = UIProgressView(progressViewStyle: .default)
progressView.sizeToFit()
let progressButton = UIBarButtonItem(customView: progressView)

Todas essas três linhas são novas, então vamos revisá-las:

1. A primeira linha cria uma nova instância UIProgressView, dando a ela o estilo padrão. Existe um estilo alternativo 
chamado .bar, que não desenha uma linha não preenchida para mostrar a extensão da visualização de progresso, mas o 
estilo padrão fica melhor aqui.

2. A segunda linha diz à visualização de progresso para definir seu tamanho de layout para que ele se encaixe totalmente em seu conteúdo.

3. The last line creates a new UIBarButtonItem using the customView parameter, which is where we wrap up our UIProgressView 
in a UIBarButtonItem so that it can go into our toolbar.

With the new progressButton item created, we can put it into our toolbar items anywhere we want it. The existing spacer will 
automatically make itself smaller to give space to the progress button, so I'm going to modify my toolbarItems array to this:

toolbarItems = [progressButton, spacer, refresh]
Ou seja, primeiro a visualização de progresso, depois um espaço no centro e, em seguida, o botão de atualização à direita.

If you run the app now, you'll just see a thin gray line for our progress view – that's because it's default value is 0, so there's 
nothing colored in. Ideally we want to set this to match our webView's estimatedProgress value, which is a number from 0 to 1, 
but WKNavigationDelegate doesn't tell us when this value has changed.

A solução da Apple para isso é enorme. A solução da Apple é poderosa. E, o melhor de tudo, a solução da Apple está em quase 
toda parte em seus kits de ferramentas, então, depois de aprender como funciona, você pode aplicá-la em outro lugar. É chamado 
de observação de valor-chave (KVO), e efetivamente permite que você diga: "por favor, me diga quando a propriedade X do objeto 
Y for alterada por qualquer pessoa a qualquer momento".

We're going to use KVO to watch the estimatedProgress property, and I hope you'll agree that it's useful. First, we add ourselves 
as an observer of the property on the web view by adding this to viewDidLoad():

webView.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil)

The addObserver() method takes four parameters: who the observer is (we're the observer, so we use self), what property we 
want to observe (we want the estimatedProgress property of WKWebView), which value we want (we want the value that was just 
set, so we want the new one), and a context value.

forKeyPath and context bear a little more explanation. forKeyPath isn't named forProperty because it's not just about entering
 a property name. You can actually specify a path: one property inside another, inside another, and so on. More advanced key 
 paths can even add functionality, such as averaging all elements in an array! Swift has a special keyword, #keyPath, which 
 works like the #selector keyword you saw previously: it allows the compiler to check that your code is correct – that the 
 WKWebView class actually has an estimatedProgress property.

context é mais fácil: se você fornecer um valor exclusivo, esse mesmo valor de contexto será enviado de volta para você 
quando você receber sua notificação de que o valor mudou. Isso permite que você verifique o contexto para ter certeza de 
que foi o seu observador que foi chamado. Existem alguns casos de canto em que especificar (e verificar) um contexto é 
necessário para evitar bugs, mas você não os alcançará durante nenhuma dessas séries.

Warning: in more complex applications, all calls to addObserver() should be matched with a call to removeObserver() when 
you're finished observing – for example, when you're done with the view controller.

Depois de se registrar como observador usando o KVO, você deve implementar um método chamadoobserveValueobserveValue(). 
Isso informa quando um valor observado foi alterado, então adicione este método agora:

override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
    if keyPath == "estimatedProgress" {
        progressView.progress = Float(webView.estimatedProgress)
    }
}

Como você pode ver, ele está nos dizendo qual caminho de chave foi alterado, e também nos envia de volta o contexto que 
registramos anteriormente para que você possa verificar se esse retorno de chamada é para você ou não.

In this project, all we care about is whether the keyPath parameter is set to estimatedProgress – that is, if the 
estimatedProgress value of the web view has changed. And if it has, we set the progress property of our progress view 
to the new estimatedProgress value.

Minor note: estimatedProgress is a Double, which as you should remember is one way of representing decimal numbers 
like 0.5 or 0.55555. Unhelpfully, UIProgressView's progress property is a Float, which is another (lower-precision) 
way of representing decimal numbers. Swift doesn't let you put a Double into a Float, so we need to create a new Float from the Double.

Se você executar seu projeto agora, verá que a visualização de progresso é preenchida com azul à medida que a página é carregada.



---------- REFACTORING FOR THE WIN 

Nosso aplicativo tem uma falha fatal e há duas maneiras de corrigi-lo: dobrar o código ou refatorar. Astutamente, a primeira 
opção é quase sempre a mais fácil e, no entanto, contraintuitivamente, também a mais difícil.

A falha é esta: permitimos que os usuários selecionem a partir de uma lista de sites, mas uma vez que estejam nesse site, 
eles podem chegar praticamente a qualquer outro lugar que quiserem apenas seguindo os links. Não seria bom se pudéssemos 
verificar todos os links seguidos para que possamos ter certeza de que estão em nossa lista segura?

One solution – doubling up on code – would have us writing the list of accessible websites twice: once in the UIAlertController 
and once when we're checking the link. This is extremely easy to write, but it can be a trap: you now have two lists of websites,
 and it's down to you to keep them both up to date. And if you find a bug in your duplicated code, will you remember to fix it 
 in the other place too?

A segunda solução é chamada de refatoração, e é efetivamente uma reescrita do código. No entanto, o resultado final deve fazer 
a mesma coisa. O objetivo da reescrita é torná-la mais eficiente, facilitar a leitura, reduzir sua complexidade e torná-la mais 
flexível. Este último uso é o que vamos procurar: queremos refatorar nosso código para que haja uma variedade compartilhada de 
sites permitidos.

Up where we declared our two properties webView and progressView, add this:

var websites = ["apple.com", "hackingwithswift.com"]

Essa é uma matriz contendo os sites que queremos que o usuário possa visitar.

Com essa matriz, podemos modificar a página inicial da web da visualização da web para que ela não seja codificada. 
InviewDidLoadviewDidLoad(), altere a página da web inicial para isso:

let url = URL(string: "https://" + websites[0])!
webView.load(URLRequest(url: url))

So far, so easy. The next change is to make our UIAlertController use the websites for its list of UIAlertActions. 
Go down to the openTapped() method and replace these two lines:

ac.addAction(UIAlertAction(title: "apple.com", style: .default, handler: openPage))
ac.addAction(UIAlertAction(title: "hackingwithswift.com", style: .default, handler: openPage))

...com este loop:

for website in websites {
    ac.addAction(UIAlertAction(title: website, style: .default, handler: openPage))
}

That will add one UIAlertAction object for each item in our array. Again, not too complicated.

The final change is something new, and it belongs to the WKNavigationDelegate protocol. If you find space for a 
new method and start typing "web" you'll see the list of WKWebView-related code completion options. Look for the 
one called decidePolicyFor and let Xcode fill in the method for you.

Este retorno de chamada delegado nos permite decidir se queremos permitir que a navegação aconteça ou não toda vez que 
algo acontece. Podemos verificar qual parte da página iniciou a navegação, podemos ver se ela foi acionada por um link 
sendo clicado ou por um formulário sendo enviado, ou, no nosso caso, podemos verificar a URL para ver se gostamos.

Agora que implementamos esse método, ele espera uma resposta: devemos carregar a página ou não? Quando esse método é 
chamado, você passa um parâmetro chamado decisionHandler. Isso realmente contém uma função, o que significa que se você 
"chamar" o parâmetro, você está realmente chamando a função.

In project 2 I talked about closures: chunks of code that you can pass into a function like a variable and have executed 
at a later date. This decisionHandler is also a closure, except it's the other way around – rather than giving someone 
else a chunk of code to execute, you're being given it and are required to execute it.

And make no mistake: you are required to do something with that decisionHandler closure. That might make sound an extremely 
complicated way of returning a value from a method, and that's true – but it's also underestimating the power a little! 
Having this decisionHandler variable/function means you can show some user interface to the user "Do you really want to 
load this page?" and call the closure when you have an answer.

You might think that already sounds complicated, but I’m afraid there’s one more thing that might hurt your head. 
Because you might call the decisionHandler closure straight away, or you might call it later on (perhaps after asking 
the user what they want to do), Swift considers it to be an escaping closure. That is, the closure has the potential to 
escape the current method, and be used at a later date. We won’t be using it that way, but it has the potential and 
that’s what matters.

Because of this, Swift wants us to add the special keyword @escaping when specifying this method, so we’re acknowledging 
that the closure might be used later. You don’t need to do anything else – just add that one keyword, as you’ll see in 
the code below.

So, we need to evaluate the URL to see whether it's in our safe list, then call the decisionHandler with a negative or 
positive answer. Here's the code for the method:

func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
    let url = navigationAction.request.url

    if let host = url?.host {
        for website in websites {
            if host.contains(website) {
                decisionHandler(.allow)
                return
            }
        }
    }

    decisionHandler(.cancel)
}

Existem alguns bits fáceis, mas eles são superados pelos bits rígidos, então vamos percorrer todas as linhas em detalhes para ter certeza:

1.First, we set the constant url to be equal to the URL of the navigation. This is just to make the code clearer.

2.Second, we use if let syntax to unwrap the value of the optional url.host. Remember I said that URL does a lot of 
work for you in parsing URLs properly? Well, here's a good example: this line says, "if there is a host for this URL, 
pull it out" – and by "host" it means "website domain" like apple.com. Note: we need to unwrap this carefully because not 
all URLs have hosts.

3. Em terceiro lugar, percorremos todos os sites da nossa lista segura, colocando o nome do site na variável do website.

4. Fourth, we use the contains() String method to see whether each safe website exists somewhere in the host name.

5. Em quinto lugar, se o site foi encontrado, ligamos para o manipulador de decisão com uma resposta positiva - queremos 
permitir o carregamento.

6. Em sexto lugar, se o site foi encontrado, depois de ligar para o decisionHandler, usamos a declaração return. 
Isso significa "sair do método agora".

7. Por último, se não houver um conjunto de host, ou se passarmos por todo o loop e não encontramos nada, chamamos o 
manipulador de decisões com uma resposta negativa: cancelar o carregamento.

You give the contains() method a string to check, and it will return true if it is found inside whichever string you 
used with contains(). You've already met the hasPrefix() method in project 1, but hasPrefix() isn't suitable here because 
our safe site name could appear anywhere in the URL. For example, slashdot.org redirects to m.slashdot.org for mobile 
devices, and hasPrefix() would fail that test.

The return statement is new, but it's one you'll be using a lot from now on. It exits the method immediately, executing no 
further code. If you said your method returns a value, you'll use the return statement to return that value.

