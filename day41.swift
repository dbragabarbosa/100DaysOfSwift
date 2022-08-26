26/08/2022


MARCO: PROJETOS 7 - 9



Há alguma pseudociência que afirma que a segunda ou terceira segunda-feira de janeiro é a "segunda-feira azul" - o dia 
mais deprimente do ano. As razões dadas incluem as condições climáticas no hemisfério norte sendo sombrias, a quantidade 
de tempo desde o feriado de Natal, o número de pessoas que desistem das resoluções de Ano Novo e muito mais.

É, é claro, bobagem, mas tem um grão de verdade: é fácil desanimar quando você está no meio de algo, porque a novidade 
inicial passou e ainda há muito mais trabalho pela frente.

É onde você está hoje. Você está a menos da metade dos 100 Dias de Swift, mas já está sendo solicitado a abordar tópicos 
complicados em vários dias consecutivos - o nível de dificuldade está aumentando, o ritmo provavelmente parece um pouco 
mais rápido e a quantidade de código que você está sendo solicitado a escrever também está aumentando.

Eu sei que alguns dos dias que você enfrentou foram mais difíceis do que outros, e também sei que você provavelmente está 
se sentindo cansado - você está desistindo de muito tempo para que isso aconteça. Mas quero encorajá-lo a continuar 
avançando: você está quase no meio do caminho agora, e os aplicativos que agora é capaz de criar são genuinamente úteis - 
você percorreu um longo caminho!

Helpfully, today is another consolidation day, which is partly a chance for us to go over some topics again to make sure 
you really understand them, partly a chance for me to dive into specific topics such as enumerated() and GCD’s 
background/foreground bounce, and partly a chance for you to try making your own app from scratch.

Como sempre, o desafio que você enfrentará está absolutamente dentro do seu nível de habilidade atual, e lhe dá a chance 
de ver o quão longe você chegou para si mesmo. Ricky Mondello – um dos times que constrói o Safari na Apple – disse uma 
vez: “uma das minhas coisas favoritas sobre engenharia de software, ou qualquer tipo de crescimento, é voltar a algo que 
você já pensou ser muito difícil e saber que pode fazê-lo.”

Hoje você tem três tópicos para trabalhar, um dos quais é o seu desafio.


---------- WHAT YOU LEARNED 

Os projetos 7, 8 e 9 foram os primeiros da série que considero "difíceis": você teve que analisar dados JSON, teve que criar 
um layout complexo para 7 Swifty Words e deu seus primeiros passos para criar código multithread - código que faz com que o 
iOS faça mais de uma coisa de cada vez.

None of those things were easy, but I hope you felt the results were worth the effort. And, as always, don’t worry if 
you’re not 100% on them just – we’ll be using Codable and GCD more in future projects, so you’ll have ample chance to 
practice.

- Você já conheceu o UITabBarController, que é outro componente principal do iOS - você o vê na App Store, Música, iBooks, 
Saúde, Atividade e muito mais.

- Each item on the tab bar is represented by a UITabBarItem that has a title and icon. If you want to use one of Apple’s 
icons, it means using Apple’s titles too.

- We used Data to load a URL, with its contentsOf method. That then got fed to JSONDecoder so that we could read it in code.

- We used WKWebView again, this time to show the petition content in the app. This time, though, we wanted to load our own 
HTML rather than a web site, so we used the loadHTMLString() method.

- Em vez de conectar muitas ações no Interface Builder, você viu como poderia escrever interfaces de usuário em código. 
Isso foi particularmente útil para os botões de letra de 7 Swifty Words, porque poderíamos usar um loop aninhado.

- In project 8 we used property observers, using didSet. This meant that whenever the score property changed, we automatically 
updated the scoreLabel to reflect the new score.

- You learned how to execute code on the main thread and on background threads using DispatchQueue, and also met the 
performSelector(inBackground:) method, which is the easiest way to run one whole method on a background thread.

- Finally, you learned several new methods, not least enumerated() for looping through arrays, joined() for bringing an 
array into a single value, and replacingOccurrences() to change text inside a string.



---------- 
