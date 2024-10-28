
# Neo4J, Funções de Agrupamento e Consulta de Relacionamentos

# Sample Database 
Para os exemplos, consideraremos nós de artistas (`Artista`) e filmes (`Filme`) com relacionamentos de atuação (`Elenco`). 

```cypher
// Criando artistas
CREATE (a1:Artista {nome: "Robert De Niro", altura: 177, local_nascto: "New York, USA"})
CREATE (a2:Artista {nome: "Al Pacino", altura: 170, local_nascto: "New York, USA"})
CREATE (a3:Artista {nome: "Fernanda Montenegro", altura: 160, local_nascto: "Rio de Janeiro, Brazil"})

// Criando filmes
CREATE (f1:Filme {titulo_original: "The Godfather Part II", ano_lancamento: 1974, generos: "Crime, Drama", duração: 200})
CREATE (f2:Filme {titulo_original: "Heat", ano_lancamento: 1995, generos: "Crime, Thriller", duração: 170})
CREATE (f3:Filme {titulo_original: "Central do Brasil", ano_lancamento: 1998, generos: "Drama", duração: 115})

// Criando relacionamentos de elenco
CREATE (a1)-[:Elenco {tipo_participação: "Actor"}]->(f1)
CREATE (a2)-[:Elenco {tipo_participação: "Actor"}]->(f1)
CREATE (a1)-[:Elenco {tipo_participação: "Actor"}]->(f2)
CREATE (a3)-[:Elenco {tipo_participação: "Actor"}]->(f3)
```

---

## 1. Antes, vamos rever como trabalhar com datas 

### 1.1 Criando e Extraindo Informações de Datas

A função `datetime()` permite capturar a data e hora atual, enquanto `datetime(<var>).month`, `.year` e `.day` extraem mês, ano e dia de uma data.

```cypher
// Obtendo a data e hora atual
RETURN datetime() AS Data_Atual

// Extraindo o mês e dia de uma data
RETURN datetime("2024-10-27T14:30:00").month AS Mes, datetime("2024-10-27T14:30:00").day AS Dia
```

### 1.2 Calculando Duração entre Datas

Com `duration.between()`, calculamos a duração entre duas datas.

```cypher
// Calcular a diferença entre duas datas
RETURN duration.between(datetime("1974-12-20"), datetime("2024-10-27")) AS Duracao
```

---

## 2. Manipulação de Tipos e Funções de Grupo

### 2.1 Conversão de Tipos


**toInteger**. Para converter valores de atributos para tipos específicos, como `toInteger()`, facilitando cálculos e funções de grupo.

```cypher
// Convertendo altura dos artistas para tipo inteiro
MATCH (a:Artista)
SET a.altura = toInteger(a.altura)
RETURN a.nome, a.altura LIMIT 50
```

Aqui você encontra também o comando **`LIMIT`**, que não havíamos empregado antes.

**toString**. Aqui como converter dados numéricos para string.

```cypher
// Conversão de altura para string e concatenação com o nome
MATCH (a:Artista)
RETURN a.nome + " tem altura de " + toString(a.altura) + " cm" AS Descricao_Artista
```

### 2.2 Funções de Grupo: `COUNT`, `AVG`, `SUM`, `MIN`, `MAX`

As funções de grupo permitem calcular média, contagem, soma, mínimo e máximo, e funcionam como as funções de agregação da SQL.

```cypher
// Média de altura dos artistas
MATCH (a:Artista)
RETURN AVG(a.altura) AS Media_Altura

// Estatísticas sobre altura dos artistas
MATCH (a:Artista)
WHERE a.altura IS NOT NULL
RETURN COUNT(a) AS Contagem, AVG(a.altura) AS Media_Altura, MAX(a.altura) AS Maior_Altura, MIN(a.altura) AS Menor_Altura
```

Note que isso é o equivalente da SQL:

```
SELECT AVG(a.altura) AS Media_altura, ...
FROM artista a
```


### 2.3 Agrupamento por Atributos

Podemos agrupar os dados para calcular estatísticas por categorias.

```cypher
// Estatísticas de altura agrupadas por local de nascimento
MATCH (a:Artista)
WHERE a.altura IS NOT NULL
RETURN a.local_nascto, COUNT(*) AS Contagem, AVG(a.altura) AS Media_Altura, MAX(a.altura) AS Maior_Altura, MIN(a.altura) AS Menor_Altura
ORDER BY Contagem DESC
```

Note que isso é o equivalente da SQL:

```
SELECT a.local_nascto, A COUNT(*) AS Contagem, ...,
FROM artista a
GROUP BY a.local_nascto
ORDER BY Contagem DESC
```

Note aqui mais um comando que não empregamos antes **`ORDER BY Contagem DESC`**. 

---

## 3. Consultas com Relacionamentos

### 3.1 Contagem de Filmes por Gênero e País

Podemos agrupar filmes por gênero e país para analisar sua distribuição.

```cypher
// Contagem de filmes por gênero e país
MATCH (f:Filme)
WHERE f.generos IS NOT NULL AND f.pais IS NOT NULL
RETURN f.pais AS Pais, f.generos AS Generos, COUNT(*) AS Contagem_Genero
ORDER BY Contagem_Genero DESC
```

### 3.2 Artistas e Filmes Específicos

Filtrar filmes e artistas por critérios, como gênero de filme e participação do artista.

```cypher
// Contagem de filmes de ficção científica com atrizes
MATCH (f:Filme)-[e:Elenco]->(a:Artista)
WHERE e.tipo_participação =~ '(?i).*actress.*' AND f.generos =~ '(?i).*sci-fi.*'
RETURN a.nome AS Artista, COUNT(e.tipo_participação) AS Qtde_Atuacoes
ORDER BY Qtde_Atuacoes DESC
```

### 3.3 Filmes de Artistas com Condições Específicas

Analisar quantos filmes um artista atuou dentro de critérios específicos, como país e gênero.

```cypher
// Artistas brasileiros que atuaram em comédias
MATCH (f:Filme)-[e:Elenco]->(a:Artista)
WHERE e.tipo_participação =~ '(?i).*act.*' AND f.generos =~ '(?i).*comedy.*' AND toUpper(f.pais) CONTAINS 'BRA'
RETURN a.nome AS Artista, COUNT(e.tipo_participação) AS Qtde_Atuacoes
ORDER BY Qtde_Atuacoes DESC
```

---

## 4. Consultas Complexas com Relacionamentos

### 4.1 Exploração de Relacionamentos entre Artistas e Filmes

Explorar as conexões entre artistas e filmes específicos para identificar colaborações.

```cypher
// Todos que trabalharam com Robert De Niro
MATCH (a1:Artista)<-[e1:Elenco]-(f:Filme)-[e2:Elenco]->(a2:Artista)
WHERE a1.nome =~ '(?i).*robert.*' AND a1.nome =~ '(?i).*niro.*' AND a1 <> a2
RETURN a2.nome AS CoAtor, f.titulo_original AS Filme
```

---

