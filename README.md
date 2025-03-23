<img src="https://maua.br/images/selo-60-anos-maua.svg" width=300, align="right">
<br>

# Banco de Dados
**TTI102** Prof rogerio.oliveira@maua.br

### Turmas e Horários

Profs: Marco Aurélio (prof. responsável | Teoria), Guardado (Labs), Rogério de Oliveira (Labs)

---

Lab1 Sistema Gerenciador de Banco de Dados

notes:  [Sistema Gerenciador de Banco de Dados](https://github.com/Rogerio-mack/IMT_Banco_de_Dados/blob/main/Lab1_notes.md)

Lab2 **Instalação do MySQL**

notes: [MySQL Installer for Windows](https://dev.mysql.com/downloads/installer/)

Lab3 **Create Table**

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

Lab4 **Create Table (Workbench)**

[Autores-Títulos](https://github.com/Rogerio-mack/IMT_Banco_de_Dados/blob/main/Lab3_2025S1.sql)

Lab5 **Create Table (Models e mais...)**

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
