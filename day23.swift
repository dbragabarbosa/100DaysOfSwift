31/05/2022


MARCO: PROJETOS 1-3

É hora de mais um dia de consolidação, porque cobrimos muito terreno nos três primeiros tópicos e é importante 
que você os revise se quiser que eles fiquem na sua cabeça.

No entanto, este também será o primeiro dia em que você será solicitado a criar um aplicativo completo do zero. 
Não se preocupe: eu descrevo todos os componentes necessários para fazê-lo funcionar e também forneço dicas para 
lhe dar uma vantagem.

Como você verá, criar um aplicativo do zero é uma experiência muito diferente de adicionar modificações a um 
aplicativo existente: você tem paralisia de página em branco, que é onde seu cérebro sabe onde você quer chegar, 
mas você simplesmente não tem certeza de como começar.

Uma razão comum para ficar preso é que as pessoas tentam escrever código impecável pela primeira vez. Como Margaret 
Atwood disse uma vez, "se eu esperasse pela perfeição, nunca escreveria uma palavra". Então, mergulhe e veja onde 
você está - esses desafios marcantes ajudarão você a aprender a se sentir confortável iniciando novos projetos e a 
colocar a funcionalidade real em funcionamento rapidamente.



---------- 1. WHAT YOU LEARNED 

Você fez seus dois primeiros projetos agora e também concluiu um projeto de técnica - essa mesma cadência de aplicativo, 
jogo e técnica é usada até o projeto 30, e você começará a se estabelecer com o passar do tempo.

Tanto o aplicativo quanto o jogo foram criados com o UIKit - algo que continuaremos por mais dois marcos - para que 
você possa realmente começar a entender como os conceitos básicos dos controladores de visualização funcionam. Estes 
são realmente uma parte fundamental de qualquer aplicativo iOS, então quanto mais experiência eu puder dar a você com eles, melhor.

Neste ponto, você está começando a colocar seu conhecimento Swift em prática com contexto real: projetos práticos reais. 
Como a maioria dos aplicativos iOS é visual, isso significa que você começou a usar muitas coisas do UIKit, não menos importante:

- Visualizações de tabela usando UITableView. Eles são usados em todos os lugares do iOS e são um dos componentes mais 
importantes em toda a plataforma.

- Image views using UIImageView, as well as the data inside them, UIImage. Remember: a UIImage contains the pixels, but 
a UIImageView displays them – i.e., positions and sizes them. You also saw how iOS handles retina and retina HD screens 
using @2x and @3x filenames.

- Botões usando UIButton. Eles não têm nenhum design especial no iOS por padrão - eles simplesmente se parecem com rótulos, 
na verdade. Mas eles respondem quando tocados, para que você possa tomar alguma ação.

- Visualize controladores usando o UIViewController. Eles oferecem toda a tecnologia de exibição fundamental necessária 
para mostrar uma tela, incluindo coisas como rotação e multitarefa no iPad.

- Alertas do sistema usando o UIAlertController. Usamos isso para mostrar uma pontuação no projeto 2, mas é útil para 
sempre que você precisar que o usuário confirme algo ou faça uma escolha.

- Botões da barra de navegação usando UIBarButtonItem. Usamos o ícone de ação integrado, mas há muitos outros para escolher, 
e você pode usar seu próprio texto personalizado, se preferir.

- Cores usando UIColor, que usamos para delinear as bandeiras com uma borda preta. Existem muitas cores de sistema 
integradas para escolher, mas você também pode criar as suas próprias.

- Compartilhando conteúdo com Facebook e Twitter usando o UIActivityViewController. Essa mesma classe também lida 
com impressão, salvamento de imagens na biblioteca de fotos e muito mais.

One thing that might be confusing for you is the relationship between CALayer and UIView, and CGColor and UIColor. 
I’ve tried to describe them as being “lower level” and “higher level”, which may or may not help. Put simply, 
you’ve seen how you can create apps by building on top of Apple’s APIs, and that’s exactly how Apple works too: 
their most advanced things like UIView are built on top of lower-level things like CALayer. Some times you need 
to reach down to these lower-level concept, but most of the time you’ll stay in UIKit.

If you’re concerned that you won’t know when to use UIKit or when to use one of the lower-level alternatives, 
don’t worry: if you try to use a UIColor when Xcode expects a CGColor, it will tell you!

