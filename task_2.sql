/*добавьте сюда запрос для решения задания 2*/
WITH
s as(
SELECT
	EXTRACT (YEAR FROM date) AS year
	,restaurant_uuid
	,round(AVG(avg_check), 2) AS avg
FROM cafe.sales
GROUP BY 1, 2
HAVING EXTRACT (YEAR FROM date) != 2023
ORDER BY 1, 2)
SELECT
	s.year
	,c.restaurant_name
	,c.restaurant_type
	,s.avg
	,LAG(s.avg) OVER (PARTITION BY restaurant_name ORDER BY year) AS avg_previous
	,round((100 - (LAG(s.avg) OVER (PARTITION BY restaurant_name ORDER BY year))/s.avg * 100), 2) AS percentage_change
FROM cafe.restaurants AS c
JOIN s ON c.restaurant_uuid = s.restaurant_uuid
ORDER BY 2,1;
