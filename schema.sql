-- ==============================================================
-- DROP existing tables (if any) in the correct dependency order
-- ==============================================================

-- DROP TABLE IF EXISTS order_items;
-- DROP TABLE IF EXISTS orders;
-- DROP TABLE IF EXISTS products;
-- DROP TABLE IF EXISTS suppliers;
-- DROP TABLE IF EXISTS customer_addresses;
-- DROP TABLE IF EXISTS customers;
-- DROP TABLE IF EXISTS employee_details;
-- DROP TABLE IF EXISTS employees;
-- DROP TABLE IF EXISTS department_details;
-- DROP TABLE IF EXISTS departments;

-- ============================================================== 
-- CREATE TABLES (using IF NOT EXISTS)
-- ==============================================================

-- Departments table (one-to-many with Employees)
CREATE TABLE IF NOT EXISTS departments (
  department_id SERIAL PRIMARY KEY,
  department_name VARCHAR(100) NOT NULL
);

-- Department Details table (one-to-one with Departments)
CREATE TABLE IF NOT EXISTS department_details (
  department_id INTEGER PRIMARY KEY,  -- mesmo valor de departments.department_id
  location VARCHAR(100),
  budget NUMERIC(10,2),
  CONSTRAINT fk_department_details FOREIGN KEY (department_id)
    REFERENCES departments(department_id) ON DELETE CASCADE
);

-- Employees table (many-to-one with Departments)
CREATE TABLE IF NOT EXISTS employees (
  employee_id SERIAL PRIMARY KEY,
  first_name VARCHAR(50) NOT NULL,
  last_name VARCHAR(50) NOT NULL,
  email VARCHAR(100),
  department_id INTEGER,
  CONSTRAINT fk_employees_department FOREIGN KEY (department_id)
    REFERENCES departments(department_id)
);

-- Employee Details table (one-to-one with Employees)
CREATE TABLE IF NOT EXISTS employee_details (
  employee_id INTEGER PRIMARY KEY,  -- mesmo valor de employees.employee_id
  phone VARCHAR(20),
  address VARCHAR(200),
  hire_date DATE,
  CONSTRAINT fk_employee_details FOREIGN KEY (employee_id)
    REFERENCES employees(employee_id) ON DELETE CASCADE
);

-- Customers table
CREATE TABLE IF NOT EXISTS customers (
  customer_id SERIAL PRIMARY KEY,
  first_name VARCHAR(50) NOT NULL,
  last_name VARCHAR(50) NOT NULL,
  email VARCHAR(100) UNIQUE
);

-- Customer Addresses table (one-to-one with Customers)
CREATE TABLE IF NOT EXISTS customer_addresses (
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
CREATE TABLE IF NOT EXISTS suppliers (
  supplier_id SERIAL PRIMARY KEY,
  supplier_name VARCHAR(100) NOT NULL,
  contact_name VARCHAR(100),
  country VARCHAR(50)
);

-- Products table (many-to-one with Suppliers)
CREATE TABLE IF NOT EXISTS products (
  product_id SERIAL PRIMARY KEY,
  product_name VARCHAR(100) NOT NULL,
  supplier_id INTEGER,
  price NUMERIC(10,2),
  CONSTRAINT fk_products_supplier FOREIGN KEY (supplier_id)
    REFERENCES suppliers(supplier_id)
);

-- Orders table (many-to-one com Customers e Employees)
CREATE TABLE IF NOT EXISTS orders (
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

-- Order Items table (many-to-one com Orders e Products)
CREATE TABLE IF NOT EXISTS order_items (
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

-- Inserir Departments
INSERT INTO departments (department_name) VALUES
  ('Sales'),
  ('Engineering'),
  ('Human Resources')
ON CONFLICT DO NOTHING;

-- Inserir Department Details (um para um com Departments)
INSERT INTO department_details (department_id, location, budget) VALUES
  (1, 'Building A', 50000.00),
  (2, 'Building B', 150000.00),
  (3, 'Building C', 30000.00)
ON CONFLICT DO NOTHING;

-- Inserir Employees
INSERT INTO employees (first_name, last_name, email, department_id) VALUES
  ('John', 'Doe', 'john.doe@example.com', 1),
  ('Jane', 'Smith', 'jane.smith@example.com', 2),
  ('Emily', 'Johnson', 'emily.johnson@example.com', 2),
  ('Michael', 'Brown', 'michael.brown@example.com', 3)
ON CONFLICT DO NOTHING;

-- Inserir Employee Details (um para um com Employees)
INSERT INTO employee_details (employee_id, phone, address, hire_date) VALUES
  (1, '555
