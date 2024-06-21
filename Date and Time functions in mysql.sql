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

-- Step 4: Using Date and Time Functions
-- 1. Retrieve Current Date and Time
SELECT NOW() AS CurrentDateTime;

-- 2. Calculate Duration of Each Meeting
SELECT MeetingID, MeetingName,
    TIMEDIFF(EndTime, StartTime) AS Duration
FROM Meetings;

-- 3. Meetings Scheduled for the Next Week
SELECT MeetingID, MeetingName, MeetingDate
FROM Meetings
WHERE MeetingDate BETWEEN CURDATE() AND DATE_ADD(CURDATE(), INTERVAL 7 DAY);

-- 4. Employees with Meetings Today
SELECT E.EmployeeID, E.FirstName, E.LastName, M.MeetingName, M.MeetingDate
FROM Employees E
JOIN EmployeeMeetings EM ON E.EmployeeID = EM.EmployeeID
JOIN Meetings M ON EM.MeetingID = M.MeetingID
WHERE M.MeetingDate = CURDATE();

-- 5. Meetings Count Per Day
SELECT MeetingDate, COUNT(*) AS NumberOfMeetings
FROM Meetings
GROUP BY MeetingDate;
