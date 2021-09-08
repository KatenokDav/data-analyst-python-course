--ДОМАШНЕЕ ЗАДАНИЕ 6 (УРОК 7)
--colab/jupyter: https://colab.research.google.com/drive/1j4XdGIU__NYPVpv74vQa9HUOAkxsgUez?usp=sharing

--task1  (lesson7)
-- sqlite3:  Сделать тестовый проект с БД (sqlite3, project name: task1_7).В таблицу table1 записать 1000 строк с 
--случайными значениями (3 колонки, тип int) от 0 до 1000.
-- Далее построить гистаграмму распределения этих трех колонко

CREATE TABLE table1 
(
one INT NOT NULL,
two INT NOT NULL,
three INT NOT NULL
);

INSERT INTO table1(one, two, three)
SELECT floor(random() * 1000 + 1)::int, floor(random() * 1000 + 1)::int, floor(random() * 1000 + 1)::int
FROM generate_series(1, 1000) AS t(i); 

select * from table1;


--task2  (lesson7)
-- oracle: https://leetcode.com/problems/duplicate-emails/

select Email from Person group by  Email having count(Email)>1;

--task3  (lesson7)
-- oracle: 
select e1.Name from Employee e1
join Employee e2 on e1.ManagerId = e2.Id
where e1.Salary > e2.Salary;
--task4  (lesson7)
-- oracle: https://leetcode.com/problems/rank-scores/
select
  Score,
  (select count(distinct Score) from Scores where Score >= s.Score) Rank
from Scores s
order by Score desc;

--task5  (lesson7)
-- oracle: https://leetcode.com/problems/combine-two-tables/

select FirstName,LastName,City,State from Person p
left join Address a
on p.PersonId=a.PersonId;