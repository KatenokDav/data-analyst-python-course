--task17
---Корабли: Найдите сражения, в которых участвовали корабли класса Kongo из таблицы Ships.
select battle
from ships t1
join outcomes t2
on t1.name = t2.ship
where class = 'Kongo';

--task1
--Корабли: Для каждого класса определите число кораблей этого класса, потопленных в сражениях. Вывести: класс и число потопленных кораблей.
select class, count(*)
from 
(
select * 
from ships t1 
join outcomes t2
on t1.name = t2.ship
)a
where result = 'sunk'
group by class;
--task2
--Корабли: Для каждого класса определите год, когда был спущен на воду первый корабль этого класса. Если год спуска на воду головного корабля неизвестен, определите минимальный год спуска на воду кораблей этого класса. Вывести: класс, год.
select class,min(launched) from ships
group by class;

--task3
--Корабли: Для классов, имеющих потери в виде потопленных кораблей и не менее 3 кораблей в базе данных, вывести имя класса и число потопленных кораблей.

select class,count(name)
from ships
group by class;


--task4
--Корабли: Найдите названия кораблей, имеющих наибольшее число орудий среди всех кораблей такого же водоизмещения 
with maxguns as (
	select max(numguns), displacement from classes c
	group by displacement
)
select s.name,numguns, c.displacement from maxguns
join classes c on c.numguns = maxguns.max and c.displacement = maxguns.displacement
join ships s on c.class = s.class
order by numguns desc;
--task5
--Компьютерная фирма: Найдите производителей принтеров, которые производят ПК с наименьшим объемом RAM и с самым быстрым процессором среди всех ПК, имеющих наименьший объем RAM. Вывести: Maker
select distinct(maker) from product_new where  type = 'Printer';

with abc as (
select model,max(speed) from pc
where ram = (select min(ram) from pc)
group by model
)
select distinct (maker)from abc a
join product_new p
on a.model = p.model;
