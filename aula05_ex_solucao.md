### 1. Exercícios com MongoDB Joins e Relacionamentos

#### Coleções Exemplo

```json
// Coleção "authors"
[
  { "_id": 1, "name": "John Doe", "age": 45 },
  { "_id": 2, "name": "Jane Smith", "age": 38 },
  { "_id": 3, "name": "Alice Johnson", "age": 50 }
]

// Coleção "books"
[
  { "_id": 101, "title": "MongoDB Mastery", "author_id": 1, "year": 2020 },
  { "_id": 102, "title": "NoSQL Explained", "author_id": 2, "year": 2019 },
  { "_id": 103, "title": "Advanced Databases", "author_id": 3, "year": 2018 },
  { "_id": 104, "title": "Introduction to MongoDB", "author_id": 1, "year": 2021 }
]
```

#### Exercícios

1. **Exercício 1**: Utilize `$lookup` para combinar as coleções `authors` e `books` e retornar o nome do autor e o título do livro.
   
2. **Exercício 2**: Use `$lookup` para retornar o nome do autor e todos os livros que ele escreveu.

3. **Exercício 3**: Adicione o campo `nationality` aos documentos da coleção `authors` usando `$set`.

4. **Exercício 4**: Realize um `$lookup` para retornar o autor que escreveu o livro "MongoDB Mastery".

5. **Exercício 5**: Faça um `$lookup` entre `authors` e `books` e filtre a saída apenas para os autores que escreveram livros após 2019, usando `$match`.

6. **Exercício 6**: Combine as coleções e ordene os resultados por idade dos autores, usando `$lookup` e `$project`.

7. **Exercício 7**: Realize um relacionamento 1-N: Encontre todos os livros escritos por "John Doe" (autor_id = 1) e retorne todos os títulos.

8. **Exercício 8**: Use `$unwind` para desfazer a junção entre `authors` e `books`, mostrando um documento por livro escrito por cada autor.

9. **Exercício 9**: Adicione um novo campo chamado `author_bio` na coleção `books`, onde cada autor recebe uma breve biografia.

10. **Exercício 10**: Faça um `$lookup` e combine autores e livros, mas retorne apenas os documentos em que o autor não tem livros na coleção `books`, utilizando `$lookup` com `pipeline` e `$match`.

---

### 2. Gabarito

1. **Exercício 1**
   ```json
   db.authors.aggregate([
     {
       $lookup: {
         from: "books",
         localField: "_id",
         foreignField: "author_id",
         as: "books_written"
       }
     }
   ])
   ```

   *Explicação*: Combina as duas coleções retornando o nome do autor e os títulos dos livros escritos.

3. **Exercício 2**
   ```json
   db.authors.aggregate([
     {
       $lookup: {
         from: "books",
         localField: "_id",
         foreignField: "author_id",
         as: "books_written"
       }
     },
     {
       $project: { name: 1, "books_written.title": 1 }
     }
   ])
   ```

   *Explicação*: O `$lookup` retorna todos os livros escritos por cada autor.

4. **Exercício 3**
   ```json
   db.authors.updateMany({}, { $set: { "nationality": "Unknown" } })
   ```
   *Explicação*: Usamos `$set` para adicionar o campo `nationality` a todos os documentos na coleção `authors`.

5. **Exercício 4**
   ```json
   db.books.aggregate([
     {
       $match: { title: "MongoDB Mastery" }
     },
     {
       $lookup: {
         from: "authors",
         localField: "author_id",
         foreignField: "_id",
         as: "author_info"
       }
     },
     {
       $project: { "author_info.name": 1, title: 1 }
     }
   ])
   ```
   *Explicação*: Encontramos o livro e, em seguida, usamos `$lookup` para retornar o autor.

6. **Exercício 5**
   ```json
   db.authors.aggregate([
     {
       $lookup: {
         from: "books",
         localField: "_id",
         foreignField: "author_id",
         as: "books_written"
       }
     },
     {
       $match: { "books_written.year": { $gt: 2019 } }
     }
   ])
   ```
   *Explicação*: Após combinar as coleções, filtramos os resultados para livros escritos após 2019.

7. **Exercício 6**
   ```json
   db.authors.aggregate([
     {
       $lookup: {
         from: "books",
         localField: "_id",
         foreignField: "author_id",
         as: "books_written"
       }
     },
     {
       $project: { name: 1, age: 1, "books_written.title": 1 }
     },
     {
       $sort: { age: 1 }
     }
   ])
   ```
   *Explicação*: Ordena os resultados combinados pelo campo `age`.

8. **Exercício 7**
   ```json
   db.books.find({ author_id: 1 }, { title: 1 })
   ```
   *Explicação*: Faz uma busca simples para retornar os livros escritos por "John Doe".

9. **Exercício 8**
   ```json
   db.authors.aggregate([
     {
       $lookup: {
         from: "books",
         localField: "_id",
         foreignField: "author_id",
         as: "books_written"
       }
     },
     { $unwind: "$books_written" }
   ])
   ```
   *Explicação*: O `$unwind` separa os documentos de livros de cada autor em documentos individuais.

10. **Exercício 9**
   ```json
   db.books.updateMany({}, { $set: { "author_bio": "A renowned author in the field of databases." } })
   ```
   *Explicação*: Usamos `$set` para adicionar uma breve biografia a cada livro.

11. **Exercício 10**
   ```json
   db.authors.aggregate([
     {
       $lookup: {
         from: "books",
         localField: "_id",
         foreignField: "author_id",
         as: "books_written"
       }
     },
     {
       $match: { books_written: { $size: 0 } }
     }
   ])
   ```
   *Explicação*: Retorna os autores sem livros, usando uma combinação de `$lookup` e `$match`.
