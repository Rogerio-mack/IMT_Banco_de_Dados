## Exercícios: Import de Dados e Agregações no MongoDB

**Exercício 1:**  
Implemente o comando para importar o arquivo 'tracks_df.csv' para uma coleção chamada `Tracks_csv` em seu MongoDB.

**Exercício 2:**  
Implemente o comando para importar o arquivo 'tracks.json' para uma coleção chamada `Tracks_Artist` em seu MongoDB.

**Exercício 3:**  
Dada a coleção `produtos` com os seguintes documentos:

```json
[
  { "nome": "Laptop", "preco": 2000, "categoria": "Eletrônicos", "estoque": 10 },
  { "nome": "Cadeira", "preco": 150, "categoria": "Móveis", "estoque": 20 },
  { "nome": "Mesa", "preco": 500, "categoria": "Móveis", "estoque": 5 },
  { "nome": "Celular", "preco": 1500, "categoria": "Eletrônicos", "estoque": 8 },
  { "nome": "Caneta", "preco": 5, "categoria": "Papelaria", "estoque": 100 }
]
```

Crie uma agregação que calcule o valor total em estoque para cada categoria de produtos. Ou seja, multiplique o preço pelo estoque e agrupe os valores por categoria.

---

**Exercício 4:**  
Ainda usando a coleção `produtos`, crie uma agregação que retorne o preço médio dos produtos por categoria.

---

**Exercício 5:**  
Dada a seguinte coleção `vendas`:

```json
[
  { "produtoId": 1, "quantidade": 3, "dataVenda": "2024-08-01" },
  { "produtoId": 2, "quantidade": 2, "dataVenda": "2024-08-02" },
  { "produtoId": 3, "quantidade": 1, "dataVenda": "2024-08-03" },
  { "produtoId": 1, "quantidade": 4, "dataVenda": "2024-08-04" },
  { "produtoId": 4, "quantidade": 5, "dataVenda": "2024-08-05" }
]
```

Crie uma agregação que retorne o total de vendas (quantidade) por produto.

---

**Exercício 6:**  
Dada a mesma coleção `vendas`, crie uma agregação que retorne a quantidade total vendida por dia, ordenando os resultados pela data de venda.

---

---

## Respostas  

**Exercício 1 - Solução:**

Para importar o arquivo CSV `tracks_df.csv` para a coleção `Tracks_csv`, o comando é:

```bash
mongoimport --db mydb --collection Tracks_csv --type csv --headerline --file /path/tracks_df.csv
```

O parâmetro `--headerline` informa que a primeira linha do arquivo CSV contém os nomes dos campos.

---

**Exercício 2 - Solução:**

Para importar o arquivo JSON `tracks.json` para a coleção `Tracks_Artist`, o comando é:

```bash
mongoimport --db mydb --collection Tracks_Artist --file /path/tracks.json --jsonArray
```

O parâmetro `--jsonArray` é necessário para indicar que o arquivo contém um array de documentos JSON. E talvez você tenha que editar o arquivo fazendo algum ajuste.

---

**Exercício 3 - Solução:**

A agregação que calcula o valor total em estoque por categoria:

```js
db.produtos.aggregate([
  {
    $group: {
      _id: "$categoria",
      valorTotalEstoque: { $sum: { $multiply: ["$preco", "$estoque"] } }
    }
  }
])
```

O estágio `$group` agrupa os documentos por `categoria`. 
O campo `valorTotalEstoque` é calculado multiplicando o preço pelo estoque para cada documento e somando esses valores para cada categoria.

---

**Exercício 4 - Solução:**

A agregação que calcula o preço médio por categoria:

```js
db.produtos.aggregate([
  {
    $group: {
      _id: "$categoria",
      precoMedio: { $avg: "$preco" }
    }
  }
])
```

O estágio `$group` agrupa os documentos por `categoria`, e o campo `precoMedio` é calculado utilizando o operador `$avg` para obter a média dos preços de cada categoria.

---

**Exercício 5 - Solução:**

A agregação que calcula o total de vendas por produto:

```js
db.vendas.aggregate([
  {
    $group: {
      _id: "$produtoId",
      totalVendas: { $sum: "$quantidade" }
    }
  }
])
```

A agregação agrupa os documentos por `produtoId` e calcula o total de vendas somando a quantidade vendida para cada produto.

---

**Exercício 6 - Solução:**

A agregação que calcula o total de vendas por dia:

```js
db.vendas.aggregate([
  {
    $group: {
      _id: "$dataVenda",
      totalVendido: { $sum: "$quantidade" }
    }
  },
  {
    $sort: { _id: 1 }
  }
])
```

Primeiro, agrupamos os documentos por `dataVenda` e calculamos o total vendido em cada dia. Depois, usamos `$sort` para ordenar os resultados pela data de venda.
