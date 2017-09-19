SELECT 
	*, 
	ISNULL([Community], 0) + 
	ISNULL([Economy], 0) + 
	ISNULL([Environment], 0) + 
	ISNULL([Infrastructure], 0) + 
	ISNULL([Safety], 0) + 
	ISNULL([Sustainability], 0) + 
	ISNULL([Technology], 0) + 
	ISNULL([Tourism], 0) CNT
FROM (
	SELECT        
		CAST(s.suburb_pfi AS varchar(100)) AS suburb_pfi, 
		c.summary, 
		COUNT(s.id) AS Count
	FROM COE_DT_MESSAGE AS m 
	INNER JOIN COE_DT_SUBMITTER AS s ON s.message_token = m.token 
	INNER JOIN COE_DT_CATEGORY AS c ON m.category_id = c.id
	GROUP BY s.suburb_pfi, c.summary
	) Main 
PIVOT (
	SUM(count) 
	FOR summary IN 
	(
		[Community], 
		[Economy], 
		[Environment], 
		[Infrastructure], 
		[Safety], 
		[Sustainability], 
		[Technology], 
		[Tourism]
	)
) pvt
