# Neo4J, Solução Atividade 6
## Exercício 1. 
Mostre o nome dos atores que trabalharam diretamente com a atriz Fernanda Montenegro em filmes diferentes de drama e romance.

```cypher
MATCH (a1)<-[e1:Elenco]-(f)-[e2:Elenco]->(a2)
WHERE e2.tipo_participação =~ '(?i).*act.*'
AND a1.nome =~ '(?i).*fernanda montenegro.*'
AND ( NOT f.generos =~ '(?i).*drama.*'
      AND NOT f.generos =~ '(?i).*roman.*' )
RETURN a2.nome, f.titulo, f.generos
ORDER BY a2.nome
╒════════════════╤══════════╤═════════╕
│a2.nome         │f.titulo  │f.generos│
╞════════════════╪══════════╪═════════╡
│"Maria Sílvia"  │"Tudo Bem"│"Comedy" │
├────────────────┼──────────┼─────────┤
│"Paulo Gracindo"│"Tudo Bem"│"Comedy" │
├────────────────┼──────────┼─────────┤
│"Zezé Motta"    │"Tudo Bem"│"Comedy" │
└────────────────┴──────────┴─────────┘
```

## Exercício 2. 
Repita a consulta 1) acima para os que não trabalharam diretamente com ela, 
com maior força para fazer contato

```cypher
//***** segundo circulo
//** apareceu Luiz Fernando Guimarães com maior Força : 8, ou seja, tem 8 relacionamento que permitem chegar neste ator
// Fernada Torres -> 6, Pedro Cardoso -> 1, Evandro Mesquita -> 1
MATCH (a1:Artista)<-[e1:Elenco]-(f1:Filme)-[e2:Elenco]->(a2:Artista)<-[e3:Elenco]-(f2:Filme)-[e4:Elenco]->(a3:Artista)
WHERE a1 <> a3
AND a1.nome =~ '(?i).*fernanda montenegro.*'
AND e2.tipo_participação =~ '(?i).*act.*'
AND e3.tipo_participação =~ '(?i).*act.*'
AND e4.tipo_participação =~ '(?i).*act.*'
AND NOT (a1)<-[:Elenco]-(:Filme)-[:Elenco]->(a3)
// RETURN *
RETURN a2.nome AS Trabalhou, a3.nome AS Não_Trabalhou, COUNT(a3) AS Força
ORDER BY Força DESC
//RETURN a3.nome, a2.nome, f2.titulo, f1.titulo 
//ORDER BY a3.nome, a2.nome, f2.titulo, f1.titulo   **** aqui mostra quem são esses relacionamentos

╒═════════════════════════╤═══════════════════════════╤═════╕
│Trabalhou                │Não_Trabalhou              │Força│
╞═════════════════════════╪═══════════════════════════╪═════╡
│"Fernanda Torres"        │"Luiz Fernando Guimarães"  │6    │
├─────────────────────────┼───────────────────────────┼─────┤
│"Matheus Nachtergaele"   │"Denise Fraga"             │2    │
├─────────────────────────┼───────────────────────────┼─────┤
│"Matheus Nachtergaele"   │"Dira Paes"                │2    │
├─────────────────────────┼───────────────────────────┼─────┤
│"Paulo Gracindo"         │"Cristina Aché"            │2    │
├─────────────────────────┼───────────────────────────┼─────┤
│"Paulo Gracindo"         │"Paulo Guarnieri"          │2    │
├─────────────────────────┼───────────────────────────┼─────┤
│"Paulo Gracindo"         │"Ligia Diniz"              │2    │
├─────────────────────────┼───────────────────────────┼─────┤
│"José Dumont"            │"Mariana Lima"             │2    │
├─────────────────────────┼───────────────────────────┼─────┤
│"Marília Pêra"           │"José Wilker"              │2    │
```

## Exercício 3.
Mostre todos os artistas de filmes de comédia que não trabalharam com Renato Aragão (ator/atriz/diretor, etc.).

