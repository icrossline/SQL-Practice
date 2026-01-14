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

	

