/*добавьте сюда запросы для решения задания 6*/
BEGIN;
WITH res as(
SELECT 
cafe.restaurants.restaurant_uuid
,to_jsonb(((menu #>> '{Кофе, Капучино}') :: int * 1.2) :: int) AS val
FROM cafe.restaurants 
WHERE 1=1
	AND menu #>> '{Кофе, Капучино}' IS NOT NULL
FOR NO KEY UPDATE) --блокируем строки, пока транзакция не завершится, никто не сможет изменить или удалить строки
UPDATE 	cafe.restaurants AS r
	SET
		menu = jsonb_set(menu, '{Кофе, Капучино}', res.val)
	FROM res
	WHERE res.restaurant_uuid = r.restaurant_uuid;
COMMIT;
