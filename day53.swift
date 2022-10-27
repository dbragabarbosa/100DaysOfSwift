27/10/2022


Project 13, part two


As imagens dão vida a qualquer interface de usuário, mas como designers de aplicativos, é nosso trabalho enquadrar 
essas imagens com uma interface de usuário inteligente para realmente trazê-las à vida. Como Ben Shneiderman, professor 
de Ciência da Computação da Universidade de Maryland, disse uma vez, “uma imagem vale mais que mil palavras; uma interface 
vale mais que mil imagens” - para mim, isso realmente ressalta a importância de acertar as duas coisas!

Hoje você vai tentar o Core Image pela primeira vez. Sua API nunca foi realmente atualizada para o Swift, então você 
verá algumas peculiaridades aqui e ali. Também tem pouca margem de erro, então você verá que adicionamos várias 
verificações para garantir que nosso código esteja seguro em tempo de execução - é melhor prevenir do que remediar.

Eu disse isso antes, mas vale a pena repetir aqui: o Core Image é extraordinariamente rápido em dispositivos iOS reais, 
mas extraordinariamente lento no simulador do Xcode. Portanto, não se preocupe se você achar que o efeito de desfoque 
parece bloquear seu Mac enquanto ele funciona - isso acontecerá em um piscar de olhos em um dispositivo real.

Today you have three topics to work through, and you’ll learn about CIContext, CIFilter, and more.



---------- Applying filters: CIContext, CIFilter

Você provavelmente está ficando cansado de me ouvir dizer isso, mas o Core Image é mais uma estrutura super rápida e 
super poderosa da Apple. Ele faz apenas uma coisa, que é aplicar filtros a imagens que as manipulam de várias maneiras.

Uma desvantagem do Core Image é que não é muito adivinhável, então você precisa saber o que está fazendo, caso 
contrário, perderá muito tempo. Também não é capaz de confiar em grandes partes da segurança do tipo Swift, então 
você precisa ter cuidado ao usá-lo, porque o compilador não o ajudará tanto quanto você está acostumado.

Para começar, importe o CoreImage adicionando esta linha perto da parte superior do ViewController.swift:

import CoreImage

Precisamos adicionar mais duas propriedades à nossa classe, então coloque-as abaixo da propriedade currentImage:

var context: CIContext!
var currentFilter: CIFilter!

O primeiro é um contexto Core Image, que é o componente Core Image que lida com a renderização. Nós o criamos aqui e 
o usamos em todo o nosso aplicativo, porque criar um contexto é computacionalmente caro, então não queremos continuar 
fazendo isso.

O segundo é um filtro Core Image e armazenará qualquer filtro que o usuário tenha ativado. Este filtro receberá várias 
configurações de entrada antes de pedirmos para gerar um resultado para mostrarmos na visualização da imagem.

Queremos criar ambos em viewDidLoad(), então coloque isso pouco antes do final do método:

context = CIContext()
currentFilter = CIFilter(name: "CISepiaTone")

Isso cria um contexto padrão da Core Image e, em seguida, cria um filtro de exemplo que aplicará um efeito de tom 
sépia às imagens. É só por enquanto; deixaremos que os usuários o mudem em breve.

Para começar, vamos permitir que os usuários arrastem o controle deslizante para cima e para baixo para adicionar 
quantidades variáveis de efeito sépia à imagem que selecionarem.

To do that, we need to set our currentImage property as the input image for the currentFilter Core Image filter. 
We're then going to call a method (as yet unwritten) called applyProcessing(), which will do the actual Core Image 
manipulation.

Então, adicione isso ao final do método didFinishPickingMediaWithInfo:

let beginImage = CIImage(image: currentImage)
currentFilter.setValue(beginImage, forKey: kCIInputImageKey)

applyProcessing()

You’ll get an error for applyProcessing() because we haven’t written it yet, but we’ll get there soon.

The CIImage data type is, for the sake of this project, just the Core Image equivalent of UIImage. Behind the scenes 
it's a bit more complicated than that, but really it doesn't matter.

As you can see, we can create a CIImage from a UIImage, and we send the result into the current Core Image Filter using 
the kCIInputImageKey. There are lots of Core Image key constants like this; at least this one is somewhat self-explanatory!

We also need to call the (still unwritten!) applyProcessing() method when the slider is dragged around, so modify 
the intensityChanged() method to this:

@IBAction func intensityChanged(_ sender: Any) {
    applyProcessing()
}

