-- ===========================================================================
-- Contains solved Queries for only  Employees Datasets 
-- ===========================================================================


-- Q1.Display all employee details.

  SELECT *FROM Employees;


-- Q2. Show only employees working in the IT department.

  SELECT  EmpName,Department FROM Employees
  WHERE Department = 'IT';

-- Q3.Find employees whose salary is greater than 80,000.

  SELECT  EmpName ,Salary 
  FROM Employees
  WHERE Salary > 80000
  ORDER BY salary DESC;


-- Q4.List employees hired after 2020.

  SELECT EmpName ,HireDate  FROM Employees
  WHERE YEAR(HireDate) > 2020;


-- Q5..Show distinct departments.

  SELECT DISTINCT Department 
  FROM Employees;

-- Q6. Find the average salary of all employees.

	SELECT AVG(salary) as Avg_Salary
	FROM Employees;

-- Q7. Find the total salary paid per department.
	SELECT Department , SUM(Salary) AS Total_Salary
	FROM Employees
	GROUP BY Department;
-- Q8. Display the maximum salary in each department.
	
	SELECT Department , MAX(Salary) AS Max_Salary
	FROM Employees
	GROUP BY Department;

-- Q9. Find departments having more than 2 employees.
	SELECT Department , COUNT(*) AS Emp_Count
	FROM Employees
	GROUP BY Department
	HAVING COUNT(*) > 2;

-- Q10. Count how many employees work under each ManagerID.
	
	SELECT ManagerID , COUNT(*) AS Emp_count
	FROM Employees
	GROUP BY ManagerID;


--Q11. Find employees whose salary is greater than the average salary of the company.
	SELECT EmpName ,Salary FROM Employees
	WHERE Salary > (
					SELECT AVG(SALARY) FROM Employees
					);

--Q12. Display employees who work in the same department as Rahul.
	SELECT EmpName ,Department
	FROM Employees
	WHERE Department IN (Select Department FROM Employees
						WHERE EmpName ='Rahul');

--Q13. Find employees earning the highest salary in the table.

	SELECT EmpName , Salary 
	FROM Employees
	WHERE salary = (Select MAX(salary) FROM Employees);

--Q14. Display employees whose salary is greater than their department’s average salary.
					 
	SELECT EmpName ,Department, Salary  
	FROM(
	     SELECT EmpName ,Department,  Salary , AVG(salary) OVER(Partition by Department) as avg_salary
		 FROM Employees
		 )t
		 WHERE salary > avg_salary
		 ORDER BY Salary DESC;

--Q15. Find departments where the average salary is greater than 80,000.
	
	SELECT Department  ,AVG(Salary)
	FROM Employees
	GROUP BY Department
	HAVING AVG(salary) > 80000;

	OR 


	SELECT DISTINCT Department, avg_salary
	FROM  
		(
	    SELECT *,
	           AVG(Salary) OVER (PARTITION BY Department) AS avg_salary
	    FROM Employees
		) t
	WHERE avg_salary > 80000;

-- Q16. Show employee name and their manager name.

SELECT e1.EmpName,e2.EmpName AS Manager_Name FROM Employees e1
LEFT JOIN  Employees e2
ON e1.ManagerID = e2.EmpID;

-- Q17. List employees who do NOT have a manager.

SELECT EmpName 
FROM Employees
WHERE ManagerID IS NULL;

		 -- OR 
 -- 
SELECT e1.EmpName FROM Employees e1
LEFT JOIN  Employees e2
ON e1.ManagerID = e2.EmpID
WHERE e1.ManagerID IS NULL;

-- Q18. Find employees whose manager earns more than 100,000.

					--Detailed Version
	SELECT 
		e1.EmpName ,
		e1.Salary , 
		e2.EmpName AS Manager_Name ,
		e2.Salary as Manager_Salary 
	FROM Employees e1
	LEFT JOIN  Employees e2
	ON e1.ManagerID = e2.EmpID
	WHERE e2.Salary > 100000;
 
						 --OR
  
	SELECT e1.EmpName  FROM Employees e1
	LEFT JOIN  Employees e2
	ON e1.ManagerID = e2.EmpID
	WHERE e2.Salary > 100000;

-- Q19 Rank employees by salary within each department.

	SELECT EmpName ,Department ,Salary ,
	ROW_NUMBER() OVER(PARTITION BY Department  ORDER BY Salary DESC) as Rank
	FROM Employees;

-- Q20. Find the 2nd highest salary in each department.
	
	SELECT 
		EmpName ,
		Department ,
		Salary 
	FROM (
		SELECT * , 
		DENSE_RANK() OVER(PARTITION BY Department  ORDER BY Salary DESC) as Rank
		FROM Employees
		 )t
		 WHERE Rank =2;

-- Q21. Display employee salary along with the average salary of their department.
 
 	SELECT EmpName,  Department , salary ,Dept_avg_salary
	FROM (
			SELECT * , 
			AVG(salary) OVER(Partition By Department ) as Dept_avg_salary
			FROM Employees
			)t;
			
-- Q22. Identify employees whose salary is above their department average.
 
	SELECT EmpName , Department , Salary 
	FROM (
		 SELECT *,
			AVG(Salary) OVER(Partition By Department) as Dept_avg_salary
		FROM Employees
		)t
		Where Salary > Dept_avg_salary;

