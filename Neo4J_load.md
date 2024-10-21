# Load Neo4j Database

Roteiro para Criação BD Filmes e Artistas do IMBD usando arquivo dump da base tratada.

0 – Baixe o arquivo [dump Neo4J](https://drive.google.com/drive/folders/1cA-yNkwgr7ghfj2Smk4i4mtIF5_aUuJ7?usp=sharing)

1 – Abra o Neo4J. Crie e acesse o projeto onde vai criar o novo banco para o IMDB.

2- Selecionar + **`ADD -> File`**

3 - Selecione os [...] (três pontos, "more options") **`-> Create new DBMS from dump`**

4 – Preencher nome do banco: Importacao IMDB Senha : imtdb2024 (precisa 8 caracteres) **-> CREATE**

> Após o load, clique em **`Start`** e depois **`Open`** para a abrir o navegador.

5 - No navegador Neo4j, clique no cilindro de banco que exibe as informações do BD e selecione o **`elenco`**. Clique em elenco e deve aparecer algo similar à figura abaixo.

Neste banco serão empregados Nós: Artista e Filme Relacionamento: Elenco
