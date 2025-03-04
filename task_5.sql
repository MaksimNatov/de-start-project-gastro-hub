/*добавьте сюда запрос для решения задания 5*/
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
	,fk.f_key
	,(jsonb_each(f_val)).KEY AS s_key
	,(jsonb_each(f_val)).value :: int AS s_val
FROM fk
WHERE f_key ILIKE 'Пицца'),
res AS (
SELECT 
	*
	,ROW_NUMBER() OVER(PARTITION BY restaurant_name ORDER BY s_val DESC) AS top
FROM sk)
SELECT
	res.restaurant_name
	,res.f_key AS meal_type
	,res.s_key AS pizza_name
	,res.s_val AS price
FROM res
WHERE
	res.top = 1;
