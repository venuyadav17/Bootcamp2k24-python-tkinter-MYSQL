-- Step 1: Create the Database
CREATE DATABASE CompanyDB;
USE CompanyDB;

-- Step 2: Create the Tables
-- Create Employees Table
CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    DepartmentID INT,
    Salary DECIMAL(10, 2)
);

-- Create Departments Table
CREATE TABLE Departments (
    DepartmentID INT PRIMARY KEY,
    DepartmentName VARCHAR(50)
);

-- Create Projects Table
CREATE TABLE Projects (
    ProjectID INT PRIMARY KEY,
    ProjectName VARCHAR(100),
    DepartmentID INT
);

-- Create EmployeeProjects Table
CREATE TABLE EmployeeProjects (
    EmployeeID INT,
    ProjectID INT,
    PRIMARY KEY (EmployeeID, ProjectID),
    FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID),
    FOREIGN KEY (ProjectID) REFERENCES Projects(ProjectID)
);

-- Step 3: Insert Values into the Tables
-- Insert Values into Departments
INSERT INTO Departments (DepartmentID, DepartmentName)
VALUES
(1, 'Human Resources'),
(2, 'Engineering'),
(3, 'Marketing');

-- Insert Values into Employees
INSERT INTO Employees (EmployeeID, FirstName, LastName, DepartmentID, Salary)
VALUES
(1, 'John', 'Doe', 1, 50000.00),
(2, 'Jane', 'Smith', 2, 60000.00),
(3, 'Emily', 'Davis', 3, 55000.00),
(4, 'Michael', 'Brown', 2, 65000.00),
(5, 'Sarah', 'Wilson', 1, 70000.00);

-- Insert Values into Projects
INSERT INTO Projects (ProjectID, ProjectName, DepartmentID)
VALUES
(1, 'Project Alpha', 2),
(2, 'Project Beta', 3),
(3, 'Project Gamma', 1);

-- Insert Values into EmployeeProjects
INSERT INTO EmployeeProjects (EmployeeID, ProjectID)
VALUES
(1, 3),
(2, 1),
(3, 2),
(4, 1),
(5, 3);

-- Step 4: Complex Joins

-- 1. Inner Join with Multiple Tables
SELECT E.EmployeeID, E.FirstName, E.LastName, D.DepartmentName, P.ProjectName
FROM Employees E
INNER JOIN Departments D ON E.DepartmentID = D.DepartmentID
INNER JOIN EmployeeProjects EP ON E.EmployeeID = EP.EmployeeID
INNER JOIN Projects P ON EP.ProjectID = P.ProjectID;

-- 2. Left Join with Multiple Tables
SELECT E.EmployeeID, E.FirstName, E.LastName, D.DepartmentName, P.ProjectName
FROM Employees E
LEFT JOIN Departments D ON E.DepartmentID = D.DepartmentID
LEFT JOIN EmployeeProjects EP ON E.EmployeeID = EP.EmployeeID
LEFT JOIN Projects P ON EP.ProjectID = P.ProjectID;

-- 3. Right Join with Multiple Tables
SELECT E.EmployeeID, E.FirstName, E.LastName, D.DepartmentName, P.ProjectName
FROM Employees E
RIGHT JOIN EmployeeProjects EP ON E.EmployeeID = EP.EmployeeID
RIGHT JOIN Projects P ON EP.ProjectID = P.ProjectID
LEFT JOIN Departments D ON P.DepartmentID = D.DepartmentID;

-- 4. Full Outer Join (using UNION for MySQL)
SELECT E.EmployeeID, E.FirstName, E.LastName, D.DepartmentName, P.ProjectName
FROM Employees E
LEFT JOIN EmployeeProjects EP ON E.EmployeeID = EP.EmployeeID
LEFT JOIN Projects P ON EP.ProjectID = P.ProjectID
LEFT JOIN Departments D ON E.DepartmentID = D.DepartmentID

UNION

SELECT E.EmployeeID, E.FirstName, E.LastName, D.DepartmentName, P.ProjectName
FROM Employees E
RIGHT JOIN EmployeeProjects EP ON E.EmployeeID = EP.EmployeeID
RIGHT JOIN Projects P ON EP.ProjectID = P.ProjectID
LEFT JOIN Departments D ON E.DepartmentID = D.DepartmentID;
