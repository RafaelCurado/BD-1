# Lab05

## Grupo - **P2G2**

| Membros | Número Mecanográfico |
| :- | :-: |
| David Araújo | 93444 |
| Miguel Nogueira | 93082 |

## Exercicio 1

### a)
>π project.Pname, project.Pnumber, project.Plocation, project.Dnum, employee.Fname, employee.Lname, employee.Ssn works_on ⨝ Pno = Pnumber project ⨝ Ssn = Essn employee

```` SQL
SELECT project.*, employee.Fname, employee.Lname, employee.Ssn
FROM works_on
INNER JOIN project on Pno=Pnumber
INNER JOIN employee on Ssn=Essn
````

![ex1_a](ex1_a.png)

<div style="page-break-after: always;"></div>

### b)

> π a.Fname, a.Minit, a.Lname, a.Ssn, a.Bdate, a.Address, a.Sex, a.Salary, a.Super_ssn, a.Dno ρ a employee ⨝ b.Ssn = a.Super_ssn ρ b π b.Ssn σ b.Fname = 'Carlos' and b.Lname = 'Gomes' ρ b employee

```` SQL
SELECT a.*
FROM employee AS a
INNER JOIN (
    SELECT b.Ssn
    FROM employee as b
    WHERE b.Fname='Carlos' AND b.Lname='Gomes')
AS b
ON b.Ssn = a.Super_ssn;
````

![ex1_b](ex1_b.png)

<div style="page-break-after: always;"></div>

### c)

>π project.Pname, a.Total project ⨝ a.Pno = Pnumber ρ a π Pno, Total γ Pno; SUM(Hours)→Total works_on
````SQL
SELECT project.Pname, a.Total
FROM project
INNER JOIN (
    SELECT Pno, SUM(Hours) AS Total
    FROM works_on
    GROUP BY Pno)
AS a
ON (a.Pno=Pnumber);
````

![ex1_c](ex1_c.png)

<div style="page-break-after: always;"></div>

### d)

>π Fname, Minit, Lname employee ⨝ employee.Ssn = a.Essn ρ a π Essn works_on ⨝ works_on.Hours > 20 ρ b π Pnumber σ Pname = 'Aveiro Digital' project
````SQL
SELECT Fname, Minit, Lname
FROM employee
INNER JOIN (
    SELECT Essn
    FROM works_on
    INNER JOIN (
        SELECT Pnumber
        FROM project
        WHERE Pname='Aveiro Digital')
    AS b
    ON works_on.Hours > 20)
AS a
ON employee.Ssn = a.Essn
````

![ex1_d](ex1_d.png)

<div style="page-break-after: always;"></div>
