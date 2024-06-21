-- Step 1: Create the Database
CREATE DATABASE CompanyScheduleDB;
USE CompanyScheduleDB;

-- Step 2: Create the Tables
-- Create Employees Table
CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50)
);

-- Create Meetings Table
CREATE TABLE Meetings (
    MeetingID INT PRIMARY KEY,
    MeetingName VARCHAR(100),
    MeetingDate DATE,
    StartTime TIME,
    EndTime TIME
);

-- Create EmployeeMeetings Table
CREATE TABLE EmployeeMeetings (
    EmployeeID INT,
    MeetingID INT,
    PRIMARY KEY (EmployeeID, MeetingID),
    FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID),
    FOREIGN KEY (MeetingID) REFERENCES Meetings(MeetingID)
);

-- Step 3: Insert Values into the Tables
-- Insert Values into Employees
INSERT INTO Employees (EmployeeID, FirstName, LastName)
VALUES
(1, 'John', 'Doe'),
(2, 'Jane', 'Smith'),
(3, 'Emily', 'Davis'),
(4, 'Michael', 'Brown'),
(5, 'Sarah', 'Wilson');

-- Insert Values into Meetings
INSERT INTO Meetings (MeetingID, MeetingName, MeetingDate, StartTime, EndTime)
VALUES
(1, 'Project Kickoff', '2024-06-21', '09:00:00', '10:30:00'),
(2, 'Design Review', '2024-06-22', '11:00:00', '12:00:00'),
(3, 'Sprint Planning', '2024-06-23', '14:00:00', '15:30:00');

-- Insert Values into EmployeeMeetings
INSERT INTO EmployeeMeetings (EmployeeID, MeetingID)
VALUES
(1, 1),
(2, 1),
(3, 2),
(4, 3),
(5, 2),
(5, 3);

-- Step 4: Subqueries

-- 1. Subquery in the SELECT Clause
-- Retrieve each employee's name along with the number of meetings they are assigned to.
SELECT 
    E.EmployeeID, 
    E.FirstName, 
    E.LastName,
    (SELECT COUNT(*) 
     FROM EmployeeMeetings EM 
     WHERE EM.EmployeeID = E.EmployeeID) AS NumberOfMeetings
FROM Employees E;

-- 2. Subquery in the WHERE Clause
-- Retrieve details of meetings that have more than two participants.
SELECT M.MeetingID, M.MeetingName, M.MeetingDate, M.StartTime, M.EndTime
FROM Meetings M
WHERE M.MeetingID IN (
    SELECT EM.MeetingID
    FROM EmployeeMeetings EM
    GROUP BY EM.MeetingID
    HAVING COUNT(EM.EmployeeID) > 2
);

-- 3. Subquery in the FROM Clause
-- Retrieve the average meeting duration for each meeting date.
SELECT 
    MeetingDate, 
    AVG(Duration) AS AverageDuration
FROM (
    SELECT 
        M.MeetingDate, 
        TIMEDIFF(M.EndTime, M.StartTime) AS Duration
    FROM Meetings M
) AS MeetingDurations
GROUP BY MeetingDate;

-- 4. Correlated Subquery
-- Retrieve the names of employees who are part of the meeting with the highest number of participants.
SELECT 
    E.EmployeeID, 
    E.FirstName, 
    E.LastName
FROM Employees E
WHERE E.EmployeeID IN (
    SELECT EM.EmployeeID
    FROM EmployeeMeetings EM
    WHERE EM.MeetingID = (
        SELECT EM2.MeetingID
        FROM EmployeeMeetings EM2
        GROUP BY EM2.MeetingID
        ORDER BY COUNT(EM2.EmployeeID) DESC
        LIMIT 1
    )
);

-- 5. Subquery with EXISTS
-- Retrieve details of employees who are assigned to at least one meeting.
SELECT 
    E.EmployeeID, 
    E.FirstName, 
    E.LastName
FROM Employees E
WHERE EXISTS (
    SELECT 1
    FROM EmployeeMeetings EM
    WHERE EM.EmployeeID = E.EmployeeID
);
