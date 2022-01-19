# Teste Técnico backender | Árvore


* **Nome do Projeto**: ArvoreRepli
* **Autor**: Rafael Vilas Boas de Carvalho
* **Objetivo**: Construir uma API usando Phoenix (elixir) e banco de dados MySQL visando permitir a um parceiro da Árvore replicar a sua estrutura de Redes, Escolas, Turmas e administrá-la conforme necessário. 
A modelagem deverá utilizar apenas uma entidade (Entity), que poderá representar qualquer nível da estrutura hierárquica.
 
* **Tecnologias utilizadas**:
  * AWS EC2: Criação de uma máquina virtual linux para deploy da aplicação;
  * AWS RDS: Banco de dados MySql em nuvem;
  * Linux/UNIX;
  * Elixir + Erlang + Phoenyx framework

**Requisitos Mínimos:**
- [x] Documentação do repositório git 
- [x] Histórico de commits
- [x] Testes unitários

**Requisitos Desejáveis:**
- [x] Deploy em qualquer serviço para consumo durante avaliação 

***Bônus (Além do requisitado)***:
- Separação de ambientes:
  - [x] AWS EC2: Possui somente a aplicação e seus componentes instalados
  - [x] AWS RDS: Banco de dados em nuvem conectado com a aplicação 

----

### Iniciando o servidor
#### Com todo o ambiente preparado (Elixir + MySQL), faça:
  * 1. Clone o diretório
  * 2. Na raiz do projeto, execute `mix deps.get` para instalar todas as dependências
  * 3. Ainda na raiz do projeto, abra e configure o arquivo `.env` (instruções contidas no próprio arquivo)
  * 4. Após configurado o arquivo `.env` crie e migre o banco de dados com `mix ecto.setup` (na raiz do projeto)
  * 5. Execute o comando `source .env.dev && mix phx.server` para executar o servidor com as configurações realizadas no arquivo `.env`
  *  Obs.: Execute o comando `source .env && mix test` na raiz do projeto para execução dos testes

Se tudo estiver corretamente configurado, o servidor estará pronto para uso.

----

## Deploy

O deploy da aplicação foi realizado utilizando um Servidor Virtual em Nuvem (EC2) da Amazon (Amazon Linux), onde foi configurado todo o ambiente para que a aplicação fique disponível.

---
## Endpoints
#### Consumindo endpoints públicos:

* Retornar todas as entidades registradas no banco:

Request - GET: [http://18.229.134.86:4000/api/entities](http://18.229.134.86:4000/api/entities)

Response: 
```json
{
	"data": [
		{
			"entity_type": "foo",
			"id": 1,
			"inep": "bar",
			"name": "foobar",
			"parent_id": 2
		},
		{
			"entity_type": "foob",
			"id": 2,
			"inep": "arfoo",
			"name": "barfoo",
			"parent_id": 4
		},
		{
			"entity_type": "foo",
			"id": 3,
			"inep": "barfoo",
			"name": "foobarfoo",
			"parent_id": null
		},
        ...
}
```
------------
  * Cadastrar uma nova  entidade no banco:

    

Request - POST: [http://18.229.134.86:4000/api/entities](http://18.229.134.86:4000/api/entities) 
```json
{
    "entity": {
        "name": "Foo",
        "entity_type": "Bar",
        "inep": null,
        "parent_id": null
    }
}
```
Response:
```json
{
	"data": {
		"entity_type": "Foo",
		"id": 3,
		"inep": null,
		"name": "Bar",
		"parent_id": null,
		"subtree": [...]
	}
}
```
------------
 * Retornar uma entidade específica por ID:

Request - GET: [http://18.229.134.86:4000/api/entities/](http://18.229.134.86:4000/api/entities/:id)<idDaEntidade>

Response:
```json
{
	"data": {
		"entity_type": "school",
		"id": 1,
		"inep": "123456",
		"name": "school1",
		"parent_id": 4,
		"subtree": [
			4,
			6,
			10,
			11,
			12,
			16,
			17
		]
	}
}
```
------------
   * Atualizar os dados de uma entidade. Obs.: Dados para atualização devem ser enviados no body, como demonstrado logo abaixo.

Request - PUT: [http://18.229.134.86:4000/api/entities/](http://18.229.134.86:4000/api/entities/:id)<idDaEntidade>
```json
   {
    "entity": {
        "name": "networkaltered",
        "entity_type": "network",
        "inep": null,
        "parent_id": null
    }
}
```

Response:
```json
{
	"data": {
		"entity_type": "network",
		"id": 13,
		"inep": null,
		"name": "networkaltered",
		"parent_id": null,
		"subtree": [
			3
		]
	}
}
```

