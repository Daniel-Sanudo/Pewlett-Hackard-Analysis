-- Query the titles of the retirement-elegible employees
SELECT
	employees.emp_no,
	employees.first_name,
	employees.last_name,
	titles.title,
	titles.from_date,
	titles.to_date
INTO Retirement_titles
FROM employees
INNER JOIN titles
	ON (employees.emp_no = titles.emp_no)
WHERE (employees.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY employees.emp_no;

-- Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (emp_no) 
	emp_no,
	first_name,
	last_name,
	title
INTO unique_titles
FROM Retirement_titles
WHERE to_date = ('9999-01-01')
ORDER BY emp_no ASC, to_date DESC;

-- Query the count of employees that will retire per title
SELECT
	COUNT(title),
	title
--INTO retiring_titles
FROM unique_titles
GROUP BY title
ORDER BY COUNT(title) DESC

-- Create the mentorship elegibility table
SELECT DISTINCT ON (e.emp_no)
	e.emp_no,
	e.first_name,
	e.last_name,
	e.birth_date,
	d.from_date,
	d.to_date,
	t.title
INTO mentorship_eligibilty
FROM employees as e
INNER JOIN dept_emp as d 
	ON(e.emp_no = d.emp_no)
INNER JOIN titles as t
	ON(d.emp_no = t.emp_no)
WHERE (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31') 
	AND (d.to_date = ('9999-01-01'))
ORDER BY e.emp_no;

-- Query the count of all employees per department
WITH dept_count AS (	
	SELECT DISTINCT ON (demp.emp_no)
		demp.emp_no,
		d.dept_name	
	FROM dept_emp as demp
	INNER JOIN departments as d
		ON (demp.dept_no = d.dept_no)
	WHERE (demp.to_date = ('9999-01-01'))
	)
SELECT 
	dept_count.dept_name,
	count (dept_count.emp_no)
INTO dept_count
FROM dept_count
GROUP BY dept_count.dept_name
ORDER BY count (dept_count.emp_no) DESC;

-- Query the count of the retirement-elegible employees per department
WITH retired_dept_count AS (	
	SELECT DISTINCT ON (demp.emp_no)
		demp.emp_no,
		d.dept_name	
	FROM dept_emp as demp
	INNER JOIN departments as d
		ON (demp.dept_no = d.dept_no)
	INNER JOIN employees as e
		ON (demp.emp_no = e.emp_no)
	WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31') 
		AND (demp.to_date = ('9999-01-01'))
	)
SELECT 
	retired_dept_count.dept_name,
	count (retired_dept_count.emp_no)
INTO retired_dept_count 
FROM retired_dept_count
GROUP BY retired_dept_count.dept_name
ORDER BY count (retired_dept_count.emp_no) DESC;

-- Query to analyze the salary differences between genders and the retirement elegible vs not elegible employees
WITH male_salaries AS (
	WITH male_data AS (
		SELECT
			e.gender,
			t.title,
			s.salary
		FROM 
			employees as e
		INNER JOIN
			salaries as s
			ON (e.emp_no = s.emp_no)
		INNER JOIN
			titles as t
			ON (e.emp_no = t.emp_no)
		WHERE (e.gender = ('M'))
			AND (e.birth_date > '1955-12-31')
		ORDER BY (e.emp_no)
	)
	SELECT	
		male_data.gender,
		male_data.title,
		ROUND(AVG(male_data.salary),2) as Male_no_retirement
	FROM male_data
	GROUP BY (male_data.gender, male_data.title)
	ORDER BY AVG(male_data.salary) DESC
),
    female_salaries AS (
	WITH female_data AS (
		SELECT
			e.gender,
			t.title,
			s.salary
		FROM 
			employees as e
		INNER JOIN
			salaries as s
			ON (e.emp_no = s.emp_no)
		INNER JOIN
			titles as t
			ON (e.emp_no = t.emp_no)
		WHERE (e.gender = ('F'))
			AND (e.birth_date > '1955-12-31')
		ORDER BY (e.emp_no)
	)
	SELECT	
		female_data.gender,
		female_data.title,
		ROUND(AVG(female_data.salary),2) as Female_no_retirement
	FROM female_data
	GROUP BY (female_data.gender, female_data.title)
	ORDER BY AVG(female_data.salary) DESC
),
    male_salaries_retirement AS (
	WITH male_data AS (
		SELECT
			e.gender,
			t.title,
			s.salary
		FROM 
			employees as e
		INNER JOIN
			salaries as s
			ON (e.emp_no = s.emp_no)
		INNER JOIN
			titles as t
			ON (e.emp_no = t.emp_no)
		WHERE (e.gender = ('M'))
			AND (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31') 
		ORDER BY (e.emp_no)
	)
	SELECT	
		male_data.gender,
		male_data.title,
		ROUND(AVG(male_data.salary),2) as Male_retirement
	FROM male_data
	GROUP BY (male_data.gender, male_data.title)
	ORDER BY AVG(male_data.salary) DESC
),
    female_salaries_retirement AS (
	WITH female_data AS (
		SELECT
			e.gender,
			t.title,
			s.salary
		FROM 
			employees as e
		INNER JOIN
			salaries as s
			ON (e.emp_no = s.emp_no)
		INNER JOIN
			titles as t
			ON (e.emp_no = t.emp_no)
		WHERE (e.gender = ('F'))
			AND (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31') 
		ORDER BY (e.emp_no)
	)
	SELECT	
		female_data.gender,
		female_data.title,
		ROUND(AVG(female_data.salary),2) as Female_retirement
	FROM female_data
	GROUP BY (female_data.gender, female_data.title)
	ORDER BY AVG(female_data.salary) DESC
)
SELECT
	ms.title,
	ms.Male_no_retirement,
	msr.Male_retirement,
	fs.Female_no_retirement,
	fsr.Female_retirement
INTO salaries_per_title_and_gender
FROM male_salaries as ms
INNER JOIN female_salaries as fs
	ON (ms.title = fs.title)
INNER JOIN male_salaries_retirement as msr
	ON (ms.title = msr.title)
INNER JOIN female_salaries_retirement as fsr	
	ON (ms.title = fsr.title)
ORDER BY ms.title DESC;