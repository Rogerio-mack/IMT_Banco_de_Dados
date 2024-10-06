# Conceitos Básicos de **Neo4j** para operações CRUD  

Aqui você vai encontrar operações básicas de **C**reate, **R**ead, **U**pdate e **D**elete de dados no **Neo4j** envolvend dados de **filmes** e **artistas**.

## Limpando os Dados (Reset)

Antes de começarmos, vamos garantir que não haja nenhum dado na nossa base.

```cypher
// Limpando toda a base de dados
MATCH (n)
DETACH DELETE n
```
- **`MATCH (n)`**: Encontra todos os nós.
- **`DETACH DELETE n`**: Deleta todos os nós e seus relacionamentos.

---

## Criando Nós (CREATE)

Um **nó** no Neo4j pode representar qualquer entidade, como um filme ou um artista.

### Exemplo 1: Criando um Nó Simples

```cypher
// Criando um nó de filme
CREATE (f1:Filme {nome:"Star Wars", ano_lançamento:1977, genero: "ficção", estudio :"Lucas Films"})
RETURN f1
```
- **`CREATE (f1:Filme { ... })`**: Cria um nó do tipo `Filme` com os atributos definidos.
- **`RETURN f1`**: Retorna o nó recém-criado.

### Exemplo 2: Criando Vários Nós de uma Vez

Você pode criar vários nós em uma única operação. Isso também permite a criação de diferentes tipos de nós simultaneamente.

```cypher
// Criando vários nós de filmes e artistas
CREATE (filme2:Filme {nome:"O Poderoso Chefão I", ano_lançamento:1972, genero: "drama", estudio :"Paramount"}),
       (filme3:Filme {nome:"Central do Brasil", ano_lançamento:1990, genero: "drama", estudio :"VideoFilmes"}),
       (a1:Artista {nome:"Marlon Brando", pais:"EUA", sexo:"M"})
RETURN filme2, filme3, a1
```
- Aqui criamos dois filmes e um artista ao mesmo tempo, e os retornamos na mesma query.

---

## Consultando Nós (MATCH)

Agora que temos alguns dados, vamos fazer consultas utilizando o comando **MATCH**, que é a forma de buscar nós ou relacionamentos no Neo4j.

### Exemplo 1: Encontrar todos os artistas

```cypher
// Buscando todos os nós do tipo Artista
MATCH (n:Artista)
RETURN n
```
- **`MATCH (n:Artista)`**: Encontra todos os nós que têm o rótulo `Artista`.

### Exemplo 2: Consultar por propriedades específicas

Você pode buscar nós por atributos específicos utilizando uma combinação de **MATCH** e **WHERE**.

```cypher
// Encontrar o artista com nome específico
MATCH (a:Artista {nome: "Al Pacino"})
RETURN a
```

---

## Atualizando Dados (SET)

Para atualizar propriedades dos nós, utilizamos o comando **SET**.

```cypher
// Atualizando o país dos artistas dos EUA
MATCH (a:Artista)
WHERE a.pais = "EUA"
SET a.pais = "USA"
RETURN a
```
- **`SET a.pais = "USA"`**: Altera o valor da propriedade `pais` de "EUA" para "USA".

---

## Deletando Relacionamentos (DELETE)

Além de deletar nós, também podemos deletar **relacionamentos** entre eles.

```cypher
// Deletando um relacionamento entre um filme e um artista
MATCH (f:Filme)-[e:Elenco]->(a:Artista)
WHERE a.nome = "Francis Ford Copolla"
AND f.nome = "O Poderoso Chefão I"
DELETE e
```
- **`[e:Elenco]`**: Identifica o relacionamento do tipo `Elenco` entre um filme e um artista.
- **`DELETE e`**: Remove o relacionamento.

---

## Relacionamentos (CREATE RELATIONSHIP)

Um relacionamento no Neo4j conecta dois nós e pode ter atributos que detalham o tipo da conexão.

### Exemplo 1: Criar um relacionamento entre um filme e um artista

```cypher
// Criando um relacionamento entre Marlon Brando e O Poderoso Chefão I
MATCH (a:Artista {nome: "Marlon Brando"}), (f:Filme {nome: 'O Poderoso Chefão I'})
CREATE (f)-[e:Elenco {tipo_participação:"Ator", papel: "Vito Corleone"}]->(a)
RETURN *
```
- **`(f)-[e:Elenco]->(a)`**: Cria um relacionamento do tipo `Elenco` entre o filme e o artista.
- **Atributos do relacionamento**: `tipo_participação` e `papel`.

### Exemplo 2: Exibir o elenco de um filme

```cypher
// Exibindo o elenco de um filme específico
MATCH (f:Filme)-[e:Elenco]->(a:Artista)
WHERE f.nome =~ '(?i).*chefão I.*'
RETURN *
```
- **`WHERE f.nome =~ '(?i).*chefão I.*'`**: Faz uma busca insensível a maiúsculas por filmes com "chefão I" no nome.

---

## Consultas Avançadas (WHERE)

Utilizamos o comando **WHERE** para adicionar condições às consultas. Abaixo estão alguns exemplos avançados de uso de **WHERE**.

### Exemplo 1: Negação

```cypher
// Encontrar filmes que NÃO são do gênero drama
MATCH (f:Filme)
WHERE NOT (f.genero = 'drama')
RETURN f
```

### Exemplo 2: Combinação de Condições com AND e OR

```cypher
// Encontrar filmes lançados após 1975 ou que sejam do gênero drama
MATCH (f:Filme)
WHERE f.ano_lançamento > 1975 OR f.genero = 'drama'
RETURN f.nome, f.ano_lançamento, f.genero
```

### Exemplo 3: Consultas com LIKE

```cypher
// Buscar artistas cujo nome contenha "and"
MATCH (a:Artista)
WHERE a.nome CONTAINS 'and'
RETURN a
```

- **`CONTAINS`**: Faz uma busca por strings que contenham a palavra específica.
  
---

## Exemplo de Definição de Tópicos

Em um banco de dados com grafos, você pode definir **tópicos** como entidades, ou nós, e associar dados relacionados a eles.

```cypher
// Definir tópicos para filmes
CREATE (t1:Topico {nome:"Filmes de Ficção Científica"}),
       (t2:Topico {nome:"Filmes de Drama"})
RETURN t1, t2
```
Aqui, estamos criando dois tópicos que podem ser usados para organizar ou filtrar filmes com base em seus gêneros.

---

