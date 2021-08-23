--task17
---�������: ������� ��������, � ������� ����������� ������� ������ Kongo �� ������� Ships.
select battle
from ships t1
join outcomes t2
on t1.name = t2.ship
where class = 'Kongo';

--task1
--�������: ��� ������� ������ ���������� ����� �������� ����� ������, ����������� � ���������. �������: ����� � ����� ����������� ��������.
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
--�������: ��� ������� ������ ���������� ���, ����� ��� ������ �� ���� ������ ������� ����� ������. ���� ��� ������ �� ���� ��������� ������� ����������, ���������� ����������� ��� ������ �� ���� �������� ����� ������. �������: �����, ���.
select class,min(launched) from ships
group by class;

--task3
--�������: ��� �������, ������� ������ � ���� ����������� �������� � �� ����� 3 �������� � ���� ������, ������� ��� ������ � ����� ����������� ��������.

select class,count(name)
from ships
group by class;


--task4
--�������: ������� �������� ��������, ������� ���������� ����� ������ ����� ���� �������� ������ �� ������������� 
with maxguns as (
	select max(numguns), displacement from classes c
	group by displacement
)
select s.name,numguns, c.displacement from maxguns
join classes c on c.numguns = maxguns.max and c.displacement = maxguns.displacement
join ships s on c.class = s.class
order by numguns desc;
--task5
--������������ �����: ������� �������������� ���������, ������� ���������� �� � ���������� ������� RAM � � ����� ������� ����������� ����� ���� ��, ������� ���������� ����� RAM. �������: Maker
select distinct(maker) from product_new where  type = 'Printer';

with abc as (
select model,max(speed) from pc
where ram = (select min(ram) from pc)
group by model
)
select distinct (maker)from abc a
join product_new p
on a.model = p.model;
