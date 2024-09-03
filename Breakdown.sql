CREATE TABLE Member (
    Member_ID INT PRIMARY KEY,
    First_Name VARCHAR(20),
    Last_Name VARCHAR(20),
    Member_Location VARCHAR(20),
    Member_Age INT
);

CREATE TABLE Vehicle (
    Vehicle_Registration VARCHAR(10) PRIMARY KEY,
    Vehicle_Make VARCHAR(10),
    Vehicle_Model VARCHAR(10),
    Member_ID INT,
    FOREIGN KEY (Member_ID) REFERENCES Member(Member_ID)
);

CREATE TABLE Engineer (
    Engineer_ID INT PRIMARY KEY,
    First_Name VARCHAR(20),
    Last_Name VARCHAR(20)
);


CREATE TABLE Breakdown (
    Breakdown_ID INT PRIMARY KEY,
    Vehicle_Registration VARCHAR(10),
    Engineer_ID INT,
    Breakdown_Date DATE,
    Breakdown_Time TIME,
    Breakdown_Location VARCHAR(20),
    FOREIGN KEY (Vehicle_Registration) REFERENCES Vehicle(Vehicle_Registration),
    FOREIGN KEY (Engineer_ID) REFERENCES Engineer(Engineer_ID)
);


-- vehicle foreign key set
ALTER TABLE Vehicle
ADD FOREIGN KEY (Member_ID)
REFERENCES Member(Member_ID);



-- INSERT DATA INTO TABLE --

INSERT INTO Member (Member_ID, First_Name, Last_Name, Member_Location, Member_Age)
VALUES
    (1, 'Shamim', 'Ali', 'London', 30),
    (2, 'Zak', 'Smith', 'Paris', 25),
    (3, 'Alice', 'Johnson', 'New York', 35),
    (4, 'Minam', 'Thapa', 'Tokyo', 40),
    (5, 'Emily', 'Davis', 'Sydney', 28);
    
INSERT INTO Breakdown (Breakdown_ID, Vehicle_Registration, Engineer_ID, Breakdown_Date, Breakdown_Time, Breakdown_Location)
VALUES
    (1, 'ABC123', 1, '2023-10-15', '10:30:00', 'Highway 1'),
    (2, 'DEF456', 2, '2023-11-02', '14:15:00', 'City Street'),
    (3, 'GHI789', 3, '2023-10-15', '09:45:00', 'Country Road'),
    (4, 'JKL012', 1, '2024-01-10', '17:00:00', 'Mountain Pass'),
    (5, 'MNO345', 2, '2024-03-15', '12:30:00', 'Beach Road'),
    (6, 'ABC123', 2, '2024-03-15', '08:45:00', 'Highway 2'),
    (7, 'DEF456', 3, '2024-03-18', '11:15:00', 'City Center'),
    (8, 'GHI789', 1, '2024-05-12', '15:30:00', 'Country Lane'),
    (9, 'JKL012', 2, '2024-06-18', '13:00:00', 'Mountain Trail'),
    (10, 'MNO345', 3, '2024-07-25', '16:45:00', 'Beach Boulevard'),
    (11, 'ABC123', 1, '2024-08-08', '10:00:00', 'Highway 3'),
    (12, 'DEF456', 2, '2024-09-12', '14:30:00', 'City Square');
    
INSERT INTO Vehicle (Vehicle_Registration, Vehicle_Make, Vehicle_Model, Member_ID)
VALUES
    ('ABC123', 'Mercedes', 'S-Class', 1),
    ('DEF456', 'Honda', 'Civic', 2),
    ('GHI789', 'Ford', 'Mustang', 3),
    ('JKL012', 'BMW', '3 Series', 4),
    ('MNO345', 'Nissan', 'Altima', 5),
    ('XYZ789', 'Tesla', 'Model 3', 3),
    ('PQR012', 'Audi', 'A4', 4),
    ('STU345', 'Mercedes', 'C-Class', 1);
    
INSERT INTO Engineer (Engineer_ID, First_Name, Last_Name)
VALUES
    (1, 'Mariyah', 'Ali'),
    (2, 'Emily', 'Johnson'),
    (3, 'David', 'Brown');

-- Retrieving the First 3 Members from the Member Table
SELECT *
FROM Member
LIMIT 3;

-- Retrieve 3 members, skipping the first 2. selected.
SELECT *
FROM Member
LIMIT 2 OFFSET 2;

-- 2 Retrieve all vehicles whose Vehicle_Make starts with 'T selected.
SELECT *
FROM Vehicle
WHERE Vehicle_Make LIKE 'T%';

-- retrieve all breakdowns that occurred between January 1, 2023, and June 30, 2023:
SELECT *
FROM Breakdown
WHERE Breakdown_Date BETWEEN '2023-01-01' AND '2023-06-30';


-- Retrieve details of vehicles with three Vehicle_Registration of youR own choice in the list – selected.
SELECT *
FROM Vehicle
WHERE Vehicle_Registration IN ('XYZ789', 'ABC123', 'DEF456');

-- Retrieve the number of breakdowns each vehicle has had selected.
SELECT Vehicle_Registration, COUNT(*) AS Breakdown_Count
FROM Breakdown
GROUP BY Vehicle_Registration;

