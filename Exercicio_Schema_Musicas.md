# Schema Music

Crie e popule o seguinte esquema de banco de dados

### **Modelo E/R** (\*)
> * **Artista**(**id**, nome, tipo, genero, pais_origem, ano_formacao, web_page)
> * **Album**(**id**, titulo, data_lancamento, genero)
> * **Faixa**(**id**, titulo, duracao, compositor, lancamento_single)

>> (\*) *não são representadas aqui as chaves estrangeiras. Elas serão serão definidas por você nos relacionamentos que forem criados e devem ser criadas no formato `<tabela-pai>_<pk>`.*

Neste esquema de banco de dados os campos **`id`** são chave e em cada entidade são incrementados automaticamente a cada nova inclusão. 
O nome do artista contém o nome de uma 'Banda', 'Solista' ou 'Duo', que são os únicos tipos permitidos de artistas. 
Os genêros de artista e dos álbuns também são restritos a 'Rock', 'Jazz', 'Pop', 'Classical', 'Hip Hop', 'Electronic'. A `web_page` é a url do artista
e deve ser única na base de dados. A duração da faixa é no formato hh:mm:ss e o compositor o nome de um compositor que pode não ser um artista da base.
Cada álbum pertence a um único artista que pode ter vários álbuns, assim como cada faixa pertence a um único álbum, embora possam existir 
faixas 'single' que não irão pertencer a nenhum álbum. Essas faixas são indicadas pelo valor TRUE em `lancamento_single`. `web_page` e `compositor` pode admitir ausência de valores.
Além disso no caso de exclusão ou atualização de um álbum deve refletir a mesma alteração nas faixas do álbum, mas alterção ou mudanças nos artistas devem ser restritas.
Artistas podem ainda não ter álbuns lançados, mas álbuns lançados sem terão suas faixas correspondentes. As chaves estrangeiras devem ser criadas no formato `<tabela-pai>_<pk>`.

Crie o modelo acima a partir do MySQL Workbench e **popule seu banco de dados com dados de artistas reais** (mínimo 10 músicas e 3 artistas).

### **Entrega**

Poste os seguintes arquivos separados (não zipados!) e com as extensões corretas:

1. Export .PNG do modelo
2. Script .SQL com a criação do modelo e o insert dos dados
3. Saída .txt da seguinte consulta,

```sql
SELECT a.nome AS artista, ab.titulo AS album, t.titulo AS trilha
FROM Artista a
JOIN Album ab ON a.id = ab.artista_id
JOIN Trilha t ON ab.id = t.album_id;
```