-- Q23. Assign row numbers to employees based on HireDate (earliest first).
 
	SELECT EmpName , HireDate ,
	ROW_NUMBER() OVER(ORDER BY HireDate ASC) as RowNum
	FROM EMployees;

-- Q24. Create a column SalaryGrade:

	--Salary ≥ 100000 → High

	--Salary between 70000 and 99999 → Medium

	--Else → Low

	SELECT EmpName , Salary ,
	CASE 
		WHEN Salary>=100000 THEN 'High'
		WHEN Salary BETWEEN 70000 AND 99999 THEN 'Medium'
		ELSE 'Low'
	END AS Salar_Grade
	FROM Employees;


-- Q25. Display employees who were hired before their manager.

	SELECT 
		e1.EmpName  ,
		e1.HireDate  As Emp_HireDate,
		e2.EmpName AS Manager_name ,
		e2.HireDate As Manager_HireDate
	FROM Employees e1
	LEFT JOIN Employees e2
	ON e1.ManagerID = e2.EmpID
	WHERE e1.HireDate > e2.HireDate;

--Q26. Find employees who were hired earliest in each department.

	SELECT EmpName , Department , HireDate 
	FROM(
		SELECT
			EmpName ,
			Department ,
			HireDate, 
			ROW_NUMBER() OVER(Partition by Department ORDER BY HireDate ASC) as Rank
		FROM Employees
			)t
	WHERE Rank =1;

-- Q27 Find the highest salary from the Employees table.
	SELECT 
		EmpName ,
		salary ,
		salary_rank 
	FROM (
		SELECT *,
		DENSE_RANK() OVER(ORDER BY salary DESC) as salary_rank
		FROM Employees
	)t
	Where salary_rank =1;


-- Q28 Find the second highest salary.
	SELECT EmpName ,salary ,salary_rank 
	FROM (
	SELECT *,
	DENSE_RANK() OVER(ORDER BY salary DESC) as salary_rank
	FROM Employees
	)t
	Where salary_rank =2;

-- Q29 Fetch employees whose salary is greater than the average salary.
	SELECT EmpName , Salary , Avg_salary
	FROM(
	SELECT *,
	AVG(salary) OVER() as Avg_salary
	FROM Employees
	)t
	WHERE salary > Avg_salary
	ORDER By Salary DESC;

	-- OR 

	SELECT EmpName , Salary 
	FROM Employees
	WHERE Salary>(SELECT AVG(Salary) FROM Employees)
	ORDER BY Salary DESC;


-- Q30 Count total number of employees.
	SELECT
		COUNT(EmpID) AS Total_Employees 
	FROM Employees;
-- Q31 Count number of employees in each department.
	SELECT 
		Department ,
		COUNT(EmpID) AS Total_Employees 
	FROM Employees
	GROUP By Department;

-- Q32Find departments having more than 3 employees.

	SELECT DISTINCT Department ,Total_Employees
	FROM (
		SELECT 
			Department ,
			COUNT(EmpID) OVER(Partition By Department)AS Total_Employees 
		FROM Employees
	)t
	WHERE Total_Employees >3 ;

	-----    OR

	SELECT Department , COUNT(EmpID)
	FROM Employees
	GROUP BY Department
	HAVING COUNT(EmpID)>3;

-- Q33 Retrieve employees with the minimum salary.

	SELECT 
		EmpName ,
		Salary 
	FROM Employees
	WHERE Salary = ( SELECT MIN(Salary) FROM Employees);
-- Q34 Get top 3 highest paid employees.
	
	SELECT 
		TOP(3) 
		EmpName,
		Salary 
	FROM EMployees
	ORDER By Salary DESC;

	      -- OR 

	SELECT 
		EmpName ,
		Salary
	FROM (
		SELECT *,RANK() OVER(ORDER BY salary DESC) as Salary_rank 
		FROM Employees
		)t
	Where Salary_rank <=3
-- Q35 Find employees whose department is NULL.

   SELECT EmpName ,Department
   FROM Employees
   WHERE Department IS NULL ;

-- Q36 Find duplicate employee names.

	SELECT EmpNAme, COUNT(*) AS EmpCount FROM Employees
	GROUP BY EmpName 
	HAVING COUNT(*) >1;

-- Q37 Fetch employees who earn the same salary as someone else (i.e., duplicate salaries).

SELECT 
	EmpName ,
	Salary
	FROM 
		(
		SELECT *,
			COUNT(Salary) OVER(Partition By Salary) as Salary_Count
		FROM Employees
		)t
		Where Salary_Count>1;

		--OR 
		SELECT 
			EmpName,
			Salary,
			COUNT(*)
		FROM Employees
		GROUP BY EmpName, Salary
		HAVING COUNT(*) > 1;

-- Q38 Fetch the department with the highest average salary.


SELECT TOP(1) Department , AVG(salary) as Avg_salary
FROM Employees
GROUP By Department
ORDER BY AVG(salary) DESC;

--OR 
SELECT DISTINCT  TOP(1) Department , Avg_salary 
FROM
(
SELECT  Department , AVG(salary) OVER(Partition By Department)  as Avg_salary
FROM Employees
)t
ORDER BY Avg_salary DESC;




