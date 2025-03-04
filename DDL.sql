/*Добавьте в этот файл все запросы, для создания схемы сafe и
 таблиц в ней в нужном порядке*/
CREATE SCHEMA IF NOT EXISTS cafe;
--дропаю тип, т.к. выполню весь скрпит целиком
DROP TYPE IF EXISTS cafe.restaurant_type CASCADE;
CREATE TYPE cafe.restaurant_type AS ENUM 
	('coffee_shop',
	'restaurant', 'bar',
	'pizzeria');
-- Предварительно дропаю таблички так как выполняю весь скрипт, включая INSERTы целиком
DROP TABLE IF EXISTS cafe.restaurants CASCADE;
DROP TABLE IF EXISTS cafe.managers CASCADE;
DROP TABLE IF EXISTS cafe.restaurant_manager_work_dates CASCADE;
DROP TABLE IF EXISTS cafe.sales CASCADE;
-- Создаем таблицы
CREATE TABLE cafe.restaurants (
	restaurant_uuid uuid PRIMARY KEY DEFAULT gen_random_uuid(),
	restaurant_name VARCHAR NOT NULL,
	restaurant_type cafe.restaurant_type,
	menu jsonb
	
);

CREATE TABLE cafe.managers(
	manager_uuid uuid PRIMARY KEY DEFAULT gen_random_uuid(),
	manager_name varchar NOT NULL,
	manager_phone varchar NOT NULL
);

CREATE TABLE  cafe.restaurant_manager_work_dates(
	restaurant_uuid uuid REFERENCES cafe.restaurants NOT NULL,
	manager_uuid uuid REFERENCES cafe.managers NOT NULL,
	start_date date NOT NULL,
	end_date date NOT NULL,
	PRIMARY KEY (restaurant_uuid, manager_uuid)
);

CREATE TABLE cafe.sales(
	restaurant_uuid uuid REFERENCES cafe.restaurants NOT NULL,
	date date NOT NULL,
	avg_check numeric(6, 2),
	PRIMARY KEY (restaurant_uuid, date)
);
