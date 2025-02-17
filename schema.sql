-- ==============================================================
-- DROP existing tables (if any) in the correct dependency order
-- ==============================================================

DROP TABLE IF EXISTS order_items;
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS products;
DROP TABLE IF EXISTS suppliers;
DROP TABLE IF EXISTS customer_addresses;
DROP TABLE IF EXISTS customers;
DROP TABLE IF EXISTS employee_details;
DROP TABLE IF EXISTS employees;
DROP TABLE IF EXISTS department_details;
DROP TABLE IF EXISTS departments;

-- ==============================================================
-- CREATE TABLES
-- ==============================================================

-- Departments table (one-to-many with Employees)
CREATE TABLE departments (
  department_id SERIAL PRIMARY KEY,
  department_name VARCHAR(100) NOT NULL
);

-- Department Details table (one-to-one with Departments)
CREATE TABLE department_details (
  department_id INTEGER PRIMARY KEY,  -- same value as departments.department_id
  location VARCHAR(100),
  budget NUMERIC(10,2),
  CONSTRAINT fk_department_details FOREIGN KEY (department_id)
    REFERENCES departments(department_id) ON DELETE CASCADE
);

-- Employees table (many-to-one with Departments)
CREATE TABLE employees (
  employee_id SERIAL PRIMARY KEY,
  first_name VARCHAR(50) NOT NULL,
  last_name VARCHAR(50) NOT NULL,
  email VARCHAR(100),
  department_id INTEGER,
  CONSTRAINT fk_employees_department FOREIGN KEY (department_id)
    REFERENCES departments(department_id)
);

-- Employee Details table (one-to-one with Employees)
CREATE TABLE employee_details (
  employee_id INTEGER PRIMARY KEY,  -- same value as employees.employee_id
  phone VARCHAR(20),
  address VARCHAR(200),
  hire_date DATE,
  CONSTRAINT fk_employee_details FOREIGN KEY (employee_id)
    REFERENCES employees(employee_id) ON DELETE CASCADE
);

-- Customers table
CREATE TABLE customers (
  customer_id SERIAL PRIMARY KEY,
  first_name VARCHAR(50) NOT NULL,
  last_name VARCHAR(50) NOT NULL,
  email VARCHAR(100) UNIQUE
);

-- Customer Addresses table (one-to-one with Customers)
CREATE TABLE customer_addresses (
  customer_id INTEGER PRIMARY KEY,
  street VARCHAR(100),
  city VARCHAR(50),
  state VARCHAR(50),
  zip_code VARCHAR(10),
  country VARCHAR(50),
  CONSTRAINT fk_customer_address FOREIGN KEY (customer_id)
    REFERENCES customers(customer_id) ON DELETE CASCADE
);

-- Suppliers table
CREATE TABLE suppliers (
  supplier_id SERIAL PRIMARY KEY,
  supplier_name VARCHAR(100) NOT NULL,
  contact_name VARCHAR(100),
  country VARCHAR(50)
);

-- Products table (many-to-one with Suppliers)
CREATE TABLE products (
  product_id SERIAL PRIMARY KEY,
  product_name VARCHAR(100) NOT NULL,
  supplier_id INTEGER,
  price NUMERIC(10,2),
  CONSTRAINT fk_products_supplier FOREIGN KEY (supplier_id)
    REFERENCES suppliers(supplier_id)
);

-- Orders table (many-to-one with Customers and Employees)
CREATE TABLE orders (
  order_id SERIAL PRIMARY KEY,
  order_date DATE NOT NULL,
  customer_id INTEGER,
  employee_id INTEGER,
  total NUMERIC(10,2),
  CONSTRAINT fk_orders_customer FOREIGN KEY (customer_id)
    REFERENCES customers(customer_id),
  CONSTRAINT fk_orders_employee FOREIGN KEY (employee_id)
    REFERENCES employees(employee_id)
);

-- Order Items table (many-to-one with Orders and Products)
CREATE TABLE order_items (
  order_item_id SERIAL PRIMARY KEY,
  order_id INTEGER NOT NULL,
  product_id INTEGER NOT NULL,
  quantity INTEGER NOT NULL,
  price NUMERIC(10,2) NOT NULL,
  CONSTRAINT fk_order_items_order FOREIGN KEY (order_id)
    REFERENCES orders(order_id) ON DELETE CASCADE,
  CONSTRAINT fk_order_items_product FOREIGN KEY (product_id)
    REFERENCES products(product_id)
);

-- ==============================================================
-- INSERT SAMPLE DATA
-- ==============================================================

-- Insert Departments
INSERT INTO departments (department_name) VALUES
  ('Sales'),
  ('Engineering'),
  ('Human Resources');

