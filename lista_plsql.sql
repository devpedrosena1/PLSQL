set serveroutput on;

// 1.	Crie um bloco anônimo que calcula o total de movimentações de estoque 
// para um determinado produto.

select * from movimento_estoque;

DECLARE
    v_cod_produto NUMBER := &cod;
BEGIN
    FOR x IN (
        SELECT
            SUM(qtd_movimentacao_estoque) AS total
        FROM
            movimento_estoque
        WHERE
            cod_produto = v_cod_produto
    ) LOOP
        dbms_output.put_line('Total de movimentações do produto '
                             || v_cod_produto
                             || ' = '
                             || x.total);
    END LOOP;
END;

// OUTRA FORMA DE FAZER 

DECLARE
    v_cod_produto NUMBER := &cod;
    v_total NUMBER;
BEGIN
    SELECT NVL(SUM(qtd_movimentacao_estoque), 0)
    INTO v_total
    FROM movimento_estoque
    WHERE cod_produto = v_cod_produto;

    IF v_total = 0 THEN
        dbms_output.put_line('Produto ' || v_cod_produto || ' não possui movimentações.');
    ELSE
        dbms_output.put_line('Total de movimentações do produto ' || v_cod_produto || ' = ' || v_total);
    END IF;
END;

// -------------------------------------------------------------

// 2.	Utilizando FOR crie um bloco anônimo que calcula a média de valores 
// totais de pedidos para um cliente específico.

select * from pedido;
DECLARE
    v_cod_cliente NUMBER := &cod;
BEGIN
    FOR x IN (
        SELECT
            ROUND(AVG(val_total_pedido)) AS media
        FROM
            pedido
        WHERE
            cod_cliente = v_cod_cliente
    ) LOOP
        dbms_output.put_line('Média de valores do cliente COD '
                             || v_cod_cliente
                             || ' = '
                             || x.media);
    END LOOP;
END;

// OUTRA FORMA DE FAZER
DECLARE
    v_cod_cliente NUMBER := &cod;
    v_media NUMBER;
BEGIN
    SELECT ROUND(AVG(val_total_pedido), 2)
    INTO v_media
    FROM pedido
    WHERE cod_cliente = v_cod_cliente;

    IF v_media IS NULL THEN
        dbms_output.put_line('Cliente ' || v_cod_cliente || ' não possui pedidos.');
    ELSE
        dbms_output.put_line('Média de valores do cliente ' || v_cod_cliente || ' = ' || v_media);
    END IF;
END;


// -------------------------------------------------------------

// 3.	Crie um bloco anônimo que exiba os produtos compostos ativos
SELECT * FROM PRODUTO_COMPOSTO;

DECLARE
    v_count NUMBER := 0;
BEGIN
    FOR x IN (
        SELECT
            cod_produto
        FROM
            produto_composto
        WHERE
            sta_ativo = 'S'
    ) LOOP
        v_count := v_count + 1;
        dbms_output.put_line('Produtos compostos ativos: ' || x.cod_produto);
    END LOOP;
    dbms_output.put_line('Total de produtos ativos = ' || v_count);
END;

// -------------------------------------------------------------

// 4.	Crie um bloco anônimo para calcular o total de movimentações de estoque
// para um determinado produto usando INNER JOIN com a tabela de 
// tipo_movimento_estoque.

SELECT * FROM MOVIMENTO_ESTOQUE;
SELECT * FROM TIPO_MOVIMENTO_ESTOQUE;

DECLARE
    v_cod_produto NUMBER := &cod;
BEGIN
    FOR x IN (
        SELECT
            SUM(m.qtd_movimentacao_estoque) AS total
        FROM
                 movimento_estoque m
            INNER JOIN tipo_movimento_estoque t ON m.cod_tipo_movimento_estoque = t.cod_tipo_movimento_estoque
        WHERE
            m.cod_produto = v_cod_produto
    ) LOOP
        dbms_output.put_line('Total de movimentações do produto '
                             || v_cod_produto
                             || ' = '
                             || x.total);
    END LOOP;
END;

// OUTRA FORMA DE FAZER
DECLARE
    v_cod_produto NUMBER := &cod;
    v_total NUMBER;
BEGIN
    SELECT NVL(SUM(m.qtd_movimentacao_estoque),0)
    INTO v_total
    FROM movimento_estoque m
         INNER JOIN tipo_movimento_estoque t 
         ON m.cod_tipo_movimento_estoque = t.cod_tipo_movimento_estoque
    WHERE m.cod_produto = v_cod_produto;

    dbms_output.put_line('Total de movimentações do produto ' || v_cod_produto || ' = ' || v_total);
END;

// -------------------------------------------------------------

// 5.	Crie um bloco anônimo para exibir os produtos compostos e, se houver, 
// suas informações de estoque, usando LEFT JOIN com a tabela estoque_produto.

SELECT * FROM PRODUTO_COMPOSTO;
SELECT * FROM ESTOQUE_PRODUTO;

BEGIN
    FOR x IN (
        SELECT
            pc.cod_produto,
            ep.qtd_produto
        FROM
            produto_composto pc
            LEFT JOIN estoque_produto  ep ON pc.cod_produto = ep.cod_produto
    ) LOOP
        dbms_output.put_line('Produto COD: '
                             || x.cod_produto
                             || ' | Estoque: '
                             || x.qtd_produto);
    END LOOP;
END;



// 6.	Crie um bloco que exiba as informações de pedidos e, se houver, 
// as informações dos clientes relacionados usando RIGHT JOIN com a tabela cliente.
SELECT * FROM PEDIDO;
SELECT * FROM CLIENTE; // COD CLIENTE
BEGIN
    FOR x IN (
        SELECT
            c.cod_cliente,
            p.cod_pedido,
            p.val_total_pedido
        FROM
            pedido p
            RIGHT JOIN cliente c ON c.cod_cliente = p.cod_cliente
    ) LOOP
        dbms_output.put_line('Cliente: '
                             || x.cod_cliente
                             || ' | Pedido: '
                             || x.cod_pedido
                             || ' | Valor: '
                             || x.val_total_pedido);
    END LOOP;
END;


 


