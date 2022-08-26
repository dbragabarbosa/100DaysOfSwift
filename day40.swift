25/08/2022


PROJECT 9, PART TWO 


Há uma velha piada sobre multitarefa:

Um programador tem um problema e pensa: "Posso consertar isso usando multitarefa!"

agora tem problemas! dois eles

(Ei, eu disse que era velho, eu não disse que era engraçado!)

O ponto é que quando você começa a executar vários pedaços de código ao mesmo tempo, eles podem ser concluídos em 
qualquer ordem - o "agora eles têm dois problemas!" punchline foi amassado.

Na verdade, as condições de corrida são toda uma categoria de bugs causados por uma tarefa concluída antes do que 
deveria - elas são particularmente desagradáveis de corrigir porque às vezes o trabalho é concluído na ordem correta 
e tudo funciona muito bem, e é por isso que chamamos de corrida.

Ontem foi uma introdução gentil à multitarefa usando o Grand Central Dispatch, mas voltaremos mais a ele no futuro. 
Enquanto isso, certifique-se de testar o que aprendeu para ter certeza de que está tudo afundado.

Hoje você deve trabalhar no capítulo de encerramento do projeto 9, concluir sua revisão e, em seguida, trabalhar em 
todos os três desafios.



---------- WRAP UP 

mbora eu tenha tentado simplificar as coisas o máximo possível, o GCD ainda não é fácil. Dito isto, é muito mais 
fácil do que as alternativas: o GCD lida automaticamente com a criação e o gerenciamento de threads, equilibra 
automaticamente com base nos recursos disponíveis do sistema e leva automaticamente em consideração a Qualidade de 
Serviço para garantir que seu código seja executado da maneira mais eficiente possível. A alternativa é fazer tudo 
isso sozinho!

Há muito mais que poderíamos cobrir (não menos importante como criar suas próprias filas!) mas realmente você tem 
mais do que o suficiente para continuar, e certamente mais do que o suficiente para completar o resto desta série. 
Usaremos o GCD novamente, então pode ajudar a manter essa referência à mão!

Desafio

Uma das melhores maneiras de aprender é escrever seu próprio código o mais rápido possível, então aqui estão três 
maneiras pelas quais você deve experimentar seu novo conhecimento para garantir que entenda completamente o que 
está acontecendo:

1. Modify project 1 so that loading the list of NSSL images from our bundle happens in the background. Make sure you 
call reloadData() on the table view once loading has finished!

2. Modifique o projeto 8 para que o carregamento e a análise de um nível ocorram em segundo plano. Quando terminar, 
certifique-se de atualizar a interface do usuário no tópico principal!

3. Modifique o projeto 7 para que seu código de filtragem ocorra em segundo plano. Este código de filtragem foi 
adicionado em um dos desafios para o projeto, então espero que você não o tenha ignorado!