-- Insert Department Details (one-to-one with Departments)
INSERT INTO department_details (department_id, location, budget) VALUES
  (1, 'Building A', 50000.00),
  (2, 'Building B', 150000.00),
  (3, 'Building C', 30000.00);

-- Insert Employees
INSERT INTO employees (first_name, last_name, email, department_id) VALUES
  ('John', 'Doe', 'john.doe@example.com', 1),
  ('Jane', 'Smith', 'jane.smith@example.com', 2),
  ('Emily', 'Johnson', 'emily.johnson@example.com', 2),
  ('Michael', 'Brown', 'michael.brown@example.com', 3);

-- Insert Employee Details (one-to-one with Employees)
INSERT INTO employee_details (employee_id, phone, address, hire_date) VALUES
  (1, '555-1234', '123 Main St', '2020-01-15'),
  (2, '555-5678', '456 Maple Ave', '2019-03-20'),
  (3, '555-8765', '789 Oak Rd', '2021-07-01'),
  (4, '555-4321', '321 Pine St', '2018-11-10');

-- Insert Customers
INSERT INTO customers (first_name, last_name, email) VALUES
  ('Alice', 'Walker', 'alice.walker@example.com'),
  ('Bob', 'Martin', 'bob.martin@example.com'),
  ('Charlie', 'Davis', 'charlie.davis@example.com');

-- Insert Customer Addresses (one-to-one with Customers)
INSERT INTO customer_addresses (customer_id, street, city, state, zip_code, country) VALUES
  (1, '10 Downing St', 'London', 'London', 'SW1A 2AA', 'UK'),
  (2, '1600 Pennsylvania Ave', 'Washington', 'DC', '20500', 'USA'),
  (3, '1 Infinite Loop', 'Cupertino', 'CA', '95014', 'USA');

-- Insert Suppliers
INSERT INTO suppliers (supplier_name, contact_name, country) VALUES
  ('Acme Corp', 'Alice Cooper', 'USA'),
  ('Globex Inc', 'George Smith', 'UK'),
  ('Soylent Corp', 'Helen Troy', 'Canada');

-- Insert Products
INSERT INTO products (product_name, supplier_id, price) VALUES
  ('Laptop', 1, 1200.00),
  ('Smartphone', 1, 800.00),
  ('Tablet', 2, 500.00),
  ('Monitor', 3, 300.00),
  ('Keyboard', 3, 100.00);

-- Insert Orders
INSERT INTO orders (order_date, customer_id, employee_id, total) VALUES
  ('2025-01-10', 1, 1, 2000.00),
  ('2025-01-11', 2, 2, 1500.00),
  ('2025-01-12', 3, 3, 800.00);

-- Insert Order Items
INSERT INTO order_items (order_id, product_id, quantity, price) VALUES
  (1, 1, 1, 1200.00),   -- Order 1: Laptop
  (1, 5, 2, 100.00),    -- Order 1: 2 x Keyboard
  (2, 2, 1, 800.00),    -- Order 2: Smartphone
  (2, 4, 1, 300.00),    -- Order 2: Monitor
  (3, 3, 1, 500.00),    -- Order 3: Tablet
  (3, 5, 3, 100.00);    -- Order 3: 3 x Keyboard

-- ==============================================================
-- Example JOIN Queries
-- ==============================================================

-- 1. Retrieve orders with customer and employee names
SELECT o.order_id,
       o.order_date,
       CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
       CONCAT(e.first_name, ' ', e.last_name) AS employee_name,
       o.total
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
JOIN employees e ON o.employee_id = e.employee_id;

-- 2. Retrieve order items with product and supplier details
SELECT oi.order_item_id,
       o.order_id,
       p.product_name,
       s.supplier_name,
       oi.quantity,
       oi.price
FROM order_items oi
JOIN orders o ON oi.order_id = o.order_id
JOIN products p ON oi.product_id = p.product_id
JOIN suppliers s ON p.supplier_id = s.supplier_id;

-- 3. Retrieve employees with their department and department details
SELECT e.employee_id,
       CONCAT(e.first_name, ' ', e.last_name) AS employee_name,
       d.department_name,
       dd.location,
       dd.budget
FROM employees e
JOIN departments d ON e.department_id = d.department_id
JOIN department_details dd ON d.department_id = dd.department_id;

-- 4. Retrieve customers with their addresses (one-to-one join)
SELECT c.customer_id,
       CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
       ca.street,
       ca.city,
       ca.state,
       ca.zip_code,
       ca.country
FROM customers c
JOIN customer_addresses ca ON c.customer_id = ca.customer_id;