29/04/2022


OPTIONALS (opcionais)

Referências nula - literalmente quando uma variável não tem valor - foram inventadas por Tony Hoare em 1965. 
Quando perguntado sobre isso em retrospecto, ele disse: "Eu chamo isso de meu erro de bilhões de dólares" porque eles levam a muitos problemas.

Este dia é dedicado exclusivamente à solução da Swift para referências nulas, conhecidas como opcionais. 
Estes são um recurso de linguagem muito importante, mas podem machucar um pouco o seu cérebro.


---------- 1. HANDLING MISSING DATA 

We’ve used types such as Int to hold values like 5. 
But if you wanted to store an age property for users, what would you do if you didn’t know someone’s age?

Você pode dizer “bem, eu vou guardar 0”, mas então você ficaria confuso entre bebês recém-nascidos e pessoas cuja idade você não conhece. 
Você poderia usar um número especial, como 1000 ou -1, para representar "desconhecido", ambos idades impossíveis, 
mas então você realmente se lembraria desse número em todos os lugares em que é usado?

Swift’s solution is called optionals, and you can make optionals out of any type. 
An optional integer might have a number like 0 or 40, but it might have no value at all – it might literally be missing, which is nil in Swift.

Para tornar um tipo opcional, adicione um ponto de interrogação depois dele. Por exemplo, podemos criar um número inteiro opcional como este:

var age: Int? = nil

Isso não contém nenhum número - não contém nada. Mas se aprendermos essa idade mais tarde, podemos usá-la:

age = 38



Os opcionais da Swift são um de seus recursos mais poderosos, além de serem um dos mais confusos. 
Seu trabalho principal é simples: eles nos permitem representar a ausência de alguns dados - uma string que não está apenas vazia, 
mas literalmente não existe.

Qualquer tipo de dados pode ser opcional em Swift:

- Um inteiro pode ser 0, -1, 500 ou qualquer outro intervalo de números.

- Um inteiro opcional pode ser todos os valores inteiros regulares, mas também pode ser nil - pode não existir.

- Uma corda pode ser "Olá", pode ser as obras completas de Shakespeare, ou pode ser "" - uma corda vazia.

- Uma string opcional pode ser qualquer valor de string regular, mas também pode ser nil.

- A custom User struct could contain all sorts of properties that describe a user.

- An optional User struct could contain all those same properties, or not exist at all.

- Fazer essa distinção entre "pode ser qualquer valor possível para esse tipo" e "pode ser nulo" é a chave 
para entender os opcionais, e às vezes não é fácil.

Por exemplo, pense em booleanos: eles podem ser verdadeiros ou falsos. Isso significa que um Bool opcional pode ser verdadeiro, 
falso ou nenhum dos dois - não pode ser nada. Isso é um pouco difícil de entender mentalmente, porque certamente algo é sempre verdadeiro 
ou falso a qualquer momento?

Bem, me responda o seguinte: eu gosto de chocolate? A menos que você seja um amigo meu ou talvez me siga muito de perto no Twitter, 
você não pode dizer com certeza - você definitivamente não pode dizer Verdadeiro (eu gosto de chocolate) ou Falso (eu não gosto de chocolate), 
porque você simplesmente não sabe. Claro, você poderia me perguntar e descobrir, mas até que você faça isso, a única resposta segura é "Eu não sei", 
que neste caso poderia ser representada tornando o booleano opcional com um valor nulo.

Isso também é um pouco confuso quando você pensa em strings vazias, “”. 
Essa string não contém nada, mas isso não é a mesma coisa que nil - uma string vazia ainda é uma string.



---------- 2. UNWRAPPING OPTIONALS (desembrulhando opcionais)

Strings opcionais podem conter uma string como "Olá" ou podem ser nulas - nada.

Considere esta string opcional:

var name: String? = nil

What happens if we use name.count? A real string has a count property that stores how many letters it has, 
but this is nil – it’s empty memory, not a string, so it doesn’t have a count.

Because of this, trying to read name.count is unsafe and Swift won’t allow it. 
Instead, we must look inside the optional and see what’s there – a process known as unwrapping.

Uma maneira comum de desembrulhar opcionais é com a sintaxe if let, que desembrulha com uma condição. 
Se houvesse um valor dentro do opcional, então você pode usá-lo, mas se não houvesse, a condição falha.

Por exemplo:

if let unwrapped = name {
    print("\(unwrapped.count) letters")
} else {
    print("Missing name.")
}

If name holds a string, it will be put inside unwrapped as a regular String and we can read its count property inside the condition. 
Alternatively, if name is empty, the else code will be run.



Swift’s optionals can either store a value, such as 5 or “Hello”, or they might be nothing at all. 
As you might imagine, trying to add two numbers together is only possible if the numbers are actually there, 
which is why Swift won’t let us try to use the values of optionals unless we unwrap them – unless we look inside the optional, 
check there’s actually a value there, then take the value out for us.

There are several ways of doing this in Swift, but one of the most common is if let, like this:

func getUsername() -> String? {
    "Taylor"
}

if let username = getUsername() {
    print("Username is \(username)")
} else {
    print("No username")
}

The getUsername() function returns an optional string, which means it could be a string or it could be nil. 
I’ve made it always return a value here to make it easier to understand, but that doesn’t change what Swift thinks – it’s still an optional string.

That single if let line combines lots of functionality:

1. It calls the getUsername() function.

2. It receives the optional string back from there.

3. It looks inside the optional string to see whether it has a value.

4. As it does have a value (it’s “Taylor”), that value will be taken out of the optional and placed into a new username constant.

5. The condition is then considered true, and it will print “Username is Taylor”.

6. So, if let is a fantastically concise way of working with optionals, taking care of checking and extracting values all at once.

The single most important feature of optionals is that Swift won’t let us use them without unwrapping them first. 
This provides a huge amount of protection for all our apps, because it puts a stop to uncertainty: when you’re handing a string you know it’s a vali
string, when you call a function that returns an integer, you know it’s immediately safe to use. And when you do have optionals in your code, Swift 
will always make sure you handle them correctly – that you check and unwrap them, rather than just mixing unsafe values with known safe data.



---------- 3. UNWRAPPING WITH GUARD 










