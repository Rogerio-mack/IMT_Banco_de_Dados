create database bdalunos;

use bdalunos;

create table tabalunos
(idAluno integer not null, 
cpfAluno char(14) unique not null,
nomeAluno varchar(30) default 'Aluno sem nome', 
primary key (idAluno));

describe tabalunos;

insert into tabalunos (idAluno, cpfAluno)
	values (1, '111.222.333-44');


insert into tabalunos (idAluno, cpfAluno)
	values (1, '222.333.444-55');

--ERROR 1062 (23000): Duplicate entry '1' for key 'tabalunos.PRIMARY'--
--erro por conta da repetição do número 1 dentro do campo idAluno, como idAluno é uma chave primária não pode haver dados repetidos.--


insert into tabalunos (idAluno, cpfAluno)
	values (2, '111.222.333-44');


--ERROR 1062 (23000): Duplicate entry '111.222.333-44' for key 'tabalunos.cpfAluno'--
--erro por conta da repetição do dado '111.222.333-44' dentro do campo cpfAluno, como cpf é categorizado como unique não pode haver dados repetidos.--



insert into tabalunos (idAluno, cpfAluno, nomeAluno)
	values (2, '222.333.444-55', 'PaulodeSouza');

select * from tabalunos;

drop table tabalunos;

create table tabalunos
	(idAluno integer not null,
	cpfAluno char(14) unique not null,
	nomeAluno varchar(30) default 'Aluno sem nome',
	primary key (idAluno, cpfAluno));

describe tabalunos;

insert into tabalunos(idAluno, cpfAluno)
	values (1, '111.222.333-44');

insert into tabalunos(idAluno, cpfAluno)
	values (1, '222.333.444-55');

insert into tabalunos(idAluno, cpfAluno)
	values (2, '222.333.444-55');

--ERROR 1062 (23000): Duplicate entry '222.333.444-55' for key 'tabalunos.cpfAluno'--
--erro por conta da repetição do dado dentro do campo cpfAluno, como cpfAluno é uma chave primária composta não pode haver dados repetidos.--


insert into tabalunos(idAluno, cpfAluno)
	values (2, '111.222.333-44');

--ERROR 1062 (23000): Duplicate entry '111.222.333-44' for key 'tabalunos.cpfAluno'--
--erro por conta da repetição do dado dentro do campo cpfAluno, como cpfAluno é uma chave primária composta não pode haver dados repetidos.--

select * from tabalunos;

drop table tabalunos;

drop database bdalunos;

-- fim da atividade --