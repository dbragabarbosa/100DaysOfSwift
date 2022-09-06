01/09/2022


PROJECT 10, PART TWO 

Hoje vamos fazer algo tão simples, mas tão fundamentalmente importante para a experiência de desenvolvimento de 
aplicativos: vamos adicionar fotos de usuário ao nosso aplicativo.

Eu sei, é simples, certo? E o UIKit simplifica as coisas. Mas, como você verá, adicionar fotos de usuário ao seu 
aplicativo faz algo importante: torna seu aplicativo o deles. Eles o personalizaram com os rostos e lugares que amam, 
e isso dá vida a tudo.

Com esse poder vem uma condição importante: quando eles nos permitem ler sua vida privada assim, você precisa levar 
essa permissão de privacidade a sério e viver de acordo com ela. Algumas outras plataformas jogam rápido e solto 
com a privacidade do usuário, mas no mundo do iOS você faria bem em viver pelas palavras de Valerie Plame: “A 
privacidade é preciosa - acho que a privacidade é o último verdadeiro luxo. Ser capaz de viver sua vida como 
quiser sem que todos comentem ou saibam.”

Portanto, não o compartilhe fora do aplicativo sem a permissão expressa do usuário, não o coloque no seu servidor e 
nem envie dados analíticos, a menos que seja homogeneizado e anônimo. Por favor, seja um bom cidadão do iOS!

Today you have three topics to work through, and you’ll learn about UIImagePickerController, NSObject, and more.


---------- Importing photos with UIImagePickerController

There are lots of collection view events to handle when the user interacts with a cell, but we'll come back to that later. 
For now, let's look at how to import pictures using UIImagePickerController. This new class is designed to let users select 
an image from their camera to import into an app. When you first create a UIImagePickerController, iOS will automatically 
ask the user whether the app can access their photos.

Primeiro, precisamos criar um botão que permita aos usuários adicionar pessoas ao aplicativo. Isso é tão simples quanto 
colocar o seguinte no método viewDidLoad():

navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewPerson))

The addNewPerson() method is where we need to use the UIImagePickerController, but it's so easy to do I'm just going to 
show you the code:

@objc func addNewPerson() {
    let picker = UIImagePickerController()
    picker.allowsEditing = true
    picker.delegate = self
    present(picker, animated: true)
}

Há três coisas interessantes lá:

1. We set the allowsEditing property to be true, which allows the user to crop the picture they select.

2. When you set self as the delegate, you'll need to conform not only to the UIImagePickerControllerDelegate protocol, 
but also the UINavigationControllerDelegate protocol.

3. The whole method is being called from Objective-C code using #selector, so we need to use the @objc attribute. This is 
the last time I’ll be repeating this, but hopefully you’re mentally always expecting #selector to be paired with @objc.

Em ViewController.swift, modifique esta linha:

class ViewController: UICollectionViewController {

Para isso:

class ViewController: UICollectionViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

That tells Swift you promise your class supports all the functionality required by the two protocols 
UIImagePickerControllerDelegate and UINavigationControllerDelegate. The first of those protocols is useful, telling us 
when the user either selected a picture or cancelled the picker. The second, UINavigationControllerDelegate, really is 
quite pointless here, so don't worry about it beyond just modifying your class declaration to include the protocol.

Quando você está em conformidade com o protocolo UIImagePickerControllerDelegate, você não precisa adicionar nenhum método 
porque ambos são opcionais. Mas eles não são realmente - eles são marcados como opcionais por qualquer motivo, mas seu código 
não é muito bom, a menos que você implemente pelo menos um deles!

The delegate method we care about is imagePickerController(_, didFinishPickingMediaWithInfo:), which returns when the user 
selected an image and it's being returned to you. This method needs to do several things:

- Extraia a imagem do dicionário que é passada como um parâmetro.

- Gere um nome de arquivo exclusivo para ele.

- Converta-o em um JPEG e, em seguida, escreva esse JPEG no disco.

- Descarte o controlador de visualização.

Para fazer tudo isso funcionar, você precisará aprender algumas coisas novas.

Primeiro, é muito comum a Apple enviar um dicionário de várias informações como parâmetro de método. Pode ser difícil 
trabalhar com isso às vezes, porque você precisa saber os nomes das chaves no dicionário para poder escolher os valores, 
mas você vai pegar o jeito com o tempo.

This dictionary parameter will contain one of two keys: .editedImage (the image that was edited) or .originalImage, 
but in our case it should only ever be the former unless you change the allowsEditing property.

O problema é que não sabemos se esse valor existe como uma UIImage, então não podemos simplesmente extraí-lo. Em vez 
disso, precisamos usar um método opcional de typecasting, as?, juntamente com if let. Usando esse método, podemos ter 
certeza de que sempre tiramos a coisa certa.

Em segundo lugar, precisamos gerar um nome de arquivo exclusivo para cada imagem que importamos. Isso é para que 
possamos copiá-lo para o espaço do nosso aplicativo no disco sem sobrescrever nada, e se o usuário excluir a imagem 
de sua biblioteca de fotos, ainda temos nossa cópia. Vamos usar um novo tipo para isso, chamado UUID, que gera um 
Identificador Universalmente Único e é perfeito para um nome de arquivo aleatório.

Third, once we have the image, we need to write it to disk. You're going to need to learn two new pieces of code: 
UIImage has a jpegData() to convert it to a Data object in JPEG image format, and there's a method on Data called 
write(to:) that, well, writes its data to disk. We used Data earlier, but as a reminder it’s a relatively simple data 
type that can hold any type of binary type – image data, zip file data, movie data, and so on.

Writing information to disk is easy enough, but finding where to put it is tricky. All apps that are installed have 
a directory called Documents where you can save private information for the app, and it's also automatically synchronized 
with iCloud. The problem is, it's not obvious how to find that directory, so I have a method I use called getDocumentsDirectory() 
that does exactly that – you don't need to understand how it works, but you do need to copy it into your code.

Com tudo isso em mente, aqui estão os novos métodos:

func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: 

[UIImagePickerController.InfoKey : Any]) {
    guard let image = info[.editedImage] as? UIImage else { return }

    let imageName = UUID().uuidString
    let imagePath = getDocumentsDirectory().appendingPathComponent(imageName)

    if let jpegData = image.jpegData(compressionQuality: 0.8) {
        try? jpegData.write(to: imagePath)
    }

    dismiss(animated: true)
}

