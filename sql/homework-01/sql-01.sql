--������� 1: ������� name, class �� ��������, ���������� ����� 1920

select name,class
from ships
where  launched > 1920;

--������� 2: ������� name, class �� ��������, ���������� ����� 1920, �� �� ������� 1942

select name,class
from ships
where  launched > 1920 and launched <= 1942;
--������� 3: ����� ���������� �������� � ������ ������. ������� ���������� � class

select count(*),class
from ships
group by class;

--������� 4: ��� ������� ��������, ������ ������ ������� �� ����� 16, ������� ����� � ������. (������� classes)

select class,country
from classes 
where bore >= 16;

--������� 5: ������� �������, ����������� � ��������� � �������� ��������� (������� Outcomes, North Atlantic). �����: ship.

select ship
from outcomes
where battle = 'North Atlantic' and result ='sunk';

--������� 6: ������� �������� (ship) ���������� ������������ �������

select t2.ship
from battles t1
join outcomes t2
on t1.name = t2.battle
where result = 'sunk' and 
date = (select max("date") from battles b where "name" not ilike '%#%');

--������� 7: ������� �������� ������� (ship) � ����� (class) ���������� ������������ �������

select t2.ship,class
from battles t1
join outcomes t2 on t1.name = t2.battle
 left join ships t3 on t2.ship = t3.name 
where result = 'sunk' 
and 
date = (select max(date) from battles where "name" not ilike '%#%');

--������� 8: ������� ��� ����������� �������, � ������� ������ ������ �� ����� 16, � ������� ���������. �����: ship, class

select *
from ships t1
join outcomes t2 on t1.name = t2.ship
join classes t3 on t1.class = t3.class
where result = 'sunk' and bore >= 16;

--������� 9: ������� ��� ������ ��������, ���������� ��� (������� classes, country = 'USA'). �����: class

select class
from classes
where country = 'USA';
--������� 10: ������� ��� �������, ���������� ��� (������� classes & ships, country = 'USA'). �����: name, class
select name,t1.class
from ships t1
join classes t2
on t1.class = t2.class
where country = 'USA';