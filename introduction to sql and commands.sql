use ecommerce;



-- DDL (Data Definition Language) is used to define and modify database structures.
-- Create a table
create table products(
product_id int(4) primary key,
product_title varchar(100) not null,
price int not null
);

--alter table
alter table products add column stock varchar(10);


create table customers(
customerID int primary key,
customer_name varchar(50) not null,
mobile_no int(10) unique
);

drop table customers;

create table orders(
order_id int(5) primary key,
product_id int,
foreign key (product_id) references products(product_id) on delete cascade on update cascade,
customerID int,
Foreign Key (customerID) REFERENCES customers(customerID)  on delete cascade on update cascade,
amount int not null
);



-- DML (Data Manipulation Language) is used to manage data within schema objects.
-- Insert a record into the products table
insert INTO
products(product_id,product_title,price,stock)
VALUES
(2123,"smart phone",9999,"available"),
(3213,"laptop",70000,"NA"),
(7463,"earbuds",4000,"NA"),
(3432,"Television",56000,"available"),
(7638,"Air Conditioner",40000,"available");



-- Insert a record into the customers table
insert into
customers(customerID,customer_name,mobile_no,age)
VALUES
(221,"Ashwith",876789376,20),
(222,"Vijay",976586728,17),
(223,"Latha",938162445,40),
(224,"Mallesh",986668887,44),
(225,"Venu",888511721,19);



-- Insert a record into the orders table
insert INTO
orders(order_id,product_id,customerID,amount,order_description)
VALUES
(321,7638,221,40000,"AC"),
(322,7463,222,4000,"SONY");


-- Delete a record from the customers table
DELETE FROM customers WHERE age = 19;


-- update a record
update customers set age = 20 where customerID = 225;


-- DCL (Data Control Language) is used to control access to data in the database.


-- Grant a user permissions
GRANT SELECT, INSERT, UPDATE ON School.Students TO 'user1'@'localhost';

-- Revoke a user's permissions
REVOKE INSERT, UPDATE ON School.Students FROM 'user1'@'localhost';

-- Create a user
CREATE USER 'user1'@'localhost' IDENTIFIED BY 'password';

-- Drop a user
DROP USER 'user1'@'localhost';

-- Grant all privileges on the database to a user
GRANT ALL PRIVILEGES ON School.* TO 'user1'@'localhost';

-- Show privileges granted to a user
SHOW GRANTS FOR 'user1'@'localhost';

-- DQL (Data Query Language) is used to fetch data from the database.
-- Select all records from the Students table
SELECT * FROM Students;

-- Select specific columns from the Students table
SELECT StudentID, Name, Age FROM Students;

-- Select records with a condition
SELECT * FROM Students WHERE Age > 18;

-- Select records with sorting
SELECT * FROM Students ORDER BY Name ASC;

-- Aggregate functions and grouping
SELECT Age, COUNT(*) AS NumberOfStudents FROM Students GROUP BY Age;








