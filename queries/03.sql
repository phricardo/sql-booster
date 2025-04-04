-- Junta orders e customers para mostrar o pedido com o nome do cliente
SELECT o.order_id,
       o.order_date,
       c.first_name,
       c.last_name
FROM orders o
INNER JOIN customers c ON o.customer_id = c.customer_id;

-- Exibe todos os funcionários e seus respectivos departamentos (mesmo que algum funcionário não tenha departamento associado)
SELECT e.employee_id,
       e.first_name,
       e.last_name,
       d.department_name
FROM employees e
LEFT JOIN departments d ON e.department_id = d.department_id;

-- Exibe todos os departamentos e os funcionários correspondentes (mesmo que algum departamento não possua funcionários)
SELECT d.department_id,
       d.department_name,
       e.first_name,
       e.last_name
FROM departments d
RIGHT JOIN employees e ON d.department_id = e.department_id;

-- Exibe todos os clientes e seus endereços, mesmo se algum cliente não tiver endereço ou vice-versa
SELECT c.customer_id,
       c.first_name,
       ca.city
FROM customers c
FULL OUTER JOIN customer_addresses ca ON c.customer_id = ca.customer_id;

-- Retorna detalhes do pedido, incluindo produto e fornecedor
SELECT o.order_id,
       o.order_date,
       p.product_name,
       s.supplier_name,
       oi.quantity,
       oi.price
FROM orders o
INNER JOIN order_items oi ON o.order_id = oi.order_id
INNER JOIN products p ON oi.product_id = p.product_id
INNER JOIN suppliers s ON p.supplier_id = s.supplier_id;
