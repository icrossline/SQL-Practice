-- This query  will check first that DB is not present  than it will create a a New DB 


IF NOT EXISTS ( SELECT 1 FROM sys.database WHERE name = 'DataPractice')
  BEGIN 
       CREATE  DATABASE  DataPractice ;
  END;


-- This query will check if  table is present than it DROP it First then create it and insert the values
-- 'U' stand for user-defined.
IF OBJECT_ID ('Employees','U') IS NOT NULL
DROP Table Employees;
CREATE TABLE Employees (
    EmpID INT,
    EmpName VARCHAR(50),
    Department VARCHAR(50),
    Salary INT,
    ManagerID INT,
    HireDate DATE
);

INSERT INTO Employees (EmpID, EmpName, Department, Salary, ManagerID, HireDate)
VALUES
(1, 'Rahul',   'IT',      80000,  5, '2021-01-10'),
(2, 'Anjali',  'HR',      60000,  6, '2020-03-15'),
(3, 'Aman',    'IT',      90000,  5, '2019-07-22'),
(4, 'Neha',    'Finance', 75000,  7, '2022-06-01'),
(5, 'Vikram',  'IT',     120000, NULL, '2018-11-05'),
(6, 'Priya',   'HR',      95000, NULL, '2017-02-12'),
(7, 'Suresh',  'Finance',110000, NULL, '2016-09-18'),
(8, 'Riya',    'IT',      70000,  5, '2023-01-20');

