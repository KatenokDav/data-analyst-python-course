--ДОМАШНЯЯ РАБОТА  4   (УРОК 5)

---ЧТО НА УРОКЕ НЕ ДОДЕЛАЛИ
--task11 (lesson5)
-- Компьютерная фирма: Построить график с со средней и максимальной ценами на базе products_with_lowest_price 
---(X: maker, Y1: max_price, Y2: avg)price

select maker,max(price) as max_price,avg(price) as avg_price from products_with_lowest_price
group by maker;

---ДОМАШНЯЯ РАБОТА

--task1 (lesson5)
-- Компьютерная фирма: Сделать view (pages_all_products), в которой будет постраничная разбивка всех laptop
-- (не более двух продуктов на одной странице). Вывод: все данные из laptop, номер страницы, список всех страниц
create view pages_all_products as
select *, 
case when num % 2 = 0 then num/2 else num/2 + 1 end as page_num
from 
(
      select *, row_number () over(order by price desc) as num 
      from Laptop
) a;

select * from pages_all_products;

--task2 (lesson5)
-- Компьютерная фирма: Сделать view (distribution_by_type), в рамках которого будет процентное соотношение всех товаров 
--по типу устройства. Вывод: производитель,

create view distribution_by_type as
select maker,count(*)*100 / sum(count(*))over() as col
from product
group by maker;

select * from distribution_by_type;
--task3 (lesson5)+
-- Компьютерная фирма: Сделать на базе предыдущенр view график - круговую диаграмму

select maker,col from distribution_by_type;

--task4 (lesson5)
-- Корабли: Сделать копию таблицы ships (ships_two_words), но у название корабля должно состоять из двух слов
create table ships_two_words as
select * 
from ships
where name ilike '% %';

select *from ships_two_words;
--task5 (lesson5)
-- Корабли: Вывести список кораблей, у которых class отсутствует (IS NULL) и название начинается с буквы "S"
select name
from ships
where class is null and name ilike 's%';

--task6 (lesson5)
-- Компьютерная фирма: Вывести все принтеры производителя = 'A' со стоимостью выше средней по принтерам 
--производителя = 'C' и три самых дорогих (через оконные функции). Вывести model

select * from 
(
select *,row_number () over (partition by maker order by price desc) as mp
from 
( select * from product p join printer pr on p.model = pr.model )a)b
where mp <= 3
and maker = 'A' or price > (select avg(price) from printer where maker = 'C');

---ДОПОЛНИТЕЛЬНЫЕ ЗАДАНИЯ

--task4 (lesson4)
-- Компьютерная фирма: Вывести все товары производителя = 'A' со стоимостью выше средней по принтерам производителя = 'D' и 'C'.
-- Вывести model

with avg_DC as 
(
select avg(price) as avgPrice from printer p
join product pn on p.model = pn.model
where (pn.maker = 'D'or pn.maker = 'C')
)
select price, product.model,maker from product join printer  on product.model = printer.model where maker = 'A' and price > (select avgPrice from avg_DC)
union
select price, product.model,maker from product join laptop  on product.model = laptop.model where maker = 'A' and price > (select avgPrice from avg_DC)
union
select price, product.model,maker from product join pc  on product.model = pc.model where maker = 'A' and price > (select avgPrice from avg_DC)
order by price asc;

--task5 (lesson4)
-- Компьютерная фирма: Какая средняя цена среди уникальных продуктов производителя = 'A' (printer & laptop & pc)
select avg(price) from
(
select price, product.model,maker from product join laptop  on product.model = laptop.model where maker = 'A'
union
select price, product.model,maker from product join pc  on product.model = pc.model where maker = 'A'
union
select price, product.model,maker from product join printer  on product.model = printer.model where maker = 'A'
)a;
--task6 (lesson4)
-- Компьютерная фирма: Сделать view с количеством товаров (название count_products_by_makers) по каждому производителю. 
--Во view: maker, count
create view count_products_by_makers as
select maker,count(maker) 
from product
group by maker;

--task7 (lesson4)
-- По предыдущему view (count_products_by_makers) сделать график в colab (X: maker, y: count)

select maker,count as counta from count_products_by_makers;
--task8 (lesson4)
-- Компьютерная фирма: Сделать копию таблицы printer (название printer_updated) и удалить из нее все принтеры производителя 'D'
create table printer_updated as
select code,pr.model,color,pr.type,price
from product p 
join printer pr on p.model = pr.model
where maker <> 'D';

select * from printer_updated;
--task9 (lesson4)
-- Компьютерная фирма: Сделать на базе таблицы (printer_updated) view с дополнительной колонкой производителя 
--(название printer_updated_with_makers)
create view printer_updated_with_makers as
select code,pu.model,color,p.type, price,maker
from printer_updated pu 
join product p 
on pu.model = p.model;

select * from printer_updated_with_makers;

--task10 (lesson4)
-- Корабли: Сделать view c количеством потопленных кораблей и классом корабля (название sunk_ships_by_classes).
-- Во view: count, class (если значения класса нет/IS NULL, то заменить на 0)
create view sunk_ships_by_classes as
with aby as
(
select * from outcomes o
left join ships s 
on o.ship = s.name
where result = 'sunk'
)
select count(result),COALESCE(class,'0') from aby
group by class;

select * from sunk_ships_by_classes;

--task10 (lesson4)+
-- Компьютерная фирма: На базе products_price_categories_with_makers по строить по каждому производителю график 
--(X: category_price, Y: count)
select category_price,count as counta from products_price_categories_with_makers;
--task11 (lesson4)+
-- Компьютерная фирма: На базе products_price_categories_with_makers по строить по A & D график 
--(X: category_price, Y: count)
select category_price,count as counta from products_price_categories_with_makers where maker = 'A' or maker = 'D';

--task11 (lesson4)+
-- Корабли: По предыдущему view (sunk_ships_by_classes) сделать график в colab (X: class, Y: count)
select coalesce as co,count as counta from sunk_ships_by_classes;

--task12 (lesson4)
-- Корабли: Сделать копию таблицы classes (название classes_with_flag) и добавить в нее flag: если количество 
--орудий больше или равно 9 - то 1, иначе 0
create table classes_with_flag as
select *,
case 
	when numguns >=9
	then 1
	else 0
end flag
from classes;

--task13 (lesson4)+
-- Корабли: Сделать график в colab по таблице classes с количеством классов по странам (X: country, Y: count)
select country,count(class) as counta from classes group by country;

select * from classes_with_flag;
--task14 (lesson4)
-- Корабли: Вернуть количество кораблей, у которых название начинается с буквы "O" или "M".
select count(name) 
from ships
where name ilike 'o%' or name ilike 'm%';

--task15 (lesson4)
-- Корабли: Вернуть количество кораблей, у которых название состоит из двух слов.
select count(name)
from ships
where name ilike '% %';


--task16 (lesson4)+
-- Корабли: Построить график с количеством запущенных на воду кораблей и годом запуска (X: year, Y: count)
select launched,count(name) as counta from ships group by launched;


