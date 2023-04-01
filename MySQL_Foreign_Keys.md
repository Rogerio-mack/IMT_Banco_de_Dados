# FOREIGN KEYS Sintaxe do MySQL

Aqui está a sintaxe básica para definir uma restrição de chave estrangeira na instrução CREATE TABLEor ALTER TABLE:

```
[CONSTRAINT constraint_name]
FOREIGN KEY [foreign_key_name] (column_name, ...)
REFERENCES parent_table(colunm_name,...)
[ON DELETE reference_option]
[ON UPDATE reference_option]

```
Os itens entre `[]` são opcionais. Assim se você omitir o nome da restrição de chave estrangeira ou o nome da chave estrangeira o MySQL irá gerar um nome automaticamente. 

O MySQL tem cinco opções de referência: **CASCADE**, **SET NULL**, **RESTRICT**, NO ACTION e SET DEFAULT.

- *CASCADE*: se uma linha da tabela pai for excluída ou atualizada, os valores das linhas correspondentes na tabela filha serão excluídos ou atualizados automaticamente.
- *SET NULL*: se uma linha da tabela pai for excluída ou atualizada, os valores da coluna (ou colunas) de chave estrangeira na tabela filha serão definidos como NULL.
- *RESTRICT*: se uma linha da tabela pai tiver uma linha correspondente na tabela filha, o MySQL rejeita a exclusão ou atualização de linhas na tabela pai.
- NO ACTION: é o mesmo que RESTRICT.
- SET DEFAULT: é reconhecido pelo analisador MySQL. No entanto, essa ação é rejeitada pelas tabelas InnoDB e NDB.

Na verdade, o MySQL suporta totalmente três ações: RESTRICT, CASCADE e SET NULL.

Se você não especificar a cláusula ON DELETE and ON UPDATE, a ação **padrão é RESTRICT**.

Assim, empregando os valores padrão,

```
FOREIGN KEY (column_name, ...)
REFERENCES parent_table(colunm_name,...)
```

O MySQL gera nomes automáticos para restrição e a chave estrangeira, e restrições de chave do tipo RESTRICT. 
