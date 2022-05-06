SELECT	titles.title 
FROM titles
INNER JOIN (
	SELECT title_id, qty, stor_name
	FROM stores
	INNER JOIN sales
	ON sales.stor_id=stores.stor_id)
AS stsl
ON stsl.title_id = titles.title_id
WHERE stsl.stor_name='Bookbeat'