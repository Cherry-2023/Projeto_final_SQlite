# Projeto_final_SQlite

De acordo com as informações fornecidas para a elaboração do Projeto Final SQlite, armazenadas no seguinte repositório github: https://gist.github.com/tiagoamaro/5c3977aa1f3fe9087914b5f86faf9db5 
A seguir forneço as seguintes Consultas SQLite para obter os seguintes dados que foram solicitados no Projeto Final:

# Query 1: Nomes de clientes dependentes.

SELECT c.nome
FROM cliente AS c
JOIN cliente_conta AS cc ON c.id = cc.id_cliente
WHERE cc.dependente = 1;

# Query 2: As 5 principais contas com mais transações: por número de conta.

SELECT c.numero, COUNT(t.id) AS num_transacciones
FROM conta AS c
JOIN cliente_conta AS cc ON c.id = cc.id_conta
JOIN transacao AS t ON cc.id = t.id_cliente_conta
GROUP BY c.numero
ORDER BY num_transacciones DESC
LIMIT 5;

# Query 2.1: As 5 contas com mais transações: Por nome.

SELECT c.nome, COUNT(t.id) AS num_transacciones
FROM cliente AS c
JOIN cliente_conta AS cc ON c.id = cc.id_cliente
JOIN transacao AS t ON cc.id = t.id_cliente_conta
GROUP BY c.nome
ORDER BY num_transacciones DESC
LIMIT 5;

# Query 3: As 5 contas com menos transações: Por número de conta.

SELECT c.numero, COUNT(t.id) AS num_transacciones
FROM conta AS c
JOIN cliente_conta AS cc ON c.id = cc.id_conta
LEFT JOIN transacao AS t ON cc.id = t.id_cliente_conta
GROUP BY c.numero
ORDER BY num_transacciones ASC
LIMIT 5;

# Query 3.1: As 5 contas com menos transações: Por nome.

SELECT c.nome, COUNT(t.id) AS num_transacciones
FROM cliente AS c
JOIN cliente_conta AS cc ON c.id = cc.id_cliente
LEFT JOIN transacao AS t ON cc.id = t.id_cliente_conta
GROUP BY c.nome
ORDER BY num_transacciones ASC
LIMIT 5;

# Query 4: Saldo total de todas as contas.

SELECT 
    c.nome AS nome_cliente,
    ccc.numero AS numero_conta,
    ROUND(
        ccc.saldo + 
        COALESCE((
            SELECT SUM(t.valor) 
            FROM transacao AS t
            JOIN tipo_transacao AS tt ON t.id_tipo_transacao = tt.id
            WHERE t.id_cliente_conta = cc.id 
                AND tt.descricao IN ('depósito', 'transferencia')
        ), 0) -
        COALESCE((
            SELECT SUM(t.valor) 
            FROM transacao AS t
            JOIN tipo_transacao AS tt ON t.id_tipo_transacao = tt.id
            WHERE t.id_cliente_conta = cc.id 
                AND tt.descricao IN ('saque', 'pagar conta')
        ), 0)
    , 2) AS saldo_total
FROM cliente_conta AS cc
JOIN cliente AS c ON cc.id_cliente = c.id
JOIN conta AS ccc ON cc.id_conta = ccc.id;

