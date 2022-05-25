24/05/2022


PROJECT 1, PART THREE


---------- 1. WRAP UP 

Este tem sido um projeto muito simples em termos do que pode fazer, mas você também aprendeu muito sobre Swift, Xcode e storyboards. 
Eu sei que não é fácil, mas confie em mim: você chegou até aqui, então passou pela parte mais difícil.

To give you an idea of how far you've come, here are just some of the things we've covered: table views and image views, app bundles, 
FileManager, typecasting, view controllers, storyboards, outlets, Auto Layout, UIImage, and more.

Sim, isso é uma quantia enorme, e para ser brutalmente honesto, é provável que você esqueça metade disso. Mas tudo bem, porque todos 
nós aprendemos através da repetição, e se você continuar a seguir o resto desta série, estará usando tudo isso e muito mais de novo 
e de novo até conhecê-los como a palma da sua mão.

Revise o que você aprendeu
Qualquer um pode assistir a um tutorial, mas é preciso trabalho real para lembrar o que foi ensinado. É meu trabalho garantir que 
você aproveite o máximo possível desses tutoriais, então preparei uma breve revisão para ajudá-lo a verificar seu aprendizado.

Clique aqui para revisar o que você aprendeu no projeto 1.

Desafio

Isso tem o início de um aplicativo útil, mas se você realmente quer que seu novo conhecimento afunde, você mesmo precisa começar 
a escrever algum novo código - sem seguir um tutorial ou ter uma resposta, você pode simplesmente procurar on-line.

Então, cada vez que você concluir um projeto, estarei desafiando você a modificá-lo de alguma forma. Sim, isso vai dar algum trabalho, 
mas não há aprendizado sem luta - todos os desafios estão completamente ao seu alcance com base no que você aprendeu até agora.

Para este projeto, seus desafios são:

- Use o Interface Builder para selecionar o rótulo de texto dentro da célula de visualização da tabela e ajustar o tamanho 
da fonte para algo maior - experimente e veja o que parece bom.

- Na sua visualização principal da tabela, mostre os nomes das imagens em ordem de classificação, para que "nssl0033.jpg" venha 
antes de "nssl0034.jpg".

- Em vez de mostrar os nomes das imagens na barra de título de detalhes, mostre "Imagem X de Y", onde Y é o número total de imagens 
e X é a posição da imagem selecionada na matriz. Certifique-se de contar de 1 em vez de 0.

Dicas

É vital para o seu aprendizado que você experimente os desafios acima de si mesmo, e não apenas por alguns minutos antes de desistir.

Toda vez que você tenta algo errado, você descobre que está errado e vai se lembrar que está errado. Quando você encontrar a solução correta, 
você se lembrará muito mais profundamente, ao mesmo tempo em que se lembrará de muitas das curvas erradas que tomou.

Isso é o que quero dizer com "não há aprendizado sem luta": se algo vier facilmente para você, pode ir com a mesma facilidade. 
Mas quando você tem que lutar mentalmente por algo, ele vai ficar muito mais tempo.

Mas se você já trabalhou duro nos desafios acima e ainda está lutando para implementá-los, vou escrever algumas dicas abaixo que 
devem guiá-lo para a resposta correta.

Se você me ignorar e ler essas dicas sem ter passado pelo menos 30 minutos tentando os desafios acima, a única pessoa que você está 
traindo é você mesmo.

Ainda está aqui? OK. Vamos dar uma olhada nos desafios...

Use o Interface Builder para selecionar o rótulo de texto dentro da célula de visualização da tabela e ajustar o tamanho da fonte para 
algo maior - experimente e veja o que parece bom.

Isso deve ser bastante fácil: abra Main.storyboard e, em seguida, use o contorno do documento para selecionar a visualização da tabela, 
selecione a célula Imagem dentro dela, selecione a Visualização de Conteúdo dentro dela e, finalmente, selecione o rótulo Título. 
No inspetor de atributos, você encontrará várias opções - tente descobrir qual delas controla o tamanho da fonte.

Na sua visualização principal da tabela, mostre os nomes das imagens em ordem de classificação, para que "nssl0033.jpg" venha antes 
de "nssl0034.jpg".

These pictures may or may not already be sorted for you, but your challenge here is to make sure they are always sorted. We’ve covered 
sorting arrays previously, and you should remember there’s a sort() method you can use.

However, the question is: where should it be called? You could call this method each time you append an “nssl” picture to the 
pictures array, but that just causes extra work. Where could you put a call to sort() so its done only once, when the images 
have all been loaded?

Em vez de mostrar os nomes das imagens na barra de título de detalhes, mostre "Imagem X de Y", onde Y é o número total de imagens 
e X é a posição da imagem selecionada na matriz. Certifique-se de contar de 1 em vez de 0.

Neste projeto, você aprendeu a criar propriedades como esta:

var selectedImage: String?

Você também aprendeu a definir essas propriedades de outro lugar, assim:

vc.selectedImage = pictures[indexPath.row]

Este desafio exige que você crie duas novas propriedades no DetailViewController: uma para conter a posição da imagem na 
matriz e outra para conter o número de imagens.

Por exemplo, você pode adicionar estas duas propriedades ao DetailViewController:

var selectedPictureNumber = 0
var totalPictures = 0

Você pode então usá-los para o título na barra de navegação usando interpolação de string. Lembre-se, a interpolação de strings é assim:

title = "This image is \(selectedImage)"

How can you use that with selectedPictureNumber and totalPictures?

Once that’s done, you need to pass in some values for those properties. We create DetailViewController here:

override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
        vc.selectedImage = pictures[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
}

That sets the selectedImage property using one of the strings from the pictures array. Which string? Well, we use indexPath.row for 
that, because that tells us which table view cell was selected.

So, we can use indexPath.row to set the selectedPictureNumber property in DetailViewController – just make sure you add 1 to it so 
that it counts from 1 rather than 0.

As for the totalPictures property in DetailViewController, which needs to contain the total number of pictures in our array. 
We already wrote code to read the size of the array inside the numberOfRowsInSection method – how can you use similar code to set totalPictures?



---------- 2. REVIEW FOR PROJECT 1: STROM VIEWER 