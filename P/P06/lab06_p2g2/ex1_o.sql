SELECT	titles.title,
		titles.ytd_sales, 
		titles.ytd_sales * titles.price AS faturacao,
		titles.price * titles.royalty / 100 * titles.ytd_sales  AS auths_revenue,
		titles.price * (100-titles.royalty) / 100 * titles.ytd_sales AS publisher_revenue
FROM	titles
ORDER BY	titles.title