# Revisão

## 1. CRUD de Arrays: `$each`, `$set`, `$push`...

```javascript
// Criar uma coleção de exemplo "produtos"
db.produtos.insertOne({
  nome: "Teclado",
  categoria: "Periférico",
  fornecedores: [{nome: "Empresa A", contato: "1111-1111"}, {nome: "Empresa B", contato: "2222-2222"}]
})

// a) Adicionar um novo fornecedor ao array usando $push
db.produtos.updateOne(
  { nome: "Teclado" },
  { $push: { fornecedores: { nome: "Empresa C", contato: "3333-3333" } } }
)

// b) Atualizar o contato de um fornecedor usando $set
db.produtos.updateOne(
  { nome: "Teclado", "fornecedores.nome": "Empresa A" },
  { $set: { "fornecedores.$.contato": "9999-9999" } }
)

// c) Adicionar múltiplos fornecedores de uma vez usando $each
db.produtos.updateOne(
  { nome: "Teclado" },
  { $push: { fornecedores: { $each: [{nome: "Empresa D", contato: "4444-4444"}, {nome: "Empresa E", contato: "5555-5555"}] } } }
)
```

## 2. Consultas de uma coleção: `$and`, `$or`, `$exists`...

```javascript
// Criar uma coleção de exemplo "clientes"
db.clientes.insertMany([
  { nome: "João", idade: 30, email: "joao@example.com" },
  { nome: "Maria", idade: 25 },
  { nome: "Pedro", idade: 40, email: "pedro@example.com" }
])

// a) Encontrar clientes que têm email usando $exists
db.clientes.find({ email: { $exists: true } })

// b) Buscar clientes com idade maior que 25 e que tenham email usando $and
db.clientes.find({
  $and: [
    { idade: { $gt: 25 } },
    { email: { $exists: true } }
  ]
})

// c) Buscar clientes com idade menor que 30 ou que tenham email usando $or
db.clientes.find({
  $or: [
    { idade: { $lt: 30 } },
    { email: { $exists: true } }
  ]
})
```

## 3. Consultas de junção de duas coleções: `$lookup` com `$unwind`

```javascript
// Criar coleção "pedidos"
db.pedidos.insertMany([
  { cliente_id: 1, produto: "Teclado", quantidade: 2 },
  { cliente_id: 2, produto: "Mouse", quantidade: 1 }
])

// Criar coleção "clientes"
db.clientes.insertMany([
  { _id: 1, nome: "João", idade: 30 },
  { _id: 2, nome: "Maria", idade: 25 }
])

// a) Usar $lookup para unir dados de "pedidos" e "clientes"
db.pedidos.aggregate([
  {
    $lookup: {
      from: "clientes",
      localField: "cliente_id",
      foreignField: "_id",
      as: "cliente_info"
    }
  },
  { $unwind: "$cliente_info" },
  { $project: { produto: 1, quantidade: 1, "cliente_info.nome": 1, "cliente_info.idade": 1 } }
])
```

## 4. Consultas com função de grupo: `$group`

```javascript
// Criar uma coleção de exemplo "vendas"
db.vendas.insertMany([
  { produto: "Teclado", quantidade: 2, valor: 100 },
  { produto: "Mouse", quantidade: 1, valor: 50 },
  { produto: "Teclado", quantidade: 3, valor: 150 },
  { produto: "Mouse", quantidade: 4, valor: 200 }
])

// a) Agrupar por produto e somar a quantidade e valor total
db.vendas.aggregate([
  {
    $group: {
      _id: "$produto",
      total_quantidade: { $sum: "$quantidade" },
      total_valor: { $sum: "$valor" }
    }
  }
])
```


