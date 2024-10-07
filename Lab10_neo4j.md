# Conceitos Básicos de **Neo4j** para operações CRUD  

Aqui você vai encontrar operações básicas de **C**reate, **R**ead, **U**pdate e **D**elete de dados no **Neo4j** envolvend dados de **filmes** e **artistas**.

## O que é Cypher?

Cypher (veja a documentação [aqui](https://neo4j.com/docs/cypher-manual/current/introduction/cypher-overview/) é a linguagem de consulta de gráfico declarativa da Neo4j. Foi criada em 2011 por engenheiros da Neo4j como uma linguagem equivalente a SQL para bancos de dados de gráfico. Semelhante ao SQL, o Cypher permite que os usuários se concentrem no que recuperar do gráfico, em vez de como recuperá-lo. 

O Cypher fornece uma maneira visual de combinar padrões e relacionamentos. Ele se baseia no seguinte tipo de sintaxe ascii-art: `(nodes)-[:CONNECT_TO]->(otherNodes)`. Colchetes arredondados são usados ​​para nós circulares e `-[:ARROWS]->` para relacionamentos. Escrever uma consulta é efetivamente como desenhar um padrão através dos dados no gráfico (será? rs). 

## Cypher $\times$ SQL

Consultas SQL começam com o que um usuário quer retornar, enquanto consultas Cypher terminam com a cláusula return.

```SQL
SELECT movie.name
FROM movie
WHERE movie.rating > 7
```

```cypher
MATCH (movie:Movie)
WHERE movie.rating > 7
RETURN movie.title
```
Uma consulta mais complexa...

```SQL
SELECT actors.name
FROM actors
 	LEFT JOIN acted_in ON acted_in.actor_id = actors.id
	LEFT JOIN movies ON movies.id = acted_in.movie_id
WHERE movies.title = "The Matrix"
```

```cypher
MATCH (actor:Actor)-[:ACTED_IN]->(movie:Movie {title: 'The Matrix'})
RETURN actor.name
```

## Consultas

### Conceitos básicos

Fundamentalmente, um banco de dados de gráficos Neo4j consiste em três entidades principais: **nós, relacionamentos e caminhos**. As consultas Cypher são construídas para corresponder ou criar essas entidades em um gráfico. 

#### Nós
As entidades de dados em um banco de dados de gráficos Neo4j são chamadas de nós. Os nós são referenciados no Cypher usando parênteses ().

```cypher
MATCH (n:Person {name:'Anna'})
RETURN n.born AS birthYear
```

* `Person` é um **rótulo**. Rótulos são como tags e são usados ​​para consultar o banco de dados para nós específicos. Um nó pode ter vários rótulos, por exemplo `Person` e `Actor`.

* `name` é uma **propriedade** definida como Anna. As propriedades são definidas entre chaves, {}, e são usadas para fornecer aos nós informações específicas.

* **variável**, `n`. Variáveis são empregadas para referenciar nós especificados em cláusulas subsequentes.

Este é um modelo de dados Neo4j:

![imagem](https://github.com/Rogerio-mack/IMT_Banco_de_Dados/blob/main/Figuras/neo4jschema.PNG?raw=true)

Ele inclui dois tipos de rótulos de nós:

* `Person` nós, que têm as seguintes propriedades: `name` e `born`.

* `Movie` nós, que têm as seguintes propriedades: `title`, `released`, e `tagline`.

O modelo também contém cinco tipos de relacionamento diferentes entre os nós Persone Movie: `ACTED_IN, DIRECTED, PRODUCED, WROTE`, e `REVIEWED`. Dois dos tipos de relacionamento têm propriedades (`ACTED_IN` e `REVIEWED`). 


#### Relacionamentos
Os nós em um gráfico podem ser conectados com relacionamentos. Um relacionamento deve ter um nó inicial, um nó final e exatamente um tipo. Os relacionamentos são representados no Cypher com setas (por exemplo, `->`) indicando a direção de um relacionamento.

```cypher
//
// quantos amigos Anna conhecer desde antes de 2023?
//
MATCH (:Person {name: 'Anna'})-[r:KNOWS WHERE r.since < 2023]->(friend:Person)
RETURN count(r) As numberOfFriends
```

Diferentemente dos nós, as informações dentro de um padrão de relacionamento devem ser colocadas entre colchetes. 

Embora os nós possam ter vários rótulos, os relacionamentos podem ter apenas um.

> No Neo4J, os nós podem ter múltiplos rótulos (labels), enquanto os relacionamentos são restritos a um único rótulo. Essa diferença se deve ao propósito que cada entidade serve dentro de um banco de dados de grafos.

> **a. Nós com múltiplos rótulos**
> Os nós são as entidades do grafo, representando objetos como pessoas, produtos, locais, etc. Um nó pode ter múltiplos rótulos para classificar e categorizar um mesmo objeto de maneiras diferentes. 

  ```cypher
  CREATE (p:Pessoa:Cliente:VIP {nome: "João", idade: 30, email: "joao@email.com"})
  ```

> Aqui, o nó `p` tem os rótulos `Pessoa`, `Cliente` e `VIP`. Dependendo da consulta, ele pode ser tratado como qualquer um desses rótulos.

  ```cypher
  MATCH (p:Pessoa) RETURN p
  ```

  ```cypher
  MATCH (p:Cliente) RETURN p
  ```

  ```cypher
  MATCH (p:Cliente:VIP) RETURN p
  ```

> **b. Relacionamentos com um único rótulo**
> Os relacionamentos no Neo4J conectam nós e indicam a natureza da relação entre eles. Diferentemente dos nós, os relacionamentos só podem ter um tipo (ou rótulo), porque seu propósito é definir como dois nós se relacionam em um único contexto. No entanto, é possível que um mesmo par de nós tenha mais de um relacionamento de tipos diferentes.

```cypher
MATCH (p:Pessoa {nome: "João"}), (l:Loja {nome: "Loja A"})
CREATE (p)-[:É_CLIENTE_DE]->(l)
```

```cypher
CREATE (p)-[:VISITOU]->(l)
```
> Temos dois relacionamentos distintos entre os mesmos nós: `É_CLIENTE_DE` e `VISITOU`. Porém, cada relacionamento é único e definido por um tipo de conexão.

#### Caminhos
Caminhos em um gráfico consistem em nós e relacionamentos conectados. 

```cypher
MATCH (n:Person {name: 'Anna'})-[:KNOWS]-{1,5}(friend:Person WHERE n.born < friend.born)
RETURN DISTINCT friend.name AS olderConnections
```

Este exemplo busca todos os caminhos até 5 *hops away* de apenas de relacionamentos do tipo KNOWS, do nó inicial Anna para outros Person em que Person são pessoas mais velhas (cláusula WHERE). 

```cypher
MATCH p = SHORTEST 1 (:Person {name: 'Anna'})-[:KNOWS]-+(:Person {nationality: 'Canadian'})
RETURN p
```

A consulta acima, é mais complexa. e corresponde ao `SHORTEST` caminho de Anna para outro Person com uma nacionalidade definida como Canadian.

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

