# Exercício para entrega

Empregue um dos bancos de dados já criados de filmes. Adicione, se necessário, filmes e outros elementos à base. Em seguida desenvolva os comandos em CYPHER para:

a) Criar 4 nós para sessão de exibição com data, horário, legendado (sim ou não) e público
pagante (número). A data é inserida desta forma: data_hora_sessao : "2024-10-12T16:00:00.000Z"

b) Criar 2 nós para sala com nome, capacidade, tipo de áudio Digital (Dolby, DTS por exemplo) e vídeo (IMAX, 3D, D-Box) 

c) Criar relacionamentos entre filme e sessão, sessão e sala (2 sessões para “Star Wars” e 2 para
“O poderoso Chefão”)
Cada sessão tem relacionamento com UM filme em UMA Sala

d) Exibir as salas onde foi exibido o filme Star Wars no mês atual

e) Exibir os filmes que tiveram sessões legendadas nos últimos 3 meses

f) Exibir o intervalo (duração de tempo) entre as 2 sessões do filme Star Wars

g) Exibir sessões, filmes e atores em que a nacionalidade do ator é a mesma do filme, para
filmes que não são de Romance, em sessões que não são Dubladas.


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


