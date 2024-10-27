# Exercício para entrega

Empregue um dos bancos de dados já criados de filmes. Adicione, se necessário, filmes e outros elementos à base. Em seguida desenvolva os comandos em CYPHER para:

a) Criar 4 nós para sessão de exibição com data, horário, legendado (sim ou não) e público
pagante (número). A data é inserida desta forma: data_hora_sessao : "2024-10-12T16:00:00.000Z"

```
CREATE (s1:Sessao {sessao:1, dt_sessao : datetime("2024-10-14T16:00:00.000Z"),
horario:16, legendado: True, publico: 89}),
(s2:Sessao {sessao:2, dt_sessao : datetime("2024-10-14T18:00:00.000Z"),
horario:18, legendado: False, publico: 123}),
(s3:Sessao {sessao:3, dt_sessao : datetime("2024-10-16T20:00:00.000Z"),
horario:20, legendado: True, publico: 0}),
(s4:Sessao {sessao:4, dt_sessao : datetime(),
horario:20, legendado: True, publico: 0})
RETURN s1, s2, s3, s4
```

b) Criar 2 nós para sala com nome, capacidade, tipo de áudio Digital (Dolby, DTS por exemplo) e vídeo (IMAX, 3D, D-Box) 

```
CREATE (s1:Sala {nome:"Charles Chaplin", capacidade:140, tp_audio:"Dolby",
tp_video:"3D"}),
(s2:Sala {nome:"Glauber Rocha", capacidade:200, tp_audio:"Dolby", tp_video:"3D"}),
(s3:Sala {nome:"Orson Welles", capacidade:240, tp_audio:"Surround", tp_video:"4D"})
RETURN s1, s2, s3
```

c) Criar relacionamentos entre filme e sessão, sessão e sala (2 sessões para “Star Wars” e 2 para
“O poderoso Chefão”). Cada sessão tem relacionamento com UM filme em UMA Sala.

```
// star wars
MATCH (f:Filme), (ss1:Sessao), (ss1:Sessao)
WHERE f.nome =~ '(?i).*star.*' AND f.nome =~ '(?i).*wars.*'
AND ss1.sessao = 1 AND ss2.sessao = 2
CREATE (f)-[e1:Exibicao]->(ss1), (f)-[e2:Exibicao]->(ss2)
RETURN *
MATCH (ss1:Sessao), (ss2:Sessao), (s1:Sala)
WHERE ss1.sessao = 1 AND ss2.sessao = 2
AND s1.nome= "Charles Chaplin"
CREATE (ss1)-[u1:Utiliza]->(s1), (ss2)-[u2:Utiliza]->(s1)
RETURN *
// poderoso chefao
MATCH (f:Filme), (ss3:Sessao), (ss4:Sessao)
WHERE f.nome = "O Poderoso Chefao" AND ss3.sessao = 3 AND ss3.sessao = 4
CREATE (f)-[e1:Exibicao]->(ss3), (f)-[e2:Exibicao]->(ss4)
RETURN *
MATCH (ss3:Sessao), (ss4:Sessao), (s1:Sala), (s2:Sala)
WHERE ss3.sessao = 3 AND ss4.sessao = 4 AND s1.nome= "Glauber Rocha" AND s2.nome =
"Orson Welles"
CREATE (ss3)-[u1:Utiliza]->(s1), (ss4)-[u2:Utiliza]->(s2)
RETURN *
```

d) Exibir as salas onde foi exibido o filme Star Wars no mês atual

```
MATCH (f)-[e:Exibicao]->(sse)-[u:Utiliza]->(s)
WHERE f.nome =~ '(?i).*star.*' AND f.nome =~ '(?i).*wars.*'
AND datetime(sse.dt_sessao).month = datetime().month
RETURN *
// RETURN sse.sessao, s.nome AS Sala, datetime(sse.dt_sessao).month AS Mes_atual
//
// completo
MATCH (f)-[e:Exibicao]->(sse)-[u:Utiliza]->(s)
WHERE f.nome = "O Poderoso Chefao"
RETURN *
```

e) Exibir os filmes que tiveram sessões legendadas nos últimos 3 meses

```
MATCH (f)-[e:Exibicao]->(sse)
WHERE sse.legendado
AND datetime(sse.dt_sessao) >= datetime() - duration({months:3})
RETURN *
```

f) Exibir o intervalo (duração de tempo) entre as 2 sessões do filme Star Wars

```
MATCH (f)-[e1:Exibicao]->(sse1), (f)-[e2:Exibicao]->(sse2)
WHERE f.nome =~ '(?i).*star.*' AND f.nome =~ '(?i).*wars.*'
RETURN sse1.dt_sessao AS Sessao1, sse2.dt_sessao As Sessao2,
duration.between(sse1.dt_sessao, sse2.dt_sessao) AS Intervalo_sessoes
// outra forma
MATCH (sse1)<-[e1:Exibicao]-(f)-[e2:Exibicao]->(sse2)
WHERE f.nome =~ '(?i).*star.*' AND f.nome =~ '(?i).*wars.*'
RETURN sse1.dt_sessao AS Sessao1, sse2.dt_sessao As Sessao2,
duration.between(sse1.dt_sessao, sse2.dt_sessao) AS Intervalo_sessoes
LIMIT 1
```
g) Exibir sessões, filmes e atores em que a nacionalidade do ator é a mesma do filme, para
filmes que não são de Romance, em sessões que não são Dubladas.

```
MATCH (a)<-[e:Elenco]-(f)-[ex:Exibicao]->(sse)
WHERE f.pais = a.pais
AND NOT f.genero =~ '(?i).*romance.*'
AND NOT sse.legendado
RETURN *
// reatualizando
MATCH (a:Artista {pais : 'EUA'})
SET a.pais = "USA"
RETURN a
```
Grupos de no máximo 3 alunos.

1. O script deve ser estruturado como:

```
// Identificação do grupo (mesmo que um único aluno)
// \<Nome Completo\> RA:9999999-9
// \<Nome Completo\> RA:9999999-9 

...

// Script de criação da base
...

// Script da atividade/exercício
// a)
...
// b)
...
```

2. Poste seu script Neo4J em um arquivo .txt

3. Somente um aluno por grupo deve postar


