14/03/2022

LOOPS

---------- 1. FOR LOOPS 

Swift tem algumas maneiras de escrever loops, mas seu mecanismo subjacente é o mesmo: execute algum código repetidamente até 
que uma condição seja avaliada como falsa.

O loop mais comum em Swift é um loop for: ele fará loop sobre matrizes e intervalos, e cada vez que o loop girar, ele 
retirará um item e atribuirá a uma constante.

Por exemplo, aqui está uma variedade de números:

let count = 1...10

We can use a for loop to print each item like this:

for number in count {
    print("Number is \(number)")
}

Podemos fazer o mesmo com matrizes:

let albums = ["Red", "1989", "Reputation"]

for album in albums {
    print("\(album) is on Apple Music")
}

If you don’t use the constant that for loops give you, you should use an underscore instead so that Swift doesn’t create 
needless values:

print("Players gonna ")

for _ in 1...5 {
    print("play")
}


Por que a Swift usa sublinhados com loops?
    Se você quiser repetir itens em uma matriz, você pode escrever código como este:

    let names = ["Sterling", "Cyril", "Lana", "Ray", "Pam"]

    for name in names {
        print("\(name) is a secret agent")
    }
    
    Every time the loop goes around, Swift will take one item from the names array, put it into the name constant, then 
    execute the body of our loop – that’s the print() method.

    No entanto, às vezes você realmente não precisa do valor que está sendo lido atualmente, que é onde entra o sublinhado: 
    Swift reconhecerá que você realmente não precisa da variável e não fará a constante temporária para você.

    Of course, Swift can really see that anyway – it can see whether or not you’re using name inside the loop, so it can do 
    the same job without the underscore. However, using an underscore does something very similar for our brain: we can look at 
    the code and immediately see the loop variable isn’t being used, no matter how many lines of code are inside the loop body.

    Então, se você não usar uma variável de loop dentro do corpo, Swift irá avisá-lo para reescrevê-la assim:

    let names = ["Sterling", "Cyril", "Lana", "Ray", "Pam"]

    for _ in names {
        print("[CENSORED] is a secret agent!")
    }


---------- 2. WHILE LOOPS 

Uma segunda maneira de escrever loops é usar while: dê a ele uma condição para verificar, e seu código de loop girará e 
girará até que a condição falhe.


---------- 3. REPEAT LOOPS 

The third way of writing loops is not commonly used, but it’s so simple to learn we might as well cover it: it’s called 
the repeat loop, and it’s identical to a while loop except the condition to check comes at the end.

Então, poderíamos reescrever nosso exemplo de esconde-esconde como este:

var number = 1

repeat {
    print(number)
    number += 1
} while number <= 20

print("Ready or not, here I come!")

Como a condição vem no final do loop de repeat, o código dentro do loop sempre será executado pelo menos uma vez, 
enquanto que os loops verificam sua condição antes de sua primeira execução.


---------- 4. EXITING LOOPS 

You can exit a loop at any time using the break keyword. 


---------- 5. EXITING MULTIPLE LOOPS 

Se você colocar um loop dentro de um loop, ele é chamado de loop aninhado, e não é incomum querer sair do loop interno e 
do loop externo ao mesmo tempo.

Como exemplo, poderíamos escrever algum código para calcular as tabelas de horários de 1 a 10 assim:

for i in 1...10 {
    for j in 1...10 {
        let product = i * j
        print ("\(i) * \(j) is \(product)")
    }
}

Se quiséssemos sair no meio do caminho, precisamos fazer duas coisas. Primeiro, damos ao loop externo um rótulo, assim:

outerLoop: for i in 1...10 {
    for j in 1...10 {
        let product = i * j
        print ("\(i) * \(j) is \(product)")
    }
}

Second, add our condition inside the inner loop, then use break outerLoop to exit both loops at the same time:

outerLoop: for i in 1...10 {
    for j in 1...10 {
        let product = i * j
        print ("\(i) * \(j) is \(product)")

        if product == 50 {
            print("It's a bullseye!")
            break outerLoop
        }
    }
}

With a regular break, only the inner loop would be exited – the outer loop would continue where it left off.


---------- 6. SKIPPING ITEMS 

As you’ve seen, the break keyword exits a loop. But if you just want to skip the current item and continue on to the 
next one, you should use continue instead.

Quando usamos continue, estamos dizendo “Terminei a execução atual deste loop” - Swift pulará o resto do corpo do loop e 
irá para o próximo item do loop. Mas quando dizemos break, estamos dizendo “Eu terminei completamente esse loop, então 
saia completamente”. Isso significa que Swift pulará o restante do loop corporal, mas também pulará quaisquer outros 
itens de loop que ainda estavam por vir.


---------- 7. INFINITE LOOPS 

To make an infinite loop, just use true as your condition. true is always true, so the loop will repeat forever. 
Warning: Please make sure you have a check that exits your loop, otherwise it will never end.


---------- 8. LOOPING SUMMARY 

Vamos resumir:

1.Loops nos permitem repetir o código até que uma condição seja falsa.

2.O loop mais comum é for, que atribui cada item dentro do loop a uma constante temporária.

3.If you don’t need the temporary constant that for loops give you, use an underscore instead so Swift can skip that work.

4.Existem loops while, que você fornece com uma condição explícita para verificar.

5.Embora sejam semelhantes aos loops while, os loops repeat sempre executam o corpo de seu loop pelo menos uma vez.

6.You can exit a single loop using break, but if you have nested loops you need to use break followed by whatever label you placed 
before your outer loop.

7.Você pode pular itens em um loop usando continue.

8.Loops infinitos não terminam até que você os peça, e são feitos usando while true. Certifique-se de ter uma condição em algum 
lugar para terminar seus loops infinitos!


