set serveroutput on;

/*
1. Faça um bloco PL/SQL que receba via substituição (&cod) o código de um 
cliente, busque o nome dele e exiba na tela com DBMS_OUTPUT.PUT_LINE.
*/  

DECLARE
    v_cod_cliente NUMBER := &cod;
    v_nom_cliente VARCHAR2(50);
BEGIN
    SELECT
        nom_cliente
    INTO v_nom_cliente
    FROM
        cliente
    WHERE
        cod_cliente = v_cod_cliente;

    DBMS_OUTPUT.PUT_LINE ( 'Nome do cliente: ' || V_NOM_CLIENTE ) ; 
END ;

/*
2. Crie um bloco PL/SQL que receba o código de um cliente e conte quantos pedidos 
ele tem.

Se tiver 0 pedidos, exibir "Cliente sem pedidos".

Se tiver 1 a 5 pedidos, exibir "Cliente iniciante".

Se tiver mais de 5, exibir "Cliente recorrente".
*/
select * from pedido;

declare 
    v_cod_cliente NUMBER := &cod;
    v_qtd_pedido NUMBER;
begin
    select count(cod_pedido) as qtd_pedido
    into v_qtd_pedido
    from pedido
    where cod_cliente = v_cod_cliente
    order by qtd_pedido desc;
    
    if v_qtd_pedido > 5 then
        dbms_output.put_line('Cliente recorrente.');
    elsif v_qtd_pedido > 0 then
        dbms_output.put_line('Cliente inciciante.');
    elsif v_qtd_pedido = 0 then
        dbms_output.put_line('Cliente sem pedido.');
    else 
        dbms_output.put_line('Cliente sem pedidos.');
        
    end if;
end;

/*
3. Liste os nomes de todos os clientes ativos usando um FOR LOOP com SELECT.
*/
select * from cliente;

begin
    for x in (
        select nom_cliente, dat_cadastro, sta_ativo
        from cliente
    ) loop
        if x.sta_ativo = 'S' then
            dbms_output.put_line('Nome: ' || x.nom_cliente || '- Data de cadastro: ' || x.dat_cadastro);
        end if;
    end loop;
end;

/*
4. Liste os 10 primeiros clientes (qualquer critério) com a soma do valor total 
de seus pedidos, usando um FOR LOOP com SELECT.
*/

begin
    for x in (
        select c.nom_cliente, sum(p.val_total_pedido) valor_total
        from cliente c join pedido p on c.cod_cliente = p.cod_cliente
        group by c.nom_cliente
        order by valor_total DESC
        fetch first 10 rows only
    ) loop 
        dbms_output.put_line('Nome do cliente: ' || x.nom_cliente || '- Total de pedidos em R$ ' || x.valor_total);
    end loop;
end;

/*
5. Crie uma procedure chamada p_mostrar_cliente que receba como parâmetro o
código de um cliente e mostre:

nome do cliente,

data de cadastro.
*/
select * from cliente;

CREATE OR REPLACE PROCEDURE prd_mostrar_cliente (p_cod_cliente NUMBER) AS
    v_nom_cliente  VARCHAR2(50);
    v_dat_cadastro DATE;
BEGIN
    SELECT
        nom_cliente,
        dat_cadastro
    INTO
        v_nom_cliente,
        v_dat_cadastro
    FROM
        cliente
    WHERE
        cod_cliente = p_cod_cliente;

    dbms_output.put_line('Nome do cliente: '
                         || v_nom_cliente
                         || '- Data de cadastro: '
                         || v_dat_cadastro);
END;

CALL prd_mostrar_cliente(74);

/*
6. Crie uma procedure chamada p_classificar_cliente que receba o código de um 
cliente e exiba a classificação dele de acordo com a quantidade de pedidos 
(sem pedidos / iniciante / recorrente).
*/
select * from pedido;

