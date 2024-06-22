-- Step 1: Create the Database
CREATE DATABASE SchoolDB;
USE SchoolDB;

-- Step 2: Create the Tables
-- Create Students Table
CREATE TABLE Students (
    StudentID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50)
);

-- Create Classes Table
CREATE TABLE Classes (
    ClassID INT PRIMARY KEY,
    ClassName VARCHAR(100),
    ClassDate DATE,
    StartTime TIME,
    EndTime TIME
);

-- Create Enrollments Table
CREATE TABLE Enrollments (
    StudentID INT,
    ClassID INT,
    PRIMARY KEY (StudentID, ClassID),
    FOREIGN KEY (StudentID) REFERENCES Students(StudentID),
    FOREIGN KEY (ClassID) REFERENCES Classes(ClassID)
);

-- Step 3: Insert Values into the Tables
-- Insert Values into Students
INSERT INTO Students (StudentID, FirstName, LastName)
VALUES
(1, 'Alice', 'Johnson'),
(2, 'Bob', 'Smith'),
(3, 'Charlie', 'Brown'),
(4, 'Diana', 'Ross'),
(5, 'Ethan', 'Hawke');

-- Insert Values into Classes
INSERT INTO Classes (ClassID, ClassName, ClassDate, StartTime, EndTime)
VALUES
(1, 'Mathematics', '2024-09-01', '09:00:00', '10:30:00'),
(2, 'Science', '2024-09-02', '11:00:00', '12:30:00'),
(3, 'History', '2024-09-03', '13:00:00', '14:30:00');

-- Insert Values into Enrollments
INSERT INTO Enrollments (StudentID, ClassID)
VALUES
(1, 1),
(2, 1),
(3, 2),
(4, 3),
(5, 2),
(5, 3);

-- Step 4: Creating Stored Procedures, Functions, and Cursors

-- Stored Procedure: GetStudentClasses
-- A stored procedure to get classes for a specific student.
DELIMITER //

CREATE PROCEDURE GetStudentClasses(IN studID INT)
BEGIN
    SELECT C.ClassID, C.ClassName, C.ClassDate, C.StartTime, C.EndTime
    FROM Classes C
    JOIN Enrollments E ON C.ClassID = E.ClassID
    WHERE E.StudentID = studID;
END //

DELIMITER ;

-- Execute Stored Procedure
CALL GetStudentClasses(1);

-- User-Defined Function: CalculateClassDuration
-- A function to calculate the duration of a class.
DELIMITER //

CREATE FUNCTION CalculateClassDuration(startTime TIME, endTime TIME)
RETURNS TIME
BEGIN
    RETURN TIMEDIFF(endTime, startTime);
END //

DELIMITER ;

-- Use the Function
SELECT 
    ClassID, 
    ClassName, 
    CalculateClassDuration(StartTime, EndTime) AS Duration
FROM Classes;

-- Cursor Example: List Students and Their Class Counts
-- A procedure using a cursor to list students and the count of their classes.
DELIMITER //

CREATE PROCEDURE ListStudentClassCounts()
BEGIN
    DECLARE studID INT;
    DECLARE studFirstName VARCHAR(50);
    DECLARE studLastName VARCHAR(50);
    DECLARE classCount INT;
    DECLARE done INT DEFAULT 0;
    DECLARE studCursor CURSOR FOR 
        SELECT StudentID, FirstName, LastName FROM Students;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;

    OPEN studCursor;

    read_loop: LOOP
        FETCH studCursor INTO studID, studFirstName, studLastName;
        IF done THEN
            LEAVE read_loop;
        END IF;

        SELECT COUNT(*) INTO classCount
        FROM Enrollments
        WHERE StudentID = studID;

        SELECT studID, studFirstName, studLastName, classCount;

    END LOOP;

    CLOSE studCursor;
END //

DELIMITER ;

-- Execute Procedure with Cursor
CALL ListStudentClassCounts();
