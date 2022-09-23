21/09/2022 


Project 12, part one 


Douglas Adams disse uma vez: “a maior parte do tempo gasto lutando com tecnologias que ainda não funcionam simplesmente 
não vale o esforço para os usuários finais, por mais divertido que seja para nerds como nós.” E é claro que ele estava 
certo: quando o software não funciona, às vezes vemos como um desafio encontrar uma solução alternativa, enquanto todos 
os outros no mundo ficam irritados ou desistem.

Pense na frequência com que você vê um botão Salvar no iOS. Quase nunca, certo? Isso não é um acidente: o iOS faz parecer 
que todos os aplicativos estão sendo executados o tempo todo quando realmente são enviados em segundo plano ou até mesmo 
encerrados o tempo todo, mas os usuários não querem ter que pensar em salvar arquivos antes que um programa seja encerrado.

Esse comportamento é um ótimo exemplo de como a Apple tira o aborrecimento para os usuários finais - eles não precisam 
gastar o esforço de gerenciar dados ou se preocupar com programas, o que significa que eles podem se concentrar apenas 
em usar seu dispositivo para as coisas com as quais realmente se importam.

Agora cabe a nós. O Projeto 10 funcionou muito bem, exceto que não salva as fotos que os usuários adicionam. Hoje você 
vai aprender uma das maneiras pelas quais podemos consertar isso, e vamos pensar em uma opção diferente amanhã.

Today you have three topics to work through, and you’ll learn about UserDefaults, NSCoding and more.



---------- Setting up 

This is our fourth technique project, and we're going to go back to project 10 and fix its glaring bug: all the names 
and faces you add to the app don't get saved, which makes the app rather pointless!

We're going to fix this using a new class called UserDefaults and a new protocol NSCoding – it’s similar in intent to 
the Codable protocol we used when working with JSON, but the former is available only to Swift developers whereas the 
latter is also available to Objective-C developers.

Along the way you’ll also use the classes NSKeyedArchiver and NSKeyedUnarchiver (for use with NSCoding), and JSONEncoder 
and JSONDecoder (for use with Codable), all of which are there to convert custom objects into data that can be written 
to disk.

Putting all that together, we're going to update project 10 so that it saves its people array whenever anything is 
changed, then loads when the app runs.

We're going to be modifying project 10 twice over, once for each method of solving the problem, so I suggest you take 
a copy of the project 10 folder twice – call the copies project12a and project12b.


---------- Reading and writing basics: UserDefaults

