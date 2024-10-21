# Neo4J Prática I

## Exercício 1. 
**(MATCH, DETACH DELETE, CREATE, RETURN)** 
Crie uma base de dados de filmes e artistas. Inclua dados como nome do filme, ano de lançamento, genero e estúdio. 
Para os artistas inclua nome, país e genêro, para ao menos um artista inclua nascimento: "YYYY-MM-DDT00:00:00.000Z". Procure criar filmes e artistas relacionados.

```
// limpando toda a base
MATCH (n)
DETACH DELETE n

// criando nós de filmes
CREATE (f1:Filme {nome:"Star Wars", ano_lançamento:1977,
genero: "ficção", estudio :"Lucas Films"})
RETURN f1

// criando mais de um nó, podendo misturar nós de tipos diferentes
CREATE (filme2:Filme {nome:"O Poderoso Chefão I", ano_lançamento:1972,
genero: "drama", estudio :"Paramount"}),
(filme3:Filme {nome:"Central do Brasil", ano_lançamento:1990,
genero: "drama", estudio :"VideoFilmes"}),
(a0:Artista {nome:"Marlon Brando", pais:"EUA", sexo:"M"})
RETURN filme2, filme3, a1

// criando nós para artistas
CREATE (a1:Artista{nome:"Al Pacino", pais:"EUA", sexo:"M"}),
(a2:Artista{nome:"Francis Ford Copolla", pais:"EUA", sexo:"M"}),
(a3:Artista{nome:"Fernanda Montenegro", pais:"Brasil",
sexo:"F", Nascimento: "1929-10-16T00:00:00.000Z"})
RETURN a1, a2, a3
```

## Exercício 2. 
Faça as seguintes consultas:

1. **(MATCH)**. Todos os nós e relações

```
// para ver todos os nós e relações
MATCH(n)
RETURN n
```

2. **(MATCH)**. Exiba todos artistas.

```
// mostrando só artistas
MATCH (n:Artista)
RETURN n
```

3. **(MATCH, WHERE)**. Exiba os artistas com um determinado nome. Por exemplo, nome: "Al Pacino". Empregue duas sintaxes, a de *match* e de *where*.

```
// consultas dentro match
MATCH (a:Artista {nome: "Al Pacino"})
RETURN a
// com where
MATCH ( a:Artista)
WHERE a.nome = "Al Pacino"
RETURN a
```

4. (**WHERE IS NOT NULL**). Exiba todos artista em que a data de Nascimento não é NULL.  

```
// NOT NULL
MATCH (a:Artista)
WHERE a.Nascimento IS NOT NULL
RETURN a
```

5. (**WHERE NOT**). Exiba todos filmes que não são do gênero "drama". 

```
// NEGAÇÃO
MATCH (f:Filme)
WHERE NOT (f.genero = 'drama')
RETURN f
```

6. (**toUpper**,**WHERE AND, OR**). Exiba todos filmes que não são do gênero "drama" ou "DRAMA. Em seguida exiba os artistas que a data de Nascimento não e nula OU que tenham nascido em um determinado país. 

```
MATCH (f:Filme)
WHERE NOT (toUpper(f.genero) = 'DRAMA')
RETURN f
// AND e OR
MATCH (a:Artista)
WHERE a.Nascimento IS NOT NULL OR NOT (a.pais = "EUA")
RETURN a
```

7. (**WHERE AND, OR**). Exiba todos filmes do gênero "drama", lançados a partir de um determinado ano e exiba somente as informações de nome e ano de lançamento do filme. 

```
MATCH (f:Filme)
WHERE f.ano_lançamento > 1975 OR f.genero = 'drama'
RETURN f.nome, f.ano_lançamento
```

## Exercício 3.
Empregue o exemplo a seguir para montar os seus relacionamentos, o elenco, de filmes e artistas.

**Exemplo**
```
// sintaxe 1
MATCH (a:Artista),(f:Filme)
WHERE a.nome = "Marlon Brando" AND f.nome = 'O Poderoso Chefão I'
CREATE (f)-[e:Elenco {tipo_participação:"Ator", papel : "Vito Corleone"}]->(a)
RETURN *
// usando a outra sintaxe
MATCH (a:Artista {nome : 'Al Pacino'}),(f:Filme {nome : 'O Poderoso Chefão I'})
CREATE (f)-[e:Elenco {tipo_participação:"Ator", papel : "Michael Corleone"}]->(a)
RETURN *
// exibindo o elenco do filme
MATCH (f:Filme)-[e:Elenco]->(a:Artista)
WHERE f.nome =~ '(?i).*chefão I.*'
RETURN *
```
Quando usa dois rotulos não pode fazer `return a`, logo tem que executar o `create`.
