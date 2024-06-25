-- Create a view to display total sales by customer
CREATE VIEW vw_total_sales_by_customer AS
SELECT
    c.customer_id,
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
    SUM(o.total_amount) AS total_sales
FROM
    Customers c
JOIN
    Orders o ON c.customer_id = o.customer_id
GROUP BY
    c.customer_id, customer_name;

-- Create a view to display product details along with stock information
CREATE VIEW vw_product_stock_details AS
SELECT
    p.product_id,
    p.product_name,
    p.unit_price,
    s.stock_quantity,
    s.reorder_level
FROM
    Products p
JOIN
    Stock s ON p.product_id = s.product_id;

-- Create a view to display monthly sales summary
CREATE VIEW vw_monthly_sales_summary AS
SELECT
    YEAR(order_date) AS order_year,
    MONTH(order_date) AS order_month,
    SUM(total_amount) AS total_sales
FROM
    Orders
GROUP BY
    order_year, order_month
ORDER BY
    order_year DESC, order_month DESC;
