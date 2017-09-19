SELECT * FROM (
SELECT 
	s.suburb_pfi pfi, 
	c.summary, 
	COUNT(s.id) AS cnt, 
	ROW_NUMBER() OVER(PARTITION BY s.suburb_pfi ORDER BY COUNT(s.id) DESC,s.suburb_pfi) corr
FROM 
COE_DT_MESSAGE AS m 
INNER JOIN COE_DT_SUBMITTER AS s ON s.message_token = m.token 
INNER JOIN COE_DT_CATEGORY AS c ON m.category_id = c.id
GROUP BY s.suburb_pfi, c.summary
) a WHERE corr = 1
