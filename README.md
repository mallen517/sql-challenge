# sql-challenge

It’s been two weeks since you were hired as a new data engineer at Pewlett Hackard (a fictional company). Your first major task is to do a research project about people whom the company employed during the 1980s and 1990s. All that remains of the employee database from that period are six CSV files.

For this project, you’ll design the tables to hold the data from the CSV files, import the CSV files into a SQL database, and then answer questions about the data. That is, you’ll perform data modeling, data engineering, and data analysis, respectively.


#tableschemata
CREATE TABLE departments (
dept_no VARCHAR(10),
dept_name VARCHAR(50) NOT NULL,
PRIMARY KEY (dept_no)
);

SELECT * FROM departments

CREATE TABLE dept_emp (
emp_no INT NOT NULL,
dept_no VARCHAR(10) NOT NULL,
FOREIGN KEY (dept_no) REFERENCES departments(dept_no)
);

select * from dept_emp

CREATE TABLE dept_manager (
dept_no VARCHAR(10),
emp_no INT NOT NULL
);

SELECT * FROM DEPT_MANAGER

-- Create a foreign key constraint to reference the "DEPARTMENTS" table
ALTER TABLE DEPT_MANAGER
ADD CONSTRAINT fk_dept_manager_deptno
FOREIGN KEY (dept_no) REFERENCES DEPARTMENTS (dept_no);

-- Create a foreign key constraint to reference the "DEPT_EMP" table
ALTER TABLE DEPT_MANAGER
ADD CONSTRAINT fk_dept_manager_empno
FOREIGN KEY (emp_no) REFERENCES DEPT_EMP (emp_no);





SELECT * FROM employees

CREATE TABLE employees (
    emp_no INT,
    emp_title_id VARCHAR(10),
    birth_date DATE,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    sex VARCHAR(1),
    hire_date DATE
);



ALTER TABLE employees
ADD CONSTRAINT unique_emp_no
UNIQUE (emp_no);

CREATE TABLE salaries (
    emp_no INT,
    salary DECIMAL,
    FOREIGN KEY (emp_no) REFERENCES employees (emp_no)
);

CREATE TABLE titles (
	title_id varchar(5) PRIMARY KEY,
	title varchar(30)
);

select * from titles

###queries
-- list employee number, last name, first name, sex, and salary
SELECT e.emp_no, e.last_name, e.first_name, e.sex, s.salary
FROM employees e
JOIN salaries s
ON e.emp_no = s.emp_no;

---List the first name, last name, and hire date for the employees who were hired in 1986
SELECT first_name, last_name, hire_date
FROM employees
WHERE hire_date BETWEEN '1986-01-01' AND '1986-12-31'
ORDER BY hire_date ASC;

---List the manager of each department along with their department number, department name, employee number, last name, and first name
SELECT dm.dept_no, d.dept_name, dm.emp_no, e.last_name, e.first_name 
FROM dept_manager dm
JOIN employees e
ON dm.emp_no = e.emp_no
JOIN departments d
ON dm.dept_no = d.dept_no
ORDER BY d.dept_name ASC;

---List the department number for each employee along with that employee’s employee number, last name, first name, and department name.
SELECT d.dept_no, d.dept_name, e.emp_no, e.last_name, e.first_name 
FROM employees e
JOIN dept_emp de 
ON e.emp_no = de.emp_no
JOIN departments d
ON d.dept_no = de.dept_no
ORDER BY d.dept_no ASC;

---List first name, last name, and sex of each employee whose first name is Hercules and whose last name begins with the letter B.
SELECT first_name, last_name, sex
FROM employees e
WHERE first_name = 'Hercules' AND last_name LIKE 'B%'
ORDER BY last_name ASC;

---List each employee in the Sales department, including their employee number, last name, and first name
SELECT e.emp_no, e.last_name, e.first_name, d.dept_name
FROM employees e
JOIN dept_emp de 
ON e.emp_no = de.emp_no
JOIN departments d
ON d.dept_no = de.dept_no
WHERE d.dept_name = 'Sales';

---List each employee in the Sales and Development departments, including their employee number, last name, first name, and department name.
SELECT e.emp_no, e.last_name, e.first_name, d.dept_name
FROM employees e
JOIN dept_emp de 
ON e.emp_no = de.emp_no
JOIN departments d
ON d.dept_no = de.dept_no
WHERE d.dept_name = 'Sales' OR d.dept_name = 'Development'
ORDER BY d.dept_name ASC;

---List the frequency counts, in descending order, of all the employee last names (that is, how many employees share each last name)
SELECT last_name, count(emp_no) as count_emp_with_same_last_name
FROM employees e
GROUP BY last_name
ORDER BY count_emp_with_same_last_name DESC;


###------ERD-------
departments
--
dept_no VARCHAR(10) PK
dept_name VARCHAR(50)

dept_emp
--
emp_no INT FK >- employees.emp_no
dept_no VARCHAR(10) FK >- departments.dept_no

dept_manager
--
dept_no VARCHAR(10) FK >- dept_emp.dept_no
emp_no INT FK >- employees.emp_no

#  Create a foreign key constraint to reference the "DEPARTMENTS" table
#  Create a foreign key constraint to reference the "DEPT_EMP" table
employees
--
emp_no INT
emp_title_id VARCHAR(10)
birth_date DATE
first_name VARCHAR(50)
last_name VARCHAR(50)
sex VARCHAR(1)
hire_date DATE

salaries
--
emp_no INT FK >- employees.emp_no
salary DECIMAL

titles
--
title_id varchar(5) FK >- employees.emp_title_id
title varchar(30)
