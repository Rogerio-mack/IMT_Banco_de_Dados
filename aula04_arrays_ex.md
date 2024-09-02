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



