drop database employees ;
create database employees;
use employees;

create table employee( 
	fname varchar(30), 
	minit char(1), 
	lname varchar(30), 
	ssn char(9), 
	bdate date, 
	address varchar(30), 
	sex char(1), 
	salary float(10,2), 
	super_ssn char(9), 
	dno smallint(6), 
	constraint pk_employee PRIMARY KEY (ssn) 
);


create table department( 
dname varchar(30), 
dnumber smallint, 
mgr_ssn char(9), 
mgr_start_date date, 
constraint pk_department PRIMARY KEY (dnumber) 
); 


create table dependent( 
essn char(9), 
dependent_name varchar(30), 
sex char(1), 
bdate date, 
relationship varchar(20), 
constraint pk_dependent PRIMARY KEY (essn, dependent_name) 
); 


create table dept_locations( 
dnumber smallint, 
dlocation varchar(20), 
constraint pk_dept_loc PRIMARY KEY (dnumber,dlocation) 
); 


create table project( 
pname varchar(30), 
pnumber smallint, 
plocation varchar(30), 
dnum smallint, 
constraint pk_project PRIMARY KEY (pnumber) 
); 


create table works_on( 
essn char(9), 
pno smallint, 
hours float(4,2), 
constraint pk_works_on PRIMARY KEY (essn, pno) 
);


insert into employee(fname,minit,lname,ssn,bdate,address,sex,salary,super_ssn,dno) VALUES 
('John','B','Smith','123456789','1965-01-09','731 Fondren, Houston, TX','M',30000,'333445555',5), 
('Franklin','T','Wong','333445555','1955-12-08','638 Voss, Houston, TX','M',40000,'888665555',5), 
('Alicia','J','Zelaya','999887777','1968-01-09','3321 Castle, Spring, TX','F',25000,'987654321',4), 
('Jennifer','S','Wallace','987654321','1941-06-20','291 Berry, Bellaire, TX','F',43000,'888665555',4), 
('Ramesh','K','Narayan','666884444','1962-09-15','975 Fire Oak, Humble, TX','M',38000,'333445555',5), 
('Joyce','A','English','453453453','1972-07-31','5631 Rice, Houston, TX','F',25000,'333445555',5), 
('Ahmad','V','Jabbar','987987987','1969-03-29','980 Dallas, Houston, TX','M',25000,'987654321',4), 
('James','E','Borg','888665555','1937-11-10','450 Stone, Houston, TX','M',55000,NULL,1);


insert into department(dname,dnumber,mgr_ssn,mgr_start_date) VALUES 
('Research',5,333445555,'1988-05-22'), 
('Administration',4,987654321,'1995-01-01'), 
('Headquarters',1,888665555,'1981-06-19'); 


insert into dept_locations(dnumber,dlocation) values 
(1, 'Houston'), 
(4, 'Stafford'), 
(5, 'Bellaire'), 
(5, 'Sugarland'), 
(5, 'Houston'); 


insert into works_on (essn, pno, hours) values 
('123456789', 1, 32.5), 
('123456789', 2, 7.5), 
('666884444', 3, 40.0), 
('453453453', 1, 20.0), 
('453453453', 2, 20.0), 
('333445555', 2, 10.0), 
('333445555', 3, 10.0), 
('333445555', 10, 10.0), 
('333445555', 20, 10.0), 
('999887777', 30, 30.0), 
('999887777', 10, 10.0), 
('987987987', 10, 35.0), 
('987987987', 30, 5.0), 
('987654321', 30, 20.0), 
('987654321', 20, 15.0), 
('888665555', 20, NULL); 


insert into project(pname,pnumber,plocation,dnum) values 
('ProductX', 1, 'Bellaire', 5), 
('ProductY', 2, 'Sugarland', 5), 
('ProductZ', 3, 'Houston', 5), 
('Computerization', 10, 'Stafford', 4), 
('Reorganization', 20, 'Houston', 1), 
('Newbenefits', 30, 'Stafford', 4); 


insert into dependent(essn,dependent_name,sex,bdate,relationship) values 
('333445555', 'Alice', 'F', '1986-04-05', 'Daughter'), 
('333445555', 'Theodore', 'M', '1983-10-25', 'Son'), 
('333445555', 'Joy', 'F', '1958-05-03', 'Spouse'), 
('987654321', 'Abner', 'M', '1942-02-28', 'Spouse'),
('123456789', 'Michael', 'M', '1988-01-04', 'Son'), 
('123456789', 'Alice', 'F', '1988-12-30', 'Daughter'), 
('123456789', 'Elizabeth', 'F', '1967-05-05', 'Spouse');


