# 🚗 AlkeParking
Projeto Integrador de Swift proposto pela Alkemy no IT Bootcamp.

## 📝 Descrição do projeto
AlkeParking é um estacionamento que permite estacionar diversos tipos de veículos (carro, motocicleta, micro-ônibus e ônibus) com capacidade máxima de 20 veículos, além de calcular as tarifas e calcular os ganhos.

## 💻 Desenvolvedores
* ___Douglas Yonemura___
* ___Kamilla Antunes___

## ❓ Exercícios
### Exercício 1
>Por que vehicles é definido como um Set?

Um dos requisitos iniciais, especificado no arquivo PDF do projeto, solicita que o estacionamento não permita check-in de veículos com placas iguais. A estrutura Set será a responsável por garantir que não haja repetição nas placas no momento da inserção no vetor *___vehicles___*.

### Exercício 2
>Pode mudar o tipo de veículo no tempo? Deve ser definido como variável ou como constante no Vehicle?

O tipo de veículo não deve mudar no tempo em que ele estará estacionado no AlkeParking. Devido a isso, a propriedade *___type___* foi definida como constante utilizando do termo let.

>Qual elemento do controle de fluxo poderia ser útil determinar a tarifa de cada veículo na computed property: 
>ciclo for, if ou switch?

O elemento mais útil neste caso seria o *___switch___*, devido ao padrão entre os valores que devem ser atríbuidos, além de que é necessário atribuir a vários estados (carro, onibus...).

### Exercício 3

>Onde devem ser adicionadas as propriedades, em Parkable, Vehicle ou em ambos?

Adicionada no protocolo *___Parkable___* e replicada/implementada em *___Vehicle___* que utilizará do protocolo.

>O cartão de desconto é opcional, ou seja, um veículo pode não ter cartão e seu 
>valor será nil. Qual tipo de dados do Swift permite ter esse comportamento?

O tipo *___Optional___*.

### Exercício 4

>O tempo de estacionamento dependerá de parkedTime e deverá ser computado cada vez que for consultado, tomando a data atual como referência. Qual tipo de >propriedade permite esse comportamento: lazy properties, computed properties ou static properties?

Neste caso foi utilizado do recurso da *___computed properties___*. Isso ocorreu pois o valor da propriedade não precisava ser armazenado o tempo todo, apenas quando fosse utilizada no check-out, sendo assim, obtida atraves de um getter.

### Exercício 7
>Uma propriedade de um struct está sendo modificada. Qual consideração deve ser levada em conta na definição da função?

É necessário explicitar o termo *___mutanting___* na definição da função, pois ele indicará a modificação da struct ao compilador.

### Exercício 10
>Qual validação deve ser feita para determinar se o veículo tem desconto? 
>Lembre-se de que a única coisa que importa é se tem ou não um cartão de desconto, não o valor do cartão.

Será necessário checar se a propriedade *___discountCard___* existente em *___Vehicle___* possui algum conteúdo ou se está nula. A resposta dessa verificação deve ser enviada ao parametro *___hasDiscountCard___*