-- Retrieve all members sorted by Member_Age in descending order selected.
SELECT *
FROM Member
ORDER BY Member_Age DESC;

-- retrieve all vehicles that are either 'Toyota' make or 'Honda' make, and the model starts with 'C’ selected.

SELECT *
FROM Vehicle
WHERE (Vehicle_Make = 'Mercedes' OR Vehicle_Make = 'Honda')
AND Vehicle_Model LIKE 'C%';

-- Retrieve all engineers who do not have any breakdowns assigned (use LEFT JOIN and IS NULL) selected.
SELECT Engineer.Engineer_ID, Engineer.First_Name, Engineer.Last_Name
FROM Engineer
LEFT JOIN Breakdown ON Engineer.Engineer_ID = Breakdown.Engineer_ID
WHERE Breakdown.Engineer_ID IS NULL;

-- Retrieve all members aged between 25 and 40 selected.
SELECT *
FROM Member
WHERE Member_Age BETWEEN 25 AND 40;

-- retrieve memebers between whose name starts with "J" and Lastname contains "son"
SELECT *
FROM Member
WHERE First_Name LIKE 'J%' AND Last_Name LIKE '%son';

-- retrieve top 5 oldest members
SELECT *
FROM Member
ORDER BY Member_Age DESC
LIMIT 5;

-- retrieve all vehicle registrations in uppercase
SELECT UPPER(Vehicle_Registration) 
AS Vehicle_Registration_Uppercase
FROM Vehicle;

-- retrieve the details of all memeber including vehicles they own
SELECT Member.Member_ID, Member.First_Name, Member.Last_Name, Member.Member_Location, Member.Member_Age, Vehicle.Vehicle_Registration, Vehicle.Vehicle_Make, Vehicle.Vehicle_Model
FROM Member
LEFT JOIN Vehicle ON Member.Member_ID = Vehicle.Member_ID;


-- retrieve member and any associated vehicles, including memebers who do not own any vehicles
SELECT Member.Member_ID, Member.First_Name, Member.Last_Name, Vehicle.Vehicle_Registration, Vehicle.Vehicle_Make, Vehicle.Vehicle_Model
FROM Member
LEFT JOIN Vehicle ON Member.Member_ID = Vehicle.Member_ID;


-- retrieve all Vehicles and any associated members, including vehicles that are not owned by members
SELECT Vehicle.Vehicle_Registration, Vehicle.Vehicle_Make, Vehicle.Vehicle_Model, Member.Member_ID, Member.First_Name, Member.Last_Name
FROM Vehicle
LEFT JOIN Member ON Vehicle.Member_ID = Member.Member_ID;

-- retrieve the number of breakdowns each member has had
SELECT Member.Member_ID, Member.First_Name, Member.Last_Name, COUNT(Breakdown.Breakdown_ID) AS Breakdown_Count
FROM Member
LEFT JOIN Vehicle ON Member.Member_ID = Vehicle.Member_ID
LEFT JOIN Breakdown ON Vehicle.Vehicle_registration = Breakdown.Vehicle_registration
GROUP BY Member.Member_ID;

-- retrieve all breakdowns along with memeber first and last name that occured for vehicles owned by members aged over 50
SELECT Breakdown.Breakdown_ID, Breakdown.Vehicle_Registration, Breakdown.Breakdown_Date, Breakdown.Breakdown_Time, Breakdown.Breakdown_Location, Member.First_Name, Member.Last_Name
FROM Breakdown
JOIN Vehicle ON Breakdown.Vehicle_Registration = Vehicle.Vehicle_Registration
JOIN Member ON Vehicle.Member_ID = Member.Member_ID
WHERE Member.Member_Age > 30;

-- TASK 5--SQL functions:

-- AVG():The AVG() function in SQL is used to calculate the average value of a numeric column. It returns the sum of all non-NULL values in the specified column divided by the count of non-NULL values.

SELECT department_id, AVG(salary) AS average_department_salary
FROM employees
GROUP BY department_id;

-- MAX() - MIN():The MAX() and MIN() functions in SQL are used to find the maximum and minimum values of a column, respectively.

-- Syntax:
-- MAX(column_name): Returns the maximum value in the specified column.

-- MIN(column_name): Returns the minimum value in the specified column.

SELECT department_id, MAX(salary) AS highest_department_salary, MIN(salary) AS lowest_department_salary
FROM employees
GROUP BY department_id;


-- SUM()- The SUM() function in SQL is used to calculate the sum of all non-NULL values in a numeric column. It returns the total value of the specified column.
SELECT department_id, SUM(salary) AS total_department_salary
FROM employees
GROUP BY department_id;

-- TASK 6 -- UPDATE 3 RECORDS OF YOUR OWN CHOICE FROM THE ENGINEERS TABLE

UPDATE Engineer
SET First_Name = 'JON', Last_Name = 'SMITH'
WHERE Engineer_ID IN (1, 2, 3);

-- 6.2 - DELETE 2 RECORDS OF YOUR OWN CHOICE  FROM THE BREAKDOWN TABLE

DELETE FROM Breakdown
WHERE Breakdown_ID IN (1, 2);

SELECT *
FROM BREAKDOWN;


