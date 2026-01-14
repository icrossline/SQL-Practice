-- 1.Display all employee details.

SELECT *FROM Employees;


--2. Show only employees working in the IT department.

SELECT  EmpName,Department FROM Employees
WHERE Department = 'IT';

--3.Find employees whose salary is greater than 80,000.

SELECT  EmpName ,Salary 
FROM Employees
WHERE Salary > 80000
ORDER BY salary DESC;


--4.List employees hired after 2020.

SELECT EmpName ,HireDate  FROM Employees
WHERE YEAR(HireDate) > 2020;


--5..Show distinct departments.

SELECT DISTINCT Department 
FROM Employees;

