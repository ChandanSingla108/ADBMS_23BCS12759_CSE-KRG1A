------	EASY LEVEL

CREATE TABLE TBL_EMPLOYEE( 
EMP_ID INT 
); 
INSERT INTO TBL_EMPLOYEE VALUES (2),(4),(4),(6),(6),(7),(8),(8); 
SELECT MAX(EMP_ID) as [Greatest Unique ID] FROM TBL_EMPLOYEE WHERE 
EMP_ID IN 
(SELECT EMP_ID FROM TBL_EMPLOYEE GROUP BY EMP_ID HAVING 
COUNT(EMP_ID)=1);	

--EXPERIMENT 03: (MEDIUM LEVEL)

CREATE TABLE department (
    id INT PRIMARY KEY,
    dept_name VARCHAR(50)
);

-- Create Employee Table
CREATE TABLE employees (
    id INT,
    name VARCHAR(50),
    salary INT,
    department_id INT,
    FOREIGN KEY (department_id) REFERENCES department(id)
);


-- Insert into Department Table
INSERT INTO department (id, dept_name) VALUES
(1, 'IT'),
(2, 'SALES');

-- Insert into Employee Table
INSERT INTO employees (id, name, salary, department_id) VALUES
(1, 'JOE', 70000, 1),
(2, 'JIM', 90000, 1),
(3, 'HENRY', 80000, 2),
(4, 'SAM', 60000, 2),
(5, 'MAX', 90000, 1);

-- JOINS + SUBQUERIES
SELECT D.dept_name, E.name,E.salary, D.id
FROM department as D
join employees as E
ON E.department_id = D.id
WHERE E.salary IN
(
SELECT MAX(E2.SALARY)
FROM EMPLOYEES AS E2
WHERE E2.department_id = E.department_id
)
ORDER BY D.id;

-- JOINS + GROUP BY
SELECT D.dept_name, E.name,E.salary, D.id
FROM department as D
join employees as E
ON E.department_id = D.id
WHERE E.salary IN
(
SELECT MAX(E2.SALARY)
FROM EMPLOYEES AS E2
group by e2.department_id
)
ORDER BY D.id;

--- HARD LEVEL QUESTION
-- GO WITH THE SET OPERATORS IF BOTH THE TABLES HAVE SAME DATATYPE 
CREATE TABLE TABLE_A(
EMPID INT,
ENAME VARCHAR(20),
SALARY INT
);

CREATE TABLE TABLE_B(
EMPID INT,
ENAME VARCHAR(20),
SALARY INT
);

INSERT INTO TABLE_A VALUES 
(1, 'AA', 1000),
(2,'BB', 300);

INSERT INTO TABLE_B VALUES 
(2, 'BB', 400),
(3,'CC', 100);

SELECT EMPID, ENAME, MIN(SALARY) as MIN_SALARY
FROM
(SELECT * FROM TABLE_A AS A
UNION ALL 
SELECT * FROM TABLE_B AS B) 
AS INTER_RESULT
GROUP BY EMPID, ENAME;

-- APPROACH 02:
SELECT EMPID, MIN(ENAME) AS ENAME, MIN(SALARY) as MIN_SALARY
FROM
(SELECT * FROM TABLE_A AS A
UNION ALL 
SELECT * FROM TABLE_B AS B) 
AS INTER_RESULT
GROUP BY EMPID;
