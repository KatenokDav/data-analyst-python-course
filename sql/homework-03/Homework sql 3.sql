--����� ��: https://docs.google.com/document/d/1NVORWgdwlKepKq_b8SPRaSpraltxoMg2SIusTEN6mEQ/edit?usp=sharing
--colab/jupyter: https://colab.research.google.com/drive/1j4XdGIU__NYPVpv74vQa9HUOAkxsgUez?usp=sharing

--task13 (lesson3)
--������������ �����: ������� ������ ���� ��������� � ������������� � ��������� ���� �������� (pc, printer, laptop). �������: model, maker, type
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
--������������ �����: ��� ������ ���� �������� �� ������� printer ������������� ������� ��� ���, � ���� ���� ����� ������� PC - "1", � ��������� - "0"
select *,
case 
	when price > (select avg(price) from printer)
	then 1
	else 0
end abc
from printer;

--task15 (lesson3)
--�������: ������� ������ ��������, � ������� class ����������� (IS NULL)
select *
from ships
where class is null;
--task16 (lesson3)
--�������: ������� ��������, ������� ��������� � ����, �� ����������� �� � ����� �� ����� ������ �������� �� ����.
select name,"date" 
from battles
where to_char(date, 'YYYY') not in
     (select launched::text 
      from ships
where launched is not null);
--task17 (lesson3)
--�������: ������� ��������, � ������� ����������� ������� ������ Kongo �� ������� Ships.
select battle
from ships s
join outcomes o 
on s.name = o.ship
where class = 'Kongo';

--task1  (lesson4)
-- ������������ �����: ������� view (�������� all_products_flag_300) ��� ���� ������� (pc, printer, laptop) � ������, 
--���� ��������� ������ > 300. �� view ��� �������: model, price, flag
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
-- ������������ �����: ������� view (�������� all_products_flag_avg_price) ��� ���� ������� (pc, printer, laptop) � ������, 
--���� ��������� ������ c������ . �� view ��� �������: model, price, flag
create or replace view all_products_flag_avg_price as
select *, 
case
	when price >(select avg(price) from all_products_flag)
	then 1
end flag
from all_products_flag

select * from all_products_flag_avg_price


--task3  (lesson4)
-- ������������ �����: ������� ��� �������� ������������� = 'A' �� ���������� ���� ������� �� ��������� ������������� = 'D' � 'C'.
-- ������� model
with avgDC as (
	select avg(p.price) as avgPrice from printer p 
	join product_new pn on p.model = pn.model
	where (pn.maker = 'C' or pn.maker = 'D')
)
select pn.model from printer p
join product_new pn on p.model = pn.model
where pn.maker = 'A' and p.price > (select avgPrice from avgDC);

--task10 (lesson4)
-- ������������ �����: �� ���� products_price_categories_with_makers �� ������� �� ������� 
--������������� ������ (X: category_price, Y: count)

select category_price,count as counta from products_price_categories_with_makers;

--task11 (lesson4)
-- ������������ �����: �� ���� products_price_categories_with_makers �� ������� 
--�� A & D ������ (X: category_price, Y: count)

select category_price,count as counta from products_price_categories_with_makers
where maker = 'A' or maker = 'D';

--task12 (lesson4)
-- �������: ������� ����� ������� ships, �� � �������� ������� �� ������ ���������� � ����� N (ships_without_n)
create table ships_without_n as
select *
from ships
where name not ilike 'n%';

select *
from ships_without_n;