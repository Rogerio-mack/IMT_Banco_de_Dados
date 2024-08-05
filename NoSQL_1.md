# Bancos de Dados Não Relacionais

## 1. **Apresentação**
- Apresentação do curso e seus objetivos.
- Importância dos bancos de dados não relacionais no contexto atual.  
- Overview das aulas e tópicos que serão abordados.

## 2. **Revisão Rápida de Bancos de Dados Relacionais**
   - Breve revisão dos conceitos principais de bancos de dados relacionais (tabelas, SQL, ACID).
   - Exemplos de sistemas de gerenciamento de banco de dados relacionais (MySQL, PostgreSQL, Oracle).

## 3. **Limitações dos Bancos de Dados Relacionais**
O foco desses sistemas é o de transações, tipicamente operações que envolvem poucos dados.
   - **Escalabilidade**
     - Dificuldades em escalar horizontalmente (sharding).
     - Limitações em ambientes de Big Data.
   - **Flexibilidade**
     - Rigidez do esquema e necessidade de pré-definição do esquema.
     - Dificuldades em adaptar-se a mudanças nos requisitos dos dados.
   - **Performance**
     - Desempenho em operações de leitura e escrita intensivas.
     - Ineficiência em consultas complexas envolvendo grandes volumes de dados.
   - **Modelo de Dados**
     - Não é ideal para todos os tipos de dados (ex. dados semi-estruturados ou não estruturados, como JSON, XML).
   - **Complexidade em Dados Distribuídos**
     - Gerenciamento complexo de dados em sistemas distribuídos.
     - Problemas com consistência e disponibilidade (CAP Theorem).

> **Bancos de dados objeto-relacionais (ODBR)**
> São sistemas de gerenciamento de banco de dados que combinam recursos relacionais com características de bancos de dados orientados a objetos que incluem:
> - Tipos de dados abstratos (tipos de dados definidos pelo usuário, permitindo a criação de objetos complexos com atributos e métodos).
> - Herança (hierarquias de classes).
> - Encapsulamento
> - Polimorfismo
> - Linguagem de consulta orientada a objetos (além do SQL tradicional, OQL, Object Query Language).
> Alguns desses sistemas são:
> - Oracle Database (com recursos orientados a objetos)
> - IBM DB2 (com extensões orientadas a objetos)
> - PostgreSQL (com tipos de dados abstratos e linguagem de consulta orientada a objetos)

## 4. **Casos de Uso e Exemplos Reais**
   - Discussão: que casos de uso os bancos de dados relacionais não são ideais?

## 5. **Introdução aos Bancos de Dados Não Relacionais**
   - Conceitos básicos.
   - Diferentes tipos de bancos de dados não relacionais:
     - **Document-based (ex. MongoDB)**
     - **Key-Value (ex. Redis)**
     - **Columnar (ex. Cassandra)**
     - **Graph-based (ex. Neo4j)**
## 6. **Vantagens dos Bancos de Dados Não Relacionais**
   - **Escalabilidade Horizontal**
     - Facilidade em escalar adicionando mais nós ao cluster.
   - **Flexibilidade do Esquema**
     - Esquema dinâmico e adaptável às mudanças nos dados.
   - **Performance**
     - Otimizado para operações específicas (leitura intensiva, escrita intensiva).
   - **Modelo de Dados Adequado**
     - Suporte a dados semi-estruturados e não estruturados.
   - **Gerenciamento de Dados Distribuídos**
     - Soluções mais adequadas para ambientes distribuídos e Big Data.


