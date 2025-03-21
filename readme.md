DDL (Data Definition Language): CREATE, ALTER, DROP, TRUNCATE, RENAME.
DML (Data Manipulation Language): SELECT, INSERT, UPDATE, DELETE, MERGE.
DCL (Data Control Language): GRANT, REVOKE.
TC (Transaction Control): COMMIT, ROLLBACK, SAVEPOINT, SET TRANSACTION.

SQL pode ser dividido em diferentes subconjuntos, cada um responsável por um conjunto específico de operações sobre o banco de dados. Eis uma explicação de cada um deles:

DDL (Data Definition Language)
Este subconjunto engloba comandos que definem e modificam a estrutura do banco de dados. São usados para criar, alterar e remover objetos do banco, como tabelas, índices, esquemas e views. Exemplos de comandos DDL:

CREATE: Cria um novo objeto no banco de dados (por exemplo, uma tabela ou view).
ALTER: Altera a estrutura de um objeto existente.
DROP: Remove um objeto do banco de dados.
DML (Data Manipulation Language)
O DML é voltado para a manipulação dos dados armazenados nas tabelas. Ele inclui comandos que inserem, atualizam, removem ou recuperam dados. Alguns dos comandos mais comuns são:

INSERT: Insere novos registros em uma tabela.
UPDATE: Atualiza registros existentes.
DELETE: Remove registros.
SELECT: Recupera dados, sendo frequentemente considerado parte do DML, embora alguns o classifiquem separadamente (DQL – Data Query Language).
DCL (Data Control Language)
Este subconjunto lida com os direitos de acesso e permissões dos usuários no banco de dados. Comandos DCL são usados para conceder ou revogar privilégios, garantindo a segurança e o controle de acesso aos dados. Os comandos mais comuns são:

GRANT: Concede permissões a usuários ou roles.
REVOKE: Revoga permissões previamente concedidas.
TC (Transaction Control)
Também conhecido como TCL (Transaction Control Language), este conjunto de comandos gerencia as transações no banco de dados. Uma transação é uma sequência de operações que devem ser executadas de forma completa ou não executadas de forma alguma, garantindo a integridade dos dados. Os comandos típicos são:

COMMIT: Confirma a transação, tornando as alterações permanentes.
ROLLBACK: Desfaz todas as alterações feitas durante a transação, retornando ao estado anterior.
SAVEPOINT: Cria um ponto intermediário na transação para que seja possível reverter apenas parte das alterações.
