# Job Board System (Rails Web App)
> Status do Projeto: Em desenvolvimento :warning:

Essa aplicação é uma plataforma Web de gestão de vagas de emprego e candidaturas. Ela permite que pessoas do RH de empresas criem e gerenciem as vagas de forma colaborativa. Além disso, a plataforma funciona como um site de busca empregos, no qual visitantes podem se cadastrar e se candidatar as vagas disponíveis.

O projeto foi contruído seguindo a **prática do TDD**, contando com testes unitários e de integração, e foi desenvolvido ao longo do programa [TreinaDev](https://treinadev.com.br/), da [Campus Code](https://www.campuscode.com.br/).

## Pré-requisitos 

- Ruby 3.0.0 
- Rails 6.1.1 
- Node 
- Yarn 
- SQlite3 

Verifique se tem esses requisitos buscando as versões no terminal: 

```bash
ruby --version 
``` 

## Dependências: Gems utilizadas

- [Devise](https://github.com/heartcombo/devise)  4.7.3
- [Rspec_rails](https://github.com/rspec/rspec-rails) 4.0.2 
- [Capybara](https://github.com/teamcapybara/capybara) 3.34.0 
- [SimpleCov](https://github.com/simplecov-ruby/simplecov) 0.12.2 
- [Factory_bot_rails](https://github.com/thoughtbot/factory_bot_rails) 6.1.0
- [Bootstrap](https://github.com/twbs/bootstrap-rubygem) 5.0.0.beta2
- [Jquery-rails](https://github.com/rails/jquery-rails) 4.4.0

## Instalando a aplicação 

1. Clone o repositório 

Assumindo que tenha o `git` instalado na sua máquina: 

``` 
git clone https://github.com/le-santos/job-board-system.git 
``` 

2. Instale as dependências 

No diretório da aplicação, execute o Bundler para instalar as gems necessárias 

```bash
bundle install 
``` 

3. Inicialize a DB e o schema.rb

```bash
rails db:create 
rails db:migrate 
``` 

4. Rode a aplicação 

``` 
rails server 
``` 
Quando o servidor estiver no ar, a aplicação estará disponível no endereço: https://localhost:3000 

## Rodando a aplicação

Para testar a navegação e as interfaces com um usuário real, o arquivo `seeds.rb` inclui uma amostra de dados para popular o banco de dados. Carregue essa informações da seguinte forma:

```bash
# Para carregar os valores do db/seeds.rb com:
rails db:seed

# Ou caso precise apagar o banco antes
rails db:reset 
``` 

Dessa forma, podes navegar como **Visitante** ou logar como:

- **Colaborador**: { email: pedro@devapps.com.br, password: 123456 } 
- **Candidato**: { email: teca@gmail.com.br, password: 123456 }


## Executando os Testes 

Para os testes foram utilizadas as gems **Rspec** e **Capybara**, além da **FactoryBot** para facilitar a criação de instâncias nos testes.  

```bash
 # Rode todos os testes com: 
 rspec 

 # Ou usando o bundle exec: 
 bundle exec rspec 
```

Além dessas, foi incluída a gem **SimpleCov** para verificar a cobertura de testes da aplicação. Ao rodar os testes, será gerado um arquivo em `coverage/index.html` com os dados gerados pelo simpleCov.


## Funcionalidades

A aplicação tem duas funcionalidades básicas:
- Gestão de vagas por pessoas do RH de uma empresa 
- Busca de vagas por visitantes e candidatos

### Usuário Colaborador:

:ballot_box_with_check: O primeiro colaborador pode se cadastrar com um email corporativo e criar o perfil da empresa, sendo admin deste perfil

:ballot_box_with_check: Todos os colaboradores que se cadastrarem com o email de mesmo domínio estarão associados a essa empresa

:ballot_box_with_check: Todos os colaborares associados podem ver detalhes da empresa, criar vagas e visualizar candidaturas

:ballot_box_with_check:  Todos os colaboradores podem recusar ou aprovar candidaturas, enviando propostas aos candidatos

### Usuário Visitante:

:ballot_box_with_check: Pode visualizar as empresas e suas vagas

:ballot_box_with_check: Pode se candidatar a alguma vaga, mediante cadastro

### Usuário Candidato:

:ballot_box_with_check: Pode criar e editar seu perfil

:ballot_box_with_check: Pode vizualizar suas candidaturas enviadas

:ballot_box_with_check: Pode vizualizar propostas recebidas, as quais pode aprovar ou recusar 

### Vagas:

:ballot_box_with_check: Podem ser desativadas por um colaborador 

:ballot_box_with_check: São desativadas automaticamente após zerar a quantidade disponível ou quando a data expirar 


## Próximos passos

O projeto ainda está finalizando o desenvolvimento de suas funcionalidades.
Após completar essas etapas, alguns dos próximos passos serão:

- Completar a revisão do CSS e layout de todas as views
- Adicionar funcionalidade de busca por vagas
- Revisar formato dos formulários de cadastro
- Adicionar validação de dados como email e CPF
- Adicionar confirmação de cadastro 
