18/07/2022 


PROJECT 7, PART ONE 


---------- SETTING UP

Este projeto pegará um feed de dados de um site e o analisará em informações úteis para os usuários. 
Como de costume, esta é apenas uma maneira de ensinar algumas novas técnicas de desenvolvimento iOS, mas 
vamos encarar - você já tem dois aplicativos e dois jogos sob seu currículo, então você está começando a 
construir uma boa biblioteca de trabalho!

This time you'll be learning about UITabBarController and a data format called JSON, which is a popular way 
to send and receive data online. It's not easy to find interesting JSON feeds that are freely available, but 
the option we'll be going for is the "We the people" Whitehouse petitions in the US, where Americans can submit 
requests for action, and others can vote on it.

Alguns são totalmente frívolos ("Queremos que os EUA construam uma Estrela da Morte"), mas tem um JSON bom e 
limpo que está aberto para todos lerem, o que o torna perfeito. Muito o que aprender e muito o que fazer, então 
vamos começar: crie um novo projeto no Xcode escolhendo o modelo de Aplicativo de Visualização Única. Agora 
chame-o de Project7 e salve-o em algum lugar.



---------- CREATING THE BASIC UI: UITabBarController 

We’ve already used UINavigationController in previous projects to provide a core user interface that lets us 
control which screen is currently visible. Another fundamental UI component is the tab bar, which you see in 
apps such as the App Store, Music, and Photos – it lets the user control which screen they want to view by tapping 
on what interests them.

Nosso aplicativo atual tem um único controlador de visualização vazio, mas vamos animar isso com um controlador 
de visualização de mesa, um controlador de navegação e um controlador de barra de abas para que você possa ver 
como todos eles funcionam juntos.

You should know the drill by now, or at least part of it. Start by opening ViewController.swift and changing 
ViewController to inherit from UITableViewController rather than UIViewController. That is, change this line:

class ViewController: UIViewController {

...para isso:

class ViewController: UITableViewController {

Agora abra Main.storyboard, remova o controlador de visualização existente e arraste um controlador de visualização 
de tabela em seu lugar. Use o inspetor de identidade para alterar sua classe para "Controlador de Visualização" e, 
em seguida, certifique-se de marcar a caixa "É o Controlador de Visualização Inicial".

Selecione seu protótipo de célula e use o inspetor de atributos para fornecer o identificador "Célula". Defina seu 
acessório como "Indicador de Divulgação" enquanto estiver lá; é uma ótima dica de interface do usuário e é perfeito 
neste projeto. Neste projeto, também vamos mudar o estilo da célula - esse é o primeiro item no inspetor de atributos. 
É "Personalizado" por padrão, mas eu gostaria que você o alterasse para "Legenda", para que cada linha tenha um rótulo 
de título principal e um rótulo de legenda.

Agora, a parte interessante: precisamos envolver este controlador de visualização dentro de duas outras coisas. Vá para 
Editor > Incorporar > Controlador de Navegação e, em seguida, vá imediatamente para Editor > Incorporar > Controlador de 
Barra de Guias. O controlador de navegação adiciona uma barra cinza na parte superior chamada barra de navegação, e o 
controlador da barra de guias adiciona uma barra cinza na parte inferior chamada barra de abas. Clique em Cmd+R agora 
para ver os dois em ação.

Behind the scenes, UITabBarController manages an array of view controllers that the user can choose between. You can 
often do most of the work inside Interface Builder, but not in this project. We're going to use one tab to show recent 
petitions, and another to show popular petitions, which is the same thing really – all that's changing is the data source.

Fazer tudo dentro do storyboard significaria duplicar nossos controladores de visualização, o que é uma má ideia, então, 
em vez disso, vamos projetar um deles no storyboard e, em seguida, criar uma duplicata dele usando código.

Agora que nosso controlador de navegação está dentro de um controlador de barra de abas, ele terá adquirido uma faixa 
cinza ao longo de sua parte inferior no Interface Builder. Se você clicar nisso agora, ele selecionará um novo tipo de 
objeto chamado UITabBarItem, que é o ícone e o texto usados para representar um controlador de visualização na barra 
de abas. No inspetor de atributos (Alt+Cmd+4), altere o Item do Sistema de "Personalizado" para "Mais Recente".

One important thing about UITabBarItem is that when you set its system item, it assigns both an icon and some text 
for the title of the tab. If you try to change the text to your own text, the icon will be removed and you need to 
provide your own. This is because Apple has trained users to associate certain icons with certain information, and 
they don't want you using those icons incorrectly!

Selecione o próprio controlador de navegação (basta clicar onde diz Controlador de Navegação em letras grandes no 
centro do controlador de visualização) e pressionar Alt+Cmd+3 para selecionar o inspetor de identidade. Nós nunca 
estivemos aqui antes, porque não é usado com tanta frequência. No entanto, aqui eu quero que você digite "NavController" 
na caixa de texto à direita de onde diz "ID do quadro de histórias". Vamos precisar disso em breve!

Na imagem abaixo, você pode ver como o inspetor de identidade deve ficar quando configurado para o seu controlador 
de navegação. Você usará esse inspetor em projetos posteriores para dar às visualizações uma classe personalizada, 
alterando a primeira dessas quatro caixas de texto.

Terminamos o Interface Builder, então abra o arquivo ViewController.swift para que possamos fazer as alterações 
usuais para nos obter uma visualização de tabela de trabalho.

Primeiro, adicione esta propriedade à classe ViewController:

var petitions = [String]()

Isso conterá nossas petições. Não usaremos strings no projeto final - na verdade, mudaremos isso no próximo capítulo - 
mas é bom o suficiente por enquanto.

Agora adicione este método numberOfRowsInSection:

override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return petitions.count
}

We also need to add a cellForRowAt method, but this time it’s going to be a bit different: we’re going to set some 
dummy textLabel.text like before, but we’re also going to set detailTextLabel.text – that’s the subtitle in our cell. 
It’s called “detail text label” rather than “subtitle” because there are other styles available, for example one where 
the detail text is on the right of the main text.

Adicione este método agora:

override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
    cell.textLabel?.text = "Title goes here"
    cell.detailTextLabel?.text = "Subtitle goes here"
    return cell
}

