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



---------- WHY IS LOCKING THE UI BAD? 

The answer is two-fold. First, we used Data's contentsOf to download data from the internet, which is what's known as a 
blocking call. That is, it blocks execution of any further code in the method until it has connected to the server and 
fully downloaded all the data.

Em segundo lugar, nos bastidores, seu aplicativo realmente executa vários conjuntos de instruções ao mesmo tempo, o que 
lhe permite aproveitar a existência de vários núcleos de CPU. Cada CPU pode estar fazendo algo independentemente das outras, 
o que aumenta muito o seu desempenho. Esses processos de execução de código são chamados de threads e vêm com várias 
ressalvas importantes:

1. Threads execute the code you give them, they don't just randomly execute a few lines from viewDidLoad() each. This means 
by default your own code executes on only one CPU, because you haven't created threads for other CPUs to work on.

2. Todo o trabalho da interface do usuário deve ocorrer no thread principal, que é o thread inicial no qual seu programa foi 
criado. Se você tentar executar código em um thread diferente, ele pode funcionar, pode falhar, pode causar resultados inesperados 
ou pode simplesmente falhar.

3. Você não pode controlar quando os threads são executados ou em que ordem. Você os cria e os entrega ao sistema para 
executar, e o sistema lida com a execução deles da melhor maneira possível.

4. Como você não controla a ordem de execução, você precisa estar mais atento em seu código para garantir que apenas um 
thread modifique seus dados de uma só vez.

Points 1 and 2 explain why our call is bad: if all user interface code must run on the main thread, and we just blocked 
the main thread by using Data's contentsOf, it causes the entire program to freeze – the user can touch the screen all 
they want, but nothing will happen. When the data finally downloads (or just fails), the program will unfreeze. This is 
a terrible experience, particularly when you consider that iPhones are frequently on poor-quality data connections.

De um modo geral, se você estiver acessando qualquer recurso remoto, você deve fazê-lo em um thread de fundo - ou seja, 
qualquer thread que não seja o thread principal. Se você está executando qualquer código lento, você deve fazê-lo em um 
tópico em segundo plano. Se você está executando qualquer código que possa ser executado em paralelo - por exemplo, 
adicionando um filtro a 100 fotos - você deve fazê-lo em vários tópicos de fundo.

O poder do GCD é que ele tira muito do incômodo de criar e trabalhar com vários threads, conhecidos como multithreading. 
Você não precisa se preocupar em criar e destruir threads, e não precisa se preocupar em garantir que criou o número ideal 
de threads para o dispositivo atual. O GCD cria automaticamente threads para você e executa seu código neles da maneira 
mais eficiente possível.

To fix our project, you need to learn three new GCD functions, but the most important one is called async() – it means 
"run the following code asynchronously," i.e. don't block (stop what I'm doing right now) while it's executing. Yes, 
that seems simple, but there's a sting in the tail: you need to use closures. Remember those? They are your best friend. 
No, really.



---------- GCD 101: async() 

We're going to use async() twice: once to push some code to a background thread, then once more to push code back to the 
main thread. This allows us to do any heavy lifting away from the user interface where we don't block things, but then update 
the user interface safely on the main thread – which is the only place it can be safely updated.

How you call async() informs the system where you want the code to run. GCD works with a system of queues, which are much 
like a real-world queue: they are First In, First Out (FIFO) blocks of code. What this means is that your GCD calls don't 
create threads to run in, they just get assigned to one of the existing threads for GCD to manage.

O GCD cria para você várias filas e coloca tarefas nessas filas, dependendo de quão importantes você diz que elas são. 
Todos são FIFO, o que significa que cada bloco de código será retirado da fila na ordem em que foram colocados, mas mais 
de um bloco de código pode ser executado ao mesmo tempo para que a ordem de término não seja garantida.

"Quão importante" algum código depende de algo chamado "qualidade de serviço", ou QoS, que decide qual nível de serviço 
esse código deve ser fornecido. Obviamente, no topo disso está a fila principal, que é executada no seu thread principal, 
e deve ser usada para agendar qualquer trabalho que deva atualizar a interface do usuário imediatamente, mesmo quando isso 
significa bloquear seu programa de fazer qualquer outra coisa. Mas existem quatro filas de plano de fundo que você pode usar,
cada uma com seu próprio nível de QoS definido:

1. User Interactive: este é o thread de plano de fundo de maior prioridade e deve ser usado quando você quiser que um thread 
de plano de fundo funcione, o que é importante para manter sua interface de usuário funcionando. Essa prioridade pedirá ao 
sistema que dedique quase todo o tempo de CPU disponível para que você faça o trabalho o mais rápido possível.

2. Iniciado pelo Usuário: isso deve ser usado para executar tarefas solicitadas pelo usuário que ele agora está esperando 
para continuar usando seu aplicativo. Não é tão importante quanto o trabalho interativo do usuário - ou seja, se o usuário 
tocar em botões para fazer outras coisas, isso deve ser executado primeiro - mas é importante porque você está mantendo o 
usuário esperando.

3. A fila do Utilitário: isso deve ser usado para tarefas de longa duração das quais o usuário está ciente, mas não 
necessariamente desesperado por enquanto. Se o usuário solicitou algo e pode deixá-lo em execução enquanto faz outra 
coisa com o seu aplicativo, você deve usar o Utilitário.

