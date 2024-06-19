-- SQL OPERATORS

-- arithematic operators

--addition
SELECT 10 + 20 ;

--subtraction
SELECT 20 - 10;

-- multiplication
select 10 * 3;

-- division
select 9 / 3;

--modulus
select 10 % 3;



-- comparision operators 

use byjus;

--EQUAL TO(=)

select st_name
from students
where age=20;


-- NOT EQUAL TO(!=)

select course_name
from course
where price != 4000;


-- greater than (>)

select *
from students
where age >18;


-- less than (<)

select *
from course
where price <4000;


-- greater than or equal to (>=)

select *
from students
where age>= 18;


-- less than or equal to(<=)

select *
from students
where age <= 20;



-- Logical operators

-- AND Operator
select *
from students
where age>20 AND city = "delhi";


-- OR Operator
select *from students
where age>18 or city = "hyderabad";


-- NOT

select st_name FROM students
where not age> 28;


