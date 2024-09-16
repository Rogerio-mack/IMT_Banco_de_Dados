# Solução Lab

```javascript
// a) Insira uma nova empresa fornecedora com razao social, tipo, cnpj, endereco (com campos para cada característica) e fones com campos para ddd e número.
db.empresa.insertOne({
  razao_social: 'Faisca Equipamentos e Software Ltda ',
  cnpj: 22334455,
  tipo_empresa: 'Fornecedor',
  endereco: {
    rua: 'Cerro Corá',
    numero: 1000,
    bairro: 'Lapa',
    cidade: 'Sao Paulo'
  },
  fones: [
    { DDD: 11, numero: 995001234 },
    { DDD: 11, numero: 957890000 }
  ]
})
db.empresa.find({ razao_social: /Fa.*sca/i })
```

**Explicação**: 
- O comando `insertOne()` insere um documento na coleção `empresa` com os campos especificados, como `razao_social`, `cnpj`, `tipo_empresa`, e um subdocumento `endereco` com detalhes de endereço. Além disso, inserimos um vetor de telefones usando o campo `fones`.
- A consulta `find()` utiliza uma expressão regular (`/Fa.*sca/i`) para buscar empresas que contenham "Fa" seguido de qualquer caractere e terminando com "sca" (case insensitive).

---

```javascript
// b) Após incluir o novo documento atualize o bairro da empresa.
db.empresa.updateOne({ razao_social: /Fa.*sca/i }, { $set: { "endereco.bairro": 'Alto da Lapa' } })
```

**Explicação**: 
- A função `updateOne()` encontra um documento com a `razao_social` correspondente à expressão regular e, em seguida, atualiza o campo `endereco.bairro` para "Alto da Lapa" usando o operador `$set`.

---

```javascript
// c) Inclua um novo número de telefones e posteriormente atualize este número.
db.empresa.updateOne({ razao_social: /Faisca/i }, { $push: { "fones": { $each: [{ DDD: 11, numero: 11990987654 }] } } })
db.empresa.updateOne({ razao_social: /Fa.*sca/i, "fones.numero": 11990987654 }, { $set: { "fones.$": { DDD: 11, numero: 990987622 } } })
```

**Explicação**: 
- O operador `$push` adiciona um novo número de telefone ao vetor `fones`. O `$each` permite adicionar múltiplos valores ao array, mas aqui adicionamos apenas um.
- Na segunda atualização, usamos o operador `$set` para alterar o valor de um item no array, localizando o número específico (`11990987654`) e modificando-o.

---

```javascript
// d) Mostre razao social, endereco e fones de empresas que nao estao localizadas no bairro Lapa.
db.empresa.find(
  {
    $and: [
      { endereco: { $not: /lapa/i } },
      { "endereco.bairro": { $not: /lapa/i } }
    ]
  },
  { _id: 0, razao_social: 1, endereco: 1, fones: 1 }
)
```

**Explicação**: 
- A consulta usa `$and` para combinar múltiplas condições e `$not` para filtrar empresas fora do bairro "Lapa" (case insensitive).
- No segundo argumento de `find()`, usamos uma projeção para exibir apenas os campos `razao_social`, `endereco` e `fones`.

---

```javascript
// e) Mostre os mesmos dados de d) mas para as empresas que tenham a palavra Equipamento na razao social, mas que nao se localizem em cidades com nome de santo (Sao, Santo, Santa).
db.empresa.find(
  {
    $and: [
      { razao_social: /equipamento/i },
      { endereco: { $not: /sant/i } },
      { "endereco.cidade": { $not: /sant/i } },
      { endereco: { $not: /s.*o/i } },
      { "endereco.cidade": { $not: /s.*o/i } }
    ]
  },
  { _id: 0, razao_social: 1, "endereco.cidade": 1, fones: 1 }
)
```

**Explicação**: 
- Aqui, usamos uma combinação de expressões regulares (`/equipamento/i` para "Equipamento" e `/sant/i` para "Santo, Santa") para filtrar empresas com "Equipamento" na `razao_social`, mas que não estejam em cidades com "Santo" ou "Sao" no nome.
- O segundo argumento de `find()` projeta apenas os campos solicitados.

