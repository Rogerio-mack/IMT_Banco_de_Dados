# SELECT SIMPLES

## 1. Select syntax

https://learn.microsoft.com/en-us/sql/t-sql/queries/select-transact-sql?view=sql-server-ver16Links to an external site. 

## 2. Popule as tabelas

```sql
insert into vendedores (idvendedor, cpf, nome, salariofixo, metavendas, totalvendasrealizadas) values 
(100, '298.876.123.23', 'Paulo Souza', 2440.00, 5000.00, 3400.00),
(200, '333.657.480.78', 'Ana Catarina', 2440.00, 4000.00, 4400.00),
(300, '123.125.824.12', 'Joel Silva', 2440.00, 3000.00, 9400.00),
(400, '879.982.013.90', 'Pedro de Paula', 2440.00, 4300.00, 2600.00),
(500, '268.811.861.06', 'Beatriz Carvalho', 2440.00, 8700.00, 7400.00),
(600, '631.938.066.48', 'Vitória Sandos', 2440.00, 2900.00, 3700.00);

 create table celulares (idvendedor integer not null,
 celular varchar(40) not null,
 primary key(celular),
 foreign key (idvendedor)
 references vendedores(idvendedor));

insert into celulares (idvendedor,celular) values
(100, '11 90976-1234'),
(100, '11 97654-0975'),
(200, '11 99875-1237'),
(200, '11 76542-0962'),
(300, '11 78651-0987'),
(300, '11 75321-6723'),
(400, '11 99876-2739'),
(400, '11 98760-1269'),
(500, '11 76540-0098'),
(500, '11 99977-9944'),
(600, '11 87654-0042'),
(600, '11 99998-0062');
```

## 3. Escrever os comandos SQL para as seguintes consultas:

a) Listar todos os vendedores cadastrados no banco de dados.
b) Listar todos os vendedores cadastrados no banco de dados em ordem alfabética
crescente de nome.
c) Listar todos os vendedores cadastrados no banco de dados em ordem alfabética
decrescente de nome.
d) Listar o nome e as vendas realizadas de todos os vendedores do banco de dados.
e) Listar o nome e as vendas realizadas de todos os vendedores do banco de dados em
ordem decrescente de total de vendas realizadas.
f) Listar o nome, a meta de vendas e as vendas realizadas de todos os vendedores do
banco de dados que ultrapassaram a meta de vendas, em ordem decrescente de total de
vendas realizadas.
g) Listar o nome, a meta de vendas e as vendas realizadas de todos os vendedores do
banco de dados que tiveram as vendas realizadas inferiores ou iguais à meta de vendas,
em ordem decrescente de total de vendas realizadas.
h) Listar a média de vendas realizadas pelos vendedores.
i) Listar a média de vendas realizadas pelos vendedores, com arredondamento de 2 casas
decimais.
j) Listar a diferença entre a meta de vendas e o total de vendas realizadas de cada
vendedor em ordem alfabética de nome.

## 4. Desafio

Qual o percentual de vendedores com meta maior que R$ 4000,00?

 
