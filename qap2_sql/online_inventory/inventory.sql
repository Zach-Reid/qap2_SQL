-- Online store inventory database code by Zachary Reid
CREATE TABLE products (
    id INT IDENTITY PRIMARY KEY,
    product_name VARCHAR(100),
    price DECIMAL(10, 2),
    stock_quantity INT
);

CREATE TABLE customers (
    id INT IDENTITY PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100)
);

CREATE TABLE orders (
    id INT IDENTITY PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    FOREIGN KEY (customer_id) REFERENCES customers(id)
);

CREATE TABLE order_items (
    order_id INT,
    product_id INT,
    quantity INT,
    PRIMARY KEY (order_id, product_id),
    FOREIGN KEY (order_id) REFERENCES orders(id),
    FOREIGN KEY (product_id) REFERENCES products(id)
);

--Information about the product listings
INSERT INTO products (product_name, price, stock_quantity) VALUES
('Laptop', 999.99, 50),
('iPhone', 849.99, 100),
('Headphones', 39.99, 200),
('Smart Watch', 170.00, 70),
('Nintendo Switch', 449.99, 151);

-- Customer information
INSERT INTO customers (first_name, last_name, email) VALUES
('Alph', 'Avery', 'alice.johnson@example.com'),
('Brittany', 'Brown', 'bob.smith@example.com'),
('Charlie', 'Cook', 'charlie.brown@example.com'),
('Dianna', 'Dunn', 'diana.davis@example.com');

-- The order information
INSERT INTO orders (customer_id, order_date) VALUES
(1, '2024-01-10'),
(2, '2024-01-12'),
(3, '2024-01-14'),
(1, '2024-01-15'),
(4, '2024-01-16');

-- The items for the orders
INSERT INTO order_items (order_id, product_id, quantity) VALUES
(1, 1, 1),  -- Order 1, Laptop, 1
(1, 3, 2),  -- Order 1, Headphones, 2
(2, 2, 1),  -- Order 2: Phone, 1
(2, 4, 1),  -- Order 2: Smart watch, 1
(3, 2, 3),  -- Order 3: Phone, 3 
(3, 5, 3),  -- Order 3: Switch, 1
(4, 1, 1),  -- Order 4: Laptop, 1
(4, 2, 1),  -- Order 4: Phone, 1
(5, 3, 2),  -- Order 5: Headphones, 2
(5, 4, 1),  -- Order 5: Smart watch, 1
(5, 5, 1);  -- Order 5: Switch, 1


-- Get the name and stock from each product
SELECT product_name, stock_quantity
FROM products;

-- And now the product names and quantities for one of the orders
SELECT p.product_name, oi.quantity
FROM order_items oi
JOIN products p ON oi.product_id = p.id
WHERE oi.order_id = 1;

-- Obtain all orders placed by a specific customer (let's go with Customer 1), with IDs of ordered items and quantities.
SELECT o.id AS order_id, oi.product_id, oi.quantity
FROM orders o
JOIN order_items oi ON o.id = oi.order_id
WHERE o.customer_id = 1;


-- Test lowering the stock of items after the customer places an order
UPDATE products
SET stock_quantity = stock_quantity - CASE
    WHEN id = 1 THEN 1  -- (Laptop)
    WHEN id = 3 THEN 2  -- (Headphones)
    ELSE 0
END
WHERE id IN (1, 3);

-- Remove one of the orders and the related items from the system
DELETE FROM order_items
WHERE order_id = 2;

DELETE FROM orders
WHERE id = 2;



