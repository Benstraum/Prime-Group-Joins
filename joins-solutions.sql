-- How many customers do we have

SELECT count(*) 
FROM customers;

-- How many products do we carry

SELECT count(*) 
FROM products;

-- the total amount of diet pepsi available

SELECT SUM(warehouse_product.on_hand) 
FROM products
JOIN warehouse_product 
ON products.id= warehouse_product.product_id
WHERE products.description = 'diet pepsi';

-- .getting all customers and their addresses

SELECT *
FROM customers
JOIN addresses
ON customers.id = addresses.customer_id;

-- Geting all orders and their connected line items

SELECT *
FROM orders
JOIN line_items
ON orders.id = line_items.order_id;

-- Selecting warehouses that have cheetos


SELECT *
FROM warehouse
JOIN warehouse_product 
ON warehouse.id = warehouse_product.warehouse_id
JOIN products
ON products.id = warehouse_product.product_id
WHERE  products.description = 'cheetos';

-- selecting warehouses that have pepsi

SELECT *
FROM warehouse
JOIN warehouse_product 
ON warehouse.id = warehouse_product.warehouse_id
JOIN products
ON products.id = warehouse_product.product_id
WHERE  products.description = 'diet pepsi';

-- Get the number of orders for each of the customers
-- sidenote this includes just customers with orders
SELECT customers, count(*) 
FROM orders
JOIN line_items
ON orders.id = line_items.order_id
JOIN addresses
ON addresses.id = orders.address_id
JOIN customers 
ON customers.id = addresses.customer_id
GROUP BY customers.id;


--Total cost for each order

SELECT orders.id, SUM(products.unit_price * quantity) 
FROM orders
JOIN line_items
ON orders.id = line_items.order_id
JOIN products
ON line_items.product_id = products.id
GROUP BY orders.id;


-- How much has each customer spent?

SELECT customers, SUM(products.unit_price * quantity) 
FROM customers
JOIN addresses 
ON addresses.customer_id = customers.id
JOIN orders
ON orders.address_id= addresses.id
JOIN line_items
ON orders.id = line_items.order_id
JOIN products
ON line_items.product_id = products.id
GROUP BY customers.id;
