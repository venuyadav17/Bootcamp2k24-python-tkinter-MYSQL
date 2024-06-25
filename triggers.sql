-- Create a trigger to update a log table when a new order is inserted
CREATE TRIGGER trg_after_insert_order
AFTER INSERT ON Orders
FOR EACH ROW
BEGIN
    DECLARE order_message VARCHAR(255);
    -- Create a message for logging
    SET order_message = CONCAT('New order placed: Order ID ', NEW.order_id, ' by customer ', NEW.customer_id);
    -- Insert into the log table
    INSERT INTO Order_Logs (log_message, log_time)
    VALUES (order_message, NOW());
END;

-- Create a trigger to update total sales when an order item is updated or deleted
CREATE TRIGGER trg_after_update_or_delete_order_item
AFTER UPDATE, DELETE ON Order_Items
FOR EACH ROW
BEGIN
    DECLARE order_id INT;
    DECLARE total_sales DECIMAL(10,2);

    -- Get the order ID of the affected item
    SET order_id = (SELECT order_id FROM Orders WHERE order_id = OLD.order_id);

    -- Calculate total sales for the order
    SET total_sales = (SELECT SUM(item_price * quantity) FROM Order_Items WHERE order_id = order_id);

    -- Update the total_sales in Orders table
    UPDATE Orders SET total_sales = total_sales WHERE order_id = order_id;
END;

-- Create a trigger to prevent deletion of a product if it exists in any order
CREATE TRIGGER trg_before_delete_product
BEFORE DELETE ON Products
FOR EACH ROW
BEGIN
    DECLARE product_count INT;

    -- Check if the product exists in any order
    SET product_count = (SELECT COUNT(*) FROM Order_Items WHERE product_id = OLD.product_id);

    -- If the product is in any order, prevent deletion
    IF product_count > 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Cannot delete product; it is in active orders.';
    END IF;
END;
