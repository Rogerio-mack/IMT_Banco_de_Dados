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

Fique atento a essa forma de fazer as consultas, `a1.nome =~ '(?i).*fernanda montenegro.*'` ou `f.generos =~ '(?i).*drama.*'`, é como um `LIKE`da SQL e *case insensitive*. Para prova, prefira consultas desse tipo, mais abertas, a `a1.nome = 'Fernanda Montenegro'` ou `f.generos = 'drama'`. 

> Veja aqui algumas variantes desse tipo de consulta.

> **`a1<>a2`**

```cypher
MATCH (a1)<-[e1:Elenco]-(f)-[e2:Elenco]->(a2)
WHERE e2.tipo_participação =~ '(?i).*act.*' 
AND a1<>a2
AND a1.nome =~ '(?i).*fernanda montenegro.*'
AND ( f.generos =~ '(?i).*roman.*' )
RETURN a2.nome, f.titulo, f.generos
ORDER BY a2.nome
```
> Note que o `a1<>a2` não é requerido (embora recomendado) para excluir o nome da atriz. O Neo4J faz a exclusão implícita, mas não é intuitiva e deixar explícita pode evitar muitos erros na sua consulta.

## Exercício 2. 
Repita a consulta 1) acima para os que não trabalharam diretamente com ela, 
com maior força para fazer contato

```cypher
MATCH (a1:Artista)<-[e1:Elenco]-(f1:Filme)-[e2:Elenco]->(a2:Artista)<-[e3:Elenco]-(f2:Filme)-[e4:Elenco]->(a3:Artista)
WHERE a1 <> a3
AND a1.nome =~ '(?i).*fernanda montenegro.*'
AND e2.tipo_participação =~ '(?i).*act.*'
AND e3.tipo_participação =~ '(?i).*act.*'
AND e4.tipo_participação =~ '(?i).*act.*'
AND NOT (a1)<-[:Elenco]-(:Filme)-[:Elenco]->(a3)
RETURN a2.nome AS Trabalhou, a3.nome AS Não_Trabalhou, COUNT(a3) AS Força
ORDER BY Força DESC

// aqui mostra quem são esses relacionamentos
//RETURN a3.nome, a2.nome, f2.titulo, f1.titulo 
//ORDER BY a3.nome, a2.nome, f2.titulo, f1.titulo  

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

> Veja aqui algumas variantes desse tipo de consulta.

> **Força de quem Trabalhou junto** 

```cypher
MATCH (a1:Artista)<-[e1:Elenco]-(f)-[e2:Elenco]->(a2:Artista)
WHERE a1.nome =~ '(?i).*fernanda montenegro.*'
AND e2.tipo_participação =~ '(?i).*act.*'
RETURN a2.nome AS Trabalhou, COUNT(a2) AS Força
ORDER BY Força DESC
```
> **Força de quem Não Trabalhou junto**
  
```cypher
MATCH (a1:Artista)<-[e1:Elenco]-(f1:Filme)-[e2:Elenco]->(a2:Artista)<-[e3:Elenco]-(f2:Filme)-[e4:Elenco]->(a3:Artista)
WHERE a1 <> a3
AND a1.nome =~ '(?i).*fernanda montenegro.*'
AND e2.tipo_participação =~ '(?i).*act.*'
AND e3.tipo_participação =~ '(?i).*act.*'
AND e4.tipo_participação =~ '(?i).*act.*'
AND NOT (a1)<-[:Elenco]-(:Filme)-[:Elenco]->(a3)
RETURN a3.nome AS Não_Trabalhou, COUNT(a3) AS Força
ORDER BY Força DESC
```

> **Essa é uma consulta muito ineficiente que pode demorar muito, ou nem concluir...**

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

> O `a2.dt_nascto =~ '.*-.*'` permite consistir a data de nascimento e evita dados com datas inválidas. Postei no GitHub uma solução que trata as datas inválidas.

> `WITH`, define um `pipe` e quais dados são passados para *frente* no processamento da query. 

> Veja aqui algumas variantes desse tipo de consulta.

```cypher
MATCH (a1)<-[e1:Elenco]-(f)-[e2:Elenco]->(a2)
WHERE e2.tipo_participação =~ '(?i).*act.*'
AND a1.nome =~ '(?i).*julia roberts.*'
AND NOT f.generos =~ '(?i).*drama.*'
AND a2.dt_nascto IS NOT NULL 
AND a2.dt_obito IS NULL
AND duration.between(date(a2.dt_nascto),date()).years > 40
RETURN a2, COUNT(*) AS Qtde_Vezes
ORDER BY Qtde_Vezes DESC LIMIT 5
```
> Veja aqui o uso no "`NOT LIKE`", `NOT f.generos =~ '(?i).*drama.*'`, e não `f.generos !=~ '(?i).*drama.*'` ou `NOT f.generos <>~ '(?i).*drama.*'`. A consulta acima é mais simples. 

```cypher
MATCH (a1)<-[e1:Elenco]-(f)-[e2:Elenco]->(a2)
WHERE e2.tipo_participação =~ '(?i).*act.*'
AND a1.nome =~ '(?i).*julia roberts.*'
AND NOT f.generos =~ '(?i).*drama.*'
AND a2.dt_nascto IS NOT NULL 
AND a2.dt_obito IS NULL
AND duration.between(date(a2.dt_nascto),date()).years > 40
WITH a2.nome AS nome, duration.between(date(a2.dt_nascto),date()).years AS nasc 
RETURN nome, nasc, COUNT(*) AS Qtde_Vezes
ORDER BY Qtde_Vezes DESC LIMIT 5

╒══════════════════════╤══════╤════════════╕
│"nome"                │"nasc"│"Qtde_Vezes"│
╞══════════════════════╪══════╪════════════╡
│"Brad Pitt"           │60    │3           │
├──────────────────────┼──────┼────────────┤
│"George Clooney"      │63    │3           │
├──────────────────────┼──────┼────────────┤
│"Catherine Zeta-Jones"│55    │2           │
├──────────────────────┼──────┼────────────┤
│"Richard Gere"        │75    │2           │
├──────────────────────┼──────┼────────────┤
│"Paul Giamatti"       │57    │2           │
└──────────────────────┴──────┴────────────┘
```

> Veja aqui o uso do WITH. Tente variações e veja que não são passados outros valores que não os do `WITH` na sequencia da consulta.

## Exercício 5.
Mostre os diretores que dirigiram atores comuns ao diretor Glauber Rocha mas em gêneros diferentes

### Sem UNWIND

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

### Com UNWIND

```cypher
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

"gG"       │"GO"       │"diretores"                   │
╞═══════════╪═══════════╪══════════════════════════════╡
│"Drama"    │"Comedy"   │"Domenico Paolella"           │
├───────────┼───────────┼──────────────────────────────┤
│"Drama"    │"Comedy"   │"José Luis Sáenz de Heredia"  │
├───────────┼───────────┼──────────────────────────────┤
│"Fantasy"  │"Drama"    │"Nelson Pereira dos Santos"   │
├───────────┼───────────┼──────────────────────────────┤
│"History"  │"Drama"    │"Nelson Pereira dos Santos"   │
├───────────┼───────────┼──────────────────────────────┤
│"Drama"    │"Romance"  │"Gillo Pontecorvo"            │
├───────────┼───────────┼──────────────────────────────┤
│"Drama"    │"Romance"  │"Maleno Malenotti"            │
├───────────┼───────────┼──────────────────────────────┤
(...)

```





