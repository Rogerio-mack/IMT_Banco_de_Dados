MATCH (n)
DETACH DELETE n

// Criação dos nós com datas de nascimento
CREATE 
  (pessoa1:Pessoa {nome: 'João', nascimento: localdatetime("2015-07-21T21:40:32.142")}),
  (pessoa2:Pessoa {nome: 'Maria', nascimento: nascimento: localdatetime("2012-10-21T21:40:32.142")});

// Seleciona nascido no mês 10
MATCH (p:Pessoa)
WHERE toInteger(substring(toString(p.nascimento), 5, 2)) = 10
RETURN p.nome, p.nascimento;
