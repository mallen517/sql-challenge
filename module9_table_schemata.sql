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



------ERD-------
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