With these changes, applyProcessing() is called as soon as the image is first imported, then whenever the slider 
is moved. Now it's time to write the initial version of the applyProcessing() method, so put this just before the 
end of your class:

func applyProcessing() {
    guard let image = currentFilter.outputImage else { return }
    currentFilter.setValue(intensity.value, forKey: kCIInputIntensityKey)

    if let cgimg = context.createCGImage(image, from: image.extent) {
        let processedImage = UIImage(cgImage: cgimg)
        imageView.image = processedImage
    }
}

São apenas cinco linhas, nenhuma das quais é terrivelmente tributária.

A primeira linha lê com segurança a imagem de saída do nosso filtro atual. Isso deve sempre existir, mas não há mal 
estar seguro.

The second line uses the value of our intensity slider to set the kCIInputIntensityKey value of our current Core 
Image filter. For sepia toning a value of 0 means "no effect" and 1 means "fully sepia."

The third line is where the hard work happens: it creates a new data type called CGImage from the output image of the 
current filter. We need to specify which part of the image we want to render, but using image.extent means "all of it." 
Until this method is called, no actual processing is done, so this is the one that does the real work. This returns an 
optional CGImage so we need to check and unwrap with if let.

The fourth line creates a new UIImage from the CGImage, and line five assigns that UIImage to our image view. Yes, 
I know that UIImage, CGImage and CIImage all sound the same, but they are different under the hood and we have no 
choice but to use them here.

Agora você pode pressionar Cmd+R para executar o projeto como está, depois importar uma imagem e torná-la sepia 
tonificada. Pode ser um pouco lento no simulador, mas posso prometer que ele funciona brilhantemente em dispositivos - 
o Core Image é extraordinariamente rápido.

Adding a sepia effect isn't very interesting, and I want to help you explore some of the other options presented by 
Core Image. So, we're going to make the "Change Filter" button work: it will show a UIAlertController with a selection 
of filters, and when the user selects one it will update the image.

Primeiro, aqui está o novo método changeFilter():

@IBAction func changeFilter(_ sender: Any) {
    let ac = UIAlertController(title: "Choose filter", message: nil, preferredStyle: .actionSheet)
    ac.addAction(UIAlertAction(title: "CIBumpDistortion", style: .default, handler: setFilter))
    ac.addAction(UIAlertAction(title: "CIGaussianBlur", style: .default, handler: setFilter))
    ac.addAction(UIAlertAction(title: "CIPixellate", style: .default, handler: setFilter))
    ac.addAction(UIAlertAction(title: "CISepiaTone", style: .default, handler: setFilter))
    ac.addAction(UIAlertAction(title: "CITwirlDistortion", style: .default, handler: setFilter))
    ac.addAction(UIAlertAction(title: "CIUnsharpMask", style: .default, handler: setFilter))
    ac.addAction(UIAlertAction(title: "CIVignette", style: .default, handler: setFilter))
    ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
    present(ac, animated: true)
}

That's seven different Core Image filters plus one cancel button, but no new code. When tapped, each of the filter 
buttons will call the setFilter() method, which we need to make. This method should update our currentFilter property 
with the filter that was chosen, set the kCIInputImageKey key again (because we just changed the filter), then call 
applyProcessing().

Each UIAlertAction has its title set to a different Core Image filter, and because our setFilter() method must accept 
as its only parameter the action that was tapped, we can use the action's title to create our new Core Image filter. 
Here's the setFilter() method:

func setFilter(action: UIAlertAction) {  
    // make sure we have a valid image before continuing!
    guard currentImage != nil else { return }

    // safely read the alert action's title
    guard let actionTitle = action.title else { return }

    currentFilter = CIFilter(name: actionTitle)

    let beginImage = CIImage(image: currentImage)
    currentFilter.setValue(beginImage, forKey: kCIInputImageKey)

    applyProcessing()
}

Mas não execute o projeto ainda! Nosso código atual tem um problema, e é esta linha:

currentFilter.setValue(intensity.value, forKey: kCIInputIntensityKey)

Isso define a intensidade do filtro atual. Mas o problema é que nem todos os filtros têm uma configuração de 
intensidade. Se você tentar isso usando o filtro CIBumpDistortion, o aplicativo falhará porque não sabe o que 
fazer com uma configuração para o keykCIInputIntensityKey.

Todos os filtros e as teclas que eles usam estão descritos na íntegra na documentação da Apple, mas para este 
projeto vamos pegar um atalho. Há quatro chaves de entrada que vamos manipular em sete filtros diferentes. Às vezes, 
as chaves significam coisas diferentes, e às vezes as chaves não existem, então vamos aplicar apenas as chaves que 
existem com algum código astuto.

