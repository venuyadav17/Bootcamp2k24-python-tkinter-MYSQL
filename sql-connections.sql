-- install my-sql-connector-python in bash
pip install mysql-connector-python

-- Connect to the MySQL Database

import mysql.connector
from mysql.connector import Error

try:
    connection = mysql.connector.connect(
        host='your_host',
        user='your_username',
        password='your_password',
        database='your_database'
    )
    if connection.is_connected():
        print("Connected to MySQL database")
except Error as e:
    print("Error while connecting to MySQL", e)


-- Create a Table (if not exists)

try:
    cursor = connection.cursor()
    create_table_query = """
    CREATE TABLE IF NOT EXISTS employees (
        id INT AUTO_INCREMENT PRIMARY KEY,
        name VARCHAR(255) NOT NULL,
        position VARCHAR(255) NOT NULL,
        salary DECIMAL(10, 2) NOT NULL
    )
    """
    cursor.execute(create_table_query)
    print("Table `employees` created successfully")
except Error as e:
    print("Error creating table", e)


-- Insert Sample Values

try:
    insert_query = """
    INSERT INTO employees (name, position, salary)
    VALUES (%s, %s, %s)
    """
    values = [
        ('John Doe', 'Software Engineer', 70000),
        ('Jane Smith', 'Data Scientist', 80000),
        ('Sam Brown', 'Product Manager', 90000)
    ]
    cursor.executemany(insert_query, values)
    connection.commit()
    print("Values inserted successfully")
except Error as e:
    print("Error inserting values", e)


-- Retrieve and Display Data

try:
    select_query = "SELECT * FROM employees"
    cursor.execute(select_query)
    records = cursor.fetchall()
    for row in records:
        print(row)
except Error as e:
    print("Error fetching data", e)


-- Close the Connection

if connection.is_connected():
    cursor.close()
    connection.close()
    print("MySQL connection is closed")
