24/08/2022


PROJECT 9, PART ONE 


Today you have five topics to work through, and you’ll learn about Grand Central Dispatch, quality of service queues, 
performSelector(), and more.


---------- SETTING UP 

Neste projeto técnico, retornaremos ao projeto 7 para resolver um problema crítico usando uma das estruturas mais 
importantes da Apple disponíveis: Grand Central Dispatch ou GCD. Eu já mencionei o problema para você, mas aqui 
está uma recapitulação do projeto 7:

By downloading data from the internet in viewDidLoad() our app will lock up until all the data has been transferred. 
There are solutions to this, but to avoid complexity they won't be covered until project 9.

Vamos resolver esse problema usando o GCD, o que nos permitirá buscar os dados sem bloquear a interface do usuário. 
Mas esteja avisado: mesmo que o GCD possa parecer fácil no início, ele abre uma nova série de problemas, então tenha 
cuidado!

Se você quiser manter seu trabalho anterior para referência, pegue uma cópia do projeto 7 agora e chame-o de projeto 9. 
Caso contrário, basta modificá-lo no lugar.



---------- 