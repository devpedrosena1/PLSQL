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

// 3.	Crie um bloco anônimo que exiba os produtos compostos ativos
SELECT * FROM PRODUTO_COMPOSTO;

BEGIN
    FOR x IN (
        SELECT
            cod_produto
        FROM
            produto_composto
        WHERE
            sta_ativo = 'S'
    ) LOOP
        dbms_output.put_line('Produtos compostos ativos: ' || x.cod_produto);
    END LOOP;
END;

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

BEGIN
    FOR x IN (
        SELECT
            c.nome_cliente,
            p.id_pedido,
            p.valor_pedido
        FROM
            cliente c
            RIGHT JOIN pedidos p ON c.id_cliente = p.id_cliente
    ) LOOP
        dbms_output.put_line('Cliente: '
                             || nvl(x.nome_cliente, 'Sem cliente')
                             || ' | Pedido: '
                             || x.id_pedido
                             || ' | Valor: '
                             || x.valor_pedido);
    END LOOP;
END;


// 7.	Crie um bloco que calcule a média de valores totais de pedidos para um 
// cliente específico e exibe as informações do cliente usando INNER JOIN 
// com a tabela cliente.

BEGIN
    FOR x IN (
        SELECT
            c.nome_cliente,
            AVG(p.valor_pedido) AS media
        FROM
                 cliente c
            INNER JOIN pedidos p ON c.id_cliente = p.id_cliente
        WHERE
            c.id_cliente = 1
        GROUP BY
            c.nome_cliente
    ) LOOP
        dbms_output.put_line('Cliente: '
                             || x.nome_cliente
                             || ' | Média dos pedidos = '
                             || nvl(x.media, 0));
    END LOOP;
END;


