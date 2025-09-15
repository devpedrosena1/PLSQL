// revisao geral

// ordem de execuçâo
/*FROM / JOIN → o banco junta as tabelas e forma o conjunto de dados inicial.

WHERE → filtra linha a linha desse conjunto inicial (antes de qualquer cálculo de agregação).

GROUP BY → agrupa os registros conforme a(s) coluna(s) definida(s).

Funções de agregação (COUNT, SUM, AVG, MAX, MIN) → são calculadas dentro de cada grupo.

HAVING → filtra os resultados já agregados.

SELECT → monta o resultado final (aqui nascem os aliases, como contagem_pedido).

ORDER BY → organiza o resultado final.*/

// left join
SELECT
    *
FROM
    pedido;

SELECT
    p.cod_pedido,
    p.cod_cliente
FROM
    pedido  p
    LEFT JOIN cliente c ON p.cod_cliente = c.cod_cliente;

// inner join
SELECT
    p.cod_pedido,
    p.cod_cliente
FROM
         pedido p
    INNER JOIN cliente c ON p.cod_cliente = c.cod_cliente;

// 1. Liste o nome do cliente e a quantidade de pedidos realizados, 
// mostrando apenas clientes que tenham feito mais de 5 pedidos. 
// Ordene do maior para o menor.

SELECT
    *
FROM
    cliente;

SELECT
    *
FROM
    pedido;

SELECT
    c.nom_cliente,
    COUNT(p.cod_pedido) AS contagem_pedido
FROM
         cliente c
    JOIN pedido p ON c.cod_cliente = p.cod_cliente
GROUP BY
    c.nom_cliente
HAVING
    COUNT(p.cod_pedido) > 5
ORDER BY
    contagem_pedido DESC;

// Mostre o nome do cliente, o valor total gasto em pedidos e o valor médio por 
// pedido.
SELECT
    *
FROM
    cliente;

SELECT
    *
FROM
    pedido;

SELECT
    c.nom_cliente,
    SUM(p.val_total_pedido)        AS soma,
    round(avg(p.val_total_pedido)) AS media
FROM
         cliente c
    INNER JOIN pedido p ON c.cod_cliente = p.cod_cliente
GROUP BY
    c.nom_cliente;


