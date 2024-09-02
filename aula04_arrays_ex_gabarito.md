### 1. Exercícios com Manipulação de Arrays no MongoDB

#### Coleção Exemplo

```json
// Coleção "students"
[
  { "_id": 1, "name": "Alice", "courses": ["Math", "English"] },
  { "_id": 2, "name": "Bob", "courses": ["Math", "History"] },
  { "_id": 3, "name": "Charlie", "courses": ["Biology", "Chemistry"] }
]
```

#### Exercícios

1. **Exercício 1**: Utilize `$push` para adicionar o curso "Physics" ao array `courses` do estudante Alice (`_id: 1`).

2. **Exercício 2**: Use `$addToSet` para adicionar o curso "Math" ao array `courses` do estudante Charlie (`_id: 3`). Verifique o comportamento do operador.

3. **Exercício 3**: Remova o primeiro curso da lista de `courses` do estudante Bob (`_id: 2`) usando `$pop`.

4. **Exercício 4**: Use `$pull` para remover o curso "History" do array `courses` do estudante Bob (`_id: 2`).

5. **Exercício 5**: Adicione os cursos "Philosophy" e "Economics" ao array `courses` do estudante Alice (`_id: 1`) de uma única vez usando `$push` com a opção `$each`.

6. **Exercício 6**: Remova todos os cursos "Math" dos arrays de todos os estudantes usando `$pull`.

7. **Exercício 7**: Adicione o curso "Computer Science" ao array `courses` de todos os estudantes que ainda não têm esse curso usando `$addToSet`.

8. **Exercício 8**: Adicione o curso "Art" ao final do array `courses` de todos os estudantes e, em seguida, remova o último curso do array, usando `$push` e `$pop`.

9. **Exercício 9**: Crie um campo `extra_courses` para o estudante Charlie (`_id: 3`) e adicione dois cursos adicionais ("Music", "Drama") a esse novo array usando `$push`.

10. **Exercício 10**: Use `$addToSet` para garantir que nenhum curso duplicado seja adicionado ao array `extra_courses` do estudante Charlie (`_id: 3`) ao tentar adicionar "Music" novamente.

---

### 2. Gabarito

1. **Exercício 1**
   ```json
   db.students.updateOne(
     { _id: 1 },
     { $push: { courses: "Physics" } }
   )
   ```
   *Explicação*: O operador `$push` adiciona o curso "Physics" ao array `courses` da estudante Alice.

2. **Exercício 2**
   ```json
   db.students.updateOne(
     { _id: 3 },
     { $addToSet: { courses: "Math" } }
   )
   ```
   *Explicação*: O operador `$addToSet` tenta adicionar "Math" ao array `courses`, mas não adicionará duplicatas. Como "Math" já existe, o array permanece inalterado.

3. **Exercício 3**
   ```json
   db.students.updateOne(
     { _id: 2 },
     { $pop: { courses: -1 } }
   )
   ```
   *Explicação*: O operador `$pop: -1` remove o primeiro elemento do array `courses` do estudante Bob.

4. **Exercício 4**
   ```json
   db.students.updateOne(
     { _id: 2 },
     { $pull: { courses: "History" } }
   )
   ```
   *Explicação*: O operador `$pull` remove todas as ocorrências de "History" do array `courses` do estudante Bob.

5. **Exercício 5**
   ```json
   db.students.updateOne(
     { _id: 1 },
     { $push: { courses: { $each: ["Philosophy", "Economics"] } } }
   )
   ```
   *Explicação*: O operador `$push` com `$each` permite adicionar múltiplos valores de uma só vez ao array `courses` de Alice.

6. **Exercício 6**
   ```json
   db.students.updateMany(
     {},
     { $pull: { courses: "Math" } }
   )
   ```
   *Explicação*: O operador `$pull` remove todas as ocorrências de "Math" em todos os documentos da coleção.

7. **Exercício 7**
   ```json
   db.students.updateMany(
     { courses: { $ne: "Computer Science" } },
     { $addToSet: { courses: "Computer Science" } }
   )
   ```
   *Explicação*: O operador `$addToSet` adiciona "Computer Science" ao array `courses` de todos os estudantes que ainda não possuem esse curso.

8. **Exercício 8**
   ```json
   db.students.updateMany(
     {},
     { $push: { courses: "Art" } }
   )
   db.students.updateMany(
     {},
     { $pop: { courses: 1 } }
   )
   ```
   *Explicação*: Primeiro, adicionamos "Art" ao final do array `courses` usando `$push`, e em seguida removemos o último curso adicionado ao array usando `$pop: 1`.

9. **Exercício 9**
   ```json
   db.students.updateOne(
     { _id: 3 },
     { $push: { extra_courses: { $each: ["Music", "Drama"] } } }
   )
   ```
   *Explicação*: O operador `$push` com `$each` adiciona "Music" e "Drama" ao novo campo `extra_courses` do estudante Charlie.

10. **Exercício 10**
   ```json
   db.students.updateOne(
     { _id: 3 },
     { $addToSet: { extra_courses: "Music" } }
   )
   ```
   *Explicação*: O operador `$addToSet` garante que "Music" não seja adicionado novamente ao array `extra_courses`, evitando duplicação.
