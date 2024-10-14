# Neo4J Prática I

## Exercício 1. 
**(MATCH, DETACH DELETE, CREATE, RETURN)** 
Crie uma base de dados de filmes e artistas. Inclua dados como nome do filme, ano de lançamento, genero e estúdio. 
Para os artistas inclua nome, país e genêro, para ao menos um artista inclua nascimento: "YYYY-MM-DDT00:00:00.000Z". Procure criar filmes e artistas relacionados.

## Exercício 2. 
Faça as seguintes consultas:

1. **(MATCH)**. Todos os nós e relações

2. **(MATCH)**. Exiba todos artistas.

3. **(MATCH, WHERE)**. Exiba os artistas com um determinado nome. Por exemplo, nome: "Al Pacino". Empregue duas sintaxes, a de *match* e de *where*.

4. (**WHERE IS NOT NULL**). Exiba todos artista em que a data de Nascimento não é NULL.  

5. (**WHERE NOT**). Exiba todos filmes que não são do gênero "drama". 

6. (**toUpper**,**WHERE AND, OR**). Exiba todos filmes que não são do gênero "drama" ou "DRAMA. Em seguida exiba os artistas que a data de Nascimento não e nula OU que tenham nascido em um determinado país. 

7. (**WHERE AND, OR**). Exiba todos filmes do gênero "drama", lançados a partir de um determinado ano e exiba somente as informações de nome e ano de lançamento do filme. 

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
