SELECT	publishers.pub_name ,
		titles.title, 
		SUM(titles.ytd_sales) AS total_sales
FROM publishers
INNER JOIN titles
ON titles.pub_id=publishers.pub_id
GROUP BY publishers.pub_id, publishers.pub_name, titles.title 