```cypher
MATCH (a1:Artista)<-[e1:Elenco]-(f1:Filme)-[e2:Elenco]->(a2:Artista),
(a2:Artista)<-[e3:Elenco]-(f2:Filme)-[e4:Elenco]->(a3:Artista)
WHERE a1 <> a3
AND a1.nome =~ '(?i).*renato.*' AND a1.nome =~ '(?i).*arag.*' 
AND f1.generos =~ '(?i).*comed.*' AND f2.generos =~ '(?i).*comed.*'
AND f1.país =~ '(?i).*bra.*' AND f2.país =~ '(?i).*bra.*'
AND NOT (a1)<-[:Elenco]-(:Filme)-[:Elenco]->(a3)
// RETURN *
RETURN a3.nome AS Não_Trabalhou, COUNT(a3.nome) AS Força  
ORDER BY Força DESC

╒═══════════════════════════╤═════╕
│Não_Trabalhou              │Força│
╞═══════════════════════════╪═════╡
│"Roberto Santucci"         │29   │
├───────────────────────────┼─────┤
│"Paloma Duarte"            │25   │
├───────────────────────────┼─────┤
│"Leandro Hassum"           │22   │
├───────────────────────────┼─────┤
│"Hugo Carvana"             │20   │
├───────────────────────────┼─────┤
│"Adriana Falcão"           │19   │
├───────────────────────────┼─────┤
│"Marcelo Saback"           │19   │
├───────────────────────────┼─────┤
│"Marcio Garcia"            │19   │
├───────────────────────────┼─────┤
│"Danielle Winits"          │19   │
├───────────────────────────┼─────┤
│"Ingrid Guimarães"         │19   │
```


## Exercício 4. 
Mostre os atores/atrizes com idade superior a 40 anos que mais trabalharam
em filmes de Romance com a atriz Julia Roberts.

```cypher
MATCH (a1)<-[e1:Elenco]-(f)-[e2:Elenco]->(a2)
WHERE e2.tipo_participação =~ '(?i).*act.*'
AND a1.nome =~ '(?i).*julia.*' AND a1.nome =~ '(?i).*roberts.*'
AND f.generos =~ '(?i).*roman.*'
AND a2.dt_nascto IS NOT NULL
WITH 
CASE
   WHEN a2.dt_nascto IS NOT NULL AND a2.dt_nascto =~ '.*-.*' 
        AND size(a2.dt_nascto) = 10 AND a2.dt_obito IS NULL THEN
             duration.between(date(a2.dt_nascto),date()).years
   WHEN a2.dt_obito IS NOT NULL AND a2.dt_obito =~ '.*-.*'
        AND size(a2.dt_obito) = 10 THEN
        duration.between(date(a2.dt_nascto),date(a2.dt_obito)).years
   END as Idade, a2.nome AS outro, f.titulo_original as filme, f.generos as genero
WHERE Idade > 40
RETURN outro , COUNT(*) AS Qtde_Vezes
ORDER BY Qtde_Vezes DESC LIMIT 5
```

## Exercício 5.
Mostre os diretores que dirigiram atores comuns ao diretor Glauber Rocha mas em gêneros diferentes

```cypher
MATCH (a1:Artista)<-[e1:Elenco]-(f1:Filme)-[e2:Elenco]->(a2:Artista)<-[e3:Elenco]-(f2:Filme)-[e4:Elenco]->(a3:Artista)
//UNWIND [f1.generos] AS genGlauber, UNWIND [f2.generos] AS genOutros
WHERE a1 <> a3
AND a1.nome =~ '(?i).*glauber.*'
AND e1.tipo_participação =~ '(?i).*dir.*'
AND e2.tipo_participação =~ '(?i).*act.*'
AND e3.tipo_participação =~ '(?i).*act.*'
AND e4.tipo_participação =~ '(?i).*dir.*'
//AND genGlauber <> genOutros
AND f1.generos <> f2.generos
AND NOT (a1)<-[:Elenco]-(:Filme)-[:Elenco]->(a3)
//RETURN *
RETURN a3.nome, COUNT(a3.nome) AS Força
ORDER BY Força DESC
```

```cypher
// tentativa com UNWIND - deu certo
MATCH (a1:Artista)<-[e1:Elenco]-(f1:Filme)-[e2:Elenco]->(a2:Artista)<-[e3:Elenco]-(f2:Filme)-[e4:Elenco]->(a3:Artista)
WHERE a1 <> a3
AND a1.nome =~ '(?i).*glauber.*'
AND e1.tipo_participação =~ '(?i).*dir.*'
AND e2.tipo_participação =~ '(?i).*act.*'
AND e3.tipo_participação =~ '(?i).*act.*'
AND e4.tipo_participação =~ '(?i).*dir.*'
WITH f1.generos AS genGlauber, f2.generos AS genOutros, a3.nome AS dirOutro
WITH [elemento in genGlauber | split(elemento, ',')] as ValorExtraidoGlauber,
[elemento in genOutros | split(rtrim(elemento), ',')] as ValorExtraidoOutros, dirOutro AS Outrodir
UNWIND ValorExtraidoGlauber as listaGlauber
UNWIND listaGlauber AS genG
UNWIND ValorExtraidoOutros as listaOutros
UNWIND listaOutros AS genOutrosdir
WITH trim(genG) as gG, trim(genOutrosdir) AS GO, Outrodir AS diretores
WHERE gG <> GO
RETURN gG, GO, diretores
```

