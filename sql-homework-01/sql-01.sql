--Задание 1: Вывести name, class по кораблям, выпущенным после 1920

select name,class
from ships
where  launched > 1920;

--Задание 2: Вывести name, class по кораблям, выпущенным после 1920, но не позднее 1942

select name,class
from ships
where  launched > 1920 and launched <= 1942;
--Задание 3: Какое количество кораблей в каждом классе. Вывести количество и class

select count(*),class
from ships
group by class;

--Задание 4: Для классов кораблей, калибр орудий которых не менее 16, укажите класс и страну. (таблица classes)

select class,country
from classes 
where bore >= 16;

--Задание 5: Укажите корабли, потопленные в сражениях в Северной Атлантике (таблица Outcomes, North Atlantic). Вывод: ship.

select ship
from outcomes
where battle = 'North Atlantic' and result ='sunk';

--Задание 6: Вывести название (ship) последнего потопленного корабля

select t2.ship
from battles t1
join outcomes t2
on t1.name = t2.battle
where result = 'sunk' and 
date = (select max("date") from battles b where "name" not ilike '%#%');

--Задание 7: Вывести название корабля (ship) и класс (class) последнего потопленного корабля

select t2.ship,class
from battles t1
join outcomes t2 on t1.name = t2.battle
 left join ships t3 on t2.ship = t3.name 
where result = 'sunk' 
and 
date = (select max(date) from battles where "name" not ilike '%#%');

--Задание 8: Вывести все потопленные корабли, у которых калибр орудий не менее 16, и которые потоплены. Вывод: ship, class

select *
from ships t1
join outcomes t2 on t1.name = t2.ship
join classes t3 on t1.class = t3.class
where result = 'sunk' and bore >= 16;

--Задание 9: Вывести все классы кораблей, выпущенные США (таблица classes, country = 'USA'). Вывод: class

select class
from classes
where country = 'USA';
--Задание 10: Вывести все корабли, выпущенные США (таблица classes & ships, country = 'USA'). Вывод: name, class
select name,t1.class
from ships t1
join classes t2
on t1.class = t2.class
where country = 'USA';