CREATE DATABASE CareerHub;
GO

USE CareerHub;
GO


--------------tables-----------

CREATE TABLE Companies (
    CompanyID INT PRIMARY KEY,
    CompanyName VARCHAR(100),
    Location VARCHAR(100)
);

CREATE TABLE Jobs (
    JobID INT PRIMARY KEY,
    CompanyID INT,
    JobTitle VARCHAR(100),
    JobDescription TEXT,
    JobLocation VARCHAR(100),
    Salary DECIMAL(10,2),
    JobType VARCHAR(50),
    PostedDate DATETIME,
    FOREIGN KEY (CompanyID) REFERENCES Companies(CompanyID)
);

CREATE TABLE Applicants (
    ApplicantID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Email VARCHAR(100),
    Phone VARCHAR(20),
    Resume TEXT
);

CREATE TABLE Applications (
    ApplicationID INT PRIMARY KEY,
    JobID INT,
    ApplicantID INT,
    ApplicationDate DATETIME,
    CoverLetter TEXT,
    FOREIGN KEY (JobID) REFERENCES Jobs(JobID),
    FOREIGN KEY (ApplicantID) REFERENCES Applicants(ApplicantID)
);


CREATE TABLE Recruiters (
    RecruiterID INT PRIMARY KEY,
    Name VARCHAR(100),
    Email VARCHAR(100),
    CompanyID INT
);

CREATE TABLE Recruiters (
    RecruiterID INT PRIMARY KEY,
    Name VARCHAR(100),
    Email VARCHAR(100),
    CompanyID INT
);









---------DML----> INSERT, UPDATE, DELETE---
---------------inserting values----------(DML)

INSERT INTO Companies (CompanyID, CompanyName, Location) VALUES
(1, 'TechWave Inc.', 'Chennai'),
(2, 'DataNest Solutions', 'Bangalore'),
(3, 'CloudCore Systems', 'Hyderabad'),
(4, 'GreenEdge Pvt Ltd', 'Pune'),
(5, 'InnovaSoft', 'Delhi');


INSERT INTO Jobs (JobID, CompanyID, JobTitle, JobDescription, JobLocation, Salary, JobType, PostedDate) VALUES
(101, 1, 'Software Developer', 'Develop backend APIs using Java', 'Chennai', 75000.00, 'Full-time', '2025-06-01 10:00:00'),
(102, 2, 'Data Analyst', 'Analyze company data for insights', 'Bangalore', 60000.00, 'Full-time', '2025-06-02 09:30:00'),
(103, 3, 'Cloud Engineer', 'Maintain cloud infrastructure', 'Hyderabad', 82000.00, 'Contract', '2025-06-03 11:45:00'),
(104, 4, 'UI/UX Designer', 'Design mobile-friendly interfaces', 'Pune', 55000.00, 'Part-time', '2025-06-04 14:10:00'),
(105, 5, 'DevOps Engineer', 'Setup CI/CD pipelines', 'Delhi', 78000.00, 'Full-time', '2025-06-05 12:20:00');


INSERT INTO Applicants (ApplicantID, FirstName, LastName, Email, Phone, Resume) VALUES
(201, 'Amit', 'Kumar', 'amit.kumar@gmail.com', '9876543210', 'Resume A'),
(202, 'Sneha', 'Reddy', 'sneha.reddy@gmail.com', '9823456789', 'Resume B'),
(203, 'Rahul', 'Verma', 'rahul.verma@gmail.com', '9765432101', 'Resume C'),
(204, 'Priya', 'Menon', 'priya.menon@gmail.com', '9654321098', 'Resume D'),
(205, 'Deepak', 'Sharma', 'deepak.sharma@gmail.com', '9123456780', 'Resume E');

