27/04/2022 


CLASSES 

A princípio, as classes parecem muito semelhantes às estruturas porque as usamos 
para criar novos tipos de dados com propriedades e métodos. No entanto, eles 
introduzem um recurso novo, importante e complexo chamado herança - a capacidade 
de fazer com que uma classe se baseie sobre os fundamentos de outra.


---------- 1. CREAITNG YOUR OWN CLASSES 

As classes são semelhantes às estruturas, pois permitem que você crie novos tipo
com propriedades e métodos, mas elas têm cinco diferenças importantes.

A primeira diferença entre classes e estruturas é que as classes nunca vêm com 
um inicializador membro. Isso significa que, se você tiver propriedades em sua 
classe, você deve sempre criar seu próprio inicializador.

Por exemplo:

class Dog {
    var name: String
    var breed: String

    init(name: String, breed: String) {
        self.name = name
        self.breed = breed
    }
}

Criar instâncias dessa classe parece exatamente o mesmo que se fosse uma estrutura:

let poppy = Dog(name: "Poppy", breed: "Poodle")



Classes e estruturas dão aos desenvolvedores Swift a capacidade de criar tipos personalizados e complexos com propriedades e métodos, mas eles têm cinco diferenças importantes:

1. As classes não vêm com inicializadores sintetizados por membro.

2.Uma classe pode ser construída (“herdar de”) outra classe, ganhando suas propriedades e métodos.

3. Cópias de estruturas são sempre únicas, enquanto cópias de classes realmente apontam para os mesmos dados compartilhados.

4. As classes têm desiniciadores, que são métodos que são chamados quando uma instância da classe é destruída, mas as estruturas não.

5. As propriedades variáveis em classes constantes podem ser modificadas livremente, mas as propriedades variáveis em estruturas constantes não podem.

A maioria dos desenvolvedores Swift prefere usar estruturas em vez de classes quando possível, o que significa que, quando você escolhe uma classe em vez de uma estrutura, está fazendo isso porque deseja um dos comportament


---------- 2. 


