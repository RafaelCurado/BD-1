-- a DONE

SELECT *
FROM (Works_On JOIN (SELECT Ssn, Fname, Minit, Lname FROM Employee) AS E ON Works_On.Essn = E.Ssn)

-- b DONE

SELECT Fname, Minit, Lname 
FROM (Employee JOIN (SELECT Ssn FROM Employee WHERE Fname ='Carlos' AND Minit='D' AND Lname='Gomes') AS p_ssn on Employee.Super_ssn = p_ssn.Ssn);

-- c DONE

SELECT Pname, thours 
FROM (Project JOIN (SELECT Pno, SUM(Hourss) as thours FROM Works_on GROUP BY Pno) AS p ON Project.Pnumber=p.Pno);

-- d DONE

SELECT Fname, Minit, Lname
FROM (SELECT * FROM Employee WHERE Dno=3) AS E JOIN (SELECT * FROM (Works_On JOIN (SELECT * FROM Project WHERE Pname='Aveiro Digital') as PROJ ON Works_On.Pno = PROJ.Pnumber) WHERE Hourss > 20) AS P ON E.Ssn=P.Essn;

-- e DONE

SELECT Fname, Minit, Lname FROM Employee LEFT OUTER JOIN Works_On ON Employee.Ssn = Works_On.Essn WHERE Pno = NULL;

-- f DONE

SELECT Department.Dname, AVG(Salary) AS avgSalary 
FROM (Department JOIN (SELECT * FROM Employee WHERE Sex='F') AS EMP ON Department.Dnumber = EMP.Dno) 
GROUP BY Department.Dname;

-- g DONE

SELECT * 
FROM (Employee JOIN (SELECT Essn, COUNT(Dependent_name) AS NumDependents FROM Dependents GROUP BY Essn, Essn HAVING COUNT(Essn) > 2) AS COUNT_DEPENDENTS ON COUNT_DEPENDENTS.Essn=Employee.Ssn)

-- h DONE

SELECT Fname, Minit, Lname, Ssn
FROM (Employee JOIN Department ON Employee.Ssn=Department.Mgr_ssn)
EXCEPT
SELECT Fname, Minit, Lname, Ssn
FROM Dependents LEFT OUTER JOIN (SELECT * FROM Employee JOIN Department ON Employee.Ssn=Department.Mgr_ssn) AS MANAGERS ON Dependents.Essn=MANAGERS.Ssn


--WHERE Dependent_name = NULL

-- i DONE

SELECT Fname, Minit, Lname, Addresss 
FROM Dept_Locations JOIN (SELECT * FROM Employee JOIN (SELECT * FROM Works_On JOIN (SELECT * FROM PROJECT WHERE Plocation='Aveiro') AS PROJ ON Works_On.Pno=PROJ.Pnumber) AS WORK_PROJ ON Employee.Ssn = WORK_PROJ.Essn) AS EMP_AVEIRO ON Dept_Locations.Dnumber=EMP_AVEIRO.Dnum 
WHERE Dlocation != 'Aveiro'


 
