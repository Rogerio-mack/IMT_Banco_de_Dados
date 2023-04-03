
create table FUNCIONARIO_PROJETO 
	(idFunc integer not null, 
	idProjeto integer not null, 
	funcaoProj varchar(50) not null, 
	dataInicio date not null, 
primary key(idProjeto, idFunc,dataInicio), 
foreign key(idFunc) references Funcionarios(idFunc) 
on delete cascade on update cascade, 
foreign key(idProjeto) references Projetos(idProjeto) 
on delete cascade on update cascade);