func getDocumentsDirectory() -> URL {
    let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    return paths[0]
}

Again, it doesn't matter how getDocumentsDirectory() works, but if you're curious: the first parameter of 
FileManager.default.urls asks for the documents directory, and its second parameter adds that we want the path 
to be relative to the user's home directory. This returns an array that nearly always contains only one thing: 
the user's documents directory. So, we pull out the first element and return it.

Now onto the code that matters: as you can see I’ve used guard to pull out and typecast the image from the image 
picker, because if that fails we want to exit the method immediately. We then create an UUID object, and use its 
uuidString property to extract the unique identifier as a string data type.

The code then creates a new constant, imagePath, which takes the URL result of getDocumentsDirectory() and calls a 
new method on it: appendingPathComponent(). This is used when working with file paths, and adds one string 
(imageName in our case) to a path, including whatever path separator is used on the platform.

Now that we have a UIImage containing an image and a path where we want to save it, we need to convert the UIImage to 
a Data object so it can be saved. To do that, we use the jpegData() method, which takes one parameter: a quality value 
between 0 and 1, where 1 is “maximum quality”.

Once we have a Data object containing our JPEG data, we just need to unwrap it safely then write it to the file name we 
made earlier. That's done using the write(to:) method, which takes a filename as its parameter.

Então: os usuários podem escolher uma imagem e nós a salvaremos no disco. Mas isso ainda não faz nada - você não verá a 
imagem no aplicativo, porque não estamos fazendo nada com ela além de escrevê-la no disco. Para corrigir isso, precisamos 
criar uma classe personalizada para armazenar dados personalizados...



---------- Custom subclasses of NSObject 

Você já criou sua primeira classe personalizada quando criou a célula de visualização de coleção. Mas desta vez vamos 
fazer algo muito simples: vamos criar uma aula para manter alguns dados para o nosso aplicativo. Até agora, você viu 
como podemos criar matrizes de strings usando [String], mas e se quisermos manter uma matriz de pessoas?

Bem, a solução é criar uma classe personalizada. Crie um novo arquivo e escolha Cocoa Touch Class. Clique em Avançar e 
nomeie a classe "Pessoa", digite "NSObject" para "Subclasse de", depois clique em Avançar e Criar para criar o arquivo.

NSObject is what's called a universal base class for all Cocoa Touch classes. That means all UIKit classes ultimately 
come from NSObject, including all of UIKit. You don't have to inherit from NSObject in Swift, but you did in Objective-C 
and in fact there are some behaviors you can only have if you do inherit from it. More on that in project 12, but for now 
just make sure you inherit from NSObject.

Vamos adicionar duas propriedades à nossa classe: um nome e uma foto para cada pessoa. Então, adicione isso dentro 
da definição de Person:

var name: String
var image: String

When you do that, you'll see errors: "Class 'Person' has no initializers." Swift is telling us that we aren't satisfying 
one of its core rules: objects of type String can't be empty. Remember, String! and String? can both be nil, but plain 
old String can't – it must have a value. Without an initializer, it means the object will be created and these two variables 
won't have values, so you're breaking the rules.

To fix this problem, we need to create an init() method that accepts two parameters, one for the name and one for the 
image. We'll then save that to the object so that both variables have a value, and Swift is happy.

init(name: String, image: String) {
    self.name = name
    self.image = image
}

Nossa classe personalizada está pronta; é apenas um simples armazenamento de dados por enquanto. Se você é do tipo 
curioso, pode se perguntar por que eu usei uma aula aqui em vez de uma estrutura. Esta pergunta é ainda mais urgente 
quando você sabe que as estruturas têm um método de inicialização automático feito para elas que se parece exatamente 
com o nosso. Bem, a resposta é: você terá que esperar e ver. Tudo ficará claro no projeto 12!

