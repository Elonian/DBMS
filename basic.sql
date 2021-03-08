use test;

select name, dept_name
from instructor;

select distinct dept_name
from instructor;

select ID,name,dept_name,salary*1.1
from instructor;

select name
from instructor
where dept_name = "Comp. Sci." and salary > 70000;

select i.name, i.dept_name, d.building
from instructor as i, department as d
where i.dept_name = d.dept_name;

select *
from instructor, department;

select name, course_id
from instructor, teaches
where instructor.ID = teaches.ID;

select name, course_id
from instructor, teaches
where instructor.ID = teaches.ID and instructor.dept_name = "Comp. Sci.";

select name as instructor_name, course_id
from instructor as i, teaches as t
where i.ID = t.ID;

select distinct i.name
from instructor as i, instructor I
where i.dept_name = "Biology" and i.salary > I.salary;

select *
from department
where building like "%Watson%";

select *
from department
where building not like "______"

select *
from instructor
where dept_name = "Physics"
order by name asc, salary desc;

select *
from instructor 
where salary between 90000 and 100000

select name, course_id
from instructor as i, teaches as t
where (i.ID, i.dept_name) = (t.ID, "Biology");

    (select course_id
    from section
    where semester = "Fall" and year = 2017)
union
    (select course_id
    from section
    where semester = "Spring" and year = 2018);

    (select course_id
    from section
    where semester = "Fall" and year = 2017)
union all
    (select course_id
    from section
    where semester = "Spring" and year = 2018);

The MySQL dont support intersect and except operations
If where clause predicate came to unknown or false then tuple is not added 

select name
from instructor
where salary is not null;

select name 
from instructor
where salary > 10000 is not unknown;

select avg(salary) as avg_salary
from instructor
where dept_name = "Comp. Sci.";

select count(distinct ID)
from teaches
where semester = "Spring" and year = 2018;

select count(*)
from course;

select dept_name , avg(salary) as avg_salary
from instructor
group by dept_name; 

select i.dept_name, count(distinct i.ID) as count_id
from instructor as i, teaches as t
where i.ID = t.ID and t.semester = "Spring" and t.year = 2018
group by i.dept_name;

select dept_name, avg(salary) as avg_salary
from instructor
group by dept_name
having avg_salary > 80000;

select course_id, semester, year, sec_id, avg(tot_cred)
from student as s, takes as t
where s.ID = t.ID and year = 2017
group by course_id,semester,year, sec_id
having count(t.ID) >= 2;

select distinct course_id
from section
where year = 2018 and semester = "Spring" and course_id in (select course_id
    from section
    where year = 2017 and semester = "Fall");

select distinct course_id
from section
where year = 2018 and semester = "Spring" and course_id not in (select course_id
    from section
    where year = 2017 and semester = "Fall");

select distinct name
from instructor
where name not in ("Mozart","Einstein");

select count(distinct ID)
from takes
where (course_id,sec_id,semester,year) in (select course_id, sec_id, semester, year
from teaches
where teaches.ID = '10101');

select name
from instructor
where salary > some(select salary
from instructor
where dept_name = "Biology");

select name
from instructor
where salary > all(select salary
from instructor
where dept_name = "Biology");

select dept_name
from instructor
group by dept_name
having avg(salary) >= all(select avg(salary)
from instructor
group by dept_name);

select course_id
from section as S
where semester = "Fall" and year = 2017 and exists(select *
    from section as T
    where semester = "Spring" and year = 2018 and S.course_id = T.course_id);

select c.course_id
from course as c
where 1 >= (select count(s.course_id)
from section as s
where c.course_id = s.course_id and s.year = 2017);

select T.course_id
from course as T
where 1 < (select count(R.course_id)
from section as R
where T.course_id= R.course_id and R.year = 2017);

select dept_name, avg_salary
from (select dept_name, avg(salary) as avg_salary
    from instructor
    group by dept_name) as new
where avg_salary > 61000;

select max(tot_salary)
from (select sum(salary) as tot_salary
    from instructor
    group by dept_name) as new;

with
    max_budget(value)
    as
    (
        select max(budget)
        from department
    )
select d.dept_name, d.budget
from department as d, max_budget as md
where d.budget = md.value;

with
    dept_total(dept_name, value)
    as
    (
        select dept_name, sum(salary)
        from instructor
        group by dept_name
    )
,
    dept_total_avg(value)
    as
    (
        select avg(value)
        from dept_total
    )
select dept_name
from dept_total, dept_total_avg
where dept_total.value > dept_total_avg.value;

select dept_name , (select count(*)
    from instructor as i
    where d.dept_name = i.dept_name) as no_instr
from department as d;

update instructor 
set salary = salary *1.05;

select *
from instructor

update instructor 
set salary = case 
    when salary < 100000 then salary *1.03
    else salary*1.05
end;

select *
from instructor
