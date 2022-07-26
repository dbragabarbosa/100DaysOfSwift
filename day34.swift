26/07/2022 


PROJECT 7, PART TWO 

Today you have two topics to work through, and you’ll learn about injecting HTML into a web view, 
UIStoryboard, adding tabs to a tab bar controller in code, and more.


---------- RENDERING A PETITION: loadHTMLString 

Depois de toda a análise JSON, é hora de algo fácil: precisamos criar uma classe de controlador de 
visualização detalhada para que ela possa desenhar o conteúdo da petição de uma maneira atraente.

The easiest way for rendering complex content from the web is nearly always to use a WKWebView, and we're 
going to use the same technique from project 4 to create a DetailViewController that contains a web view.

Vá para o menu Arquivo e escolha Novo > Arquivo e, em seguida, escolha iOS > Fonte > Classe Cocoa Touch. 

Clique em Próximo, nomeie-o de "DetailViewController", torne-o uma subclasse de "UIViewController" e clique em Próximo e Criar.

Replace all the DetailViewController code with this:

import UIKit
import WebKit

class DetailViewController: UIViewController {
    var webView: WKWebView!
    var detailItem: Petition?

    override func loadView() {
        webView = WKWebView()
        view = webView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

This is almost identical to the code from project 4, but you'll notice I've added a detailItem property 
that will contain our Petition instance.

Essa foi a parte mais fácil. A parte difícil é que não podemos simplesmente colocar o texto da petição na 
visualização da web, porque provavelmente parecerá minúsculo. Em vez disso, precisamos envolvê-lo em algum 
HTML, que é uma linguagem totalmente diferente com suas próprias regras e suas próprias complexidades.

Now, this series isn't called "Hacking with HTML," so I don't intend to go into much detail here. However, 
I will say that the HTML we're going to use tells iOS that the page fits mobile devices, and that we want 
the font size to be 150% of the standard font size. All that HTML will be combined with the body value from 
our petition, then sent to the web view.

Coloque isso em viewDidLoad(), diretamente abaixo da chamada para super.viewDidLoad():

guard let detailItem = detailItem else { return }

let html = """
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<style> body { font-size: 150%; } </style>
</head>
<body>
\(detailItem.body)
</body>
</html>
"""

webView.loadHTMLString(html, baseURL: nil)

That guard at the beginning unwraps detailItem into itself if it has a value, which makes sure we exit the 
method if for some reason we didn’t get any data passed into the detail view controller.

Nota: É muito comum desembrulhar variáveis usando o mesmo nome, em vez de criar pequenas variações. Neste 
caso, poderíamos ter usado guard let unwrappedItem = detailItem, mas isso não é melhor.

I've tried to make the HTML as clear as possible, but if you don't care for HTML don't worry about it. What
matters is that there's a Swift string called html that contains everything needed to show the page, and 
that's passed in to the web view's loadHTMLString() method so that it gets loaded. This is different to the 
way we were loading HTML before, because we aren't using a website here, just some custom HTML.

É isso para o controlador de visualização de detalhes, é realmente simples assim. No entanto, ainda precisamos 
conectá-lo ao controlador de visualização de tabela implementando o método didSelectRowAt.

Previously we used the instantiateViewController() method to load a view controller from Main.storyboard, but 
in this project DetailViewController isn’t in the storyboard – it’s just a free-floating class. This makes 
didSelectRowAt easier, because it can load the class directly rather than loading the user interface from a storyboard.

So, add this new method to your ViewController class now:

override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let vc = DetailViewController()
    vc.detailItem = petitions[indexPath.row]
    navigationController?.pushViewController(vc, animated: true)
}

Vá em frente e execute o projeto agora pressionando Cmd+R ou clicando em reproduzir e, em seguida, toque 
em uma linha para ver mais detalhes sobre cada petição. Algumas petições não têm texto detalhado, mas a 
maioria tem - tente algumas e veja o que você pode encontrar.



---------- FINISHING TOUCHES: didFinishLaunchingWithOptions 

Before this project is finished, we're going to make two changes. First, we're going to add another tab to 
the UITabBarController that will show popular petitions, and second we're going to make our loading code a 
little more resilient by adding error messages.

As I said previously, we can't really put the second tab into our storyboard because both tabs will host a 
ViewController and doing so would require us to duplicate the view controllers in the storyboard. You can do 
that if you really want, but please don't – it's a maintenance nightmare!

Em vez disso, vamos deixar nossa configuração atual do storyboard em paz e, em seguida, criar o segundo 
controlador de visualização usando código. Isso não é algo que você já fez antes, mas não é difícil e já 
demos o primeiro passo, como você verá.

Open the file AppDelegate.swift. This has been in all our projects so far, but it's not one we've had to 
work with until now. Look for the didFinishLaunchingWithOptions method, which should be at the top of the 
file. This gets called by iOS when the app has finished loading and is ready to be used, and we're going 
to hijack it to insert a second ViewController into our tab bar.

Já deve ter algum código padrão da Apple lá, mas vamos adicionar um pouco mais pouco antes da linha return true:

if let tabBarController = window?.rootViewController as? UITabBarController {
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    let vc = storyboard.instantiateViewController(withIdentifier: "NavController")
    vc.tabBarItem = UITabBarItem(tabBarSystemItem: .topRated, tag: 1)
    tabBarController.viewControllers?.append(vc)
}

Cada linha disso é nova, então vamos nos aprofundar:

- Nosso storyboard cria automaticamente uma janela na qual todos os nossos controladores de visualização 
são mostrados. Esta janela precisa saber qual é o seu controlador de visualização inicial, e isso é definido 
como sua propriedade rootViewController. Tudo isso é tratado pelo nosso storyboard.

- No modelo Single View App, o controlador de visualização raiz é o ViewController, mas incorporamos o nosso 
dentro de um controlador de navegação e, em seguida, incorporamos isso dentro de um controlador de barra de 
abas. Então, para nós, o controlador de visualização raiz é um UITabBarController.

- We need to create a new ViewController by hand, which first means getting a reference to our Main.storyboard 
file. This is done using the UIStoryboard class, as shown. You don't need to provide a bundle, because nil 
means "use my current app bundle."

- Criamos nosso controlador de visualização usando o método instantiateViewController(), passando o ID do 
storyboard do controlador de visualização que queremos. Anteriormente, definimos nosso controlador de navegação 
para ter o ID do storyboard de "NavController", então passamos isso.

- We create a UITabBarItem object for the new view controller, giving it the "Top Rated" icon and the tag 1. 
That tag will be important in a moment.

- Adicionamos o novo controlador de visualização à matriz viewControllers do nosso controlador de barra de 
abas, o que fará com que ele apareça na barra de abas.

So, the code creates a duplicate ViewController wrapped inside a navigation controller, gives it a new tab bar 
item to distinguish it from the existing tab, then adds it to the list of visible tabs. This lets us use the same 
class for both tabs without having to duplicate things in the storyboard.

The reason we gave a tag of 1 to the new UITabBarItem is because it's an easy way to identify it. Remember, both 
tabs contain a ViewController, which means the same code is executed. Right now that means both will download the 
same JSON feed, which makes having two tabs pointless. But if you modify urlString in ViewController.swift’s 
viewDidLoad() method to this, it will work much better:

let urlString: String

if navigationController?.tabBarItem.tag == 0 {
    // urlString = "https://api.whitehouse.gov/v1/petitions.json?limit=100"
    urlString = "https://www.hackingwithswift.com/samples/petitions-1.json"
} else {
    // urlString = "https://api.whitehouse.gov/v1/petitions.json?signatureCountFloor=10000&limit=100"
    urlString = "https://www.hackingwithswift.com/samples/petitions-2.json"
}

That adjusts the code so that the first instance of ViewController loads the original JSON, and the second 
loads only petitions that have at least 10,000 signatures. Once again I’ve provided cached copies of the
Whitehouse API data in case it changes or goes away in the future – use whichever one you prefer.

The project is almost done, but we're going to make one last change. Our current loading code isn't very 
resilient: we have a couple of if statements checking that things are working correctly, but no else statements 
showing an error message if there's a problem.

This is easily fixed by adding a new showError() method that creates a UIAlertController showing a general failure message:

func showError() {
    let ac = UIAlertController(title: "Loading error", message: "There was a problem loading the feed; please check your connection and try again.", preferredStyle: .alert)
    ac.addAction(UIAlertAction(title: "OK", style: .default))
    present(ac, animated: true)
}

Agora você pode ajustar o código de download e análise JSON para chamar esse método de erro em todos os 
lugares em que uma condição falhe, assim:

if let url = URL(string: urlString) {
    if let data = try? Data(contentsOf: url) {
        parse(json: data)
    } else {
        showError()
    }
} else {
    showError()
}

Alternatively we could rewrite this to be a little cleaner by inserting return after the call to parse(). 
This means that the method would exit if parsing was reached, so we get to the end of the method it means 
parsing wasn’t reached and we can show the error. Try this instead:

if let url = URL(string: urlString) {
    if let data = try? Data(contentsOf: url) {
        parse(json: data)
        return
    }
}

showError()

Ambas as abordagens são perfeitamente válidas - faça o que preferir.

Independentemente de qual você optar, agora que as mensagens de erro são mostradas quando o aplicativo atinge
problemas, terminamos - bom trabalho!