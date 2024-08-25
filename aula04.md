# Consultas no MongoDB: Exemplos e Exercícios

## Coleção de Exemplo: `pessoas`

A coleção `pessoas` contém documentos que incluem os campos `name`, `age`, `status`, `email`, e `address`. Você pode usar essa coleção para responder a vários exercícios de consulta.

### **Estrutura da Coleção:**

```json
[
  {
    "name": "John Doe",
    "age": 34,
    "status": "active",
    "email": "john.doe@company.com",
    "address": "123 Main St"
  },
  {
    "name": "Jane Smith",
    "age": 28,
    "status": "inactive",
    "email": "jane.smith@company.com",
    "address": "456 Oak St"
  },
  {
    "name": "Alice Johnson",
    "age": 45,
    "status": "active",
    "email": "alice.johnson@company.com",
    "address": "789 Pine Ave"
  },
  {
    "name": "Bob Brown",
    "age": 23,
    "status": "active",
    "email": "bob.brown@company.com",
    "address": "101 Maple St"
  },
  {
    "name": "Charlie Davis",
    "age": 30,
    "status": "inactive",
    "email": "charlie.davis@anothercompany.com",
    "address": "202 Elm St"
  },
  {
    "name": "David Wilson",
    "age": 36,
    "status": "active",
    "email": "david.wilson@company.com",
    "address": "303 Birch St"
  },
  {
    "name": "Emma White",
    "age": 29,
    "status": "inactive",
    "email": "emma.white@company.com",
    "address": "404 Cedar St"
  },
  {
    "name": "Frank Harris",
    "age": 32,
    "status": "active",
    "email": "frank.harris@company.com",
    "address": "505 Walnut St"
  },
  {
    "name": "George Clark",
    "age": 27,
    "status": "active",
    "email": "george.clark@company.com",
    "address": "606 Chestnut St"
  },
  {
    "name": "Hannah Martinez",
    "age": 35,
    "status": "inactive",
    "email": "hannah.martinez@company.com",
    "address": "707 Pine St"
  }
]
```

Para inserir esses dados no MongoDB, execute:

```javascript
use myDatabase;
db.pessoas.insertMany([...documentos aqui...]);
```

## Operadores Lógicos no MongoDB

### **Exemplo 1: Combinando `$and` e `$or`**

**Descrição:** Retorne os documentos onde o `status` seja "active" **e** a `age` seja maior que 30, **ou** onde o `name` comece com a letra "A".

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

**Descrição:** Retorne os documentos onde o `status` seja "active" **ou** o campo `age` não esteja presente **e** onde o `address` contenha "Main St" ou "Pine Ave".

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

**Descrição:** Retorne os documentos onde a `age` **não** seja menor que 25 **e** o `status` não seja "inactive", **e** onde o campo `email` esteja ausente ou o campo `name` **não** comece com "J".

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

## Exercícios de Consultas no MongoDB

### **Exercício 1: Selecionar pessoas ativas**

**Consulta:**

```javascript
db.pessoas.find({ status: "active" });
```

### **Exercício 2: Selecionar pessoas com idade maior que 30**

**Consulta:**

```javascript
db.pessoas.find({ age: { $gt: 30 } });
```

### **Exercício 3: Selecionar pessoas cujo nome começa com "J"**

**Consulta com expressão regular:**

```javascript
db.pessoas.find({ name: { $regex: /^J/ } });
```

### **Exercício 4: Selecionar pessoas ativas com idade maior que 30**

**Consulta:**

```javascript
db.pessoas.find({ status: "active", age: { $gt: 30 } });
```

### **Exercício 5: Selecionar pessoas cuja idade não é 28**

**Consulta:**

```javascript
db.pessoas.find({ age: { $ne: 28 } });
```

### **Exercício 6: Selecionar pessoas cujo email termina com "company.com"**

**Consulta com expressão regular:**

```javascript
db.pessoas.find({ email: { $regex: /company\.com$/ } });
```

### **Exercício 7: Selecionar pessoas cujo nome contém "Smith"**

**Consulta com expressão regular:**

```javascript
db.pessoas.find({ name: { $regex: /Smith/ } });
```

### **Exercício 8: Selecionar pessoas que têm "Pine" no endereço**

**Consulta com expressão regular:**

```javascript
db.pessoas.find({ address: { $regex: /Pine/ } });
```

### **Exercício 9: Selecionar pessoas com idade entre 25 e 35 anos**

**Consulta:**

```javascript
db.pessoas.find({ age: { $gte: 25, $lte: 35 } });
```

### **Exercício 10: Selecionar pessoas com status "inactive" ou idade menor que 30**

**Consulta:**

```javascript
db.pessoas.find({
  $or: [
    { status: "inactive" },
    { age: { $lt: 30 } }
  ]
});
```
```

Esse documento markdown reúne todos os exemplos, a coleção de exemplo e os exercícios com consultas em MongoDB que foram fornecidos até agora.