With that custom class done, we can start to make our project much more useful: every time a picture is imported, we 
can create a Person object for it and add it to an array to be shown in the collection view.

Então, volte para ViewController.swift e adicione esta declaração para uma nova matriz:

var people = [Person]()

Every time we add a new person, we need to create a new Person object with their details. This is as easy as modifying 
our initial image picker success method so that it creates a Person object, adds it to our people array, then reloads 
the collection view. Put this code before the call to dismiss():

let person = Person(name: "Unknown", image: imageName)
people.append(person)
collectionView.reloadData()

That stores the image name in the Person object and gives them a default name of "Unknown", before reloading the collection view.

Você consegue identificar o problema? Se não, tudo bem, mas você deve ser capaz de identificá-lo se executar o programa.

The problem is that although we've added the new person to our array and reloaded the collection view, we aren't 
actually using the people array with the collection view – we just return 10 for the number of items and create an 
empty collection view cell for each one! Let's fix that…



---------- Connecting up the people 

Precisamos fazer três alterações finais neste projeto para terminar: mostrar o número correto de itens, mostrar as informações 
corretas dentro de cada célula e, em seguida, fazer com que, quando os usuários tocarem em uma imagem, possam definir o nome de uma pessoa.

Those methods are all increasingly difficult, so we'll start with the first one. Right now, your collection view's 
numberOfItemsInSection method just has return 10 in there, so you'll see 10 items regardless of how many people are in your array. 
This is easily fixed:

override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return people.count
}

Next, we need to update the collection view's cellForItemAt method so that it configures each PersonCell cell to have 
the correct name and image of the person in that position in the array. This takes a few steps:

- Pull out the person from the people array at the correct position.

- Set the name label to the person's name.

- Create a UIImage from the person's image filename, adding it to the value from getDocumentsDirectory() so that we 
have a full path for the image.

We're also going to use this opportunity to give the image views a border and slightly rounded corners, then give the 
whole cell matching rounded corners, to make it all look a bit more interesting. This is all done using CALayer, so that 
means we need to convert the UIColor to a CGColor. Anyway, here's the new code:

override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Person", for: indexPath) as? PersonCell else {
        fatalError("Unable to dequeue PersonCell.")
    }

    let person = people[indexPath.item]

    cell.name.text = person.name

    let path = getDocumentsDirectory().appendingPathComponent(person.image)
    cell.imageView.image = UIImage(contentsOfFile: path.path)

    cell.imageView.layer.borderColor = UIColor(white: 0, alpha: 0.3).cgColor
    cell.imageView.layer.borderWidth = 2
    cell.imageView.layer.cornerRadius = 3
    cell.layer.cornerRadius = 7

    return cell
}

Há três coisas novas lá dentro.

First, notice how I’ve used indexPath.item rather than indexPath.row, because collection views don’t really 
think in terms of rows.

Second, that code sets the cornerRadius property, which rounds the corners of a CALayer – or in our case the 
UIView being drawn by the CALayer.

Terceiro, eu entrei em um novo inicializador UIColor: UIColor(white:alpha:) Isso é útil quando você só quer 
cores em tons de cinza.

Feito isso, o aplicativo funciona: você pode executá-lo com Cmd+R, importar fotos e admirar a maneira como todas 
elas aparecem corretamente no aplicativo. Mas não tenha esperanças, porque ainda não terminamos - você ainda não 
pode atribuir nomes às pessoas!

Para esta última parte do projeto, vamos recapitular como adicionar campos de texto a um UIAlertController, assim 
como você fez no projeto 5. Todo o código é antigo, mas vou revisar novamente para garantir que você entenda completamente.

First, the delegate method we're going to implement is the collection view’s didSelectItemAt method, which is triggered 
when the user taps a cell. This method needs to pull out the Person object at the array index that was tapped, then 
show a UIAlertController asking users to rename the person.

Adding a text field to an alert controller is done with the addTextField() method. We'll also need to add two actions: 
one to cancel the alert, and one to save the change. To save the changes, we need to add a closure that pulls out the 
text field value and assigns it to the person's name property, then we'll also need to reload the collection view to 
reflect the change.

É isso! A única coisa que é nova, e dificilmente é nova, é a configuração da propriedade de name. 
Coloque este novo método na sua aula:

override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let person = people[indexPath.item]

    let ac = UIAlertController(title: "Rename person", message: nil, preferredStyle: .alert)
    ac.addTextField()

    ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))

    ac.addAction(UIAlertAction(title: "OK", style: .default) { [weak self, weak ac] _ in
        guard let newName = ac?.textFields?[0].text else { return }
        person.name = newName

        self?.collectionView.reloadData()
    })

    present(ac, animated: true)
}

Finalmente, o projeto está completo: você pode importar fotos de pessoas e, em seguida, tocar nelas para renomear. Muito bem!

