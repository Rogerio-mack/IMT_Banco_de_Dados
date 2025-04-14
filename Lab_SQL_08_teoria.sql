drop database alunos;
create database alunos;
use alunos;

create table alunos(id_aluno integer not null,
nome varchar(50) not null,
idade decimal(2),
sexo char(1),
apelido char(10),
primary key(id_aluno));

insert into alunos(id_aluno, nome, idade, sexo, apelido) values
(100, 'Daniel Francisconi', 28, 'M', 'Dan'),
(200, 'Anna Paula', 22, 'F', 'Aninha'),
(300, 'Rodrigo Peres', 21, 'M', 'Digo'),
(400, 'Henrique de Oliveira', 19, 'M', 'Ite'),
(700, 'Alváro de Campos', 19, 'M', null),
(500, 'Beatriz Carvalho', 19, 'F','Bia'),
(600, 'Vitória Sandos', 18, null, null);
insert into alunos(id_aluno, nome, idade, sexo, apelido) values
(1400, 'Henrique Campos', 19, 'M', null),
(2500, 'Beatriz de Almeida', 19, 'F', 'Bia'),
(1100, 'Vitória Oliveira', 18, null, 'Vic');

-- is null
select id_aluno, nome from alunos
where apelido is null;
select id_aluno, nome from alunos
where apelido is not null;

-- between
select id_aluno, nome, idade from alunos /* mais eficiente */
where idade between 18 and 19;
select id_aluno, nome, idade from alunos
where idade >= 18 and idade <= 19;

-- like
select id_aluno, nome, idade from alunos
where nome like 'Beat%';

select id_aluno, nome, idade from alunos
where nome like '%Campos%';

-- like 2
select id_aluno, nome, idade from alunos
where nome like '_eat%';

select id_aluno, nome, idade from alunos
where nome not like '%Campos%';

-- Regular Expression*
select id_aluno, nome, idade from alunos
where nome REGEXP '^[ah]'; -- todos nomes que iniciam com 'a' ou 'h'

select id_aluno, nome, idade from alunos
where nome REGEXP '[ah].[n]'; -- todos nomes que iniciam com 'a' ou 'h' e têm 1
caracter seguido de 'n'

-- limit
select id_aluno, nome, idade from alunos limit 2;

-- /* Qual a maior idade dos alunos */
select max(idade) from alunos;

-- /* Quais os dois alunos mais velhos? */
select id_aluno, nome, idade from alunos
order by idade desc limit 2;

-- /* Qual o aluno mais velhos? */
select id_aluno, nome, idade from alunos
order by idade desc limit 1;

-- /* Quais todos alunos tem a idade máxima */
select id_aluno, nome, idade from alunos
where idade = (select max(idade) from alunos);

-- IN
select id_aluno, nome, idade from alunos
where idade in (18, 19);

-- distinct
select distinct apelido from alunos
where idade = 19 and apelido is not null;
