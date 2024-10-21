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

// Calculando a diferença de datas de nascimento entre Maria e João...
MATCH (p1:Pessoa {nome: 'Maria'}), (p2:Pessoa {nome: 'João'})
RETURN p1.nome AS Pessoa1, p1.nascimento AS DataNascimento1,
       p2.nome AS Pessoa2, p2.nascimento AS DataNascimento2,
       duration.between(p1.nascimento, p2.nascimento) AS Diferenca
//... mas a diferença vem como 'P4Y2M21DT2H30M'!!!

// Calculando a diferença de anos, meses e dias
MATCH (p1:Pessoa {nome: 'Maria'}), (p2:Pessoa {nome: 'João'})
RETURN p1.nome AS Pessoa1, p1.nascimento AS DataNascimento1,
       p2.nome AS Pessoa2, p2.nascimento AS DataNascimento2,
       duration.between(p1.nascimento, p2.nascimento).years AS AnosDiferenca,
       duration.between(p1.nascimento, p2.nascimento).months AS MesesDiferenca,
       duration.between(p1.nascimento, p2.nascimento).days AS DiasDiferenca
//... agora a diferença em anos, meses e dia,... 4 anos, 50 meses, mas 21 dias

