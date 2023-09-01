--DQL - Seleciona todos os clientes 
SELECT id, nome, cpf
FROM cliente;

--conta
SELECT id, numero, saldo 
FROM conta;

--cliente_conta
SELECT id, id_cliente, id_conta, dependente 
FROM cliente_conta;

--tipo_transacao
SELECT id, descricao
FROM tipo_transacao;

--transacao
SELECT id, id_tipo_transacao, id_cliente_conta, valor
FROM transacao;

SELECT id
FROM cliente
WHERE
    nome LIKE 'Kau%' ;
    

 
SELECT id, id_tipo_transacao, id_cliente_conta, valor
FROM transacao
WHERE
    (id_cliente_conta IN (1,2,3,4,5)
    AND valor > 5000)
    OR (id_cliente_conta IN (31,32,33,34,35)
    AND valor < 50);
    


SELECT
    id,
    COUNT(id) AS "Quantidade",
    SUM(valor) AS "Soma",
    MAX(valor) AS "Máximo",
    MIN(valor) AS "Mínimo",
    AVG(valor) AS "Média"
FROM transacao
GROUP BY id_tipo_transacao
ORDER BY 1;

SELECT
    transacao.id_tipo_transacao,
    descricao,
    COUNT(transacao.id) AS "Quantidade",
    SUM(valor) AS "Soma",
    MAX(valor) AS "Máximo",
    MIN(valor) AS "Mínimo",
    AVG(valor) AS "Média"
FROM transacao
JOIN tipo_transacao
	ON transacao.id_tipo_transacao = tipo_transacao.id
GROUP BY transacao.id_tipo_transacao, descricao
ORDER BY 1;



SELECT
    id, valor
FROM
    transacao
ORDER BY id DESC
LIMIT 5;
