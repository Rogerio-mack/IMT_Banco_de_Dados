# Gabarito/Correção P1

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

a1) adicionando uma nova matricula - Para incluir uma nova matrícula para um determinado curso a instrução seria:

```javascript
db.curso.updateOne({codigo:"SQLAVN"}, 
{$push: {"matriculas": {$each: [ {num_matr: 663, aluno: 2, data_hora: new Date(),
                              turma: 10, data_ini_turma : ISODate("2024-09-01T19:00:00.000Z"),
                              aproveitamento_final: null , freq_final: null } } } } ] )

db.curso.find({codigo:"SQLAVN"})
```

a2) atualizando uma matricula  - A instrução a seguir : (alternativas do que faz)

```javascript
db.curso.updateOne({codigo:"SQLAVN", "matriculas.num_matr" : 663} , 
{$set: {"matriculas.$.num_matr": 665 , "matriculas.$.turma": 11 } } )
```

a3) excluindo um fone - A instrução a seguir : (alternativas do que faz)

```javascript
db.aluno.updateOne({ra: 3 } , {$pull: { "fones" : {ddd:11, numero: 996500033} } } )
db.aluno.find({ra: 3 })
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

b1) Mostre os alunos que tem cpf cadastrado e residem em São Paulo ou Minas Gerais 

```javascript
db.aluno.find({$and: [{"cpf" : {$exists:true}} , 
                     {$or: [{endereco: /s.*o paulo/i }, {endereco: /minas gerais/i }] } ] }, 
            {nome: 1, cpf: 1, endereco: 1})
```          

b2) Mostre os cursos "basicos", com carga horaria entre 30 e 40 horas que não tem nos tópicos a palavra controle

```javascript
db.curso.find({$and: [{nome: /b.*sico/i} ,  {carga_horaria: {$gte:30}}, {carga_horaria: {$lte:40}},
                      {"topicos": {$not: /controle/i}} ] },
{_id:0 , nome: 1, carga_horaria: 1, "topicos": 1 } )
``` 

b3) Mostre os cursos com valor entre R$ 500 e 1000 que tem como topicos as palavras "dado" ou "estrutura" e não terminaram ainda

```javascript
db.curso.find( {$and: [ {valor: {$gte:500}} , {valor: {$lte:1000} } ,
                        {$or: [{"topicos": /dado/i}, {"topicos": /estrutura/i} ] } ,
                        {$or: [{"matriculas.data_fim_turma": {$eq: null } }, 
                               {"matriculas.data_fim_turma": {$exists: false} } ] } ] } ,   
                {"_id":0, nome: 1, valor: 1, topicos: 1 , "matriculas.data_fim_turma": 1} )
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

c1) Mostre uma lista dos alunos matriculados em cursos de Python no seguinte formato: 

**Nome curso – Carga Horária – Numero Matricula – Turma - Nome Aluno – Data Inicio Turma**        

```javascript
db.curso.aggregate([
        {$match : {nome : /python/i }} ,
 { $lookup :
      { from: "aluno",
        localField : "matriculas.aluno",
        foreignField : "ra",
        as : "matriculados" }  },
//	{$unwind:"$matriculados"},
    {$project :{nome: 1, carga_horaria : 1, "matriculas.num_matr":1, "matriculas.aluno": 1,
                "matriculas.turma": 1, "matriculas.data_ini_turma": 1,  _id:0,
                "matriculados.ra" : 1, "matriculados.nome" : 1 } }])
``` 

c2) Mostre para cada aluno os cursos que fizeram ou estão fazendo -- rever aparecem outros alunos nas matriculas vetor 

```javascript
db.aluno.aggregate([
    { $lookup :
      { from: "curso",
        localField : "ra" ,
        foreignField : "matriculas.aluno",
        as : "cursos_matriculados" }  },
    {$unwind:"$cursos_matriculados"},
    {$unwind:"$cursos_matriculados.matriculas"},
   // {$match: {$expr: {$eq: ["ra", "$cursos_matriculados.matriculas.aluno"] } } }
    {$project :{ra: 1 , nome: 1, sexo: 1 , endereco: 1, 
       "cursos_matriculados.nome" : 1 , _id:0,  "cursos_matriculados.matriculas.aluno" : 1 ,
       "cursos_matriculados.matriculas.aproveitamento_final" : 1 } } ]  ) 
   // {$unwind:"$cursos_matriculados.matriculas"},
``` 

c3) Mostre os alunos com idade entre 25 e 35 anos que tiveram aproveitamento final inferior a 65 (vai de 0 a 100%) para cursos com valor superior a R$ 800. 
Mostre o curso e o aproveitamento

```javascript
db.curso.aggregate([
    {$unwind: "$matriculas" }, 
    {$match : {valor : {$gte: 800}, "matriculas.aproveitamento_final" : {$lt : 65} }} ,
    { $lookup :
      { from: "aluno",
        localField : "matriculas.aluno",
        foreignField : "ra",
        as : "matriculados" }  },
	{$unwind:"$matriculados"},
	{$project :{ nome: 1, carga_horaria : 1, "matriculas.num_matr":1, "matriculas.turma": 1, 
	            "matriculas.data_ini_turma": 1,  _id: 0, "matriculados.nome" : 1,
	             "matriculas.aproveitamento_final" : 1 , 
                        anonascto: {$year: "$matriculados.data_nascto"} } },
    {$match : {anonascto: {$gte: 1989}, anonascto: {$lte: 1999}}}   ]   ) 
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

d1) Mostre uma lista com os cursos que não são de Python com carga horária entre 30 e 40 horas que já iniciaram mas ainda não terminaram, e com valor total das matrículas superior a R$ 5 mil:

**Nome Curso – Qtde alunos Matriculados - Valor Total Matriculas**

```javascript
db.curso.aggregate([
    {$match : {nome : {$not: /python/i}, carga_horaria : {$gte: 30}, carga_horaria : {$lte: 40},
              data_fim_turma : null  }} ,
    {$unwind : "$matriculas" },
    {$group: { _id: {curso: "$nome" },
                qtde_matriculados : {$count: {} } ,
                valor_total_matr : {$sum: "$valor"} } }, 
    {$match: {valor_total_matr: {$gte: 4500}}  } ]  )
``` 
          
d2) Mostre para cada aluno qtos cursos se matriculou e o valor total investido na sua capacitação, ordenado pelo valor do investimento.

```javascript
db.aluno.aggregate([
  { $lookup :
      { from: "curso",
        localField : "ra" ,
        foreignField : "matriculas.aluno",
        as : "cursos_matriculados" }  },
  {$unwind:"$cursos_matriculados"}, 
	  {$group: { _id: {aluno: "$nome" },
                qtde_cursos : {$count: {} } ,
                valor_total_investido : {$sum: "$cursos_matriculados.valor"} } }, 
      {$sort: {valor_total_investido: -1 } } ] )
```


