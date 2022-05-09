SELECT	titles.title,
		titles.ytd_sales,
		auths.author,
		titles.price * titles.royalty *  auths.royaltyper/ 10000 * titles.ytd_sales  AS auths_revenue,
		titles.price * (100-titles.royalty) / 100 * titles.ytd_sales AS publisher_revenue
FROM	titles
INNER JOIN	(
	SELECT	titleauthor.au_id,
			titleauthor.title_id,
			titleauthor.royaltyper,
			CONCAT(authors.au_fname, ' ', authors.au_lname) AS author
	FROM	titleauthor
	INNER JOIN	authors
	ON	titleauthor.au_id = authors.au_id
) AS auths
ON	auths.title_id=titles.title_id 
ORDER BY	titles.title