/*добавьте сюда запросы для решения задания 6*/
BEGIN;
LOCK TABLE cafe.managers IN EXCLUSIVE MODE; --совместима только с чтением таблицы и несовместима с любыми изменениями данных в ней
ALTER TABLE cafe.managers ADD COLUMN
	phone_arr text[2];
WITH np as( 
SELECT
	manager_uuid
	,manager_phone
	,'8-800-2500-' || (row_number() OVER (ORDER BY manager_name) + 100) :: text AS new_phone
	--,ARRAY[manager_phone, ('8-800-2500-' || (row_number() OVER (ORDER BY manager_name) + 100))]
FROM cafe.managers)
UPDATE cafe.managers AS m
	SET phone_arr = ARRAY[np.manager_phone, np.new_phone]
FROM np
	WHERE np.manager_uuid = m.manager_uuid;
ALTER TABLE cafe.managers DROP COLUMN manager_phone CASCADE;
COMMIT;
