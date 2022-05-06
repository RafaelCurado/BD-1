SELECT	type,
		pub_id,
		SUM(ytd_sales) AS total_sales,
		AVG(price) AS avg_price
FROM	titles
GROUP BY	type, pub_id
ORDER BY	pub_id