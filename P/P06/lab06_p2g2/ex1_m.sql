SELECT	type,
		AVG(advance) AS avg_advance
FROM	titles
GROUP BY	type
HAVING	AVG(advance)*1.5 < MAX(advance)