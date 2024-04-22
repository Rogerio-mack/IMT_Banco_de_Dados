
$$ \sigma_{idade > 10}(Alunos) $$
```
select * from alunos where idade > 10;
```

$$ \Pi_{\text{nome, idade, sexo}}(Alunos) $$
```
select nome, idade, sexo from alunos;
```

$$ \Pi_{\text{nome, idade, sexo}}( \sigma_{idade > 10}(Alunos) ) $$
```
select nome, idade, sexo from alunos where idade > 10;
```

```
Isso ok,

```

$$ \sigma_{idade > 10}( \Pi_{\text{nome, sexo, idade}}(Alunos) ) $$

```
Isso nok 
```

$$ \Pi_{\text{nome, sexo}}(\sigma_{idade > 10}(Alunos) ) $$



```
Mas isso nok 
```

$$ \sigma_{idade > 10}( \Pi_{\text{nome, sexo}}(Alunos) ) $$


```
select nome, idade, sexo from alunos where idade > 10;
```
