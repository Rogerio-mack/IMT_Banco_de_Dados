# Neo4J, Atividade 5

## Exercício 1

Em uma base de dados de artistas, converta a propriedade `altura` de cada `Artista` para o tipo `Integer`. Mostre os resultados para os primeiros 50 artistas após a conversão.

**Solução**:

```cypher
// Converte altura para inteiro
MATCH (a:Artista)
SET a.altura = toInteger(a.altura)
RETURN a.nome, a.altura
LIMIT 50
```

**Explicação**: Este exercício utiliza `toInteger()` para garantir que o campo `altura` esteja em um formato numérico, o que é essencial para cálculos futuros.

---

## Exercício 2

Converta as propriedades `duração` e `ano_lancamento` dos nós `Filme` para o tipo `Integer`, para que possam ser usadas em operações numéricas. Mostre o título, duração e ano de lançamento dos primeiros 50 filmes.

**Solução**:

```cypher
// Converte duração e ano_lancamento para inteiro
MATCH (f:Filme)
SET f.duração = toInteger(f.duração), 
    f.ano_lancamento = toInteger(f.ano_lancamento)
RETURN f.titulo_original, f.duração, f.ano_lancamento
LIMIT 50
```

**Explicação**: Este exercício é semelhante ao anterior, mas aqui lidamos com dois campos numéricos diferentes em `Filme`. As conversões asseguram que esses campos estejam no tipo correto.

---

## Exercício 3

Calcule a média da altura dos artistas armazenados no banco de dados. Mostre o resultado com o rótulo `Media_Altura`.

**Solução**:

```cypher
// Média de altura dos artistas
MATCH (a:Artista)
RETURN AVG(a.altura) AS Media_Altura
```

**Explicação**: Utilizamos a função de grupo `AVG` para calcular a média de altura. Essa operação é útil para resumir dados quantitativos e obter insights rápidos sobre características dos dados.

---

## Exercício 4

Para cada local de nascimento, exiba a quantidade de artistas, a altura média, a maior altura e a menor altura. Ordene os resultados pela quantidade de artistas em ordem decrescente.

**Solução**:

```cypher
// Estatísticas de altura por local de nascimento
MATCH (a:Artista)
WHERE a.altura IS NOT NULL
RETURN a.local_nascto, COUNT(*) AS Contagem, AVG(a.altura) AS Media_Altura, 
       MAX(a.altura) AS Maior_Altura, MIN(a.altura) AS Menor_Altura
ORDER BY Contagem DESC
```

**Explicação**: Este exercício emprega funções de grupo para agrupar e resumir os dados, ordenando-os para uma melhor compreensão dos locais com maior representatividade de artistas.

---

## Exercício 5

Para cada artista, mostre o número de vezes em que atuou em um filme. Considere apenas as participações marcadas como “Actor” ou “Actress”. Ordene o resultado em ordem decrescente.

**Solução**:

```cypher
// Quantidade de filmes por artista com participações como "Actor" ou "Actress"
MATCH (f)-[e:Elenco]->(a:Artista)
WHERE e.tipo_participação =~ '(?i).*act.*'
RETURN a.nome AS Artista, COUNT(e.tipo_participação) AS Qtde_Atuacoes
ORDER BY Qtde_Atuacoes DESC
```

**Explicação**: Aqui utilizamos a função `COUNT` para contar as relações de elenco de cada artista. A expressão regular `(.*act.*)` ignora maiúsculas e minúsculas ao filtrar atores e atrizes.

---

## Exercício 6

Exiba o número de atuações de atrizes em filmes de ficção científica. Considere apenas participações marcadas como “Actress”. Ordene os resultados pela quantidade de atuações em ordem decrescente.

**Solução**:

```cypher
// Quantidade de filmes de ficção científica com atrizes
MATCH (f:Filme)-[e:Elenco]->(a:Artista)
WHERE e.tipo_participação =~ '(?i).*actress.*'
AND f.generos =~ '(?i).*sci-fi.*'
RETURN a.nome AS Artista, COUNT(e.tipo_participação) AS Qtde_Atuacoes
ORDER BY Qtde_Atuacoes DESC
```

**Explicação**: Esse exercício utiliza expressões regulares para filtrar filmes de ficção científica e participações de atrizes, contabilizando as atuações.

---

## Exercício 7

Para o artista **Clint Eastwood**, exiba os diferentes tipos de participação nos filmes em que atuou. Conte cada tipo de participação e ordene o resultado em ordem decrescente de contagem.

**Solução**:

```cypher
// Tipos de participação de Clint Eastwood
MATCH (a:Artista)<-[e:Elenco]-(f:Filme)
WHERE a.nome =~ '(?i).*clint.*' AND a.nome =~ '(?i).*eastwood.*'
RETURN e.tipo_participação, COUNT(e.tipo_participação) AS Contagem_Tipo
ORDER BY Contagem_Tipo DESC
```

**Explicação**: Este exercício filtra um artista específico e conta os diferentes tipos de participação usando `COUNT`, útil para entender o envolvimento do artista em diferentes papéis.

---

## Exercício 8

Encontre os artistas que já atuaram ao lado de **Robert De Niro** em pelo menos um filme. Exiba o nome do co-ator e o título dos filmes onde eles atuaram juntos.

**Solução**:

```cypher
// Artistas que atuaram com Robert De Niro
MATCH (a1:Artista)<-[e1:Elenco]-(f:Filme)-[e2:Elenco]->(a2:Artista)
WHERE a1.nome =~ '(?i).*robert.*' AND a1.nome =~ '(?i).*niro.*' AND a1 <> a2
RETURN a2.nome AS CoAtor, f.titulo_original AS Filme
```

**Explicação**: Este exercício explora relacionamentos indiretos para descobrir colaborações entre artistas, filtrando todos que já atuaram com Robert De Niro. É uma consulta poderosa para descobrir conexões complexas.

---