```cypher
// sujeira em alguns generos com espaço em branco na separação
//atualizando alguns titulos 
MATCH (a1:Artista)<-[e1:Elenco]-(f:Filme)
WHERE e1.tipo_participação =~ '(?i).*dir.*'
AND a1.nome =~ '(?i).*glauber.*' AND a1.nome =~ '(?i).*rocha.*'
RETURN *
// o leão de sete cabeças
MATCH (a1:Artista)<-[e1:Elenco]-(f:Filme)
WHERE e1.tipo_participação =~ '(?i).*dir.*'
AND a1.nome =~ '(?i).*glauber.*' AND a1.nome =~ '(?i).*rocha.*'
AND f.titulo =~ '(?i).*il leone.*'
SET f.titulo = 'O Leão de Sete Cabeças'
RETURN *
// terra em transe
MATCH (a1:Artista)<-[e1:Elenco]-(f:Filme)
WHERE e1.tipo_participação =~ '(?i).*dir.*'
AND a1.nome =~ '(?i).*glauber.*' AND a1.nome =~ '(?i).*rocha.*'
AND f.titulo =~ '(?i).*trance.*'
SET f.titulo = 'Terra em transe'
RETURN *
// deus e o diabo
MATCH (a1:Artista)<-[e1:Elenco]-(f:Filme)
WHERE e1.tipo_participação =~ '(?i).*dir.*'
AND a1.nome =~ '(?i).*glauber.*' AND a1.nome =~ '(?i).*rocha.*'
AND f.titulo =~ '(?i).*dio nero.*'
SET f.titulo = 'Deus e o Diabo na terra do Sol'
RETURN *
```

```cypher
// artistas que trabalharam com Glauber
MATCH (a1:Artista)<-[e1:Elenco]-(f:Filme)-[e2:Elenco]->(a2:Artista)
WHERE e1.tipo_participação =~ '(?i).*dir.*'
AND a1.nome =~ '(?i).*glauber.*' AND a1.nome =~ '(?i).*rocha.*'
AND a1 <> a2
AND e2.tipo_participação =~ '(?i).*act.*'
WITH DISTINCT a2.nome AS atores ORDER BY a2.nome
WITH collect(atores) AS atores_glauber
RETURN atores_glauber
// excluindo nós
MATCH (n:Glauber)
DETACH DELETE n
```

```cypher
// Nova estratégia : criando nós para os atores de Glauber juntamente com o gênero do filme que foram dirigidos pelo Glauber
// depois trazer os diretores desses atores em filmes de gêneros diferentes
MATCH (a1:Artista)<-[e1:Elenco]-(f:Filme)-[e2:Elenco]->(a2:Artista)
WHERE e1.tipo_participação =~ '(?i).*dir.*'
AND a1.nome =~ '(?i).*glauber.*' AND a1.nome =~ '(?i).*rocha.*'
AND a1 <> a2
AND e2.tipo_participação =~ '(?i).*act.*'
WITH a2.nome AS gatores, f.generos as ggenero ORDER BY a2.nome
WITH collect([gatores,ggenero]) AS atores_glauber
FOREACH (i in range(0, size(atores_glauber)-1)
   | FOREACH (node1 in [atores_glauber[i]]
   | CREATE (:Glauber {atorg: node1[0], geng: node1[1]} ) ) )
```

```cypher
// funcionou parcialmente mas precisa do unwind pq tem muitos filmes com mais de um genero e às x são o mesmo 
MATCH (a1:Artista)<-[e1:Elenco]-(f:Filme)-[e2:Elenco]->(a2:Artista), (ag:Glauber)
     WHERE a1.nome = ag.atorg
AND e2.tipo_participação =~ '(?i).*dir.*'
AND NOT a1.nome =~ '(?i).*glauber rocha.*' 
AND NOT a2.nome =~ '(?i).*glauber rocha.*'
AND a1 <> a2
AND f.generos <> ag.geng
RETURN a1.nome, a2.nome, f.titulo, f.generos, ag.geng
ORDER BY a1.nome
```
