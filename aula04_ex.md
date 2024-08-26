## Exercícios de Consultas no MongoDB

## Coleção de Exemplo: `pessoas`

A coleção `pessoas` contém documentos que incluem os campos `name`, `age`, `status`, `email`, e `address`. 

### **Coleção:**

```json
[
  {
    "name": "John Doe",
    "age": 34,
    "status": "active",
    "email": "john.doe@company.com",
    "address": "123 Main St"
  },
  {
    "name": "Jane Smith",
    "age": 28,
    "status": "inactive",
    "email": "jane.smith@company.com",
    "address": "456 Oak St"
  },
  {
    "name": "Alice Johnson",
    "age": 45,
    "status": "active",
    "email": "alice.johnson@company.com",
    "address": "789 Pine Ave"
  },
  {
    "name": "Bob Brown",
    "age": 23,
    "status": "active",
    "email": "bob.brown@company.com",
    "address": "101 Maple St"
  },
  {
    "name": "Charlie Davis",
    "age": 30,
    "status": "inactive",
    "email": "charlie.davis@anothercompany.com",
    "address": "202 Elm St"
  },
  {
    "name": "David Wilson",
    "age": 36,
    "status": "active",
    "email": "david.wilson@company.com",
    "address": "303 Birch St"
  },
  {
    "name": "Emma White",
    "age": 29,
    "status": "inactive",
    "email": "emma.white@company.com",
    "address": "404 Cedar St"
  },
  {
    "name": "Frank Harris",
    "age": 32,
    "status": "active",
    "email": "frank.harris@company.com",
    "address": "505 Walnut St"
  },
  {
    "name": "George Clark",
    "age": 27,
    "status": "active",
    "email": "george.clark@company.com",
    "address": "606 Chestnut St"
  },
  {
    "name": "Hannah Martinez",
    "age": 35,
    "status": "inactive",
    "email": "hannah.martinez@company.com",
    "address": "707 Pine St"
  }
]
```

Para inserir esses dados no MongoDB, execute:

```javascript 
use myDatabase;
db.pessoas.insertMany([...documentos aqui...]);
```

### **Exercício 1: Selecionar pessoas ativas**

### **Exercício 2: Selecionar pessoas com idade maior que 30**

### **Exercício 3: Selecionar pessoas cujo nome começa com "J"**

### **Exercício 4: Selecionar pessoas ativas com idade maior que 30**

### **Exercício 5: Selecionar pessoas cuja idade não é 28**

### **Exercício 6: Selecionar pessoas cujo email termina com "company.com"**

### **Exercício 7: Selecionar pessoas cujo nome contém "Smith"**

### **Exercício 8: Selecionar pessoas que têm "Pine" no endereço**

### **Exercício 9: Selecionar pessoas com idade entre 25 e 35 anos**

### **Exercício 10: Selecionar pessoas com status "inactive" ou idade menor que 30**


