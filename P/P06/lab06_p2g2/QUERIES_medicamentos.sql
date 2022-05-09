-- a DONE

SELECT PA.NSNS, PA.Nome
FROM Paciente AS PA RIGHT OUTER JOIN Prescricao AS PR ON PA.NSNS=PR.NSNS
WHERE Nuni IS NULL


--b DONE

SELECT M.Especialidade, COUNT(PR.Nuni) AS N_presc
FROM Medico AS M JOIN Prescricao AS PR ON M.NID=PR.NID
GROUP BY M.Especialidade



-- c DONE

SELECT F.Nome, COUNT(Nuni) AS N_presc
FROM Farmacia AS F JOIN Prescricao AS PR ON F.Nome=PR.Nome_farmacia
GROUP BY F.Nome


-- d DONE

SELECT F.Nreg, F.Nome, F.Formula
FROM Farmaco AS F JOIN Presc_farmaco AS PRF ON F.Nome=PRF.Nome_farmaco 
WHERE PRF.Num_presc IS NULL AND F.Nreg=906


-- e DONE

SELECT F.Nome, PRF.Num_reg_farm, COUNT(PR.Nuni) AS Num_vendidos
FROM Farmacia AS F JOIN Prescricao AS PR ON F.Nome=PR.Nome_farmacia
		JOIN Presc_farmaco AS PRF ON PR.Nuni=PRF.Num_presc
GROUP BY F.Nome, PRF.Num_reg_farm


-- f DONE

SELECT P.NSNS
FROM(
	SELECT PR.NSNS, PR.NID, COUNT(PR.NID) AS N_med
	FROM Prescricao AS PR
	GROUP BY PR.NSNS, PR.NID
	) AS P
GROUP BY P.NSNS
HAVING COUNT(P.NSNS) > 1