4. A fila em segundo plano: isso é para tarefas de longa duração das quais o usuário não está ativamente ciente, ou pelo 
menos não se importa com seu progresso ou quando é concluído.

Essas filas de QoS afetam a maneira como o sistema prioriza seu trabalho: As tarefas interativas pelo usuário e iniciadas 
pelo usuário serão executadas o mais rápido possível, independentemente de seu efeito na vida útil da bateria, as tarefas 
do utilitário serão executadas com o objetivo de manter a eficiência energética o mais alta possível sem sacrificar muito 
desempenho, enquanto as tarefas em segundo plano serão executada

O GCD equilibra automaticamente o trabalho para que as filas de prioridade mais alta recebam mais tempo do que as de 
prioridade mais baixa, mesmo que isso signifique atrasar temporariamente uma tarefa em segundo plano porque uma tarefa 
interativa do usuário acabou de chegar.

Há também mais uma opção, que é a fila padrão. Isso é priorizado entre iniciado pelo usuário e utilitário, e é uma boa 
escolha de uso geral enquanto você está aprendendo.

Enough talking, time for some action: we're going to use async() to make all our loading code run in the background queue 
with default quality of service. It's actually only two lines of code different:

DispatchQueue.global().async {

...antes do código que você deseja executar em segundo plano, depois uma chave de fechamento no final. Se você quisesse 
especificar a qualidade de serviço iniciada pelo usuário em vez de usar a fila padrão - o que é uma boa escolha para este 
cenário - você escreveria isso:

DispatchQueue.global(qos: .userInitiated).async {

The async() method takes one parameter, which is a closure to execute asynchronously. We’re using trailing closure syntax, 
which removes an unneeded set of parentheses.

Because async() uses closures, you might think to start with [weak self] in to make sure there aren’t any accident strong 
reference cycles, but it isn’t necessary here because GCD runs the code once then throws it away – it won’t retain things 
used inside.

Para ajudá-lo a colocá-lo corretamente, veja como o código de carregamento deve ficar:

DispatchQueue.global(qos: .userInitiated).async {
    if let url = URL(string: urlString) {
        if let data = try? Data(contentsOf: url) {
            self.parse(json: data)
            return
        }
    }
}

showError()

Note that because our code is now inside a closure, we need to prefix our method calls with self. otherwise Swift complains.

If you want to try the other QoS queues, you could also use .userInteractive, .utility or .background.



---------- BACK TO THE MAIN THREAD: DispatchQueue.main 

Com essa mudança, nosso código é cada vez pior. É melhor porque não bloqueia mais o thread principal enquanto o JSON é baixado 
do Whitehouse.gov. É pior porque estamos empurrando o trabalho para o thread em segundo plano, e qualquer outro código chamado 
nesse trabalho também estará no thread em segundo plano.

This change also introduced some confusion: the showError() call will get called regardless of what the loading does. Yes, there’s 
still a call to return in the code, but it now effectively does nothing – it’s returning from the closure that was being executed 
asynchronously, not from the whole method.

The combination of these problems means that regardless of whether the download succeeds or fails, showError() will be called.
 And if the download succeeds, the JSON will be parsed on the background thread and the table view's reloadData() will be called 
 on the background thread – and the error will be shown regardless.

Vamos corrigir esses problemas, começando com o trabalho em segundo plano da interface do usuário. Não há problema em analisar 
o JSON em um thread em segundo plano, mas nunca é OK fazer o trabalho da interface do usuário lá.

Isso é tão importante que vale a pena repetir duas vezes: nunca há problema em fazer o trabalho da interface do usuário no 
thread em segundo plano.

If you're on a background thread and want to execute code on the main thread, you need to call async() again. This time, 
however, you do it on DispatchQueue.main, which is the main thread, rather than one of the global quality of service queues.

We could modify our code to have async() before every call to showError() and parse(), but that's both ugly and inefficient. 
Instead, it's better to place the async() call inside showError(), wrapping up the whole UIAlertController code, and also 
inside parse(), but only where the table view is being reloaded. The actual JSON parsing can happily stay on the background 
thread.

So, inside the parse() method find this code:

tableView.reloadData()

…and replace it with this new code, bearing in mind again the need for self. to make our capturing clear:

DispatchQueue.main.async {
    self.tableView.reloadData()
}

To stop showError() being called regardless of the result of our fetch call, we need to move it inside the call to 
DispatchQueue.global() in viewDidLoad(), like this:

DispatchQueue.global(qos: .userInitiated).async {
    if let url = URL(string: urlString) {
        if let data = try? Data(contentsOf: url) {
            self.parse(json: data)
            return
        }
    }

    self.showError()
}

Remember, we need to add self. to the showError() call because it’s inside a closure now.

But this has created a second problem: showError() creates and shows a UIAlertController – we now have user interface work 
happening on a background thread, which is always a bad idea.

So, we need to modify showError() to push that work back to the main thread, like this:

func showError() {
    DispatchQueue.main.async {
        let ac = UIAlertController(title: "Loading error", message: "There was a problem loading the feed; please check your connection and try again.", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(ac, animated: true)
    }
}

Neste ponto, este código está em um lugar melhor: fazemos todo o trabalho lento fora do thread principal e, em seguida, 
empurramos o trabalho de volta para o thread principal quando queremos fazer o trabalho da interface do usuário. Essa 
rejeição de plano de fundo/primeiro plano é comum, e você a verá novamente em projetos posteriores.



----------