INSERT INTO Applications (ApplicationID, JobID, ApplicantID, ApplicationDate, CoverLetter) VALUES
(301, 101, 201, '2025-06-10 08:00:00', 'Cover letter A'),
(302, 102, 202, '2025-06-10 09:30:00', 'Cover letter B'),
(303, 103, 203, '2025-06-11 10:15:00', 'Cover letter C'),
(304, 104, 204, '2025-06-11 12:45:00', 'Cover letter D'),
(305, 105, 205, '2025-06-12 14:20:00', 'Cover letter E');


-----2.SELECT------

-- View all applicants
SELECT * FROM Applicants;

-- View jobs with salary > 70000
SELECT JobTitle, Salary FROM Jobs WHERE Salary > 70000;

---------------3. UPDATE-------
-- Update salary for a job
UPDATE Jobs SET Salary = 80000 WHERE JobID = 102;


------------4.DELETE---------
-- Delete one application
DELETE FROM Applications WHERE ApplicationID = 304;







--------DDL----------

------------ALTER-------
ALTER TABLE Recruiters
ADD Phone VARCHAR(20);

------------TRUNCATE ------------

TRUNCATE TABLE Recruiters;



------------DROP-----------

DROP TABLE Recruiters;



SELECT*FROM RECRUITERS;

-----------JOINSS-------------
  1. INNER JOINT

  SELECT 
    a.FirstName, a.LastName,
    j.JobTitle
FROM Applications ap
INNER JOIN Applicants a ON ap.ApplicantID = a.ApplicantID
INNER JOIN Jobs j ON ap.JobID = j.JobID;


------------LEFT JOINT----------

SELECT 
    j.JobTitle,
    COUNT(ap.ApplicationID) AS ApplicationCount
FROM Jobs j
LEFT JOIN Applications ap ON j.JobID = ap.JobID
GROUP BY j.JobTitle;



----------RIGHT JOIN----------
SELECT 
    a.FirstName, a.LastName,
    ap.ApplicationID
FROM Applications ap
RIGHT JOIN Applicants a ON ap.ApplicantID = a.ApplicantID;

--------FULL OUTER JOIN----
SELECT 
    a.FirstName, a.LastName,
    j.JobTitle
FROM Applicants a
FULL OUTER JOIN Applications ap ON a.ApplicantID = ap.ApplicantID
FULL OUTER JOIN Jobs j ON ap.JobID = j.JobID;


--------CROSS JOINT-
SELECT 
    a.FirstName, a.LastName,
    c.CompanyName
FROM Applicants a
CROSS JOIN Companies c;



