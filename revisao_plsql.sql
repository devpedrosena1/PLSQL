set serveroutput on;

// revisao plsql

/*
Exercício 1 – Declaração de variáveis

Crie um bloco PL/SQL que declare:

Uma variável v_nome_cliente VARCHAR2(50),

Uma variável v_qtd_pedidos NUMBER.

Atribua valores fixos a essas variáveis e, em seguida, use DBMS_OUTPUT.PUT_LINE 
para exibir os valores.
*/

DECLARE

    v_nome_cliente VARCHAR2(50) := 'Pedro';
    v_qtd_pedidos NUMBER := 200;

BEGIN

    dbms_output.put_line('Nome do cliente: ' || v_nome_cliente);
    dbms_output.put_line('Quantide de pedidos: ' || v_qtd_pedidos);

END;

/*
Exercício 2 – Atribuição de valores via SELECT

Altere o exercício 1 para que:

v_nome_cliente receba do banco o nome de um cliente qualquer (cliente.nom_cliente).

v_qtd_pedidos receba a contagem de pedidos (COUNT(*)) desse cliente na tabela pedido.

Exiba no console algo como:

O cliente X possui Y pedidos.
*/

DECLARE
    v_cod_cliente  NUMBER := &cod;
    v_nome_cliente VARCHAR2(50);
    v_qtd_pedidos  NUMBER;
BEGIN
    SELECT
        c.nom_cliente,
        COUNT(p.cod_pedido)
    INTO
        v_nome_cliente,
        v_qtd_pedidos
    FROM
             cliente c
        INNER JOIN pedido p ON c.cod_cliente = p.cod_cliente
    WHERE
        c.cod_cliente = v_cod_cliente
    GROUP BY
        c.nom_cliente;

    dbms_output.put_line('O cliente '
                         || v_nome_cliente
                         || ' possui '
                         || v_qtd_pedidos
                         || ' pedidos');

END;

/*
Exercício 3 – Condicionais (IF / ELSIF / ELSE)

Crie um bloco que:

Pegue um cliente (via SELECT) e a quantidade de pedidos dele.

Se o cliente tiver 0 pedidos, exiba “Cliente sem pedidos”.

Se tiver entre 1 e 5 pedidos, exiba “Cliente iniciante”.

Se tiver mais de 5 pedidos, exiba “Cliente recorrente”.
*/

DECLARE

    v_cod_cliente NUMBER := &cod;
    v_nome_cliente VARCHAR2(50);
    v_qtd_pedidos NUMBER;

BEGIN

    select c.nom_cliente, count(p.cod_pedido)
    into v_nome_cliente, v_qtd_pedidos
    from pedido p inner join cliente c 
    on p.cod_cliente = c.cod_cliente
    where c.cod_cliente = v_cod_cliente
    group by c.nom_cliente;
    
    if v_qtd_pedidos between 1 AND 5 THEN
        dbms_output.put_line('Cliente iniciante.');
    elsif v_qtd_pedidos > 5 THEN
        dbms_output.put_line('Cliente recorrente.');
    else
        dbms_output.put_line('Cliente sem pedidos.');
    end if;

END;

/*
Exercício 4 – Loops (FOR e WHILE)

Monte um bloco que:

Percorra os 10 primeiros clientes cadastrados.

Para cada cliente, exiba o nome e o total gasto (SUM(val_total_pedido)).

Dica: você pode usar um FOR i IN (SELECT ...) LOOP.
*/

BEGIN
    FOR x IN (
        SELECT
            c.nom_cliente,
            SUM(p.val_total_pedido) AS valor_total
        FROM
                 cliente c
            JOIN pedido p ON c.cod_cliente = p.cod_cliente
        GROUP BY
            c.nom_cliente
    ) LOOP
        dbms_output.put_line('Cliente: '
                             || x.nom_cliente
                             || ' - Total: '
                             || x.valor_total);
    END LOOP;
END;

