# Consultas no MongoDB: Exemplos e Exercícios

## Coleção de Exemplo: `pessoas`

A coleção `pessoas` contém documentos que incluem os campos `name`, `age`, `status`, `email`, e `address`. 

### **Coleção:**

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

## 1. **Introdução às Consultas no MongoDB**

   - **Comandos Básicos de Consulta (`find`, `findOne`)**

     ```javascript
     // Exemplo básico de consulta de todos os documentos
     db.collection.find()
     // Exemplo de consulta com um filtro
     db.collection.find({ field: "value" })
     ```

## 2. **Filtros de Consulta**
 
   - **Operadores de Comparação**
   
     ```javascript
     // Operadores: $eq, $ne, $gt, $gte, $lt, $lte
     db.collection.find({ age: { $gt: 25 } })
     ```
   
   - **Consulta com múltiplos campos**

     ```javascript
     // Exemplo de filtro em mais de um campo
     db.collection.find({ age: { $gt: 25 }, status: "active" })
     ```

## 3. **Operadores Lógicos**
   
   - **Combinação de Operadores: `$and`, `$or`, `$not`, `$nor`**
   
     ```javascript
     // Consulta com $or
     db.collection.find({ $or: [ { status: "active" }, { age: { $lt: 30 } } ] })
     ```

## 4. **Projeções**

   - **Selecionando Campos Específicos**

     ```javascript
     // Excluir ou incluir campos específicos
     db.collection.find({ status: "active" }, { name: 1, age: 1, _id: 0 })
     ```

## 5. **Operadores de Elemento**

   - **Verificação de Existência de Campos: `$exists`, `$type`**

     ```javascript
     // Verifica se o campo `email` existe
     db.collection.find({ email: { $exists: true } })
     ```

## 6. **Consultas em Arrays**

   - **Consultas com Arrays e Arrays de Documentos**
   
     ```javascript
     // Busca documentos onde `tags` contém o valor "mongodb"
     db.collection.find({ tags: "mongodb" })
     // Consulta com $all (todos os valores)
     db.collection.find({ tags: { $all: ["mongodb", "database"] } })
     ```

## 7. **Operadores de Array**

   - **Operadores `$size`, `$elemMatch`, `$slice`**

     ```javascript
     // Busca documentos onde o array `tags` tem exatamente 3 elementos
     db.collection.find({ tags: { $size: 3 } })
     ```

## 8. **Consultas com Expressões Regulares (Regex)**
   
   Expressões regulares são poderosas para trabalhar com strings em consultas. Elas são empregadas para procurar padrões dentro de campos de texto. No MongoDB, elas seguem o padrão do `Perl Compatible Regular Expressions (PCRE)`.

   #### Exemplos de Consultas com Expressões Regulares
   
   - **Procurando Substrings**
   
     ```javascript
     // Consulta onde o nome começa com "Jo"
     db.collection.find({ name: { $regex: /^Jo/ } })
     ```
     Esse comando busca todos os documentos cujo campo `name` começa com "Jo".

   - **Busca Insensível a Maiúsculas e Minúsculas**
   
     ```javascript
     // Consulta com a flag `i` para ignorar maiúsculas/minúsculas
     db.collection.find({ name: { $regex: /mongodb/i } })
     ```
     A flag `i` torna a busca insensível ao caso (ex.: "MongoDB", "mongodb" e "MONGODB" serão encontrados).

   - **Expressões Regulares Mais Complexas**
     ```javascript
     // Busca nomes que contenham números
     db.collection.find({ name: { $regex: /\d+/ } })
     ```
     Aqui, `\d+` procura por qualquer string que contenha um ou mais números.

   - **Combinação de Expressões Regulares**
     ```javascript
     // Consulta para nomes que começam com "Jo" e terminam com "hn"
     db.collection.find({ name: { $regex: /^Jo.*hn$/ } })
     ```

     Este padrão busca qualquer nome que comece com "Jo" e termine com "hn", podendo ter qualquer sequência de caracteres entre eles.

   #### Uso Prático de Regex
   
   - **Encontrando Padrões de E-mail**
   
     ```javascript
     // Consulta por endereços de e-mail no domínio "gmail.com"
     db.collection.find({ email: { $regex: /@gmail\.com$/ } })
     ```

     Este exemplo busca todos os e-mails que terminam com "@gmail.com".

   #### Combinação de Regex com Outros Operadores
  
   - **Regex + `$or`**
   
     ```javascript
     db.collection.find({ $or: [ { name: { $regex: /^A/ } }, { name: { $regex: /^B/ } } ] })
     ```

     Aqui, buscamos nomes que comecem com "A" ou "B".

## 9. **Consultas em Documentos Aninhados**
   
   - **Acessando Subdocumentos**
  
     ```javascript
     db.collection.find({ "address.city": "New York" })
     ```

## 10. **Consultas com Ordenação, Limite e Salto**
   
   - **Ordenar (`sort`), Limitar (`limit`), Pular (`skip`)**

     ```javascript
     db.collection.find().sort({ age: -1 }).limit(5).skip(10)
     ```

## 11. **Consultas Agregadas**
   
   - **Operações Básicas de Agregação**
     ```javascript
     db.collection.aggregate([
       { $match: { status: "active" } },
       { $group: { _id: "$city", total: { $sum: 1 } } }
     ])
     ```

## 12. **Avançado - Mais sobre Operadores Lógicos no MongoDB**

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



