# Importação de Dados no MongoDB

## 1. **Importando Dados de Arquivos**
MongoDB permite importar dados de diferentes formatos, como JSON, CSV, ou TSV. Para isso, usamos a ferramenta `mongoimport`. 
Ela é útil para carregar dados de forma rápida e eficiente.

**Comando Básico para Importação de JSON:**
```bash
mongoimport --db nome_do_banco --collection nome_da_colecao --file caminho/arquivo.json --jsonArray
```

**Exemplo:**
```bash
mongoimport --db loja --collection produtos --file /path/produtos.json --jsonArray
```

Este comando importa dados do arquivo `produtos.json` para a coleção `produtos` no banco de dados `loja`.

**Importação de CSV:**
```bash
mongoimport --db loja --collection clientes --type csv --headerline --file /path/clientes.csv
```
Neste exemplo, o arquivo CSV será importado, onde a primeira linha do arquivo será interpretada como os nomes dos campos.

## Agregações no MongoDB

Agregações, são o equivalente ao `group by` da SQL. 
Elas permitem que você execute operações de transformação, filtros e agrupamentos nos documentos.

### 1. **Pipeline de Agregação**
O pipeline de agregação, que você já conhece das operações de `join`, é uma sequência de estágios onde cada estágio realiza uma operação no conjunto de documentos 
e passa o resultado para o próximo estágio.

A estrutura básica de uma agregação:
```js
db.colecao.aggregate([
  { estágio1 },
  { estágio2 },
  ...
])
```

Assim como nas operações de `join` empregaremos o `aggregate` para fazer as agregações, ou os agrupamentos. Não confunda, portanto `aggregate` $\diff$ `groupby`.

### 2. **Exemplo de Agregação Simples**
Suponha que temos uma coleção `vendas` e queremos calcular o total vendido por cada categoria.

**Coleção de Exemplo - `vendas`:**
```json
[
  { "produto": "Laptop", "categoria": "Eletrônicos", "preco": 2000, "quantidade": 3 },
  { "produto": "Mouse", "categoria": "Eletrônicos", "preco": 100, "quantidade": 5 },
  { "produto": "Cadeira", "categoria": "Móveis", "preco": 150, "quantidade": 2 }
]
```

**Agregação:**
```js
db.vendas.aggregate([
  {
    $group: {
      _id: "$categoria",
      totalVendido: { $sum: { $multiply: ["$preco", "$quantidade"] } }
    }
  }
])
```

**Resultado:**
```json
[
  { "_id": "Eletrônicos", "totalVendido": 6500 },
  { "_id": "Móveis", "totalVendido": 300 }
]
```

### 3. **Filtrando com `$match` e Agregando com `$group`**
Podemos filtrar antes de agrupar com o estágio `$match`:

**Exemplo:**
```js
db.vendas.aggregate([
  { $match: { "categoria": "Eletrônicos" } },
  {
    $group: {
      _id: "$categoria",
      totalVendido: { $sum: { $multiply: ["$preco", "$quantidade"] } }
    }
  }
])
```
Aqui, o pipeline primeiro filtra os documentos onde a categoria é "Eletrônicos", e depois agrupa e calcula o total vendido.

### 4. **Exemplo de Usando `$group` e `$avg`**
Vamos calcular o preço médio dos produtos por categoria:

```js
db.vendas.aggregate([
  {
    $group: {
      _id: "$categoria",
      precoMedio: { $avg: "$preco" }
    }
  }
])
```

**Resultado:**
```json
[
  { "_id": "Eletrônicos", "precoMedio": 1050 },
  { "_id": "Móveis", "precoMedio": 150 }
]
```

### 5. **Usando `$project` para Reformatação**
Podemos usar o estágio `$project` para formatar os dados e escolher os campos que desejamos no resultado:

```js
db.vendas.aggregate([
  {
    $project: {
      produto: 1,
      precoTotal: { $multiply: ["$preco", "$quantidade"] }
    }
  }
])
```
Aqui, estamos criando um novo campo chamado `precoTotal`, multiplicando `preco` por `quantidade`.

---

## Agregação com Documentos Relacionados

### 1. **Coleção de Produtos:**
```js
db.produtos.insertMany([
  { "_id": 1, "nome": "Laptop", "categoria": "Eletrônicos", "preco": 2000 },
  { "_id": 2, "nome": "Cadeira", "categoria": "Móveis", "preco": 150 }
])
```

### 2. **Coleção de Vendas:**
```js
db.vendas.insertMany([
  { "produtoId": 1, "quantidade": 3, "dataVenda": "2024-08-01" },
  { "produtoId": 2, "quantidade": 2, "dataVenda": "2024-08-02" }
])
```

### 3. **Relacionando Produtos e Vendas com `$lookup`:**
```js
db.vendas.aggregate([
  {
    $lookup: {
      from: "produtos",
      localField: "produtoId",
      foreignField: "_id",
      as: "produtoDetalhes"
    }
  },
  { $unwind: "$produtoDetalhes" },
  {
    $group: {
      _id: "$produtoDetalhes.categoria",
      totalVendas: { $sum: { $multiply: ["$produtoDetalhes.preco", "$quantidade"] } }
    }
  }
])
```

**Resultado:**
```json
[
  { "_id": "Eletrônicos", "totalVendas": 6000 },
  { "_id": "Móveis", "totalVendas": 300 }
]
```

Este exemplo mostra como podemos fazer um "join" entre coleções e depois aplicar agregações para calcular os valores desejados.

