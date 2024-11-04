# Neo4J, Consultas para Recomendação

## Base de Dados

Modelo de dados de filmes, atores/atrizes e diretores empregado.  
A relação central é `Elenco`, conectando `Artista` e `Filme`, em que a propriedade `tipo_participação`  especifica o papel do artista (ator, diretor, etc.).

* **Nós:**
    * `Artista`:  `{nome: 'Nome do Artista'}`
    * `Filme`: `{titulo: 'Título do Filme'}`

* **Relações:**
    * `Elenco`: `{tipo_participação: 'ator' | 'diretor' | ...}`  conecta `Artista` e `Filme`.

```
(:Artista {nome: 'Paulo Gustavo'})
(:Artista {nome: 'Wagner Moura'})
(:Artista {nome: 'Fernanda Montenegro'})
(:Artista {nome: 'Fabio Porchat'})
(:Artista {nome: 'Robert De Niro'})
(:Artista {nome: 'Quentin Tarantino'})
...
(:Artista {nome: 'Ator X'})
(:Artista {nome: 'Atriz Y'})

(:Filme {titulo: 'Filme A'})
(:Filme {titulo: 'Filme B'})
(:Filme {titulo: 'Filme C'})
(:Filme {titulo: 'Filme D'})
(:Filme {titulo: 'Filme E'})
...

(:Artista {nome: 'Paulo Gustavo'})-[:Elenco {tipo_participação: 'ator'}]->(:Filme {titulo: 'Filme A'})
(:Artista {nome: 'Ator X'})-[:Elenco {tipo_participação: 'ator'}]->(:Filme {titulo: 'Filme A'})

(:Artista {nome: 'Paulo Gustavo'})-[:Elenco {tipo_participação: 'ator'}]->(:Filme {titulo: 'Filme B'})
(:Artista {nome: 'Atriz Y'})-[:Elenco {tipo_participação: 'ator'}]->(:Filme {titulo: 'Filme B'})

(:Artista {nome: 'Wagner Moura'})-[:Elenco {tipo_participação: 'ator'}]->(:Filme {titulo: 'Filme C'})
(:Artista {nome: 'Ator X'})-[:Elenco {tipo_participação: 'ator'}]->(:Filme {titulo: 'Filme C'})
...

```

## Exemplos de Consultas

### **1. Quem trabalhou com Paulo Gustavo?**

```cypher
MATCH (a1)<-[e1:Elenco]-(f)-[e2:Elenco]->(a2)
WHERE a1.nome =~ '(?i).*paulo.*' AND a1.nome =~ '(?i).*gustavo.*'
AND a1 <> a2
RETURN *
```
Busca pares de atores (`a1` e `a2`) que participaram do mesmo filme (`f`), onde `a1` é Paulo Gustavo.  O `(?i).*` na cláusula `WHERE` garante pesquisa case-insensitive. `a1 <> a2` previne que retorne Paulo Gustavo consigo mesmo.

### **2. Quantas vezes cada artista trabalhou com Paulo Gustavo?**

```cypher
MATCH (a1)<-[e1:Elenco]-(f)-[e2:Elenco]->(a2)
WHERE a1.nome =~ '(?i).*paulo.*' AND a1.nome =~ '(?i).*gustavo.*'
AND a1 <> a2
RETURN a2.nome AS Trabalhou_junto, COUNT(e2) AS Qtas_vezes
ORDER BY Qtas_vezes DESC
```

Similar à consulta anterior, mas agrupa os resultados por ator (`a2.nome`) e conta quantas vezes (`COUNT(e2)`) cada um participou de um filme com Paulo Gustavo.

### **3. Quem ainda não trabalhou com Paulo Gustavo?**

```cypher
MATCH (a1)<-[e1:Elenco]-(f1)-[e2:Elenco]->(a2),
(a2)<-[e3:Elenco]-(f2)-[e4:Elenco]->(a3)
WHERE a1.nome =~ '(?i).*paulo gustavo.*' 
AND a1 <> a2 AND a2 <> a3
AND NOT (a1)<-[e1:Elenco]-(f1)-[e2:Elenco]->(a3)
RETURN *
```

Esta consulta é complexa e possivelmente ineficiente em grandes datasets. Ela busca atores que trabalharam com atores que trabalharam com Paulo Gustavo, mas que *não* trabalharam diretamente com ele. A lógica pode estar incompleta ou incorreta, retornando resultados inesperados. Uma revisão da lógica é necessária.

