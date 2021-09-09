--ДОМАШНЯЯ РАБОТА 8 ЗАДАНИЕ (9 УРОК)

--ОСТАЛОСЬ С УРОКА
--task6 (lesson9)
-- Компьютерная фирма: Получить количество ПК и среднюю цену для каждой модели, средняя цена которой менее 800
select model,count(*),avg(price) 
from pc
group by model
having avg(price) <800;

--ДОМАШНЯЯ

--task1  (lesson9)
-- oracle: https://www.hackerrank.com/challenges/the-report/problem
SELECT CASE WHEN (STUDENTS.MARKS < 70) THEN 'NULL' ELSE STUDENTS.NAME END,GRADES.GRADE,STUDENTS.MARKS
FROM STUDENTS, GRADES WHERE STUDENTS.MARKS >= GRADES.MIN_MARK AND STUDENTS.MARKS <= GRADES.MAX_MARK ORDER BY GRADES.GRADE DESC, STUDENTS.NAME ASC;
--task2  (lesson9)
-- oracle: https://www.hackerrank.com/challenges/occupations/problem
select doc,prof,singer,act from ( select row_number() over(partition by Occupation order by Name) ron,Name as n,Occupation as o from OCCUPATIONS ) pro pivot(max(n)for o in ('Doctor' as doc,'Actor' as act,'Professor' as prof,'Singer' as singer))order by ron asc;

--task3  (lesson9)
-- oracle: https://www.hackerrank.com/challenges/weather-observation-station-9/problem
select distinct city from station where city Not like 'A%' and city Not like 'E%' and city Not like 'I%' and city Not like 'O%' and city not like 'U%';

--task4  (lesson9)
-- oracle: https://www.hackerrank.com/challenges/weather-observation-station-10/problem
select distinct city from station where city Not like '%a' and city Not like '%e' and city Not like '%i' and city Not like '%o' and city not like '%u';
--task5  (lesson9)
-- oracle: https://www.hackerrank.com/challenges/weather-observation-station-11/problem
select distinct city from station where city Not like '%a' and city Not like '%e' and city Not like '%i' and city Not like '%o' and city not like '%u' or city Not like 'A%' and city Not like 'E%' and city Not like 'I%' and city Not like 'O%' and city not like 'U%';
--task6  (lesson9)
-- oracle: https://www.hackerrank.com/challenges/weather-observation-station-12/problem
select distinct city from station where city Not like '%a' and city Not like '%e' and city Not like '%i' and city Not like '%o' and city not like '%u' and city Not like 'A%' and city Not like 'E%' and city Not like 'I%' and city Not like 'O%' and city not like 'U%';
--task7  (lesson9)
-- oracle: https://www.hackerrank.com/challenges/salary-of-employees/problem
select name from Employee where salary>2000 and months<10 order by employee_id;
--task8  (lesson9)
-- oracle: https://www.hackerrank.com/challenges/the-report/problem
SELECT CASE WHEN (STUDENTS.MARKS < 70) THEN 'NULL' ELSE STUDENTS.NAME END,GRADES.GRADE,STUDENTS.MARKS
FROM STUDENTS, GRADES WHERE STUDENTS.MARKS >= GRADES.MIN_MARK AND STUDENTS.MARKS <= GRADES.MAX_MARK ORDER BY GRADES.GRADE DESC, STUDENTS.NAME ASC;