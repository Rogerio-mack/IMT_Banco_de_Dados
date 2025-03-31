<img src="https://maua.br/images/selo-60-anos-maua.svg" width=300, align="right">
<br>

# Banco de Dados
**TTI102** Prof rogerio.oliveira@maua.br

### Turmas e Horários

Profs: Marco Aurélio (prof. responsável | Teoria), Guardado (Labs), Rogério de Oliveira (Labs)

---

## Lab1 Sistema Gerenciador de Banco de Dados

notes:  [Sistema Gerenciador de Banco de Dados](https://github.com/Rogerio-mack/IMT_Banco_de_Dados/blob/main/Lab1_notes.md)

## Lab2 **Instalação do MySQL**

notes: [MySQL Installer for Windows](https://dev.mysql.com/downloads/installer/)

## Lab3 **Create Table**

notes: [Executing SQL Statements from a Text File](https://dev.mysql.com/doc/refman/8.0/en/mysql-batch-commands.html)

notes:

```
mysql –u root –p –P 3300 –h localhost –D mydatabase

mysql -u root -p mysql

mysql -u root -p < c:/temp/exemplo1.sql

mysql -u root -pmysql < c:/temp/exemplo1.sql

mysql> source c:/temp/exemplo1.sql

mysql> \. c:/temp/exemplo1.sql

mysql -u root -p < c:/temp/exemplo1.sql > c:/temp/output.txt
```

[exemplo1.sql](https://github.com/Rogerio-mack/IMT_Banco_de_Dados/blob/main/exemplo1.sql) [download](https://github.com/Rogerio-mack/IMT_Banco_de_Dados/raw/main/exemplo1.sql) 

[exemplo2.sql](https://github.com/Rogerio-mack/IMT_Banco_de_Dados/blob/main/exemplo2.sql) [download](https://github.com/Rogerio-mack/IMT_Banco_de_Dados/raw/main/exemplo2.sql)

## Lab4 **Create Table (Workbench)**

[Autores-Títulos](https://github.com/Rogerio-mack/IMT_Banco_de_Dados/blob/main/Lab3_2025S1.sql) | 
[Solução](https://github.com/Rogerio-mack/IMT_Banco_de_Dados/blob/main/Exemplos/Autores-Titulos.sql)  

## Lab5 **Create Table (Models e mais...)**

**CREATE FROM MODELS**
> - MySQL
> - File > New Model
> - Add Diagram
> > - Crie seu diagrama
> - Database > Forward Engineer
> - next > ... > execução do script

[Autores-Títulos](https://github.com/Rogerio-mack/IMT_Banco_de_Dados/blob/main/Exemplos/Autores-Titulos.sql)

> CREATE TABLE, Tipos básicos de dados, PRIMARY KEY, FOREIGN KEY, Relacionamento 1-N, AUTO_INCREMENT, INSERT, SELECT *
> > - Lembre-se PRIMARY KEY e FOREIGN KEY precisam ter o mesmo tipo de dados!
> > - **Boas práticas!**: identação, nomes significativos, tipos de dados representativos, upper/lower case, não usar caracteres especiais, acentos ou 'ç' etc.

[Agendamentos-dates](https://github.com/Rogerio-mack/IMT_Banco_de_Dados/blob/main/Exemplos/Agendamentos-dates.sql)

> Tipos DATE e Time, DATEDIFF, ADD_DATE, Select <campo> AS <campo-nome>

[Produtos](https://github.com/Rogerio-mack/IMT_Banco_de_Dados/blob/main/Exemplos/Produtos.sql)

> DROP TABLE [ IF EXISTS ], INSERT, DECIMAL, BOOLEAN e as restrições NULL, NOT NULL e DEFAULT. 

[Pais-Cidade](https://github.com/Rogerio-mack/IMT_Banco_de_Dados/blob/main/Exemplos/Pais-Cidade.sql)

> PRIMARY KEY, FOREIGN KEY, **RELACIONAMENTO 1-N**, declaração na linha e posterior, nomeando CONSTRAINTs, UNIQUE 
> > - Não se preocupe com o JOIN, é apresentado somente para ilustrar o uso.
> > - **ON DELETE CASCADE** | **ON DELETE SET NULL** | **ON DELETE RESTRICT** (\*)
> > - **ON UPDATE CASCADE** | **ON UPDATE SET NULL**
> > - Exemplo adicional: [Departamento-Funcionario](https://github.com/Rogerio-mack/IMT_Banco_de_Dados/blob/main/Exemplos/Departamento-Funcionario.sql)

[Aluno-Curso](https://github.com/Rogerio-mack/IMT_Banco_de_Dados/blob/main/Exemplos/Aluno-Curso.sql)

> PRIMARY KEY composta, FOREIGN KEY, **RELACIONAMENTO N-N**, **Tabela/Relação Associativa** 
> > - Não se preocupe com o JOIN, é apresentado somente para ilustrar o uso.
> > - Exemplo adicional: [Medico-Paciente](https://github.com/Rogerio-mack/IMT_Banco_de_Dados/blob/main/Exemplos/Medico-Paciente.sql), **Atributo Associativo** 

[Produtos_ALTER](https://github.com/Rogerio-mack/IMT_Banco_de_Dados/blob/main/Exemplos/Produtos_ALTER.sql)

> ALTER TABLE ADD, MODIFY, DROP, COLUMN, CONSTRAINT
> > - Exemplo adicional: [Pais-Cidade_ALTER](https://github.com/Rogerio-mack/IMT_Banco_de_Dados/blob/main/Exemplos/Pais-Cidade_ALTER.sql)
 
## Lab6 **Atividades de Entrega e Revisão para P1**

#### Atividade 1 (iniciar em Lab)

* [Exercicio_Schema_Musicas](https://github.com/Rogerio-mack/IMT_Banco_de_Dados/blob/main/Exercicio_Schema_Musicas.md)

* [Exercicio_Schema_Internacoes](https://github.com/Rogerio-mack/IMT_Banco_de_Dados/blob/main/Exercicio_Schema_Internacoes.md)

> [Tutorial Prático de SQL](https://www.w3schools.com/sql/)

#### Atividade 2 (home)

* [Exercicio_Schema_Site](https://github.com/Rogerio-mack/IMT_Banco_de_Dados/blob/main/Exercicio_Schema_Site.md)

### Questões de revisão para P1

> 1. O que é cardinalidade de um relacionamento? Dê exemplos de cardinalidade que são tipicamente de relacionamento 1-N e N-M.
> 2. O que é restrição de participação em um relacionamento? 
<!-- (obrigatória, opcional, total ou parcial) -->
> 3. [Diagramas One, Many, One and onlue one, Zero or one, One or many, Zero or many](https://github.com/Rogerio-mack/IMT_Banco_de_Dados/blob/main/Figuras/relacionamentos_figs.png)
> 4. ACID, o que são cada uma dessas propriedades?
<!-- (consistência, operações não deixa o banco em um estado inconsistente, pense as integridades referenciais) -->
> 5. Chaves superchave, chave candidata e primária? Estrangeira? 
> 6. Qual o conceito de Entidade Fraca? Dê um exemplo. [SQL: Cliente-Dependente FRACA](https://github.com/Rogerio-mack/IMT_Banco_de_Dados/blob/main/cliente-dependente-FRACA.sql)
<!-- (entidade fraca não tem existência própria, depende de outra entidade, por exemplo DEPENDENTE depende de FUNCIONARIO, possui uma chave 
composta com FK em FUNCIONARIO e é representada por um retângulo duplo) -->
> 7. Dê exemplos de restrição de DOMÍNIO.
<!-- (valores possíveis de um atributo) -->
> 8. Dê um exemplo de generalização-especialização em um modelo de banco de dados. [SQL: Func-Prof-Adm HERANÇA](https://github.com/Rogerio-mack/IMT_Banco_de_Dados/blob/main/Func-Prof-Adm-HERANCA.sql)
<!-- (FUNCIONARIO> PROFESSOR | ADMNISTRATIVO, CLIENTE> PF | PJ, o postgres implementa superclasse) -->

> *Note que há outros temas como SGBD, SQL e criação de tabelas (CREATE TABLE), informação e conhecimento etc. mas aqui você encontra alguns temas mais técnicos, sem prática de lab e que merecem sua atenção. **Veja também os scripts exemplos do Lab anterior.***


