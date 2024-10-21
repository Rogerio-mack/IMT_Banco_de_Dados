# Neo4J Prática II

# Exercício 1.
(**CONTAINS, STARTS WITH, ENDS WITH**). Pesquise e empregue os comandos CONTAINS, STARTS WITH, ENDS WITH para fazer pesquisa de nomes de filmes que iniciem, terminem ou 
contenham uma determinada string.

```
// consultas como LIKE sem usar REGEX
MATCH (a:Artista)
WHERE a.nome CONTAINS 'and'
RETURN a

// inicio da String
MATCH (f:Filme)
WHERE f.nome STARTS WITH 'Star'
RETURN f.nome, f.genero

// termino da String
MATCH (f:Filme)
WHERE f.nome ENDS WITH 'Wars'
RETURN f.nome, f.genero

// usando UPPER
MATCH (f:Filme)
WHERE toUpper(f.nome) ENDS WITH 'WARS'
RETURN f.nome, f.genero
```

# Exercício 2.
(**=~**, REGEX). Pesquise uma expressão regular simples e empregue para pesquisar o nome de um ator.

```
// usando expressão regular  REGEX, começa com 'Tom' 
MATCH ( a:Artista)
WHERE a.nome =~ '^Tom.*' 
RETURN a

// usando expressão regular  REGEX, 'son' em qualquer posição   
MATCH ( a:Artista)
WHERE a.nome =~ '.*son.*'  
RETURN a

// usando expressão regular  REGEX, nome tenha pelo menos 5 caracteres (.{5,}) e termine com a letra s  
MATCH ( a:Artista)
WHERE a.nome =~ '.{5,}s$' 
RETURN a

// usando expressão regular  REGEX, nome inicia com 'marlon', maiúsculo ou minúsculo
MATCH ( a:Artista)
WHERE a.nome =~ '(?i)^marlon.*' 
RETURN a
```

# Exercício 3.
(**UNION**). Empregue o exemplo abaixo para exibir entidades (filmes e artistas) separadas de forma conjunta.

```
// UNION só para exibir separado
MATCH (n:Artista)
WHERE n.nome = "Marlon Brando"
RETURN n
UNION MATCH (n:Filme)
WHERE n.nome = "O Poderoso Chefão I"
RETURN n
```

# Exercício 4.
(**()-[]->**, "JOIN"). Exiba o elenco de um filme empregando os relacionamentos criados.

```
// filmes do Marlon Brando
MATCH (f:Filme)-[e:Elenco]->(a:Artista)
WHERE a.nome =~ '(?i)^marlon.*'
AND e.tipo_participação =~ '(?i)^at.*'
RETURN *
// mudando a direção da consulta
MATCH (a:Artista)<-[e:Elenco]-(f:Filme)
WHERE a.nome =~ '(?i)^marlon.*'
AND e.tipo_participação =~ '(?i)^at.*'
RETURN *
```
# Exercício 5.
(**DELETE"**). Crie relacionamento errado (um ator que não faz parte do elenco) e depois exclua esse relacionamento.

```
MATCH (a:Artista),(f:Filme)
WHERE a.nome = "Marlon Brando" AND f.nome = 'Star Wars'
CREATE (f)-[e:Elenco {tipo_participação:"Ator", papel : "Yoda"}]->(a)
RETURN *

// deletando um relacionamento
MATCH (f:Filme)-[e:Elenco]->(a:Artista)
WHERE a.nome= "Marlon Brando"
AND f.nome="Star Wars"
DELETE e
```

# Exercício 6
(**UPDATE**). Atualize os nomes do pais dos atores para siglas, por exemplo ESTADOS UNIDOS para USA, ou EUA para USA, ou BRASIL para BR.

```
// UPDATE
MATCH (a:Artista)
WHERE a.país="EUA"
SET a.país = "USA"
RETURN a
```
