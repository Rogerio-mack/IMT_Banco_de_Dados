MATCH (n)
DETACH DELETE n

// Criação dos nós com datas de nascimento
CREATE 
  (pessoa1:Pessoa {nome: 'João', nascimento: datetime('2000-01-15T12:00:00Z')}),
  (pessoa2:Pessoa {nome: 'Maria', nascimento: datetime('1995-10-25T09:30:00Z')});

// Seleciona nascido no mês 10
MATCH (p:Pessoa)
WHERE toInteger(substring(toString(p.nascimento), 5, 2)) = 10
RETURN p.nome, p.nascimento;
