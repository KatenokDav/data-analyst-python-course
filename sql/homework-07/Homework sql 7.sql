--ÄÎÌÀØÍÅÅ ÇÀÄÀÍÈÅ 7 (ÓÐÎÊ 8)

--task1  (lesson8)
-- oracle: https://leetcode.com/problems/department-top-three-salaries/
select d.Name AS Department, e.Name AS Employee, e.Salary AS Salary 
from Employee e
join Department d ON e.DepartmentId = d.Id 
where
(select count(distinct(Salary)) from Employee 
where DepartmentId = e.DepartmentId and Salary > e.Salary) < 3
order by E.DepartmentId, E.Salary desc;

--task2  (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/17

SELECT member_name, status, SUM(amount*unit_price) AS costs 
FROM FamilyMembers
JOIN Payments
    ON FamilyMembers.member_id=Payments.family_member
WHERE YEAR(date) = 2005
GROUP BY member_name, status;
--task3  (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/13
SELECT name
from Passenger
group by  name having count(name)>1;


--task4  (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/38

SELECT count(first_name) as count
FROM student
where first_name = 'Anna';

--task5  (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/35
SELECT COUNT(classroom) as count
from Schedule
where date = '2019-09-02T00:00:00.000Z';

--task6  (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/38
SELECT count(first_name) as count
FROM student
where first_name = 'Anna';

--task7  (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/32
SELECT FLOOR(AVG(YEAR(CURRENT_DATE) - YEAR(birthday))) AS age
FROM FamilyMembers;
--task8  (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/27
SELECT good_type_name,sum(unit_price) as costs
from GoodTypes g 
JOIN Payments p 
on g.good_type_id = p.payment_id
where date BETWEEN '2005-01-01T00:00:00.000Z'and '2005-12-31T00:00:00.000Z'
GROUP BY good_type_name;

--task9  (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/37
SELECT  
 (YEAR(CURRENT_DATE)-YEAR(birthday))-(RIGHT(CURRENT_DATE,5)<RIGHT(birthday,5)
  ) AS year
FROM Student
ORDER BY year 
LIMIT 1;

--task10  (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/44
SELECT MAX(TIMESTAMPDIFF(YEAR,birthday,CURRENT_DATE)) as max_year
FROM Student 
JOIN Student_in_class
    ON Student.id=Student_in_class.student
JOIN Class
    ON Student_in_class.class=Class.id
WHERE Class.name LIKE '10%';
--task11 (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/20
SELECT fm.status, fm.member_name, SUM(p.amount*p.unit_price) AS costs
FROM FamilyMembers AS fm
JOIN Payments AS p
    ON fm.member_id=p.family_member
JOIN Goods AS g
    ON p.good=g.good_id
JOIN GoodTypes AS gt
    ON g.type=gt.good_type_id
WHERE good_type_name = 'entertainment'
GROUP BY fm.status, fm.member_name;

--task12  (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/55
DELETE FROM Company
WHERE Company.id IN (
    SELECT company FROM Trip
    GROUP BY company
    HAVING COUNT(id) = (SELECT MIN(count) FROM (SELECT COUNT(id) AS count FROM Trip GROUP BY company) AS min_count)
    );

--task13  (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/45
SELECT classroom 
FROM Schedule
GROUP BY classroom
HAVING COUNT(classroom) = 
    (SELECT COUNT(classroom) 
     FROM Schedule 
     GROUP BY classroom
     ORDER BY COUNT(classroom) DESC 
     LIMIT 1);
   
--task14  (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/43
SELECT last_name
FROM Teacher t 
JOIN Schedule s 
ON t.id = s.teacher
JOIN Subject s2
on s.subject = s2.id
where name = 'Physical Culture'
ORDER BY last_name;
    
--task15  (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/63
SELECT CONCAT(last_name, '.', LEFT(first_name, 1), '.', LEFT(middle_name, 1), '.') AS name
FROM Student
ORDER BY last_name, first_name;