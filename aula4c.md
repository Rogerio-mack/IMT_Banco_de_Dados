# Atualização MongoDB, Avançado

## Campos

Operadores que podem ser usados ​​para atualizar campos:

- `$currentDate`: Define o valor do campo para a data atual
- `$inc`: Incrementa o valor do campo
- `$rename`: Renomeia o campo
- `$set`: Define o valor de um campo
- `$unset`: Remove o campo do documento

## Arrays
Operadores que auxiliam na atualização de arrays/matrizes.

- `$addToSet`: Adiciona elementos distintos a uma matriz
- `$pop`: Remove o primeiro ou o último elemento de uma matriz
- `$pull`: Remove todos os elementos de uma matriz que correspondem à consulta
- `$push`: Adiciona um elemento a uma matriz

### **1. Operadores `$rename`, `$set` e `$unset`**

#### **Cenário:**
Vamos considerar a seguinte coleção `pessoas`:

```json
{
  "_id": 1,
  "name": "John Doe",
  "age": 34,
  "status": "active",
  "skills": [
    { "skill": "Python", "level": 5 },
    { "skill": "JavaScript", "level": 4 },
    { "skill": "SQL", "level": 3 }
  ]
},
{
  "_id": 2,
  "name": "Jane Smith",
  "age": 28,
  "status": "inactive"
}
```

#### **Exemplo 1: Operador `$rename`**
Renomeie o campo `age` para `years_old`.

```javascript
db.pessoas.updateMany({}, { $rename: { "age": "years_old" } });
```

#### **Explicação:**
- O operador `$rename` renomeia o campo `age` para `years_old` em todos os documentos da coleção `pessoas`.

---

#### **Exemplo 2: Operador `$set`**
Atualize o status de `John Doe` para `"on leave"` e adicione um novo campo `department`.

```javascript
db.pessoas.updateOne(
  { name: "John Doe" },
  { $set: { status: "on leave", department: "IT" } }
);
```

#### **Explicação:**
- O operador `$set` modifica o valor do campo `status` de `John Doe` e adiciona o campo `department` com o valor `"IT"`.

#### **Exemplo 3: Operador `$unset`**
Remova o campo `status` de `Jane Smith`.

```javascript
db.pessoas.updateOne(
  { name: "Jane Smith" },
  { $unset: { status: "" } }
);
```

#### **Explicação:**
- O operador `$unset` remove o campo `status` do documento correspondente a `Jane Smith`. O valor vazio (`""`) é irrelevante; o campo é removido independentemente do valor fornecido.

### **2. Operadores `$pop`, `$pull` e `$push`**

Agora vamos trabalhar com arrays, especificamente o campo `skills` da coleção `pessoas`.

#### **Exemplo 1: Operador `$pop`**
Remova o último elemento do array `skills` de `John Doe`.

```javascript
db.pessoas.updateOne(
  { name: "John Doe" },
  { $pop: { skills: 1 } }
);
```

#### **Explicação:**
- O operador `$pop: 1` remove o último elemento do array `skills` para o documento de `John Doe`. Se fosse `$pop: -1`, o primeiro elemento seria removido.

#### **Exemplo 2: Operador `$pull`**
Remova do array `skills` de `John Doe` todas as habilidades com `level` menor que 4.

```javascript
db.pessoas.updateOne(
  { name: "John Doe" },
  { $pull: { skills: { level: { $lt: 4 } } } }
);
```

#### **Explicação:**
- O operador `$pull` remove todos os elementos do array `skills` cujo campo `level` seja menor que 4. Assim, o skill `"SQL"` será removido.

#### **Exemplo 3: Operador `$push`**
Adicione uma nova habilidade ao array `skills` de `John Doe`.

```javascript
db.pessoas.updateOne(
  { name: "John Doe" },
  { $push: { skills: { skill: "C++", level: 3 } } }
);
```

#### **Explicação:**
- O operador `$push` adiciona um novo objeto ao array `skills` de `John Doe`, com `skill: "C++"` e `level: 3`.

### **Coleção Final:**

Após a execução desses comandos, a coleção `pessoas` ficaria assim:

```json
{
  "_id": 1,
  "name": "John Doe",
  "years_old": 34,
  "status": "on leave",
  "department": "IT",
  "skills": [
    { "skill": "Python", "level": 5 },
    { "skill": "JavaScript", "level": 4 },
    { "skill": "C++", "level": 3 }
  ]
},
{
  "_id": 2,
  "name": "Jane Smith",
  "years_old": 28
}
```