O primeiro passo agora está concluído: temos uma interface de usuário básica e estamos prontos para 
prosseguir com algum código real...



---------- PARSING JSON USING THE CODABLE PROTOCOL 

JSON - abreviação de JavaScript Object Notation - é uma maneira de descrever dados. Não é o 
mais fácil de ler, mas é compacto e fácil de analisar para computadores, o que o torna popular 
on-line, onde a largura de banda é premium.

Antes de fazermos a análise, aqui está uma pequena fatia do JSON real que você receberá:

{
    "metadata":{
        "responseInfo":{
            "status":200,
            "developerMessage":"OK",
        }
    },
    "results":[
        {
            "title":"Legal immigrants should get freedom before undocumented immigrants – moral, just and fair",
            "body":"I am petitioning President Trump's Administration to take a humane view of the plight of legal immigrants. Specifically, legal immigrants in Employment Based (EB) category. I believe, such immigrants were short changed in the recently announced reforms via Executive Action (EA), which was otherwise long due and a welcome announcement.",
            "issues":[
                {
                    "id":"28",
                    "name":"Human Rights"
                },
                {
                    "id":"29",
                    "name":"Immigration"
                }
            ],
            "signatureThreshold":100000,
            "signatureCount":267,
            "signaturesNeeded":99733,
        },
        {
            "title":"National database for police shootings.",
            "body":"There is no reliable national data on how many people are shot by police officers each year. In signing this petition, I am urging the President to bring an end to this absence of visibility by creating a federally controlled, publicly accessible database of officer-involved shootings.",
            "issues":[
                {
                    "id":"28",
                    "name":"Human Rights"
                }
            ],
            "signatureThreshold":100000,
            "signatureCount":17453,
            "signaturesNeeded":82547,
        }
    ]
}

Na verdade, você estará recebendo entre 2000-3000 linhas dessas coisas, todas contendo petições 
de cidadãos dos EUA sobre todos os tipos de coisas políticas. Realmente não importa (para nós) quais 
são as petições, apenas nos preocupamos com a estrutura de dados. Em particular:

1. Há um valor de metadados, que contém um valor responseInfo, que por sua vez contém um valor de status. 
Status 200 é o que os desenvolvedores de internet usam para "está tudo bem".

2. Há um valor de resultado, que contém uma série de petições.

3. Cada petição contém um título, um corpo, algumas questões a que se relaciona, além de 
algumas informações de assinatura.

4. JSON também tem strings e inteiros. Observe como as strings estão todas embrulhadas entre 
aspas, enquanto os inteiros não estão.

Swift tem suporte interno para trabalhar com JSON usando um protocolo chamado Codable. Quando 
você diz "meus dados estão em conformidade com o Codable", o Swift permitirá que você converta 
livremente entre esses dados e o JSON usando apenas um pequeno código.

Swift’s simple types like String and Int automatically conform to Codable, and arrays and dictionaries also conform to 
Codable if they contain Codable objects. That is, [String] conforms to Codable just fine, because String itself conforms 
to Codable.

Here, though, we need something more complex: each petition contains a title, some body text, a signature count, and more. 
That means we need to define a custom struct called Petition that stores one petition from our JSON, which means it will 
track the title string, body string, and signature count integer.

Então, comece pressionando Cmd+N e escolhendo criar um novo arquivo Swift chamado Petition.swift.

struct Petition {
    var title: String
    var body: String
    var signatureCount: Int
}

That defines a custom struct with three properties. You might remember that one of the advantages of structs in Swift 
is that it gives us a memberwise initializer – a special function that can create new Petition instances by passing in 
values for title, body, and signatureCount.

We’ll come onto that in a moment, but first I mentioned the Codable protocol. Our Petition struct contains two strings 
and an integer, all of which conforms to Codable already, so we can ask Swift to make the whole Petition type conform 
to Codable like this:

struct Petition: Codable {
    var title: String
    var body: String
    var signatureCount: Int
}

With that simple change we’re almost ready to load instances of Petition from JSON.

Eu digo quase pronto porque há uma leve ruga em nosso plano: se você olhasse para o exemplo JSON que dei acima, teria notado 
que nossa matriz de petições realmente vem dentro de um dicionário chamado "resultados". Isso significa que, quando tentamos 
fazer com que o Swift analise o JSON, precisamos carregar essa chave primeiro e, dentro disso, carregar a matriz de resultados 
da petição.

Swift’s Codable protocol needs to know exactly where to find its data, which in this case means making a second struct. 
This one will have a single property called results that will be an array of our Petition struct. This matches exactly 
how the JSON looks: the main JSON contains the results array, and each item in that array is a Petition.

Então, pressione Cmd+N novamente para criar um novo arquivo, escolhendo o arquivo Swift e nomeando-o Petition.swift. 
Dê a ele este conteúdo:

struct Petitions: Codable {
    var results: [Petition]
}

Eu percebo que isso parece muito trabalho, mas confie em mim: fica muito mais fácil!

All we’ve done is define the kinds of data structures we want to load the JSON into. The next step is to create a 
property in ViewController that will store our petitions array.

Como você deve se lembrar, você declara matrizes apenas colocando o tipo de dados entre colchetes, assim:

var petitions = [String]()

Queremos fazer uma matriz do nosso objeto de Petition. Então, parece assim:

var petitions = [Petition]()

Put that in place of the current petitions definition at the top of ViewController.swift.

It's now time to parse some JSON, which means to process it and examine its contents. We're going to start by 
updating the viewDidLoad() method for ViewController so that it downloads the data from the Whitehouse petitions 
server, converts it to a Swift Data object, then tries to convert it to an array of Petition instances.

We haven’t used Data before. Like String and Int it’s one of Swift’s fundamental data types, although it’s even 
more low level – it holds literally any binary data. It might be a string, it might be the contents of a zip file, 
or literally anything else.

Data and String have quite a few things in common. You already saw that String can be created using contentsOf 
to load data from disk, and Data has exactly the same initializer.

Isso é perfeito para as nossas necessidades - aqui está o novo método viewDidLoad:

