CREATE DATABASE CompanyDB;
USE CompanyDB;


CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    DepartmentID INT,
    Salary DECIMAL(10, 2)
);



CREATE TABLE Departments (
    DepartmentID INT PRIMARY KEY,
    DepartmentName VARCHAR(50)
);



INSERT INTO Employees (EmployeeID, FirstName, LastName, DepartmentID, Salary)
VALUES
(1, 'John', 'Doe', 1, 50000.00),
(2, 'Jane', 'Smith', 2, 60000.00),
(3, 'Emily', 'Davis', 3, 55000.00),
(4, 'Michael', 'Brown', 2, 65000.00),
(5, 'Sarah', 'Wilson', 1, 70000.00);



INSERT INTO Departments (DepartmentID, DepartmentName)
VALUES
(1, 'Human Resources'),
(2, 'Engineering'),
(3, 'Marketing');



-- INNER JOIN

SELECT Employees.EmployeeID, Employees.FirstName, Employees.LastName, Departments.DepartmentName
FROM Employees
INNER JOIN Departments ON Employees.DepartmentID = Departments.DepartmentID;


-- LEFT JOIN
SELECT Employees.EmployeeID, Employees.FirstName, Employees.LastName, Departments.DepartmentName
FROM Employees
LEFT JOIN Departments ON Employees.DepartmentID = Departments.DepartmentID;



--RIGHT JOIN

SELECT Employees.EmployeeID, Employees.FirstName, Employees.LastName, Departments.DepartmentName
FROM Employees
RIGHT JOIN Departments ON Employees.DepartmentID = Departments.DepartmentID;


--FULL JOIN

SELECT Employees.EmployeeID, Employees.FirstName, Employees.LastName, Departments.DepartmentName
FROM Employees
FULL OUTER JOIN Departments ON Employees.DepartmentID = Departments.DepartmentID;



--CROSS JOIN
SELECT Employees.EmployeeID, Employees.FirstName, Employees.LastName, Departments.DepartmentName
FROM Employees
CROSS JOIN Departments;



-- SELF JOIN
SELECT A.EmployeeID, A.FirstName, A.LastName, B.FirstName AS ManagerFirstName, B.LastName AS ManagerLastName
FROM Employees A, Employees B
WHERE A.EmployeeID <> B.EmployeeID AND A.DepartmentID = B.DepartmentID;
