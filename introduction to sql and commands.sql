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

-- Grant SELECT, INSERT, UPDATE on all tables to a user 'employee'
GRANT SELECT, INSERT, UPDATE ON *.* TO 'employee'@'localhost';

-- Grant all privileges on the 'ecommerce' database to a user 'admin'
GRANT ALL PRIVILEGES ON ecommerce.* TO 'admin'@'localhost';

-- Grant SELECT permission on 'Products' table to a user 'customer'
GRANT SELECT ON ecommerce.Products TO 'customer'@'localhost';


-- Revoke INSERT, UPDATE on all tables from a user 'employee'
REVOKE INSERT, UPDATE ON *.* FROM 'employee'@'localhost';

-- Revoke all privileges on the 'ecommerce' database from a user 'admin'
REVOKE ALL PRIVILEGES ON ecommerce.* FROM 'admin'@'localhost';

-- Revoke SELECT permission on 'Products' table from a user 'customer'
REVOKE SELECT ON ecommerce.Products FROM 'customer'@'localhost';



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


-- Transaction Control Language (TCL)

-- Start a transaction
START TRANSACTION;

-- Insert a new product
INSERT INTO Products (product_name, price, stock) VALUES ('Laptop', 1200.00, 50);

-- Update stock for an existing product
UPDATE Products SET stock = stock - 1 WHERE product_id = 10;

-- Commit the transaction if all operations are successful
COMMIT;

-- If an error occurs, rollback the transaction
ROLLBACK;

-- Start a transaction
START TRANSACTION;

-- Insert a new product
INSERT INTO Products (product_name, price, stock) VALUES ('Smartphone', 800.00, 100);

-- Set a savepoint
SAVEPOINT before_update;

-- Update stock for an existing product
UPDATE Products SET stock = stock - 5 WHERE product_id = 20;

-- If an error occurs, rollback to the savepoint
ROLLBACK TO before_update;

-- Commit the transaction if all operations are successful
COMMIT;






