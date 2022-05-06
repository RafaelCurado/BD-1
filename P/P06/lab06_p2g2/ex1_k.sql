SELECT	authors.au_lname, authors.au_fname
FROM	authors
INNER JOIN(
	SELECT	au_id, type
	FROM	titleauthor
	INNER JOIN	titles
	ON	titleauthor.title_id=titles.title_id
)
AS titlesa 
ON titlesa.au_id = authors.au_id
GROUP BY authors.au_id, authors.au_lname, authors.au_fname
HAVING COUNT (DISTINCT titlesa.type) > 1