---

```javascript
// f) Insira um novo periferico do tipo Mesa Digitalizadora, coloque marca, resolucao e outras características que julgar interessante.
db.equipamento.insertOne({
  patrimonio: 104,
  marca: "Wacon",
  tipo: "Periferico",
  caracteristicas: {
    cor: "Preto",
    tipo_periferico: "Mesa Digitalizadora",
    resolucao_lpi: 2540,
    area_ativa: "216 x 135 mm"
  }
})
```

**Explicação**: 
- O comando `insertOne()` insere um novo documento na coleção `equipamento`, definindo as características como `marca`, `tipo`, e um subdocumento `caracteristicas` para especificar detalhes como `resolucao_lpi` e `area_ativa`.

---

```javascript
// g) Aloque o novo periferico ao computador de patrimônio 100 (Notebook).
db.equipamento.updateOne(
  { patrimonio: 100 },
  { $push: { "perifericos_instalados": { $each: [{ patrimonio_perif: 104, dt_alocacao: ISODate("2023-09-17T10:17:45.285-03:00") }] } } }
)
```

**Explicação**: 
- O comando `updateOne()` adiciona um novo periférico ao computador de patrimônio `100`. O operador `$push` adiciona um item ao array `perifericos_instalados` com o número do patrimônio do periférico e a data de alocação.

---

```javascript
// h) Mostre para cada equipamento o patrimônio, marca, tipo e a principal característica, a razao social do fornecedor e os fones, filtrando os fornecedores que nao tem as palavras “comercio” e “equipamento” na razao social.
db.equipamento.aggregate([
  {
    $lookup: {
      from: "empresa",
      localField: "cnpj_forn",
      foreignField: "cnpj",
      as: "fornecedor"
    }
  },
  {
    $project: {
      "_id": 0,
      "patrimonio": 1,
      "marca": 1,
      "tipo": 1,
      "caracteristicas.tipo_periferico": 1,
      "fornecedor.razao_social": 1,
      "fornecedor.fones": 1
    }
  }
])
```

**Explicação**: 
- A agregação usa `$lookup` para realizar um "join" entre as coleções `equipamento` e `empresa` com base no campo `cnpj`.
- O operador `$project` seleciona os campos a serem exibidos, ocultando o `_id`.

---

```javascript
// i) Mostre os dados do computador e os perifericos alocados que têm a característica resolucao. Mostre a marca, patrimônio, resolucao e data de alocacao dos perifericos, bem como a marca e tipo de computador de patrimônio 100.
db.equipamento.aggregate([
  { $match: { "tipo": /comput/i } },
  {
    $lookup: {
      from: "equipamento",
      localField: "perifericos_alocados.patrimonio_perif",
      foreignField: "patrimonio",
      as: "alocacao_perifericos"
    }
  },
  { $unwind: "$alocacao_perifericos" },
  {
    $match: {
      $or: [
        { "alocacao_perifericos.caracteristicas.resolucao": { $exists: true } },
        { "alocacao_perifericos.caracteristicas.resolucao_lpi": { $exists: true } }
      ]
    }
  },
  {
    $project: {
      "_id": 0,
      "patrimonio": 1,
      "marca": 1,
      "tipo": 1,
      "alocacao_perifericos.patrimonio": 1,
      "alocacao_perifericos.marca": 1,
      "perifericos_instalados.dt_alocacao": 1,
      "alocacao_perifericos.caracteristicas.resolucao": 1,
      "alocacao_perifericos.caracteristicas.resolucao_lpi": 1
    }
  }
]).pretty()
```

**Explicação**: 
- O primeiro `$match` filtra os computadores (usando uma expressão regular em `tipo`).
- O `$lookup` faz a junção com os periféricos alocados, e o `$unwind` "expande" os arrays de periféricos.
- Em seguida, o `$match` encontra periféricos que tenham a característica `resolucao` ou `resolucao_lpi`.
- Finalmente, o `$project` exibe os campos desejados, como patrimônio, marca, tipo e a resolução dos periféricos.

