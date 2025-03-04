/*добавьте сюда запрос для решения задания 1*/
WITH
s AS (
	SELECT
	restaurant_uuid
	,ROUND(AVG(avg_check), 2) AS avg_check
	FROM cafe.sales
	GROUP BY restaurant_uuid),
r AS (	
SELECT 
	r.restaurant_name
	,r.restaurant_type
	,s.avg_check
	,ROW_NUMBER() OVER(PARTITION BY r.restaurant_type ORDER BY s.avg_check DESC) AS rank
FROM cafe.restaurants AS r
INNER JOIN s ON r.restaurant_uuid = s.restaurant_uuid
ORDER BY restaurant_type, s.avg_check DESC)
SELECT 
	restaurant_name
	,restaurant_type
	,avg_check
FROM r
WHERE RANK <=3;
