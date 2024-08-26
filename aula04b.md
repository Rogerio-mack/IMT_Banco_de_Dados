# Consultas no MongoDB: Exemplos Avançados

## 1. **Mais sobre Operadores Lógicos no MongoDB**

### **Exemplo 1: Combinando `$and` e `$or`**

Retorne os documentos onde o `status` seja "active" **e** a `age` seja maior que 30, **ou** onde o `name` comece com a letra "A".

```javascript
db.pessoas.find({
  $and: [
    {
      $or: [
        { status: "active" },
        { age: { $gt: 30 } }
      ]
    },
    { name: { $regex: /^A/ } }
  ]
});
```

**Explicação:**
- Usa-se `$and` para combinar duas condições.
- Dentro do `$and`, um `$or` verifica se o `status` é "active" ou se a `age` é maior que 30.
- A segunda condição do `$and` verifica se o `name` começa com "A".

### **Exemplo 2: Combinando `$or` e `$not` em uma consulta com arrays**

Retorne os documentos onde o `status` seja "active" **ou** o campo `age` não esteja presente **e** onde o `address` contenha "Main St" ou "Pine Ave".

```javascript
db.pessoas.find({
  $or: [
    { status: "active" },
    { age: { $exists: false } }
  ],
  $and: [
    { address: { $in: ["123 Main St", "789 Pine Ave"] } }
  ]
});
```

**Explicação:**
- O `$or` verifica se o `status` é "active" **ou** se o campo `age` não existe.
- O `$and` garante que o `address` contenha "123 Main St" ou "789 Pine Ave" (trabalhando com arrays).

### **Exemplo 3: Combinando `$nor`, `$not` e `$and`**

Retorne os documentos onde a `age` **não** seja menor que 25 **e** o `status` não seja "inactive", **e** onde o campo `email` esteja ausente ou o campo `name` **não** comece com "J".

```javascript
db.pessoas.find({
  $and: [
    { age: { $not: { $lt: 25 } } },
    { status: { $not: { $eq: "inactive" } } },
    {
      $nor: [
        { email: { $exists: true } },
        { name: { $regex: /^J/ } }
      ]
    }
  ]
});
```

**Explicação:**
- `$not` é usado para especificar que a `age` não deve ser menor que 25, e o `status` não deve ser "inactive".
- `$nor` retorna documentos que **não** atendem a nenhuma das condições dentro dele (email não existe ou o nome não começa com "J").

## 2. **Operadores de Array: `$elemMatch` e `$slice`**

### **Exemplo 1: Operador `$elemMatch`**

O operador `$elemMatch` é usado para combinar múltiplas condições em um único elemento de um array. Ele garante que todas as condições dentro do `$elemMatch` sejam verdadeiras para pelo menos um elemento do array.

#### **Cenário:**
Considere que você tem uma coleção `pessoas` que agora inclui um campo adicional chamado `skills`, que é um array de documentos. Cada documento dentro de `skills` contém informações sobre as habilidades de uma pessoa.

```json
{
  "name": "John Doe",
  "age": 34,
  "status": "active",
  "skills": [
    { "skill": "Python", "level": 5 },
    { "skill": "JavaScript", "level": 4 },
    { "skill": "SQL", "level": 3 }
  ]
}
```

#### **Consulta:**
Retorne todos os documentos em que a pessoa tenha uma habilidade de nível 4 ou maior em `Python`.

```javascript
db.pessoas.find({
  skills: { $elemMatch: { skill: "Python", level: { $gte: 4 } } }
});
```

#### **Explicação:**
- `$elemMatch` verifica se existe um elemento no array `skills` que satisfaça ambas as condições: o `skill` deve ser `"Python"` **e** o `level` deve ser maior ou igual a 4.

---

### **Exemplo 2: Operador `$slice`**

O operador `$slice` é usado para limitar a quantidade de elementos que serão retornados de um array em uma consulta. Ele não altera os dados armazenados, mas restringe o que é exibido na consulta.

#### **Cenário:**
Na mesma coleção `pessoas`, você quer retornar apenas os dois primeiros elementos do array `skills` de cada pessoa.

#### **Consulta:**
Retorne os dois primeiros elementos do array `skills` para todas as pessoas.

```javascript
db.pessoas.find({}, { name: 1, skills: { $slice: 2 } });
```

#### **Explicação:**
- O operador `$slice: 2` limita a saída para os dois primeiros elementos do array `skills` de cada pessoa.
- O campo `name` é incluído apenas para contexto, mas você pode modificar a consulta conforme necessário.

**Atenção**: O $slice é usado para limitar a visualização ou projeção dos elementos de um array, enquanto o $size é usado para realizar consultas com base no tamanho do array.

#### **Consulta:**
Retorne apenas o último elemento do array `skills`.

```javascript
db.pessoas.find({}, { name: 1, skills: { $slice: -1 } });
```

#### **Explicação:**
- O operador `$slice: -1` retorna o último elemento do array `skills`.

Aqui estão exemplos complementares com os operadores `$elemMatch` e `$slice` no MongoDB:

Sim! O operador `$slice` permite retornar um intervalo de valores dentro de um array, semelhante a como a fatia de listas funciona em Python.

### **Sintaxe e Usos do `$slice`**

1. **Retornar os primeiros N elementos**:
   - `{ $slice: N }`
   - retorna os primeiros `N` elementos de um array.

2. **Retornar os últimos N elementos**:
   - `{ $slice: -N }`
   - retorna os últimos `N` elementos de um array.

3. **Retornar um intervalo de elementos** (composição de offset e limite):
   - `{ $slice: [offset, limit] }`
   - `offset` indica a posição inicial e `limit` indica quantos elementos serão retornados a partir desse ponto.
   - O `offset` pode ser negativo para contar a partir do final do array.

Imagine a coleção `pessoas` com o seguinte documento:

```json
{
  "_id": 1,
  "name": "John Doe",
  "skills": ["Python", "JavaScript", "SQL", "C++", "Java"]
}
```

#### **Retornar os primeiros 2 elementos**

```javascript
db.pessoas.find(
  { _id: 1 },
  { skills: { $slice: 2 } }
);
```

- Resultado: `["Python", "JavaScript"]`

#### **Retornar os últimos 2 elementos**

```javascript
db.pessoas.find(
  { _id: 1 },
  { skills: { $slice: -2 } }
);
```

- Resultado: `["C++", "Java"]`

#### **Retornar 2 elementos começando a partir do terceiro elemento**

```javascript
db.pessoas.find(
  { _id: 1 },
  { skills: { $slice: [2, 2] } }
);
```
- Resultado: `["SQL", "C++"]`

#### **Usando um `offset` negativo**
Você pode usar um valor negativo no `offset` para começar a contagem a partir do final do array.

```javascript
db.pessoas.find(
  { _id: 1 },
  { skills: { $slice: [-3, 2] } }
);
```
- Resultado: `["SQL", "C++"]` (Começa no terceiro elemento a partir do final e retorna 2 elementos)



