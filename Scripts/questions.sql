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
