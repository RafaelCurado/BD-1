USE empresa;

GO

-- a)

GO
CREATE PROCEDURE remove_employee 
	@ssn as INT	
AS
BEGIN	
	DELETE FROM dependents WHERE essn = @ssn;
	DELETE FROM works_on WHERE essn = @ssn; 
	UPDATE department set Mgr_ssn = NULL where Mgr_ssn = @ssn;
	UPDATE employee set Super_ssn = NULL where Super_ssn = @ssn;
	DELETE FROM employee WHERE ssn = @ssn;
END
GO

--ex b)
GO
CREATE PROC dbo.p_RecordSetI(@OldestEmployee INT OUTPUT)
AS
	BEGIN

	SELECT TOP 1 @OldestEmployee = Ssn
	FROM (dbo.DEPARTMENT AS Dep JOIN dbo.EMPLOYEE AS Emp on Dep.Mgr_ssn = Emp.Ssn) 
	ORDER BY Mgr_start_date DESC

	-- Funcionarios gestores de departamentos
	SELECT * FROM (dbo.DEPARTMENT AS Dep JOIN dbo.EMPLOYEE AS Emp on Dep.Mgr_ssn = Emp.Ssn)
	END

-- Teste
EXEC remove_employee 21312332;
GO
--drop PROCEDURE remove_employee 

-- c)
GO
CREATE TRIGGER dpt_manager ON department
INSTEAD OF INSERT, UPDATE
AS
BEGIN
	DECLARE @Mgr_ssn AS INT;
	SELECT @Mgr_ssn=Mgr_ssn FROM inserted;

	IF @Mgr_ssn IN (SELECT Mgr_ssn FROM department)
	BEGIN
		PRINT 'Employee already manages one department'
	END
	ELSE
	BEGIN
		INSERT INTO department SELECT * FROM inserted;
		PRINT 'Success'
	END
END
GO
--drop TRIGGER dpt_manager
--Teste
SELECT * FROM DEPARTMENT;
SELECT * FROM EMPLOYEE;
INSERT INTO DEPARTMENT VALUES ('Teste', 5, 21312332,'2013-05-16');
INSERT INTO DEPARTMENT VALUES ('Teste', 5, 345355435 ,'2013-05-16');

-- d) 
GO
CREATE TRIGGER t_salary ON dbo.EMPLOYEE AFTER INSERT, UPDATE
AS 
BEGIN
	DECLARE @Essn				AS INT;
	DECLARE @Esalary			AS INT;
	DECLARE @Dno				AS INT;
	DECLARE @ManagerSalary		AS INT;

	SELECT @Essn=inserted.Ssn, @Esalary=inserted.Salary, @Dno=inserted.Dno FROM inserted;
	SELECT @ManagerSalary=EMPLOYEE.Salary FROM DEPARTMENT
		JOIN EMPLOYEE ON DEPARTMENT.Mgr_ssn=EMPLOYEE.Ssn
		WHERE @Dno=DEPARTMENT.Dnumber;
	

	IF @Esalary>@ManagerSalary 
	BEGIN
		UPDATE EMPLOYEE
		SET EMPLOYEE.Salary=@ManagerSalary
		WHERE EMPLOYEE.Ssn=@Essn;
	END
END
GO

-- e)

GO
CREATE FUNCTION locations_name (@ssn CHAR(9)) RETURNS @table TABLE
	(Pname		VARCHAR(15),
	 PLocation  VARCHAR(15))
AS
BEGIN
	INSERT @table
		SELECT Pname, Plocation
		FROM works_on, project
		WHERE Essn = @ssn AND Pno = Pnumber;
	RETURN;
END
GO

-- Test
SELECT * FROM locations_name(21312332);

-- f)
GO
CREATE FUNCTION dbo.AboveAverageSalary (@dno int) RETURNS @table TABLE (Ssn int)
AS
	BEGIN
		INSERT @table
			SELECT EMPLOYEE.Ssn
			FROM EMPLOYEE
			JOIN (SELECT Dno, AVG(Salary) 'AverageSalary'
				FROM EMPLOYEE
				GROUP BY Dno) AS AVGSALARY
				ON AVGSALARY.Dno=EMPLOYEE.Dno
			WHERE EMPLOYEE.Salary > AVGSALARY.AverageSalary
		RETURN;
	END;

-- g)
GO
CREATE FUNCTION employeeDeptHighAverage(@departId  INT)
RETURNS @table TABLE (
	pname  VARCHAR(15), 
	pnumber INT, 
	plocation VARCHAR(15), 
	dnum INT, 
	budget FLOAT, 
	totalbudget FLOAT )
