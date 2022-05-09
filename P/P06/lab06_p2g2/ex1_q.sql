SELECT	titles.title,
		ss.stor_name
FROM	titles
LEFT JOIN	(
	SELECT	sales.title_id,
			stor_name
	FROM	sales
	INNER JOIN	stores
	ON	sales.stor_id = stores.stor_id
) AS ss
ON	ss.title_id=titles.title_id 