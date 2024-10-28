# Neo4J, Listas

O Neo4J também suporta listas ou arrays,

```cypher
// Criando filmes com múltiplos gêneros
CREATE (f1:Filme {titulo_original: "Inception", ano_lancamento: 2010, generos: ['sci-fi', 'drama', 'thriller'], duracao: 148})
CREATE (f2:Filme {titulo_original: "The Godfather", ano_lancamento: 1972, generos: ['crime', 'drama'], duracao: 175})
CREATE (f3:Filme {titulo_original: "The Dark Knight", ano_lancamento: 2008, generos: ['action', 'crime', 'drama'], duracao: 152})
CREATE (f4:Filme {titulo_original: "Pulp Fiction", ano_lancamento: 1994, generos: ['crime', 'drama'], duracao: 154})
CREATE (f5:Filme {titulo_original: "Forrest Gump", ano_lancamento: 1994, generos: ['drama', 'romance'], duracao: 142});

// Consultando filmes que têm 'drama' como gênero
MATCH (f:Filme)
WHERE 'drama' IN f.generos
RETURN f.titulo_original AS Filme, f.generos AS Generos;
```

**UNWIND**

O UNWIND, é empregado para desenvelopar os elementos da lista/array,

```cypher
MATCH (f:Filme)
UNWIND f.generos AS genero
RETURN f.titulo_original AS Filme, genero AS Genero;
``` 

Irá retornar,


| Filme             | Genero     |
|-------------------|------------|
| Inception         | sci-fi     |
| Inception         | drama      |
| Inception         | thriller   |
| The Godfather     | crime      |
| The Godfather     | drama      |
| The Dark Knight   | action     |
| The Dark Knight   | crime      |
| The Dark Knight   | drama      |
| Pulp Fiction      | crime      |
| Pulp Fiction      | drama      |
| Forrest Gump      | drama      |
| Forrest Gump      | romance    |

