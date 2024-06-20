use byjus;


-- count()

select course_name,count(*)
from course
group by course_name
order by count(*) desc
limit 3;


-- sum()

select sum(amt) as revenue_generated
from payments;

-- avg()

select city,avg(age)
from students
group by city;

--upper

select upper(st_name)
from students;


--lower
select lower(faculty_name)
from faculty;


--length
select length(st_name)
from students
where age = 19;