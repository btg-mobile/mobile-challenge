# Desafio BTG

Avaliadores,

Muito obrigado pela oportunidade. 

![](btgappdemo.gif)

## Requisitos

## Features
### Obrigatórias:
- [x ] As taxas de câmbio disponíveis devem ser obtidas da chamada de [API Supported Currencies (/list)](https://currencylayer.com/documentation)
- [ x] A cotação atual deve ser obtida da chamada de [API Real-time Rates (/live)](https://currencylayer.com/documentation)
- [ x] É necessário fazer tratamento de erros e dos fluxos de exceção, como busca vazia, carregamento e outros erros que possam ocorrer.

### Opcionais (não necessário, porém contam pontos):
- [ x] Funcinalidade de busca na lista de moedas por nome ou sigla da moeda ("dólar" ou "USD").
- [x ] Ordenação da lista de moedas por nome ou código.
- [ x] Realizar a persistência local da lista de moedas e taxas para permitir o uso do app no caso de falta de internet.
- [ ] Desenvolver testes unitários e/ou funcionais. 
    - fiz somente alguns unitários 
- [ ] Desenvolver o app seguindo a arquitetura MVVM.
- [ ] Pipeline automatizado.

Fiz algumas também as seguintes features extras: 

- mostrar os dados da última atualização das cotações para o usuário
- botão para dar share para outros apps
- botão para fazer a troca da cotação base pela cotação alvo e vice-versa.
