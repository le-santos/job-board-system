# Job Board System (Rails Web App)
> Status do Projeto: Em desenvolvimento :warning:

Essa aplicação é uma plataforma Web para que pessoas do RH de empresas criem vagas e gerenciem todo processo de forma colaborativa. Além disso, a plataforma funciona como um site de busca empregos, no qual visitantes podem se cadastrar e se candidatar para estas vagas.

O projeto foi desenvolvido ao longo do programa [TreinaDev](https://treinadev.com.br/), da [Campus Code](https://www.campuscode.com.br/). 

## Requisitos, versões e gems utilizadas
- Ruby 3.0.0
- Rails 6.1.1
- Devise 4.7.3

Para os testes:
- rspec 4.0.2
- Capybara 3.34.0
- FactoryBot rails 6.1.0

## Funcionalidades

A aplicação tem duas funcinalidades básicas:
- Gestão de Vagas por pessoas do RH de uma empresa 
- Busca de vagas por visitantes e candidatos

### Usuário Colaborador:

:ballot_box_with_check: O primeiro colaborador pode se cadastrar com email da corporativo e criar o perfil da empresa, sendo admin deste perfil

:ballot_box_with_check: Todos os colaboradores que se cadastrarem com o email de mesmo domínio estarão associados a essa empresa

:ballot_box_with_check: Todos os colaborares associados podem ver detalhes da empresa, criar vagas e visualizar candidaturas

:ballot_box_with_check:  Todos os colaboradores podem recusar ou aprovar candidaturas, enviando propostas


### Usuário Visitante:

:ballot_box_with_check: Pode visualizar Empresas e suas vagas

:ballot_box_with_check: Pode se candidatar a alguma vaga, mediante cadastro

### Usuário Candidato:

:ballot_box_with_check: Pode criar e editar seu perfil

:ballot_box_with_check: Pode vizualizar suas candidaturas enviadas

:ballot_box_with_check: Pode vizualizar propostas recebidas, as quais pode aprovar ou recusar 

### Vagas:

:ballot_box_with_check: Pode ser desativagas por um colaborador 

:ballot_box_with_check: São desativadas automaticamente após zerar a quantidade disponível 


### Próximos passos

O projeto ainda está finalizando o desenvolvimento de suas funcionalidades básicas.
Após completar essas etapas, alguns dos próximos passos serão:

- Revisão do Estilo (CSS) e layout
- Confirmação de cadastro 
- Validação de dados (como email, CPF)
- Funcionalidade Banco de Currículos
