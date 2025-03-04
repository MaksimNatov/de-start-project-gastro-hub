/*добавьте сюда запрос для решения задания 4*/
WITH 
fk AS (
SELECT 
	restaurant_name
	,(jsonb_each(menu)).KEY AS f_key
	,(jsonb_each(menu)).value::jsonb AS f_val
FROM cafe.restaurants),
sk AS (
SELECT 
	fk.restaurant_name
	,jsonb_each_text(f_val) AS pizza
FROM fk
WHERE f_key ILIKE 'Пицца'),
pred_res AS (
SELECT
	sk.restaurant_name
	,COUNT(sk.pizza) AS pizza_count
	,DENSE_RANK() OVER (ORDER BY (COUNT(sk.pizza)) desc) AS rank
FROM sk
GROUP BY 1
ORDER BY 2 DESC)
SELECT
	pred_res.restaurant_name,
	pred_res.pizza_count
FROM pred_res
WHERE
	pred_res.RANK = 1;
