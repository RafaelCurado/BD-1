# Lab05

## Grupo - **P2G2**

| Membros | Número Mecanográfico |
| :- | :-: |
| Miguel Nogueira | 93082 |

## Exercicio 1

### a)

```` SQL
SELECT project.*, employee.Fname, employee.Lname, employee.Ssn FROM  works_on
INNER JOIN project on Pno=Pnumber
INNER JOIN employee on Ssn=Essn
ORDER BY project.Pname;
````
![ex1_a](ex1_a.png)

### b)