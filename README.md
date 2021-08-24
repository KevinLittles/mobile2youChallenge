# Aplicativo de desafio - Mobile2You

### Esse desafio se compõe em reproduzir uma tela do aplicativo TodoMovies.

![460x0w](https://user-images.githubusercontent.com/49958388/130621852-faf48405-050a-49d1-8664-2c5577868bed.png)

### Requisitos apresentados

- Usar algum design pattern: MVP, MVVM, MVVM-C, VIPER
- As informações do filme devem vir do endpoint getMovieDetails
- Usar o vote_count que retorna da API para apresentar o número de likes
- Substituir o "3 of 10 watched" por "< popularity > views", utilizando o valor retornado da API e mantendo algum ícone ao lado
- O ícone de like(coração) deve mudar quando clicado, alternando entre preenchido e vazop.
- Deve haver uma lista de filmes abaixo dos detalhes
- O app deve ser desenvolvido utilizando a linguagemm Swift
- O projeto deve ser disponibilizado em um repositório aberto no GitHub. Envie a URL assim que possível

### Dicas apresentadas

- Você pode usar o Alamofire para facilitar a sua vida (é apenas uma dica, não é obrigatório)
- A lista de filmes abaixo do detalhe do filme pode ser o retorno da getSimilarMovies
- Gostamos de Rx
- Testes são sempre bem-vindos
- Vamos olhar tudo, inclusive commits, branches, organização de pastas, etc.
- Um código limpo e organizado pode ser mais importante do que o app todo pronto.
- Vamos ler seu README, caso você queira deixar alguma mensagem para nós

## Resultado

![image](https://user-images.githubusercontent.com/49958388/130620671-6996df7d-6ae4-421e-902e-2cd9eb23c9fb.png)

### Pontos a serem obervados

- O UI design pattern utilizado no projeto foi o MVVM. Por mais que minhas experiências com MVVM sejam bastante recentes, depois que comecei a aplica-lo não consigo mais ver o MVC (aka massive view controller pattern) com bons olhos... Aqui deixei um (quase que) diagrama de domínio do app para que a arquitetura possa ser visualizada mais facilmente.

![SMVVM M2Y](https://user-images.githubusercontent.com/49958388/130621287-cd6edeef-4ca9-4f33-acbc-15c9d1b7478c.png)

- Também sou muito novo no Rx, mas acredito que aprendi o suficiente nesse meio tempo para entender como funcionam os Observables e Observers, assim como as funções .bind, .flatMap e .subscribe para trabalhar com dados assíncronos/streams.

- Não apaguei as branches de features, justamente para que vocês possam ver a minha organização.

- Utilizei um framework bem legal chamado ChameleonFramework para lidar com as cores dos labels no app, você pode conferir sobre ele aqui: https://cocoapods.org/pods/ChameleonFramework
