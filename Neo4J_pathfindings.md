# Neo4J, Pathfindinds Algorithms

## 1. Criando um Exemplo de Base de Dados

Vamos criar um grafo simples que inclui nós (representando cidades) e relacionamentos (representando as estradas entre elas).

```cypher
// Criando cidades
CREATE (sp:City {name: "São Paulo"})
CREATE (rj:City {name: "Rio de Janeiro"})
CREATE (bh:City {name: "Belo Horizonte"})
CREATE (br:City {name: "Brasília"})
CREATE (sv:City {name: "Salvador"})
```

```cypher
// Criando estradas (distâncias em quilômetros aproximadas)
CREATE (sp)-[:CONNECTED {distance: 430}]->(rj)  // São Paulo a Rio de Janeiro
CREATE (sp)-[:CONNECTED {distance: 586}]->(bh)  // São Paulo a Belo Horizonte
CREATE (rj)-[:CONNECTED {distance: 360}]->(bh)  // Rio de Janeiro a Belo Horizonte
CREATE (bh)-[:CONNECTED {distance: 715}]->(br)  // Belo Horizonte a Brasília
CREATE (br)-[:CONNECTED {distance: 1000}]->(sv) // Brasília a Salvador
CREATE (bh)-[:CONNECTED {distance: 1050}]->(sv) // Belo Horizonte a Salvador
```

## 2. Exemplos de Algoritmos de Pathfinding

Agora que temos o grafo configurado com cidades brasileiras e distâncias, vamos usar alguns algoritmos de pathfinding.

### 2.1. **algo.shortestPath.stream**. Encontrar o Caminho Mais Curto com o algoritmo de Dijkstra


```cypher
MATCH (start:City {name: "São Paulo"}), (end:City {name: "Salvador"})
CALL algo.shortestPath.stream(start, end, 'CONNECTED', {graph: 'cypher', weightProperty: 'distance'}) YIELD nodeId, cost
RETURN algo.getNodeById(nodeId).name AS City, cost;
```

O algoritmo de Dijkstra é um método que encontra o caminho mais curto de um nó inicial para todos os outros nós 
em um grafo com pesos não negativos em suas arestas. Ele utiliza uma abordagem *gulosa*, expandindo o nó com a 
menor distância acumulada e atualizando as distâncias dos nós vizinhos até encontrar o caminho mais curto para o nó de destino.
Ele começa a partir do nó inicial, atribuindo a ele uma distância de 0 e a todos os outros nós uma distância infinita.
Em cada iteração, escolhe o nó com a menor distância não visitada, e atualiza as distâncias dos nós vizinhos baseando-se nessa.
Repete o processo até que todos os nós sejam visitados ou até encontrar o nó de destino.

Saída:

| City       | Cost |
|------------|------|
| São Paulo  |  0   |  (inicial)
| Rio de Janeiro |  430 |
| Belo Horizonte |  586 |
| Brasília   |  1000 |
| Salvador   |  1050 |

Isso mostra que o caminho mais curto de São Paulo a Salvador teria um custo total de 1.050 km, passando por Brasília ou Belo Horizonte.

### 2.2. **algo.aStar.stream**. Encontrar o Caminho Mais Curto com o algoritmo A*

```cypher
MATCH (start:City {name: "São Paulo"}), (end:City {name: "Salvador"})
CALL algo.aStar.stream(start, end, 'CONNECTED', 'distance', {graph: 'cypher'}) YIELD nodeId, cost
RETURN algo.getNodeById(nodeId).name AS City, cost;
```

O algoritmo A* é uma melhoria sobre o Dijkstra que também usa uma heurística para encontrar o caminho mais curto 
de forma mais eficiente. Em vez de expandir todos os nós sempre que uma distância mínima é encontrada, 
o A* utiliza uma função de custo que considera a distância do nó atual ao nó final (heurística). 
Ele inicializa o nó de partida com uma estimativa de custo (g + h), onde "g" é o custo conhecido até o nó atual e "h" é a estimativa do custo até o destino.
Escolhe sempre o nó com a menor função de custo (g + h) para expandir. Assim como Dijkstra, ele atualiza as distâncias dos vizinhos, porém levando em conta a heurística.

Saída:
(a saída será semelhante ao Dijkstra, mas com um caminho mais curto possivelmente em menos iterações. 

| City       | Cost |
|------------|------|
| São Paulo  |  0   |
| Rio de Janeiro |  430 |
| Belo Horizonte |  586 |
| Brasília   |  1000 |
| Salvador   |  1050 |

A saída pode variar dependendo da heurística utilizada, mas geralmente será o mesmo caminho.

### 2.3. **algo.allShortestPaths.stream**. Encontrar Todos os Caminhos de um Nó a Outro

```cypher
MATCH (start:City {name: "São Paulo"}), (end:City {name: "Salvador"})
CALL algo.allShortestPaths.stream(start, end, {graph: 'cypher', weightProperty: 'distance'}) YIELD nodeId, cost
RETURN algo.getNodeById(nodeId).name AS City, cost;
```

Este algoritmo encontra todos os caminhos mais curtos entre os nós especificados, em vez de apenas o mais curto.
Isso é útil quando se deseja ter uma visão completa das opções disponíveis. Usa uma abordagem semelhante à do Dijkstra, mas sem parar após encontrar o primeiro caminho mais curto.
Explora todas as rotas possíveis e as armazena, retornando uma lista de todos os caminhos que têm o menor custo.

Saída:

| Path                                     | Cost |
|------------------------------------------|------|
| São Paulo -> Rio de Janeiro -> Brasília -> Salvador | 1000 |
| São Paulo -> Belo Horizonte -> Brasília -> Salvador  | 1000 |
| São Paulo -> Belo Horizonte -> Salvador                | 1050 |

Isso mostraria todos os caminhos mais curtos que levam a Salvador.

