--схема БД: https://docs.google.com/document/d/1NVORWgdwlKepKq_b8SPRaSpraltxoMg2SIusTEN6mEQ/edit?usp=sharing
--colab/jupyter: https://colab.research.google.com/drive/1j4XdGIU__NYPVpv74vQa9HUOAkxsgUez?usp=sharing

--task13 (lesson3)
--Компьютерная фирма: Вывести список всех продуктов и производителя с указанием типа продукта (pc, printer, laptop). Вывести: model, maker, type
select model,maker,type from 
(
select t1.model,maker,type from pc t1 join product_new t2 on t1.model = t2.model
union
select t3.model,maker,t2.type from printer t3 join product_new t2 on t3.model = t2.model
union
select t4.model,maker,type from laptop t4 join product_new t2 on t4.model = t2.model
) a 
order by model;

--task14 (lesson3)
--Компьютерная фирма: При выводе всех значений из таблицы printer дополнительно вывести для тех, у кого цена вышей средней PC - "1", у остальных - "0"
select *,
case 
	when price > (select avg(price) from printer)
	then 1
	else 0
end abc
from printer;

--task15 (lesson3)
--Корабли: Вывести список кораблей, у которых class отсутствует (IS NULL)
select *
from ships
where class is null;
--task16 (lesson3)
--Корабли: Укажите сражения, которые произошли в годы, не совпадающие ни с одним из годов спуска кораблей на воду.
select name,"date" 
from battles
where to_char(date, 'YYYY') not in
     (select launched::text 
      from ships
where launched is not null);
--task17 (lesson3)
--Корабли: Найдите сражения, в которых участвовали корабли класса Kongo из таблицы Ships.
select battle
from ships s
join outcomes o 
on s.name = o.ship
where class = 'Kongo';

--task1  (lesson4)
-- Компьютерная фирма: Сделать view (название all_products_flag_300) для всех товаров (pc, printer, laptop) с флагом, 
--если стоимость больше > 300. Во view три колонки: model, price, flag
create or replace view all_products_flag as
select price, product.model from product join laptop  on product.model = laptop.model 
union
select price, product.model from product join pc  on product.model = pc.model   
union 
select price, product.model from product join printer  on product.model = printer.model 

create or replace view all_products_flag_300 as
select *,
case
	when price > 300
	then 1
end flag
from all_products_flag

select * from all_products_flag_300
--task2  (lesson4)
-- Компьютерная фирма: Сделать view (название all_products_flag_avg_price) для всех товаров (pc, printer, laptop) с флагом, 
--если стоимость больше cредней . Во view три колонки: model, price, flag
create or replace view all_products_flag_avg_price as
select *, 
case
	when price >(select avg(price) from all_products_flag)
	then 1
end flag
from all_products_flag

select * from all_products_flag_avg_price


--task3  (lesson4)
-- Компьютерная фирма: Вывести все принтеры производителя = 'A' со стоимостью выше средней по принтерам производителя = 'D' и 'C'.
-- Вывести model
with avgDC as (
	select avg(p.price) as avgPrice from printer p 
	join product_new pn on p.model = pn.model
	where (pn.maker = 'C' or pn.maker = 'D')
)
select pn.model from printer p
join product_new pn on p.model = pn.model
where pn.maker = 'A' and p.price > (select avgPrice from avgDC);

--task10 (lesson4)
-- Компьютерная фирма: На базе products_price_categories_with_makers по строить по каждому 
--производителю график (X: category_price, Y: count)

select category_price,count as counta from products_price_categories_with_makers;

--task11 (lesson4)
-- Компьютерная фирма: На базе products_price_categories_with_makers по строить 
--по A & D график (X: category_price, Y: count)

select category_price,count as counta from products_price_categories_with_makers
where maker = 'A' or maker = 'D';

--task12 (lesson4)
-- Корабли: Сделать копию таблицы ships, но у название корабля не должно начинаться с буквы N (ships_without_n)
create table ships_without_n as
select *
from ships
where name not ilike 'n%';

select *
from ships_without_n;