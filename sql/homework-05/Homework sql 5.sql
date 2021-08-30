---�������� ������ 5 (6 ����)

--task5  (lesson6)
-- ������������ �����: ������� ������� all_products_with_index_task5 ��� ����������� ���� ������ �� ����� code (union all) 
--� ������� ���� (flag) �� ���� > ������������ �� ��������.
-- ����� �������� ��������� (����� ������� �������) �� ������ ��������� �������� � ������� ����������� ���� (price_index).
-- �� ����� price_index ������� ������

create table all_products_with_index_task5 as
select *,
case 
	when price > (select max(price) from printer)
	then 1
	else 0
end flag 
from 
(
select price, product.model,maker,product.type from product join printer  on product.model = printer.model
union all
select price, product.model,maker,product.type from product join laptop  on product.model = laptop.model
union all
select price, product.model,maker,product.type from product join pc  on product.model = pc.model
)a;

select *,row_number () over (partition by type order by price)as price_index
from all_products_with_index_task5;

create index price_index on all_products_with_index_task5(price);