override func viewDidLoad() {
    super.viewDidLoad()

    // let urlString = "https://api.whitehouse.gov/v1/petitions.json?limit=100"
    let urlString = "https://www.hackingwithswift.com/samples/petitions-1.json"

    if let url = URL(string: urlString) {
        if let data = try? Data(contentsOf: url) {
            // we're OK to parse!
        }
    }
}

Nota: Acima, incluí uma URL para o feed oficial da API da Whitehouse, mas isso pode desaparecer ou mudar a qualquer
 momento no futuro. Então, para evitar problemas, peguei uma cópia desse feed e o coloquei no meu próprio site - você 
 pode usar a API oficial ou minha própria cópia.

Vamos nos concentrar nas coisas novas:

- urlStringaponta para o servidor Whitehouse.gov ou para a minha cópia em cache dos mesmos dados, acessando as petições disponíveis.

- We use if let to make sure the URL is valid, rather than force unwrapping it. Later on you can return to 
this to add more URLs, so it's good play it safe.

- We create a new Data object using its contentsOf method. This returns the content from a URL, but it might throw 
an error (i.e., if the internet connection was down) so we need to use try?.

- If the Data object was created successfully, we reach the “we're OK to parse!” line. This starts with //, which begins a 
comment line in Swift. Comment lines are ignored by the compiler; we write them as notes to ourselves.

This code isn't perfect, in fact far from it. In fact, by downloading data from the internet in viewDidLoad() our app will 
lock up until all the data has been transferred. There are solutions to this, but to avoid complexity they won't be covered until project 9.

For now, we want to focus on our JSON parsing. We already have a petitions array that is ready to accept an array of 
petitions. We want to use Swift’s Codable system to parse our JSON into that array, and once that's done tell our 
table view to reload itself.

Você está pronto? Porque este código é extremamente simples, dado quanto trabalho está fazendo:

func parse(json: Data) {
    let decoder = JSONDecoder()

    if let jsonPetitions = try? decoder.decode(Petitions.self, from: json) {
        petitions = jsonPetitions.results
        tableView.reloadData()
    }
}

Place that method just underneath viewDidLoad() method, then replace the existing // we're OK to parse! 
line in viewDidLoad() with this:

parse(json: data)

This new parse() method does a few new and interesting things:

1. Ele cria uma instância do JSONDecoder, que é dedicada à conversão entre JSON e objetos Codable.

2. It then calls the decode() method on that decoder, asking it to convert our json data into a Petitions object. 
This is a throwing call, so we use try? to check whether it worked.

3. If the JSON was converted successfully, assign the results array to our petitions property then reload the table view.

The one part you haven’t seen before is Petitions.self, which is Swift’s way of referring to the Petitions type 
itself rather than an instance of it. That is, we’re not saying “create a new one”, but instead specifying it as 
a parameter to the decoding so JSONDecoder knows what to convert the JSON too.

You can run the program now, although it just shows “Title goes here” and “Subtitle goes here” again and again, 
because our cellForRowAt method just inserts dummy data.

We want to modify this so that the cells print out the title value of our Petition object, but we also want to use 
the subtitle text label that got added when we changed the cell type from "Basic" to "Subtitle" in the storyboard. 
To do that, change the cellForRowAt method to this:

let petition = petitions[indexPath.row]
cell.textLabel?.text = petition.title
cell.detailTextLabel?.text = petition.body

Our custom Petition type has properties for title, body and signatureCount, so now we can read them out to 
configure our cell correctly.

Se você executar o aplicativo agora, verá que as coisas estão começando a se encaixar muito bem - cada linha 
da tabela agora mostra o título da petição e, abaixo dela, mostra as primeiras palavras do corpo da petição. 
A legenda mostra automaticamente "..." no final, quando não há espaço suficiente para todo o texto, mas é o 
suficiente para dar ao usuário um sabor do que está acontecendo.

Tip: If you don’t see any data, make sure you named all the properties in the Petition struct correctly – the 
Codable protocol matches those names against the JSON directly, so if you have a typo in “signatureCount” then it will fail.

