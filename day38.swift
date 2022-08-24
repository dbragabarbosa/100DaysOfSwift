24/08/2022 


PROJECT 8, PART THREE 


Há muitas citações bem conhecidas de Shakespeare, mas há uma que eu acho particularmente adequada hoje: "o tolo pensa 
que é sábio, mas o sábio sabe que é um tolo". Eu não sei onde você se classificaria em termos de conhecimento de Layout 
Automático, mas espero que você esteja pelo menos ciente de que é um espaço muito grande e complexo para se trabalhar!

Na minha palestra na NSSpain 2018, eu disse "O layout automático facilita as coisas difíceis e as coisas fáceis" - você 
descobrirá que pode fazer layouts relativamente avançados como o de hoje em cerca de uma hora, mas ocasionalmente você 
se encontrará querendo uma restrição de layout específica que é realmente difícil de acertar.

Felizmente para todos nós, esta parte do seu aprendizado de Layout Automático está completa, então é hora de revisarmos 
o que você aprendeu.

Hoje você deve trabalhar no capítulo de encerramento do projeto 8, concluir sua revisão e, em seguida, trabalhar em todos 
os três desafios.



---------- WRAP UP 

Sim, foi preciso muito código de interface de usuário para iniciar este projeto, mas espero que tenha mostrado que você pode 
fazer ótimos jogos usando apenas as ferramentas UIKit que você já conhece. Construir interfaces de usuário programaticamente 
é obviamente muito menos visual do que usar storyboards, mas o outro lado é que tudo está sob seu controle - não há conexões 
acontecendo nos bastidores.

Of course, at the same time as making another game, you've made several steps forward in your iOS development journey, this 
time learning about addTarget(), enumerated(), joined(), replacingOccurrences(), and more.


Desafio

Uma das melhores maneiras de aprender é escrever seu próprio código o mais rápido possível, então aqui estão três maneiras pelas 
quais você deve tentar estender este aplicativo para garantir que você entenda completamente o que está acontecendo:

1. Use as técnicas que você aprendeu no projeto 2 para desenhar uma fina linha cinza ao redor da visualização de botões, para que 
ela se destaque do resto da interface do usuário.

2. If the user enters an incorrect guess, show an alert telling them they are wrong. You’ll need to extend the submitTapped() method 
so that if firstIndex(of:) failed to find the guess you show the alert.

3. Try making the game also deduct points if the player makes an incorrect guess. Think about how you can move to the next level – 
we can’t use a simple division remainder on the player’s score any more, because they might have lost some points.
