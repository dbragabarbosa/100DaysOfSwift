26/06/2022


PROJECT 5, PART THREE 

Espero que hoje você tenha se aproximado um pouco mais de entender os fechamentos e que esteja começando 
a ver que eles são realmente apenas um tipo muito especial de função. Claro que eles têm uma sintaxe estranha, 
e sim, a coisa de captura faz com que eles se comportem de todas as maneiras interessantes, mas, em última análise, 
são apenas funções anônimas que você passa como se fossem dados.

Se você ainda não tem certeza sobre os fechamentos, tudo bem: vamos usá-los várias vezes, e mais cedo ou 
mais tarde eles clicarão. Você faria bem em se lembrar das palavras de Patrick McKenzie: "todo grande 
desenvolvedor que você conhece chegou lá resolvendo problemas que eles não estavam qualificados para 
resolver até que realmente o fizessem".

De qualquer forma, você tem outro projeto em seu currículo, e espero que se sinta feliz com tudo o que aprendeu. 
Claro, agora é hora de solidificar seu conhecimento com um teste e alguns novos desafios - você precisa ir além 
de apenas seguir comigo, caso contrário, terá dificuldade em se lembrar de qualquer coisa a longo prazo.

Hoje você deve trabalhar no capítulo de encerramento do projeto 5, concluir sua revisão e, em seguida, trabalhar 
em todos os três desafios. Como você verá, também há um desafio bônus hoje - você precisa ser um detetive de bugs!



---------- WRAP UP 

Você chegou até aqui, então seu aprendizado de Swift realmente está começando a se unir, e espero que este 
projeto tenha mostrado que você pode fazer algumas coisas bem avançadas com seu conhecimento.

In this project, you learned a little bit more about UITableView: how to reload their data and how to insert rows. 
You also learned how to add text fields to UIAlertController so that you can accept user input. But you also learned 
some serious core stuff: more about Swift strings, closures, NSRange, and more. These are things you're going to use 
in dozens of projects over your Swift coding career, and things we'll be returning to again and again in this series.


Desafio

Uma das melhores maneiras de aprender é escrever seu próprio código o mais rápido possível, então aqui estão três 
maneiras pelas quais você deve tentar estender este aplicativo para garantir que você entenda completamente o que está acontecendo:

1. Disallow answers that are shorter than three letters or are just our start word. For the three-letter check, 
the easiest thing to do is put a check into isReal() that returns false if the word length is under three letters. 
For the second part, just compare the start word against their input word and return false if they are the same.

2. Refactor all the else statements we just added so that they call a new method called showErrorMessage(). 
This should accept an error message and a title, and do all the UIAlertController work from there.

3. Adicione um item de botão da barra esquerda que chame startGame(), para que os usuários possam reiniciar 
com uma nova palavra sempre que quiserem.

Bônus: Depois de fazer esses três, há um bug muito sutil em nosso jogo e eu gostaria que você tentasse encontrá-lo e corrigi-lo.

Para acionar o bug, procure uma palavra de três letras na sua palavra inicial e insira-a com uma letra 
maiúscula. Assim que aparecer na tabela, tente inseri-lo novamente em letras minúsculas - você verá que ele é inserido. 
Você consegue descobrir o que causa isso e como consertá-lo?

Dicas

É vital para o seu aprendizado que você experimente os desafios acima de si mesmo, e não apenas por alguns minutos antes de desistir.

Toda vez que você tenta algo errado, você descobre que está errado e vai se lembrar que está errado. 
Quando você encontrar a solução correta, você se lembrará muito mais profundamente, ao mesmo tempo em 
que se lembrará de muitas das curvas erradas que tomou.

Isso é o que quero dizer com "não há aprendizado sem luta": se algo vier facilmente para você, pode ir 
com a mesma facilidade. Mas quando você tem que lutar mentalmente por algo, ele vai ficar muito mais tempo.

Mas se você já trabalhou duro nos desafios acima e ainda está lutando para implementá-los, vou escrever 
algumas dicas abaixo que devem guiá-lo para a resposta correta.

Se você me ignorar e ler essas dicas sem ter passado pelo menos 30 minutos tentando os desafios acima, a 
única pessoa que você está traindo é você mesmo.

Ainda está aqui? OK. Se você está preso no desafio de bônus de localização de bugs, dê uma olhada nesta linha de código:

usedWords.insert(answer, at: 0)

É isso que deveria ser?