AS
BEGIN
	DECLARE C CURSOR
        FOR
            SELECT Pname, Pnumber, Plocation, Dnum, SUM((Salary*1.0*Hours)/40) AS Budget 
            FROM project JOIN works_on
            ON Pnumber=Pno
            JOIN employee
            ON Essn=Ssn
            WHERE Dnum=@departId
            GROUP BY Pnumber, Pname, Plocation, Dnum;
 
	DECLARE @pname AS VARCHAR(15), @pnumber AS INT, @plocation as VARCHAR(15), @dnum AS INT, @budget AS FLOAT, @totalbudget AS FLOAT;
	SET @totalbudget = 0;
    OPEN C;
	FETCH C INTO @pname, @pnumber, @plocation, @dnum, @budget;

	WHILE @@FETCH_STATUS = 0
	BEGIN
		SET @totalbudget += @budget;
		INSERT INTO @table VALUES (@pname, @pnumber, @plocation, @dnum, @budget, @totalbudget);
		FETCH C INTO @pname, @pnumber, @plocation, @dnum, @budget;
	END
	CLOSE C;
	DEALLOCATE C;
	RETURN;
END
GO

--Teste 
SELECT * FROM employeeDeptHighAverage(3);

-- h)

--------------------------------------------- Instead of ------------------------------
GO
CREATE TRIGGER t_RemoveDepartment_InsteadOf ON dbo.DEPARTMENT INSTEAD OF DELETE
AS
BEGIN
	DECLARE @Dname			AS VARCHAR(30);
	DECLARE @Dnumber		AS INT;
	DECLARE @Mgr_ssn		AS INT;
	DECLARE @Mgr_start_date AS DATE;

	SELECT @Dname=deleted.Dname, @Dnumber=deleted.Dnumber, @Mgr_ssn=deleted.Mgr_ssn, @Mgr_start_date=deleted.Mgr_start_date FROM deleted;
	IF NOT (EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'DEPARTMENT_DELETED'))
		CREATE TABLE DEPARTMENT_DELETED (
		Dname				varchar(30) NOT NULL,
		Dnumber				int,
		Mgr_ssn				int,
		Mgr_start_date		date,
		CONSTRAINT DEPARTMENT_DELETED_PK PRIMARY KEY (Dnumber)
	);
	INSERT INTO dbo.DEPARTMENT_DELETED SELECT * FROM deleted;
	DELETE FROM dbo.DEPARTMENT WHERE Dnumber=@Dnumber;
END

----------------------------------------------After --------------------------------------------------
GO
CREATE TRIGGER t_RemoveDepartment_After ON dbo.DEPARTMENT AFTER DELETE
AS
BEGIN
	DECLARE @Dname			AS VARCHAR(30);
	DECLARE @Dnumber		AS INT;
	DECLARE @Mgr_ssn		AS INT;
	DECLARE @Mgr_start_date AS DATE;

	SELECT @Dname=deleted.Dname, @Dnumber=deleted.Dnumber, @Mgr_ssn=deleted.Mgr_ssn, @Mgr_start_date=deleted.Mgr_start_date FROM deleted;
	-- If the table does not exist, then create
	IF NOT (EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'DEPARTMENT_DELETED'))
		CREATE TABLE DEPARTMENT_DELETED (
		Dname				varchar(30) NOT NULL,
		Dnumber				int,
		Mgr_ssn				int,
		Mgr_start_date		date,
		CONSTRAINT DEPARTMENT_DELETED_PK PRIMARY KEY (Dnumber)
	);
	INSERT INTO dbo.DEPARTMENT_DELETED SELECT * FROM deleted;
END

-- i)

/*
	Tanto os SPs e as UDFs s�o otimizados: 
	-S�o compilados 1 unica vez, na sua cria��o
	-S�o guardados em cache na sua primeira execu��o

	SPs permitem retornar multiplos valores atrav�s de parametros output, as UDFs permitem retornar apenas 1
	SPs permitem chamar outras SPs, as UDFs n�o
	SPs permitem lan�ar e lidar com exce��o e definir transactions, as UDFs n�o
	UDFs podem ser usadas como fontes de dados nas clausulas SELECT/ WHERE/ HAVING 
	UDFs nao podem usar instru�oes DML na base de dados (no side-effects)
	UDFs para os mesmos parametros de entradas produzem o mesmo valor de retorno (deterministicas)
	As UDF podem ser usadas como forma de abstra��o de uma estrutura l�gica complexa sob a forma de uma fun��o deterministica (pura), que pode ser
	usada como fonte de dados.
	Podem, por exemplo, funcionar com uma view parametrizada, que retorna uma tabela em fun��o dos parametros de entrada

	Os SP funcionam como uma camada de abstra��o do modelo de dados, tornam mais facil o manuseamento da base de dados por parte das
	aplica��es. Se alguma coisa for alterado no modelo de dados e a interface dos SP se mantiver igual, n�o existe qualquer impacto para os clientes.
	Para al�m disso, permitem garantir a integridade e a seguran�a dos dados.
	Podem, por exemplo, ser ute�s para fazer um conjunto de opera��es que envolvem v�rias tabelas, onde � preciso lidar com eventuais erros,
	onde este conjunto de opera��es podem ser vista como uma opera��o unica, transaction

*/