JOIN-1(List of Applicants and the Jobs They Applied For------------

SELECT 
    a.FirstName,
    a.LastName,
    j.JobTitle,
    c.CompanyName
FROM Applications ap
JOIN Applicants a ON ap.ApplicantID = a.ApplicantID
JOIN Jobs j ON ap.JobID = j.JobID
JOIN Companies c ON j.CompanyID = c.CompanyID;



---------JOIN 2----------List All Jobs with Number of Applicants (Including 0)

SELECT 
    j.JobTitle,
    c.CompanyName,
    COUNT(ap.ApplicationID) AS TotalApplications
FROM Jobs j
JOIN Companies c ON j.CompanyID = c.CompanyID
LEFT JOIN Applications ap ON j.JobID = ap.JobID
GROUP BY j.JobTitle, c.CompanyName;



--------------SUBQUERIES------------
jobs with salary higher than the average




SELECT JobTitle, Salary
FROM Jobs
WHERE Salary > (
    SELECT AVG(Salary) FROM Jobs
);

----------applicants who applied to the job with the highest salary

SELECT a.FirstName, a.LastName
FROM Applicants a
JOIN Applications ap ON a.ApplicantID = ap.ApplicantID
WHERE ap.JobID = (
    SELECT TOP 1 JobID
    FROM Jobs
    ORDER BY Salary DESC
);

----- jobs that have not received any application


SELECT JobTitle
FROM Jobs
WHERE JobID NOT IN (
    SELECT JobID FROM Applications
);


---------company that posted the most jobs
SELECT CompanyName
FROM Companies
WHERE CompanyID IN (
    SELECT TOP 1 CompanyID
    FROM Jobs
    GROUP BY CompanyID
    ORDER BY COUNT(*) DESC
);


-------------AGGREGATE FUNCTIONS-------

----------COUNT----

SELECT COUNT(*) AS TotalJobs
FROM Jobs;

----------AVREGE-------
SELECT AVG(Salary) AS AverageSalary
FROM Jobs
WHERE Salary > 0;

SELECT JobID, COUNT(ApplicationID) AS ApplicationsCount
FROM Applications
GROUP BY JobID;

--------MAX--------

SELECT MAX(Salary) AS MaxSalary
FROM Jobs;

-------MIN------
SELECT MIN(Salary) AS MinSalary
FROM Jobs;



---------SUM---------

SELECT SUM(Salary) AS TotalSalaries
FROM Jobs;


--- Count how many applicants applied to each company


SELECT c.CompanyName, COUNT(ap.ApplicationID) AS TotalApplications
FROM Companies c
JOIN Jobs j ON c.CompanyID = j.CompanyID
JOIN Applications ap ON j.JobID = ap.JobID
GROUP BY c.CompanyName;



OPERATORS

----------LIKE-----

SELECT * FROM Applicants
WHERE FirstName LIKE 'A%';

SELECT * FROM Jobs
WHERE JobTitle LIKE '%Engineer%';







----------IN --------

SELECT * FROM Jobs
WHERE JobLocation IN ('Chennai', 'Bangalore');

SELECT * FROM Applications
WHERE JobID IN (101, 102, 103);



-----BETWEEN------

SELECT JobTitle, Salary
FROM Jobs
WHERE Salary BETWEEN 60000 AND 80000;




--------AND OR------

SELECT * FROM Jobs
WHERE JobLocation = 'Chennai' AND JobType = 'Full-time';



SELECT * FROM Applicants
WHERE Email LIKE '%@gmail.com' AND (Phone LIKE '98%' OR Phone LIKE '97%');

--------NOT PERATOR--------

SELECT * FROM Applicants
WHERE ApplicantID NOT IN (
    SELECT ApplicantID FROM Applications
    JOIN Jobs ON Applications.JobID = Jobs.JobID
    WHERE JobLocation = 'Chennai'
);


------------BULIT IN FUNCTIONS------

--------STRING FUNCTION------
SELECT FirstName, UPPER(LastName) AS LastNameCaps
FROM Applicants;

-------------LEN---------
SELECT 
    FirstName,
    LEN(CAST(Resume AS VARCHAR(MAX))) AS ResumeLength
FROM Applicants;

------------SUBSTRING-------
SELECT JobTitle, SUBSTRING(JobTitle, 1, 3) AS ShortTitle
FROM Jobs;


-------------NUMERIC FUNCTIONS--------

---ROUND--

SELECT JobTitle, ROUND(Salary, -3) AS RoundedSalary
FROM Jobs;


----ABS---
SELECT ABS(-55000) AS AbsoluteValue;

-----DATE FUNCTION----

SELECT GETDATE() AS CurrentDateTime;

---DATE DIFF--------

SELECT JobTitle, DATEDIFF(DAY, PostedDate, GETDATE()) AS DaysOpen
FROM Jobs;

------DATE ADD--

SELECT JobTitle, DATEADD(DAY, 30, PostedDate) AS Deadline
FROM Jobs;



------------------CONVERSTION FUNCTION-----------

--CAST----
SELECT JobTitle, CAST(Salary AS INT) AS RoundedSalary
FROM Jobs;

----CONVERT--
SELECT CONVERT(VARCHAR, PostedDate, 103) AS FormattedDate
FROM Jobs;




--------------------IN THE TASK----------------

----Write an SQL query to count the number of applications received for each job listing in the 
"Jobs" table. Display the job title and the corresponding application count. Ensure that it lists all 
jobs, even if they have no applications. ---


SELECT 
    j.JobTitle,
    COUNT(a.ApplicationID) AS ApplicationCount
FROM 
    Jobs j
LEFT JOIN 
    Applications a ON j.JobID = a.JobID
GROUP BY 
    j.JobTitle;


    ------6.Develop an SQL query that retrieves job listings from the "Jobs" table within a specified salary 
range. Allow parameters for the minimum and maximum salary values. Display the job title, 
company name, location, and salary for each matching job. -----

-- Declare scalar variables for salary range
DECLARE @MinSalary DECIMAL(10,2) = 60000;
DECLARE @MaxSalary DECIMAL(10,2) = 80000;

SELECT 
    j.JobTitle,
    c.CompanyName,
    j.JobLocation,
    j.Salary
FROM 
    Jobs j
JOIN 
    Companies c ON j.CompanyID = c.CompanyID
WHERE 
    j.Salary BETWEEN @MinSalary AND @MaxSalary;




    7-------------Write an SQL query that retrieves the job application history for a specific applicant. Allow a 
parameter for the ApplicantID, and return a result set with the job titles, company names, and 
application dates for all the jobs the applicant has applied to. ------------


DECLARE @ApplicantID INT = 201;  


SELECT 
    j.JobTitle,
    c.CompanyName,
    a.ApplicationDate
FROM 
    Applications a
JOIN 
    Jobs j ON a.JobID = j.JobID
JOIN 
    Companies c ON j.CompanyID = c.CompanyID
WHERE 
    a.ApplicantID = @ApplicantID;


8------------Create an SQL query that calculates and displays the average salary offered by all companies for 
job listings in the "Jobs" table. Ensure that the query filters out jobs with a salary of zero. 


    SELECT 
    AVG(Salary) AS AverageSalary
FROM 
    Jobs
WHERE 
    Salary > 0;



    9------------Write an SQL query to identify the company that has posted the most job listings. Display the 
company name along with the count of job listings they have posted. Handle ties if multiple 
companies have the same maximum count. ------------


SELECT 
    c.CompanyName,
    COUNT(j.JobID) AS JobCount
FROM 
    Companies c
JOIN 
    Jobs j ON c.CompanyID = j.CompanyID
GROUP BY 
    c.CompanyName
HAVING 
    COUNT(j.JobID) = (
        SELECT TOP 1 COUNT(JobID)
        FROM Jobs
        GROUP BY CompanyID
        ORDER BY COUNT(JobID) DESC
    );


    ---10. Find the applicants who have applied for positions in companies located in 'CityX' and have at 
least 3 years of experience. ---------


SELECT DISTINCT 
    a.FirstName,
    a.LastName,
    a.ExperienceYears
FROM 
    Applicants a
JOIN 
    Applications ap ON a.ApplicantID = ap.ApplicantID
JOIN 
    Jobs j ON ap.JobID = j.JobID
JOIN 
    Companies c ON j.CompanyID = c.CompanyID
WHERE 
    c.Location = 'CityX' AND
    a.ExperienceYears >= 3;


    -------------------------------------ALTER TABLE---------------
    ALTER TABLE Applicants
ADD ExperienceYears INT;


------------------------------------UPDATE-----------
UPDATE Applicants SET ExperienceYears = 2 WHERE ApplicantID = 201;
UPDATE Applicants SET ExperienceYears = 4 WHERE ApplicantID = 202;
UPDATE Applicants SET ExperienceYears = 3 WHERE ApplicantID = 203;
UPDATE Applicants SET ExperienceYears = 1 WHERE ApplicantID = 204;
UPDATE Applicants SET ExperienceYears = 5 WHERE ApplicantID = 205;

SELECT DISTINCT 
    a.FirstName,
    a.LastName,
    a.ExperienceYears
FROM 
    Applicants a
JOIN 
    Applications ap ON a.ApplicantID = ap.ApplicantID
JOIN 
    Jobs j ON ap.JobID = j.JobID
JOIN 
    Companies c ON j.CompanyID = c.CompanyID
WHERE 
    c.Location = 'CityX' AND
    a.ExperienceYears >= 1;


    11----------11. Retrieve a list of distinct job titles with salaries between $60,000 and $80,000
    SELECT DISTINCT JobTitle
FROM Jobs
WHERE Salary BETWEEN 60000 AND 80000;


-------12. Find the jobs that have not received any applications
SELECT JobTitle
FROM Jobs
WHERE JobID NOT IN (
    SELECT JobID FROM Applications
);

--------------13. Retrieve a list of job applicants along with the companies they have applied to and the positions they have applied for
SELECT 
    a.FirstName,
    a.LastName,
    c.CompanyName,
    j.JobTitle
FROM 
    Applicants a
JOIN 
    Applications ap ON a.ApplicantID = ap.ApplicantID
JOIN 
    Jobs j ON ap.JobID = j.JobID
JOIN 
    Companies c ON j.CompanyID = c.CompanyID;


----14. Retrieve a list of companies along with the count of jobs they have posted, even if they have not received any applications

SELECT 
    c.CompanyName,
    COUNT(j.JobID) AS JobCount
FROM 
    Companies c
LEFT JOIN 
    Jobs j ON c.CompanyID = j.CompanyID
GROUP BY 
    c.CompanyName;


---15. List all applicants along with the companies and positions they have applied for, including those who have not applied

SELECT 
    a.FirstName,
    a.LastName,
    c.CompanyName,
    j.JobTitle
FROM 
    Applicants a
LEFT JOIN 
    Applications ap ON a.ApplicantID = ap.ApplicantID
LEFT JOIN 
    Jobs j ON ap.JobID = j.JobID
LEFT JOIN 
    Companies c ON j.CompanyID = c.CompanyID;


    -------16. Find companies that have posted jobs with a salary higher than the average salary of all jobs

    SELECT DISTINCT 
    c.CompanyName
FROM 
    Companies c
JOIN 
    Jobs j ON c.CompanyID = j.CompanyID
WHERE 
    j.Salary > (
        SELECT AVG(Salary)
        FROM Jobs
        WHERE Salary > 0
    );


----17. Display a list of applicants with their names and a concatenated string of their city and state

(((
SELECT 
    FirstName,
    LastName,
    CONCAT(City, ', ', State) AS FullLocation
FROM 
    Applicants;

    SELECT * FROM Applicants;
    ))))

    ------------ALTER-----
