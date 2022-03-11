11/03/2022

OPERADORES E CONDIÇÕES 

---------- 1. OPERADORES ARITMÉTICOS 

+  -  *  /  % 

SWIFT NÃO CONSEGUE FZAER QUALQUER OPERAÇÃO DE INT COM DOUBLE 
SWIFT NÃO CONSEGUE FZAER QUALQUER OPERAÇÃO DE DOIS TIPOS DE DADOS DIFERENTES 


---------- 2. SOBRECARGA DO OPERADOR 

Swift supports operator overloading, which is a fancy way of saying that what an operator does depends on the values 
you use it with. For example, + sums integers like this:
let meaningOfLife = 42
let doubleMeaning = 42 + 42

But + also joins strings, like this:
let fakers = "Fakers gonna "
let action = fakers + "fake"

You can even use + to join arrays, like this:
let firstHalf = ["John", "Paul"]
let secondHalf = ["George", "Ringo"]
let beatles = firstHalf + secondHalf

Lembre-se, Swift é uma linguagem segura para tipos, o que significa que não permite que você misture tipos. 
Por exemplo, você não pode adicionar um inteiro a uma string porque não faz sentido.


---------- 3. OPERADORES DE ATRIBUIÇÃO COMPOSTOS 

var score = 95
score -= 5

Da mesma forma, você pode adicionar uma string a outra usando +=:
var quote = "The rain in Spain falls mainly on the "
quote += "Spaniards"


---------- 4. OPERADORES DE COMPARAÇÃO

==   !=   <    >   <=   >=

Os operadores funcionam também com strings respeitando a ordem alfabética 


---------- 5. CONDIÇÕES 

IF
ELSE 
ELSE IF


---------- 6. COMBINANDO CONDIÇÕES 

&&
||


---------- 7. O OPERADOR TERNÁRIO 

Swift tem um operador raramente usado chamado operador ternário. Ele funciona com três valores de uma só vez, que é de onde 
vem seu nome: ele verifica uma condição especificada no primeiro valor e, se é verdadeiro, retorna o segundo valor, mas se é
falso retorna o terceiro valor.

O operador ternário é uma condição mais blocos verdadeiros ou falsos, todos em um, divididos por um ponto de interrogação e 
dois pontos, o que dificulta bastante a leitura. Aqui está um exemplo:

let firstCard = 11
let secondCard = 10
print(firstCard == secondCard ? "Cards are the same" : "Cards are different")


---------- 8. ALTERNAR INSTRUÇÕES 

SWITCH CASE 

Ex:
let weather = "sunny"

switch weather {
case "rain":
    print("Bring an umbrella")
case "snow":
    print("Wrap up warm")
case "sunny":
    print("Wear sunscreen")
default:
    print("Enjoy your day!")
}


---------- 9. OPERADORES DE ALCANCE 

Swift gives us two ways of making ranges: the ..< and ... operators. The half-open range operator, ..<, creates ranges up to 
but excluding the final value, and the closed range operator, ..., creates ranges up to and including the final value.

For example, the range 1..<5 contains the numbers 1, 2, 3, and 4, whereas the range 1...5 contains the numbers 1, 2, 3, 4, 
and 5.

Os intervalos são úteis com blocos de comutação, porque você pode usá-los para cada um dos seus casos. Por exemplo, se alguém 
fizesse um exame, poderíamos imprimir mensagens diferentes dependendo da pontuação deles:

let score = 85

switch score {
case 0..<50:
    print("You failed badly.")
case 50..<85:
    print("You did OK.")
default:
    print("You did great!")
}


EX: Se tivéssemos uma matriz de nomes como este:

let names = ["Piper", "Alex", "Suzanne", "Gloria"]

Poderíamos ler um nome individual como este:
print(names[0])

Com intervalos, também podemos imprimir um intervalo de valores como este:
print(names[1...3])

That carries a small risk, though: if our array didn’t contain at least four items then 1...3 would fail. 
Fortunately, we can use a one-sided range to say “give me 1 to the end of the array”, like this:
print(names[1...])

Portanto, os intervalos são ótimos para contar através de valores específicos, mas também são úteis para ler grupos de iten
de matrizes.


---------- 10. RESUMO DOS OPERADORES E CONDIÇÕES 

1.Swift tem operadores para fazer aritmética e para comparação; eles funcionam principalmente como você já sabe.

2.There are compound variants of arithmetic operators that modify their variables in place: +=, -=, and so on.

3.You can use if, else, and else if to run code based on the result of a condition.

4.Swift tem um operador ternário que combina uma verificação com blocos de código verdadeiros e falsos. Embora você possa vê-lo em outro código, eu não recomendaria usá-lo você mesmo.

5.Se você tiver várias condições usando o mesmo valor, muitas vezes é mais claro usar o switch.

6.You can make ranges using ..< and ... depending on whether the last number should be excluded or included.




