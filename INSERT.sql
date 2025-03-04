/*Добавьте в этот файл запросы, которые наполняют данными таблицы в схеме cafe данными*/
--Вставляем данные
INSERT INTO cafe.restaurants(restaurant_name, restaurant_type, menu)
SELECT 
	DISTINCT(cafe_name)
	,TYPE::cafe.restaurant_type
	,m.menu
FROM raw_data.sales
LEFT JOIN raw_data.menu m USING(cafe_name);

INSERT INTO cafe.managers (manager_name, manager_phone)
SELECT 
	DISTINCT(manager)
	,manager_phone
FROM raw_data.sales;

INSERT INTO cafe.restaurant_manager_work_dates(
	restaurant_uuid
	,manager_uuid
	,start_date
	,end_date)
SELECT 
	r.restaurant_uuid
	,m.manager_uuid
	,MIN(s.report_date)
	,MAX(s.report_date)
FROM raw_data.sales AS s
INNER JOIN cafe.restaurants AS r ON r.restaurant_name = s.cafe_name
INNER JOIN cafe.managers AS m ON m.manager_name = s.manager 
GROUP BY r.restaurant_uuid, m.manager_uuid;

INSERT INTO  cafe.sales(
	restaurant_uuid
	,date
	,avg_check)
SELECT 
	r.restaurant_uuid
	,s.report_date
	,s.avg_check
FROM raw_data.sales AS s
LEFT JOIN cafe.restaurants AS r ON r.restaurant_name = s.cafe_name;
