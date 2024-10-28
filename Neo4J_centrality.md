# Neo$J, Centralidade e Detecção de Comunidades em Grafos

## 1. Centralidade com Cidades Brasileiras

As medidas de centralidade ajudam a **identificar os nós mais importantes dentro de um grafo**.
Existem várias formas de calcular a centralidade, como:

* Centralidade de **Grau**: Mede a importância de um nó com base no **número de conexões (arestas)** que ele possui.
* Centralidade de **Proximidade**: Avalia a rapidez com que um nó pode alcançar todos os outros nós no grafo.
* Centralidade de **Intermediação**: Mede quantas vezes um nó atua como intermediário ao longo dos caminhos mais curtos entre outros nós.

Vamos criar um grafo com cidades e calcular a **centralidade de grau**.

### 1.1 Criando a Base de Dados

```cypher

// Criando cidades
CREATE (sp:City {name: "São Paulo"})
CREATE (rj:City {name: "Rio de Janeiro"})
CREATE (bh:City {name: "Belo Horizonte"})
CREATE (br:City {name: "Brasília"})
CREATE (sv:City {name: "Salvador"})

// Criando estradas com distâncias em quilômetros
CREATE (sp)-[:CONNECTED]->(rj)
CREATE (sp)-[:CONNECTED]->(bh)
CREATE (rj)-[:CONNECTED]->(bh)
CREATE (bh)-[:CONNECTED]->(br)
CREATE (br)-[:CONNECTED]->(sv)
CREATE (bh)-[:CONNECTED]->(sv)
CREATE (sp)-[:CONNECTED]->(br)
CREATE (rj)-[:CONNECTED]->(sv)
```

### 1.2 Calculando a Centralidade de Grau: algo.degree

Para calcular a centralidade de grau de cada cidade podemos empregar o método **algo.degree**. 

```cypher

CALL algo.degree('City', 'CONNECTED') YIELD nodeId, score
RETURN algo.getNodeById(nodeId).name AS City, score AS DegreeCentrality
ORDER BY DegreeCentrality DESC;
```

A saída informará quais cidades têm a maior centralidade de grau:


| City                | DegreeCentrality |
|---------------------|------------------|
| São Paulo           | 3                |
| Rio de Janeiro      | 3                |
| **Belo Horizonte**      | **4**                |
| Brasília            | 2                |
| Salvador            | 2                |


## 2. Detecção de Comunidades em Grafos
 
A detecção de comunidades busca dividir um grafo em grupos de nós que estão mais densamente conectados 
entre si do que com o restante do grafo. Isso é útil para identificar subgrupos em redes sociais, redes de transporte, etc.

Vamos usar nosso grafo de cidades para detectar comunidades das cidades brasileiras.

### 2.1 Detectando Comunidades, algo.louvain

Para detectar comunidades podemos usar um algoritmo de detecção de comunidades, como o algoritmo de Louvain, implementado no método **algo.louvain** do Neo4J:

```cypher
CALL algo.louvain('City', 'CONNECTED') YIELD nodeId, community
RETURN algo.getNodeById(nodeId).name AS City, community
ORDER BY community;
```

A saída mostrará a associação de cada cidade a uma comunidade:

| City                | Community |
|---------------------|-----------|
| São Paulo           | 0         |
| Rio de Janeiro      | 0         |
| Belo Horizonte      | 1         |
| Brasília            | 1         |
| Salvador            | 1         |

Neste exemplo, as cidades "São Paulo" e "Rio de Janeiro" poderiam ser detectadas como pertencentes à mesma comunidade,
enquanto "Belo Horizonte", "Brasília" e "Salvador" pertencem a outra. É um algoritmo semelhante à *clusterização*. 

## 3. Outras métricas do Neo4j 

### 3.1. **Centralidade de Proximidade**
Mede o quão perto um nó está de todos os outros nós no grafo.

```cypher
CALL algo.closeness('City', 'CONNECTED') YIELD nodeId, score
RETURN algo.getNodeById(nodeId).name AS City, score AS ClosenessCentrality
ORDER BY ClosenessCentrality DESC;
```

### 3.2. **Centralidade de Intermediação**
Mede quantas vezes um nó aparece nos caminhos mais curtos entre outros nós.

```cypher
CALL algo.betweenness('City', 'CONNECTED') YIELD nodeId, score
RETURN algo.getNodeById(nodeId).name AS City, score AS BetweennessCentrality
ORDER BY BetweennessCentrality DESC;
```

### 3.3. **PageRank**
Mede a importância de um nó em relação aos outros, baseado em um modelo de link semelhante ao algoritmo utilizado pelo Google.

```cypher
CALL algo.pageRank('City', 'CONNECTED', {iterations:20, dampingFactor:0.85}) YIELD nodeId, score
RETURN algo.getNodeById(nodeId).name AS City, score AS PageRankScore
ORDER BY PageRankScore DESC;
```

### 3.4. **Densidade do Grafo**
Calcula a densidade do grafo, que é a razão entre o número de arestas e o número máximo possível de arestas em um grafo.

```cypher
MATCH (n)
RETURN density((n)--()) AS GraphDensity;
```

### 3.5. **Diâmetro do Grafo**
Resume a maior distância entre quaisquer dois nós no grafo.

```cypher
CALL algo.diameter('City', 'CONNECTED') YIELD diameter
RETURN diameter;
```

### 3.6. **Espaço Conectado**
Identifica os componentes conectados do grafo, ou seja, grupos de nós que estão interconectados.

```cypher
CALL algo.connectedComponents("City", "CONNECTED") YIELD nodeId, component
RETURN algo.getNodeById(nodeId).name AS City, component
ORDER BY component;
```

### 3.7. **Análise de Comunidade** (Outros Métodos)
Além do algoritmo de Louvain, existem outras abordagens, como o algoritmo de Girvan-Newman, que detecta comunidades removendo arestas de maior centralidade.

```cypher
CALL algo.girvanNewman('City', 'CONNECTED') YIELD node1, node2, community
RETURN algo.getNodeById(node1).name AS City1, algo.getNodeById(node2).name AS City2, community;
```

