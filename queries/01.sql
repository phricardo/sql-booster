-- Seleciona todas as colunas da tabela departments
SELECT * FROM departments;

-- Seleciona colunas específicas
SELECT department_id, department_name
FROM departments;

-- Filtra registros com WHERE: exibe funcionários do departamento com ID 2 (por exemplo, Engineering)
SELECT * FROM employees
WHERE department_id = 2;

-- Filtra com múltiplas condições
SELECT * FROM employees
WHERE department_id = 2 AND last_name = 'Smith';

-- Ordena os resultados usando ORDER BY (exibe os pedidos do mais recente para o mais antigo)
SELECT * FROM orders
ORDER BY order_date DESC;

-- Usa alias para renomear colunas na saída
SELECT first_name AS "First Name", last_name AS "Last Name"
FROM employees;