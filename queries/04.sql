-- 4.1 Subquery (Consulta aninhada)
-- Lista funcionários e busca o telefone deles a partir da tabela employee_details usando uma subconsulta
-- SELECT e.employee_id,
--        e.first_name,
--        e.last_name,
--        (SELECT phone 
--         FROM employee_details ed 
--         WHERE ed.employee_id = e.employee_id) AS phone
-- FROM employees e;

-- 4.2 DISTINCT para eliminar duplicatas
-- SELECT DISTINCT department_id
-- FROM employees;

-- 4.3 LIMIT para restringir a quantidade de linhas retornadas
-- SELECT * FROM customers
-- LIMIT 2;

-- 4.4 Combinação de WHERE, ORDER BY e LIMIT
-- Exibe os 5 pedidos com total acima de 1000, ordenados do mais recente para o mais antigo
-- SELECT * FROM orders
-- WHERE total > 1000
-- ORDER BY order_date DESC
-- LIMIT 5;