Each filter has an inputKeys property that returns an array of all the keys it can support. We're going to use this 
array in conjunction with the contains() method to see if each of our input keys exist, and, if it does, use it. Not 
all of them expect a value between 0 and 1, so I sometimes multiply the slider's value to make the effect more pronounced.

Change your applyProcessing() method to be this:

func applyProcessing() {
    let inputKeys = currentFilter.inputKeys

    if inputKeys.contains(kCIInputIntensityKey) { currentFilter.setValue(intensity.value, forKey: kCIInputIntensityKey) }
    if inputKeys.contains(kCIInputRadiusKey) { currentFilter.setValue(intensity.value * 200, forKey: kCIInputRadiusKey) }
    if inputKeys.contains(kCIInputScaleKey) { currentFilter.setValue(intensity.value * 10, forKey: kCIInputScaleKey) }
    if inputKeys.contains(kCIInputCenterKey) { currentFilter.setValue(CIVector(x: currentImage.size.width / 2, y: currentImage.size.height / 2), forKey: kCIInputCenterKey) }

    if let cgimg = context.createCGImage(currentFilter.outputImage!, from: currentFilter.outputImage!.extent) {
        let processedImage = UIImage(cgImage: cgimg)
        self.imageView.image = processedImage
    }
}

Using this method, we check each of our four keys to see whether the current filter supports it, and, if so, 
we set the value. The first three all use the value from our intensity slider in some way, which will produce 
some interesting results. If you wanted to improve this app later, you could perhaps add three sliders.

If you run your app now, you should be able to choose from various filters then watch them distort your image in 
weird and wonderful ways. Note that some of them – such as the Gaussian blur – will run very slowly in the simulator, 
but quickly on devices. If we wanted to do more complex processing (not least chaining filters together!) you can add 
configuration options to the CIContext to make it run even faster; another time, perhaps.



---------- Saving to the iOS photo library

I know it's fun to play around with Core Image filters (and you've only seen some of them!), but we have a project 
to finish so I want to introduce you to a new function: UIImageWriteToSavedPhotosAlbum(). This method does exactly 
what its name says: give it a UIImage and it will write the image to the photo album.

This method takes four parameters: the image to write, who to tell when writing has finished, what method to call, 
and any context. The context is just like the context value you can use with KVO, as seen in project 4, and again 
we're not going to use it here. The first two parameters are quite simple: we know what image we want to save 
(the processed one in the image view), and we also know that we want self (the current view controller) to be 
notified when writing has finished.

The third parameter can be provided in two ways: vague and clean, or specific and ugly. It needs to be a selector 
that lists the method in our view controller that will be called, and it's specified using #selector. The method 
it will call will look like this:

func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
}

Previously we've had very simple selectors, like #selector(shareTapped). And we can use that approach here – Swift 
allows us to be really vague about the selector we intend to call, and this works just fine:

#selector(image)

Yes, that approach is nice and easy to read, but it's also very vague: it doesn't say what is actually going to 
happen. The alternative is to be very specific about the method we want called, so you can write this:

#selector(image(_:didFinishSavingWithError:contextInfo:))

This second option is longer, but provides much more information both to Xcode and to other people reading your code, 
so it's generally preferred. To be honest, this particular callback is a bit of a wart in iOS, but the fact that it 
stands out so much is testament to the fact that there are so few warts around!

Putting it all together, here's the finished save() method:

@IBAction func save(_ sender: Any) {
    guard let image = imageView.image else { return }

    UIImageWriteToSavedPhotosAlbum(image, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
}

From here on it's easy, because we just need to write the didFinishSavingWithError method. This must show one of 
two messages depending on whether we get an error sent to us. The error might be, for example, that the user denied 
us permission to write to the photo album. This will be sent as an Error? object, so if it's nil we know there was no error.

This parameter is important because if an error has occurred (i.e., the error parameter is not nil) then we need 
to unwrap the Error object and use its localizedDescription property – this will tell users what the error message 
was in their own language.

@objc func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
    if let error = error {
        // we got back an error!
        let ac = UIAlertController(title: "Save error", message: error.localizedDescription, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    } else {
        let ac = UIAlertController(title: "Saved!", message: "Your altered image has been saved to your photos.", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }
}

And that's it: your app now imports pictures, manipulates them with a Core Image filter and a UISlider, then saves 
the result back to the photo library. Easy!

