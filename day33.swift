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

