# Neo4J, Atividade 5

Para entrega, máximo 3 alunos por grupo e apenas um aluno deve postar. Estruture o script como abaixo: 

```
// Identificação do grupo (mesmo que um único aluno)
// <Nome Completo> RA:9999999-9
// <Nome Completo> RA:9999999-9 

// Exercício 1
...
// Exercício 2
...

```

Outros formatos o `corretor` irá desconsiderar.

Desenvolva os scripts abaixo com base na base de dados [(Filmes Atores, Dump)](https://drive.google.com/drive/folders/1cA-yNkwgr7ghfj2Smk4i4mtIF5_aUuJ7?usp=sharing).

> [Base alternativa](https://github.com/Rogerio-mack/IMT_Banco_de_Dados/blob/main/Neo4J_filmes_atores_short.js)... *somente se dump failed (sua máquina de casa por exemplo)*.


## Exercício 1

Em uma base de dados de artistas, converta a propriedade `altura` de cada `Artista` para o tipo `Integer`. Mostre os resultados para os primeiros 50 artistas após a conversão.

## Exercício 2

Converta as propriedades `duração` e `ano_lancamento` dos nós `Filme` para o tipo `Integer`, para que possam ser usadas em operações numéricas. Mostre o título, duração e ano de lançamento dos primeiros 50 filmes.

## Exercício 3

Calcule a média da altura dos artistas armazenados no banco de dados. Mostre o resultado com o rótulo `Media_Altura`.

## Exercício 4

Para cada local de nascimento, exiba a quantidade de artistas, a altura média, a maior altura e a menor altura. Ordene os resultados pela quantidade de artistas em ordem decrescente.

## Exercício 5

Para cada artista, mostre o número de vezes em que atuou em um filme. Considere apenas as participações marcadas como “Actor” ou “Actress”. Ordene o resultado em ordem decrescente.

## Exercício 6

Exiba o número de atuações de atrizes em filmes de **"Ficção Científica"**. Considere apenas participações marcadas como “Actress”. Ordene os resultados pela quantidade de atuações em ordem decrescente.

## Exercício 7

Para o artista **Clint Eastwood**, exiba os diferentes tipos de participação nos filmes em que atuou. Conte cada tipo de participação e ordene o resultado em ordem decrescente de contagem.

## Exercício 8

Encontre os artistas que já atuaram ao lado de **Robert De Niro** em pelo menos um filme. Exiba o nome do co-ator e o título dos filmes onde eles atuaram juntos.
