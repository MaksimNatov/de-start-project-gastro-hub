/*добавьте сюда запрос для решения задания 3*/
WITH cnt as(
SELECT
	restaurant_uuid
	,count(manager_uuid) AS count
	,RANK() OVER(ORDER BY count(manager_uuid) DESC) AS rank
FROM cafe.restaurant_manager_work_dates
GROUP BY 1
ORDER BY 2 DESC)
SELECT 
	res.restaurant_name
	,cnt.count
FROM cafe.restaurants AS res
JOIN cnt ON cnt.restaurant_uuid = res.restaurant_uuid
WHERE cnt.RANK <= 3;