Ambos os projetos 1 e 2 trabalharam extensivamente no Interface Builder, que é um tema em execução nesta série: 
embora você possa fazer coisas em código, geralmente é preferível não fazê-lo. Isso não significa apenas que você 
pode ver exatamente como seu layout ficará quando visualizado em vários tipos de dispositivos, mas também abre a 
oportunidade para designers especializados entrarem e ajustarem seus layouts sem tocar no seu código. Confie em mim: 
manter sua interface do usuário e código separados é uma coisa boa.

Três coisas importantes do Interface Builder que você conheceu até agora são:

1. Storyboards, editados usando o Interface Builder, mas também usados em código, definindo identificadores de storyboard.

2. Saídas e ação do Interface Builder. As saídas conectam visualizações a propriedades nomeadas (por exemplo, imageView), 
e as ações as conectam a métodos que são executados, por exemplo, buttonTapped().

3. Layout Automático para criar regras sobre como os elementos da sua interface devem ser posicionados entre si.

Você usará muito o Interface Builder ao longo desta série. Às vezes, fazemos interfaces em código, mas somente quando 
necessário e sempre por um bom motivo.

Há três outras coisas que eu quero abordar brevemente, porque elas são importantes.

Primeiro, você conheceu a classe Bundle, que permite que você use todos os ativos que criar em seus projetos, como imagens 
e arquivos de texto. Usamos isso para obter a lista de JPEGs NSSL no projeto 1, mas vamos usá-lo novamente em projetos futuros.

Em segundo lugar, o carregamento desses JPEGs NSSL foi feito digitalizando o pacote de aplicativos usando a classe FileManager, 
que permite ler e gravar no sistema de arquivos iOS. Nós o usamos para digitalizar diretórios, mas ele também pode verificar 
se existe um arquivo, excluir coisas, copiar coisas e muito mais.

Finally, you learned how to generate truly random numbers using Swift’s Int.random(in:) method. Swift has 
lots of other functionality for randomness that we’ll be looking at in future projects.



---------- 2. KEY POINTS 

Existem cinco partes importantes de código que são importantes o suficiente para justificar alguma revisão. 
Primeiro, esta linha:

let items = try! fm.contentsOfDirectory(atPath: path)

The fm was a reference to FileManager and path was a reference to the resource path from Bundle, so that 
line pulled out an array of files at the directory where our app’s resources lived. But do you remember 
why the try! was needed?

When you ask for the contents of a directory, it’s possible – although hopefully unlikely! – that the 
directory doesn’t actually exist. Maybe you meant to look in a directory called “files” but accidentally 
wrote “file”. In this situation, the contentsOfDirectory() call will fail, and Swift will throw an exception – 
it will literally refuse to continue running your code until you handle the error.

Isso é importante, porque lidar com o erro permite que seu aplicativo se comporte bem, mesmo quando as coisas 
dão errado. Mas, neste caso, pegamos o caminho direto do iOS - não o digitamos à mão, portanto, se a leitura 
do pacote do nosso próprio aplicativo não funcionar, então claramente algo está muito errado.

A Swift exige chamadas que possam não ser chamadas usando a palavra-chave try, o que força você a adicionar 
código para detectar quaisquer erros que possam resultar. No entanto, como sabemos que esse código funcionará - 
não pode ser digitado incorretamente - podemos try! palavra-chave, que significa “não me faça pegar erros, 
porque eles não vão acontecer”. Claro, se você estiver errado - se ocorrerem erros - seu aplicativo vai travar, 
então tenha cuidado!

O segundo pedaço de código que eu gostaria de ver é este método:

override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return pictures.count
}

Isso foi usado no projeto 1 para fazer com que a visualização da tabela mostrasse quantas linhas forem necessárias 
para a matriz de pictures, mas embala muito em uma pequena quantidade de espaço.

To recap, we used the Single View App template when creating project 1, which gave us a single UIViewController 
subclass called simply ViewController. To make it use a table instead, we changed ViewController so that it was 
based on UITableViewController, which provides default answers to lots of questions: how many sections are there? 
How many rows? What’s in each row? What happens when a row is tapped? And so on.

