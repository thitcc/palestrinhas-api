# Conference Scheduler API

## Tabela de Conteúdos

- [Sobre](#sobre)
- [Funcionalidades](#funcionalidades)
- [Pré-Requisitos](#pré-requisitos)
- [Tecnologias Utilizadas](#tecnologias-utilizadas)
- [Bibliotecas](#bibliotecas)
- [Autores](#autores)
- [Licença](#licença)
- [Referências](#referências)

## Sobre

Este projeto foi desenvolvido para auxiliar na organização de uma conferência de programação. Ele fornece uma API REST para CRUD de palestras e organiza essas palestras em tracks de acordo com regras específicas.

## Funcionalidades

- CRUD de palestras
- Endpoint para upload de arquivo com listagem de palestras
- Algoritmo para organização de palestras em tracks

## Pré-Requisitos

- Ruby 3.0.2
- PostgreSQL 12 ou superior
- Bundler

## Instalação

### Clone o repositório:

```bash
git clone https://github.com/seu_usuario/palestrinhas-api.git
```

### Instale as dependências:

```bash
cd palestrinhas-api
bundle install
```

### Configure o banco de dados:

```lua
rails db:create db:migrate
```

---

## Execução

### Execute o servidor Rails:

```bash
rails s
```

Agora, a API estará disponível em [http://localhost:3000](http://localhost:3000).

---

## Testes

### Para executar os testes, utilize o comando:

```bash
rspec
```

## Postman Collection

[![Run in Postman](https://run.pstmn.io/button.svg)](https://god.gw.postman.com/run-collection/2668350-847ca4a5-7a5e-4935-beee-32b95cf59b3e?action=collection%2Ffork&source=rip_markdown&collection-url=entityId%3D2668350-847ca4a5-7a5e-4935-beee-32b95cf59b3e%26entityType%3Dcollection%26workspaceId%3Ddab0cd06-e883-4ad2-bb3f-a3ca761bc7d6)

## Bibliotecas

- Rails 7.0.8
- PostgreSQL 1.1
- Puma 5.0
- tzinfo-data
- bootsnap
- active_model_serializers 0.10.0
- date_validator 0.12.0
- debug
- dotenv-rails 2.1.1
- factory_bot_rails
- pry-byebug
- rubocop
- rubocop-rails
- rubocop-factory_bot
- rubocop-rspec
- rspec-rails 6.0.0
- annotate
- database_cleaner-active_record
- faker
- shoulda-matchers 5.0
- simplecov

## Referências

- [Documentação do Ruby on Rails](https://guides.rubyonrails.org/)
- [Go Rails](https://gorails.com/)
- [Documentação do PostgreSQL](https://www.postgresql.org/docs/)