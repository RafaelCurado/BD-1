SELECT	titles.title,
		b.au_fname,
		b.au_lname,
		ytd_sales * b.royaltyper AS total_value
FROM	titles
INNER JOIN (
	SELECT	authors.au_fname,
			authors.au_lname,
			authors.au_id,
			titleauthor.title_id,
			titleauthor.royaltyper
	FROM	authors
	INNER JOIN	titleauthor
	ON	authors.au_id=titleauthor.au_id
)
AS	b
ON	b.title_id=titles.title_id
ORDER BY titles.title