Clearly we don’t want the default answers to each of those questions, because our app needs to specify how many 
rows it wants based on its own data. And that’s where the override keyword comes in: it means “I know there’s a 
default answer to this question, but I want to provide a new one.” The “question” in this case is “numberOfRowsInSection”, 
which expects to receive an Int back: how many rows should there be?

Os dois últimos pedaços de código que eu quero ver novamente são estes:

let cell = tableView.dequeueReusableCell(withIdentifier: "Picture", for: indexPath)

if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
}

Ambos são responsáveis por vincular o código às informações do storyboard usando uma string identificadora. 
No primeiro caso, é um identificador de reutilização de célula; no segundo, é um identificador de storyboard 
do controlador de visualização. Você sempre precisa usar o mesmo nome no Interface Builder e seu código - 
se não fizer isso, você terá uma falha porque o iOS não sabe o que fazer.

The second of those pieces of code is particularly interesting, because of the if let and as? DetailViewController. 
When we dequeued the table view cell, we used the built-in “Basic” style – we didn’t need to use a custom class to 
work with it, so we could just crack on and set its text.

However, the detail view controller has its own custom thing we need to work with: the selectedImage string. 
That doesn’t exist on a regular UIViewController, and that’s what the instantiateViewController() method returns – 
it doesn’t know (or care) what’s inside the storyboard, after all. That’s where the if let and as? typecast comes in: 
it means “I want to treat this is a DetailViewController so please try and convert it to one.”

Only if that conversion works will the code inside the braces execute – and that’s why we can access the selectedImage property safely.



----------- 3. CHALLENGE 

Você tem uma compreensão rudimentar das visualizações de tabela, visualizações de imagem e controladores de navegação, 
então vamos juntá-los: seu desafio é criar um aplicativo que liste várias bandeiras mundiais em uma visualização de tabela. 
Quando um deles for tocado, deslize em um controlador de visualização detalhada que contenha uma visualização de imagem, 
mostrando o mesmo sinalizador em tamanho real. No controlador de visualização de detalhes, adicione um botão de ação que 
permita ao usuário compartilhar a imagem da bandeira e o nome do país usando o UIActivityViewController.

Para resolver esse desafio, você precisará aproveitar as habilidades que aprendeu nos tutoriais 1, 2 e 3:

1. Start with a Single View App template, then change its main ViewController class so that builds on UITableViewController instead.

2. Carregue a lista de sinalizadores disponíveis do pacote de aplicativos. Você pode digitá-los diretamente no código, 
se quiser, mas é preferível não digitar.

3. Crie uma nova Classe Cocoa Touch responsável pelo controlador de visualização de detalhes e forneça propriedades 
para sua visualização de imagem e para a imagem a ser carregada.

4. Você também precisará ajustar seu storyboard para incluir o controlador de visualização detalhada, incluindo o 
uso do Layout Automático para fixar sua visualização de imagem corretamente.

5. You will need to use UIActivityViewController to share your flag.

Como sempre, vou fornecer algumas dicas abaixo, mas sugiro que você tente completar o máximo possível do desafio antes de lê-las.

Dicas:

- To load the images from disk you need to use three lines of code: let fm = FileManager.default, 
then let path = Bundle.main.resourcePath!, then finally let items = try! fm.contentsOfDirectory(atPath: path).

- Essas linhas acabam lhe dando uma matriz de todos os itens no pacote do seu aplicativo, mas você só quer as imagens, 
então você precisará usar algo como o método hasSuffix().

- Once you have made ViewController build on UITableViewController, you’ll need to 
override its numberOfRowsInSection and cellForRowAt methods.

- Você precisará atribuir um identificador de protótipo de célula no Interface Builder, como "País". 
Você pode então desenfileirar células desse tipo usando tableView.dequeueReusableCell(withIdentifier: 
"Country", for: indexPath)

- The didSelectItemAt method is responsible for taking some action when the user taps a row.

- Make sure your detail view controller has a property for the image name to load, as well as the 
UIImageView to load it into. The former should be modified from ViewController inside didSelectItemAt; 
the latter should be modified in the viewDidLoad() method of your detail view controller.

Bonus tip: try setting the imageView property of the table view cell. Yes, they have one. And yes, it 
automatically places an image right there in the table view cell – it makes a great preview for every country.