CREATE OR REPLACE PROCEDURE p_classificar_cliente (
    p_cod_cliente NUMBER
) AS
    v_qtd_pedidos NUMBER;
    v_nom_cliente VARCHAR2(50);
BEGIN
    SELECT
        c.nom_cliente,
        COUNT(p.cod_pedido) AS total_pedidos
    INTO
        v_nom_cliente,
        v_qtd_pedidos
    FROM
             cliente c
        JOIN pedido p ON c.cod_cliente = p.cod_cliente
    WHERE
        c.cod_cliente = p_cod_cliente
    GROUP BY
        c.nom_cliente
    ORDER BY
        total_pedidos desc;

    IF v_qtd_pedidos > 5 THEN
        dbms_output.put_line('Cliente: '
                             || v_nom_cliente
                             || ' - '
                             || 'recorrente');
    ELSIF v_qtd_pedidos > 1 THEN
        dbms_output.put_line('Cliente: '
                             || v_nom_cliente
                             || ' - '
                             || 'iniciante');
    ELSIF v_qtd_pedidos = 0 THEN
        dbms_output.put_line('Cliente: '
                             || v_nom_cliente
                             || ' - '
                             || 'sem pedidos');
    ELSE
        dbms_output.put_line('Cliente não encontrado.');
    END IF;

END;

call p_classificar_cliente(74);
    
/*
7. Crie uma função chamada f_total_pedidos que receba o código de um cliente e 
retorne a quantidade de pedidos.
*/
select * from pedido;

CREATE OR REPLACE function f_total_pedidos (
p_cod_cliente NUMBER
) return number IS
    p_qtd_pedidos NUMBER;
BEGIN
    SELECT
        COUNT(cod_pedido)
    INTO p_qtd_pedidos
    FROM
             pedido p
        JOIN cliente c ON p.cod_cliente = c.cod_cliente
    WHERE
        p.cod_cliente = p_cod_cliente;

    RETURN p_qtd_pedidos;
END;

select f_total_pedidos(74) from dual;    
/*
8. Crie uma função chamada f_valor_total_cliente que receba o código de um 
cliente e retorne a soma de todos os pedidos feitos por ele.
*/
create or replace function f_valor_total(
    p_cod_cliente NUMBER
) RETURN NUMBER IS 
    valor_pedidos NUMBER;
begin
    select sum(val_total_pedido)
    into valor_pedidos
    from pedido p join cliente c on p.cod_cliente = c.cod_cliente
    where p.cod_cliente = p_cod_cliente;
    
    return valor_pedidos;
end;

SELECT F_VALOR_TOTAL(74) FROM DUAL;
/*
9. Crie uma procedure chamada p_top_clientes que mostre os 10 clientes com maior
valor total em pedidos, usando FOR LOOP.
*/
select * from pedido;

create or replace procedure p_top_clientes
AS
begin
    for x in (
        select c.nom_cliente, sum(p.val_total_pedido) as total_pedido
        from cliente c join pedido p on c.cod_cliente = p.cod_cliente
        group by c.nom_cliente
        order by total_pedido DESC
        fetch first 10 rows only
    ) loop
        dbms_output.put_line('Nome do cliente: ' || x.nom_cliente || ' - Valor em R$' || x.total_pedido);
    end loop;
end;

call p_top_clientes();
/*
10. Crie uma função chamada f_ticket_medio que receba o código do cliente e 
retorne o ticket médio (valor médio dos pedidos).
*/
select * from pedido;

CREATE OR REPLACE function f_ticket_medio(p_cod_cliente NUMBER) return number IS
    valor_medio_pedido NUMBER;
BEGIN
    SELECT
        ROUND(AVG(p.val_total_pedido)) AS media_valor
    INTO valor_medio_pedido
    FROM
             cliente c
        JOIN pedido p ON c.cod_cliente = p.cod_cliente
    WHERE
        p.cod_cliente = p_cod_cliente;

    RETURN valor_medio_pedido;
END;

select f_ticket_medio(74) from dual;    