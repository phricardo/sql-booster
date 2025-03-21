-- Conta o número de funcionários por departamento
SELECT department_id, COUNT(*) AS total_employees
FROM employees
GROUP BY department_id;

-- Filtra grupos usando HAVING: exibe departamentos com mais de 1 funcionário
SELECT department_id, COUNT(*) AS total_employees
FROM employees
GROUP BY department_id
HAVING COUNT(*) > 1;