ALTER TABLE Applicants ADD City VARCHAR(50), State VARCHAR(50);
-----------UPDATE----------
UPDATE Applicants
SET City = 'Chennai', State = 'TN'
WHERE ApplicantID = 201;
------------USING _+----------
SELECT 
    FirstName,
    LastName,
    City + ', ' + State AS FullLocation
FROM 
    Applicants;


    18-----------Retrieve a list of jobs with titles containing either 'Developer' or 'Engineer'

    SELECT 
    JobTitle
FROM 
    Jobs
WHERE 
    JobTitle LIKE '%Developer%' OR JobTitle LIKE '%Engineer%';

----------19.19. Retrieve a list of applicants and the jobs they have applied for, including those who have not applied and jobs without applicants

SELECT 
    a.FirstName,
    a.LastName,
    j.JobTitle
FROM 
    Applicants a
FULL OUTER JOIN 
    Applications ap ON a.ApplicantID = ap.ApplicantID
FULL OUTER JOIN 
    Jobs j ON ap.JobID = j.JobID;


    -----20. List all combinations of applicants and companies where the company is in a specific city and the applicant has more than 2 years of experience (e.g., Chennai)


    SELECT 
    a.FirstName,
    a.LastName,
    c.CompanyName
FROM 
    Applicants a
CROSS JOIN 
    Companies c
WHERE 
    c.Location = 'Chennai' AND
    a.ExperienceYears > 2;