alter table employee
add constraint fk_super_ssn FOREIGN KEY (super_ssn) REFERENCES employee(ssn);

alter table employee
add constraint fk_dno FOREIGN KEY (dno) REFERENCES department(dnumber);

alter table dept_locations
add constraint fk_dnumber FOREIGN KEY (dnumber) REFERENCES department(dnumber);

alter table project
add constraint fk_dnum FOREIGN KEY (dnum) REFERENCES department(dnumber);

alter table works_on
add constraint fk_essn FOREIGN KEY (essn) REFERENCES employee(ssn);

alter table works_on
add constraint fk_pno FOREIGN KEY (pno) REFERENCES project(pnumber);

alter table dependent
add constraint fk_dep_essn FOREIGN KEY (essn) REFERENCES employee(ssn);

# 1. Calculate total salary of employees
select  sum(salary) from employee;

# 2. Retrieve details of all employees who draw a salary which is at least 40000.
select * from employee where salary>=40000;

# 3. Retrieve details of all female employees who draw a salary which is at least 40000.
select * from employee where salary>=40000 and sex="F";

# 4. Retrieve details of "Female" employees or employees who draw a salary which is at least 40000.
select * from employee where salary>=40000 or sex="F";

# 5. Retrieve the details of all dependents of essn 333445555.
select * from dependent where essn=333445555;

# 6. Retrieve details of projects that are based out Houston or Stafford
select * from dept_locations where dlocation in ("Houston","Stafford");

# 7. Retrieve details of projects that are based out Houston or belongs to deptartment 4.
select * from dept_locations where dlocation="Houston" or dnumber=4;

# 8. Display the name of the department and the year in which the manager was appointed. 
select dname,mgr_start_date from department;

# 9. Display the SSN of all employees who live in Houston 
select ssn from employee where address like "%Houston%";

# 10. Display employees whose name begins with J
select concat(fname," ",minit," ",lname) as employees from employee where fname like "J%";

# 11. Display details of all (male employee who earn more than 40000) or (female employees who earn less than 40000)
select * from employee 
where salary>40000 and sex="M" or
salary<40000 and sex="F";

# 12. Display the essn of employees who have worked betwen 25 and 50 hours
select essn from works_on where hours between 25 and 50;

# 13. Display the names of the project that are neither based at Houston nor at Stafford.
select pname from project where plocation not in ("Houston","Stafford");

# 14. Display the ssn and full name of all employees.
select ssn, concat(fname," ",minit," ",lname) as full_name from employee;

# 15. Display the ssn of employees sorted by their salary in ascending mode 
# Hint: Use ORDER by SALARY
select ssn from employee 
order by salary asc;

# 16. Sort the works_on table based on Pno and Hours
select * from works_on
order by Pno , Hours;

# 17. Display the average project hours
select avg(hours) from works_on;

# 18. What is the average salary of 'Male' employees.
select avg(salary) from employee
where sex="M";

# 19. What is the highest salary of female employees.
select max(salary) from employee where sex="F";

# 20. What is the least salary of male employees
select min(salary) from employee where sex="M";

# 21. Display the average project hours for each project.
select pno,avg(hours)
from works_on
group by pno;

# 22. Display the number of employees in each department in decreasing order of no. of employees.
select count(fname),dno from employee
group by dno
order by count(fname) desc;

# 23. Display the Dno of those departments that has at least 3 employees.
select dno from employee
group by dno
having count(fname)>=3 ;

# 24. Display department names where employuees draw atleast 30000 salary. Display Avearge salary by department name
select distinct d.dname 
from employee e join department d
where e.salary>=30000;
select d.dname, avg(e.salary)
from employee e join department d
group by d.dname;

# 25. Display the fname of employees working in the Research department.
select e.fname
from employee e join department d
where d.dname="research";

# 26. Display names of employees and project names for each of them.
select concat(e.fname," ",e.minit," ",e.lname) as ename,p.pname
from employee e join project p 
on e.dno=p.dnum;

# 27. Which project(s) have the least number of employees?
select pname,count(fname)
from
employee join project
on employee.dno=project.dnum
group by pname
order by count(fname) asc
limit 0,1;

# 28. Display the fname and salary of employees whose salary is more than the average salary of all the employees.
select fname,salary 
from employee
where salary>(select avg(salary) from employee);

# 29. Display the fname of those employees who work for at least 20 hours
select distinct e.fname from employee e join works_on w
on e.ssn=w.essn
where w.hours>=20;

# 30. What is the average salary of those employees who have at least one dependent ?
select fname,ssn,count(essn) as number_of_dependent ,avg(salary)
from employee join dependent
on
employee.ssn=dependent.essn
group by ssn;










