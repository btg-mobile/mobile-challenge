#### LEIA AS INSTRUÇÕES POR COMPLETO ANTES DE COMEÇAR

O Desafio consiste no desenvolvimento de um app de conversão de moedas. O app deve permitir que o usuário selecione a moeda de origem e a moeda a ser convertida, para então inserir o valor e visualizar o resultado da conversão. 

## Requisitos

O app deve counsumir a [API CurrencyLayer](https://currencylayer.com/documentation). Para utilizar a API será necessário fazer um cadastro no plano gratuito para obter uma chave de acesso. Como o plano gratuito da API apresenta apenas as taxas de câmbio em relação ao dólar americano (USD), caso o usuário deseje fazer uma conversão entre quaisquer outras duas moedas, será necessário primeiro converter a moeda de origem para dólar e então de dólar para a moeda desejada. 

## Chave de acesso

Crie sua chave de acesso pela plataforma [API CurrencyLayer](https://currencylayer.com/documentation) e substitua dentro do arquivo build.gradle (app) o valor da variável CURRENCYLAYER_ACCESS_KEY atual pela sua nova chave gerada.

* Android: _Kotlin_
* O aplicativo deve ter duas telas principais:
   * A tela de conversão deve conter:
      * Dois botões que permitam o usuário a escolher as moedas de origem e de destino.
      * Um campo de entrada de texto onde o usuário possa inserir o valor a ser convertido.
      * Uma campo de texto para apresentar o valor convertido.
   * A tela de listagem de moedas deve conter:
      * Uma lista das moedas disponíves para conversão, mostrando código e nome da moeda.
    
* A listagem de moedas deve ser mostrada obrigatóriamente em uma tela diferente da tela de conversão.

## Features
### Obrigatórias:
- [ ] As taxas de câmbio disponíveis devem ser obtidas da chamada de [API Supported Currencies (/list)](https://currencylayer.com/documentation)
- [ ] A cotação atual deve ser obtida da chamada de [API Real-time Rates (/live)](https://currencylayer.com/documentation)
- [ ] É necessário fazer tratamento de erros e dos fluxos de exceção, como busca vazia, carregamento e outros erros que possam ocorrer.

### Opcionais (não necessário, porém contam pontos):
- [ ] Funcinalidade de busca na lista de moedas por nome ou sigla da moeda ("dólar" ou "USD").
- [ ] Ordenação da lista de moedas por nome ou código.
- [ ] Realizar a persistência local da lista de moedas e taxas para permitir o uso do app no caso de falta de internet.
- [ ] Desenvolver testes unitários e/ou funcionais.
- [ ] Desenvolver o app seguindo a arquitetura MVVM.
- [ ] Pipeline automatizado.
