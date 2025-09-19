// Crie uma função que ao passar o cod_cliente retorne o total
// em reais de todos os pedidos que o cliente fez

select * from pedido;
SELECT SUM(val_total_pedido) FROM PEDIDO where cod_cliente = 74;

CREATE OR REPLACE FUNCTION fn_calc_pedidos (
    p_cod_cliente NUMBER // PARAMETRO
) RETURN NUMBER IS
    total_pedido NUMBER; // RETORNAR
BEGIN
    SELECT
        SUM(val_total_pedido)
    INTO total_pedido
    FROM
        pedido
    WHERE
        cod_cliente = p_cod_cliente;

    RETURN total_pedido;
END;

// crie uma funcao que traga total de pedidos dos clientes da cidade
// de sp

create or replace function fn_total_ped_cidade (p_nom_cidade VARCHAR2) return number is
total_pedidos number;
begin
    SELECT
        COUNT(DISTINCT p.cod_pedido)
    INTO total_pedidos
    FROM
             pedido p
        INNER JOIN endereco_cliente ec ON p.cod_cliente = ec.cod_cliente
        JOIN cidade           c ON ec.cod_cidade = c.cod_cidade
    WHERE
        c.nom_cidade = p_nom_cidade;
    RETURN total_pedidos;
end;

SELECT FN_TOTAL_PED_CIDADE('Fortaleza') FROM DUAL;

// ve se estuda seu merda

regexp_like (atribuo, ['0-9']);