### **4. Amigos que levam a Fabio Porchat.**

```cypher
MATCH (a1)<-[e1:Elenco]-(f1)-[e2:Elenco]->(a2),
(a2)<-[e3:Elenco]-(f2)-[e4:Elenco]->(a3)
WHERE a1.nome =~ '(?i).*paulo gustavo.*'  // origem
AND a3.nome =~ '(?i).*porchat.*'  //destino
AND a1 <> a2 AND a2 <> a3
RETURN a2.nome AS Trabalhou, COUNT(*) AS Força_Relacionamento
ORDER BY  Força_Relacionamento DESC
```

Busca atores (`a2`) que trabalharam com Paulo Gustavo (`a1`) e também com Fabio Porchat (`a3`), identificando atores que conectam os dois. `COUNT(*)` conta quantas vezes cada `a2` aparece, indicando a força do relacionamento entre os dois atores.

### **5. Quem ainda não trabalhou com Wagner Moura?**

```cypher
MATCH (a1)<-[e1:Elenco]-(f1)-[e2:Elenco]->(a2),
(a2)<-[e3:Elenco]-(f2)-[e4:Elenco]->(a3)
WHERE a1.nome =~ '(?i).*wagner moura.*' 
AND a1 <> a2 AND a2 <> a3
AND NOT (a1)<-[e1:Elenco]-(f1)-[e2:Elenco]->(a3)
RETURN a2.nome AS TRabalhou, a3.nome AS Ainda_não_trabalhou
ORDER BY Ainda_não_trabalhou
```

Esta consulta identifica artistas que ainda não trabalharam diretamente com Wagner Moura, mas têm conexões de segundo grau através de outros artistas. 
O resultado mostra quem trabalhou com Wagner Moura (a2) e quem ainda não trabalhou (a3), ordenado pelo nome dos artistas que ainda não trabalharam.

### **6. Caminho com MAIS FORÇA para chegar em Fernanda Montenegro?**

```cypher
MATCH (a1)<-[e1:Elenco]-(f1)-[e2:Elenco]->(a2),
(a2)<-[e3:Elenco]-(f2)-[e4:Elenco]->(a3)
WHERE a1.nome =~ '(?i).*wagner moura.*' 
AND a3.nome =~ '(?i).*fernanda montenegro.*'
AND a1 <> a2 AND a2 <> a3
AND NOT (a1)<-[e1:Elenco]-(f1)-[e2:Elenco]->(a3)
RETURN a2.nome AS TRabalhou, COUNT(*) AS Força
ORDER BY Força DESC
```

Esta consulta busca o caminho mais forte entre Wagner Moura e Fernanda Montenegro através de um artista intermediário. A "força" do caminho é determinada pelo número de conexões entre os artistas. O resultado é ordenado pela força do relacionamento em ordem decrescente.

### **7. Qual o caminho para Robert De Niro chegar ao diretor Quentin Tarantino?**

```cypher
MATCH (a1:Artista)<-[e1:Elenco]-(f1:Filme)-[e2:Elenco]->(a2:Artista)<-[e3:Elenco]-(f2:Filme)-[e4:Elenco]->(a3:Artista)
WHERE a2 <> a3
AND a1.nome =~ '(?i).*robert de niro.*' // origem
AND a3.nome =~ '(?i).*tarantino.*' // destino
AND e2.tipo_participação =~ '(?i).*act.*'
AND e3.tipo_participação =~ '(?i).*act.*'
AND e4.tipo_participação =~ '(?i).*dir.*'
AND NOT (a1)<-[:Elenco]-(:Filme)-[:Elenco]->(a3)
RETURN a2.nome, a3.nome AS Recomendado, COUNT(e4) AS Força
ORDER BY Força DESC
```

Uma consulta mais sofisticada para encontrar caminhos entre Robert De Niro e Quentin Tarantino.  Busca atores (`a2`) que trabalharam com De Niro e também em filmes dirigidos por Tarantino, filtrando por tipo de participação. `COUNT(e4)` conta a força da conexão.

1. De Niro como ator em um filme (e1)
2. Um ator intermediário que trabalhou com De Niro (e2)
3. Esse mesmo ator intermediário em um filme dirigido por Tarantino (e3)
4. Tarantino como diretor desse filme (e4)


