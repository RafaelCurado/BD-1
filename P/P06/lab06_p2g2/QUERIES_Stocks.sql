-- a DONE

SELECT Nif, Nome, Fax, Endereco, Condpag, Tipo
FROM Fornecedor AS F LEFT OUTER JOIN Encomenda AS E ON F.Nif=E.Fornecedor
WHERE E.Numero IS NULL


-- b DONE

SELECT CodProd, AVG(Unidades) AS Media
FROM Item
GROUP BY CodProd



-- c DONE

SELECT AVG(Count_prod.NProdPerEnc) AS Media_prod_per_enc
FROM(
	SELECT COUNT(CodProd) AS NProdPerEnc
	FROM Item AS I JOIN Encomenda AS E ON I.NumEnc=E.Numero
	GROUP BY E.Numero
	) AS Count_prod


-- d DONE

SELECT E.Fornecedor, I.CodProd, Unidades
FROM Encomenda AS E JOIN Item AS I ON E.Numero=I.NumEnc
GROUP BY E.Fornecedor, I.CodProd, Unidades
