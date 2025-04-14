create database alunos;
use alunos;

create table alunos(id_aluno integer not null,
nome varchar(50) not null,
idade decimal(2),
sexo char(1),
primary key(id_aluno));

insert into alunos(id_aluno, nome, idade, sexo) values
(100, 'Daniel Francisconi', 28, 'M'),
(200, 'Anna Paula', 22, 'F'),
(300, 'Rodrigo Peres', 21, 'M'),
(400, 'Henrique de Oliveira', 19, 'M'),
(700, 'Alváro de Campos', 19, 'M'),
(500, 'Beatriz Carvalho', 19, 'F'),
(600, 'Vitória Sandos', 18, 'F');

select * from alunos;

-- selecionando atributos
select nome, idade from alunos;

-- order by
select nome, idade from alunos order by nome;
select nome, idade from alunos order by 2;
select nome, idade from alunos order by idade desc;

-- cláusula where
select nome, idade
from alunos
where idade > 20;

-- select distinct
select idade, sexo
from alunos
where idade < 20;
select distinct idade, sexo
from alunos
where idade < 20;

-- LIMITE
select * from alunos limit 4;
-- renomeando atributos
select nome as 'aluno', sexo as 'genêro'
from alunos;

-- atributos derivados
select nome, 2024 - idade as 'ano de nascimento'
from alunos;

select substr(nome,1,locate(' ',nome)) as 'primeiro nome', 2024 - idade as
'ano de nascimento'
from alunos;

select substr(nome,1,locate(' ',nome)) as 'primeiro nome',
case when sexo = 'M' then 'Masculino'
when sexo is null then 'Não informado'
else 'Feminino'
end as 'Gênero'
from alunos;

select substr(nome,1,locate(' ',nome)) as 'primeiro nome',
case when sexo = 'M' then 'Masculino'
when sexo is null then 'Não informado'
else 'Feminino'
end as 'genêro'
from alunos;

-- várias cláusulas
select nome, round(idade/100,2) as 'fração' , 2024 - idade as 'ano de nascimento'
from alunos
where idade > 20
order by nome;

-- agregação total
select avg(idade) from alunos;
select count(idade) from alunos;
select sum(idade) from alunos;
select min(idade) from alunos;

select 'Idade máxima é ' as '', max(idade) as 'idade' from alunos
where sexo = 'F';

-- Atenção: não faz sentido, Error Code: 1140. In aggregated query without
-- GROUP BY...
-- select nome, avg(idade) from alunos;
-- vários

-- select nome, avg(idade) from alunos;

-- exemplo final
select nome, ' é do sexo ', sexo, ' e nasceu em ' idade, 2024 - idade as
'ano de nascimento'
from alunos
where idade > 20
order by 3 desc;
