# Relacionamento de Documentos no MongoDB

## Introdução

No MongoDB, o conceito de relacionamento entre documentos é implementado de forma diferente do modelo relacional tradicional. Em vez de chaves estrangeiras como nos bancos relacionais, o MongoDB usa documentos aninhados ou referências para relacionar dados. Vamos abordar alguns comandos importantes para criar e buscar esses relacionamentos.

## 1. **$set**
O operador `$set` é usado para atualizar documentos existentes ou adicionar novos campos. É útil ao modificar documentos para incluir novos valores ou ajustar estruturas de dados.

### Exemplo de uso de `$set`
**Coleção: `pessoas`**
```json
{
  "_id": 1,
  "nome": "Alice",
  "idade": 30
}
```

### Atualizando o documento para incluir o campo `profissao`:
```javascript
db.pessoas.updateOne(
   { "_id": 1 },
   { $set: { "profissao": "Engenheira de Software" } }
)
```

**Resultado:**
```json
{
  "_id": 1,
  "nome": "Alice",
  "idade": 30,
  "profissao": "Engenheira de Software"
}
```

## 2. **`aggregate`**
O `aggregate` permite realizar operações avançadas de processamento e análise de dados. Ele agrupa, filtra e transforma dados de forma poderosa. Quando se trabalha com relacionamentos, ele é especialmente útil.

## 3. **$lookup**
O operador `$lookup` é utilizado para realizar **joins** entre coleções, semelhante a um `JOIN` em SQL. Ele permite consultar documentos de uma coleção a partir de documentos relacionados em outra coleção.

### Exemplo de `$lookup`
Vamos usar duas coleções: **`pessoas`** e **`enderecos`**.

**Coleção: `pessoas`**
```json
{
  "_id": 1,
  "nome": "Alice",
  "idade": 30,
  "endereco_id": 101
}
```

**Coleção: `enderecos`**
```json
{
  "_id": 101,
  "rua": "Rua das Flores",
  "cidade": "São Paulo"
}
```

### Fazendo o join com `$lookup`:
```javascript
db.pessoas.aggregate([
   {
     $lookup: {
       from: "enderecos",            // Coleção para fazer o join
       localField: "endereco_id",     // Campo na coleção 'pessoas'
       foreignField: "_id",           // Campo na coleção 'enderecos'
       as: "endereco"                 // Nome do campo de saída
     }
   }
])
```

**Resultado:**
```json
{
  "_id": 1,
  "nome": "Alice",
  "idade": 30,
  "endereco_id": 101,
  "endereco": [
    {
      "_id": 101,
      "rua": "Rua das Flores",
      "cidade": "São Paulo"
    }
  ]
}
```

## 4. **$match**
O operador `$match` é usado para filtrar documentos em estágios da `pipeline` de agregação com base em critérios específicos.

### Exemplo de `$match`:
Filtrar apenas pessoas de São Paulo.

```javascript
db.pessoas.aggregate([
   {
     $lookup: {
       from: "enderecos",
       localField: "endereco_id",
       foreignField: "_id",
       as: "endereco"
     }
   },
   {
     $match: { "endereco.cidade": "São Paulo" }
   }
])
```

**Resultado:**
```json
{
  "_id": 1,
  "nome": "Alice",
  "idade": 30,
  "endereco_id": 101,
  "endereco": [
    {
      "_id": 101,
      "rua": "Rua das Flores",
      "cidade": "São Paulo"
    }
  ]
}
```

## 5. **$unwind**
O `$unwind` decompõe arrays em documentos individuais. Ele é útil para desestruturar dados aninhados em arrays.

### Exemplo de `$unwind`:
Vamos supor que o campo `endereco` seja um array com múltiplos endereços.

```json
{
  "_id": 1,
  "nome": "Alice",
  "idade": 30,
  "enderecos": [
    {
      "_id": 101,
      "rua": "Rua das Flores",
      "cidade": "São Paulo"
    },
    {
      "_id": 102,
      "rua": "Avenida Brasil",
      "cidade": "Rio de Janeiro"
    }
  ]
}
```

### Usando `$unwind`:
```javascript
db.pessoas.aggregate([
   { $unwind: "$enderecos" }
])
```

**Resultado:**
```json
{
  "_id": 1,
  "nome": "Alice",
  "idade": 30,
  "enderecos": {
    "_id": 101,
    "rua": "Rua das Flores",
    "cidade": "São Paulo"
  }
}
{
  "_id": 1,
  "nome": "Alice",
  "idade": 30,
  "enderecos": {
    "_id": 102,
    "rua": "Avenida Brasil",
    "cidade": "Rio de Janeiro"
  }
}
```

## 6. **$project**
O operador `$project` permite controlar quais campos serão exibidos nos resultados de uma consulta.

### Exemplo de `$project`:
Exibir apenas o nome da pessoa e o nome da cidade.

```javascript
db.pessoas.aggregate([
   {
     $lookup: {
       from: "enderecos",
       localField: "endereco_id",
       foreignField: "_id",
       as: "endereco"
     }
   },
   { $unwind: "$endereco" },
   {
     $project: {
       "nome": 1,
       "endereco.cidade": 1
     }
   }
])
```

**Resultado:**
```json
{
  "nome": "Alice",
  "endereco": {
    "cidade": "São Paulo"
  }
}
```



