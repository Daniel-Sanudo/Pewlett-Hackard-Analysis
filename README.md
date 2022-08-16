# Pewlett-Hackard-Analysis  

By using PostgreSQL and PGAdmin, we'll analyze the distinct csv formatted files to obtain the relevant information for the changes in staffing that will be caused by the retirement of the employees born between 1952 and 1955.

The databases that will be used are shown in the following image as well as how they're related to each other using their are shown in the following ERD:

![DB_ERD](/EmployeeDB.png)

The relations drawn in the ERD are a clear method to stablish how to obtain the data that's stored in the different files through the use of joins.

By using the appropriate queries, new data tables are generated according to the objective that's stablished for each.

## Overview of Project

Pewlet Hackard is a company with almost 250,000 working employees according to the sumation of the extracted entries. Based on the birthdate range (1952 to 1955) that's specified for the retirement package, around 72,500 employees will retire soon, that's around 30% of the current employees, and a significant amount of expertise years if we add up the time that everyone has worked here.

To prepare for the upcoming retirements, we need to quantify just how many of our employees will retire, so that our HR department can get started with the hiring process. This is why we used PostgreSQL to analyze this information.

We had to filter out the employees that no longer work with Pewlett Hackard, this information is included in the to_date of the CSV files. After getting the current employees and their positions we could then figure a realistic outlook of what to expect and what to do to prepare for the retirement of our employees.

## Results

![Retiring_employees_title_count](/Images/Count_of_retiring_employees_by_title.png)

* This table was saved in the retiring_titles query from our queries. A glimpse shows that most of our retiring employees have senior positions, either as engineers or staff. These two titles amount to more than half of our retiring employees. 

* From the 72,500 retirement elegible employees, 17,000 of them did not achieve a senior position and are still working as either engineers or staff. This means that almost a fourth part of our employees could not reach into a higher position so it would be worth to look further into the reasons for this

* Among our retiring employees, only 2 of them are managers, which means that this area won't be as affected as the others.

![Mentors](/Images/Available_Mentors.png)

* Mentors are selected according to their birthdate; for our analysis, the mentors should have been born in 1965. According to our queries, this means that only 1549 employees would be tasked with mentoring the future hires, which if we assume would be equal to the amount of retired employees, then they'd have to teach around 72,500 employees. This would need a further breakdown to see which areas would need more or less mentors.

## Summary

The following section will address the following questions; roles that will require new hires, the mentor/mentee distribution and the 2 additional questions about the total count of employees by gender, as well as the salary differences between positions, retirement condition and gender.

### Roles that will be needed

![Retirement_Breakdown](/Images/Retirements_per_year.png)

Using the birthdate of the Pewlett Hackard employees, it's possible to determine how many positions will be opened after they retire. On average, each year we'll have 6000 Senior positions available.

The 2 retired managers were born on 1952 and 1955 so there's plenty of time to look for someone new who can fulfill these duties.

On average, 18,000 positions will be opened each year.

### Mentors and mentees

![Mentors_per_mentees](/Images/Mentors_mentees_and_retiring_employees.png)

This table breaks down the count of employees per department into the total count, the retired employees and the available mentors.

Assuming our HR team hires the same amount of employees as those who will retire from Pewlett Hackard, the mentors would have to intrusct the amount of mentees specified in the rightmost column.

The Finance, Production, Quality Management might need some additional mentors since each would have to instruct at least 50 new employees.

### Employees by gender count

![Employees_gender_count](/Images/Count_of_employees_by_gender.png)

Around 30% of our employees by gender groups will retire, leaving 100,000 male employees and 66,980 female employees. Its noticeable that there' a significant gap between the count of both gender groups, this could mean that Pewlett Hackard could try a initiative to motivate women to join the company in order to even out the proportions.

### Position salary per age and gender

![Salary_comparison_chart](/Images/Salary_per_title_gender.png)

![Salary_comparison_table](/Images/Salary_per_title_gender_table.png)

The salary comparison raises some interesting trends:

1. The staff positions have a much higher pay than even the manager positions.

2. The Manager positions have a noticeable wage gap regarding both gender, and the retirement age of the employees. Male employees that are not in the retirement range earn almost 30% more than female employees in retirement age.

3. The rest of the positions are paid almost the same.

Although only 2 managers will retire, Pewlett Hackard will have a slightly if all expense on manager wages. However this gap of almost 30% should be addressed.