use ecommerce;


create table products(
product_id int(4) primary key,
product_title varchar(100) not null,
price int not null
);


create table customers(
customerID int primary key,
customer_name varchar(50) not null,
mobile_no int(10) unique
);


create table orders(
order_id int(5) primary key,
product_id int,
foreign key (product_id) references products(product_id) on delete cascade on update cascade,
customerID int,
Foreign Key (customerID) REFERENCES customers(customerID)  on delete cascade on update cascade,
amount int not null
);


insert INTO
products(product_id,product_title,price,stock)
VALUES
(2123,"smart phone",9999,"available"),
(3213,"laptop",70000,"NA"),
(7463,"earbuds",4000,"NA"),
(3432,"Television",56000,"available"),
(7638,"Air Conditioner",40000,"available");


insert into
customers(customerID,customer_name,mobile_no,age)
VALUES
(221,"Ashwith",876789376,20),
(222,"Vijay",976586728,17),
(223,"Latha",938162445,40),
(224,"Mallesh",986668887,44),
(225,"Venu",888511721,19);

insert INTO
orders(order_id,product_id,customerID,amount,order_description)
VALUES
(321,7638,221,40000,"AC"),
(322,7463,222,4000,"SONY");



-- added new column in products 
alter table products
add column stock varchar(10);

-- alter table customer and add age
alter table customers
add column age int(2);


-- alter table orders

alter table orders
add column order_description varchar(100) not NULL;

-- to see products
select * from products;

--to delete table
drop table orders;


-- To select only specific columns
select order_id,order_description,amount
from orders;