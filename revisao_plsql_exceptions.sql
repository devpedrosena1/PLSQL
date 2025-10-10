/*Revisão PLSQL - Parte 3*/
set serveroutput on;

/*
1. Crie um bloco anônimo que receba um COD_CLIENTE via variável (&cod) e 
busque o nome do cliente.

Se o cliente existir, mostre o nome.

Se não existir (NO_DATA_FOUND), exiba a mensagem: "Cliente não encontrado"
*/

declare
    v_cod_cliente NUMBER := &cod;
    v_nom_cliente VARCHAR2(50);
    exc exception;
begin
    select nom_cliente
    into v_nom_cliente
    from cliente
    where cod_cliente = v_cod_cliente;
    
    if length(v_nom_cliente) < 3 then
        raise exc;
    end if;
    
    dbms_output.put_line('Nome do cliente: ' || v_nom_cliente);

exception
    when no_data_found then 
        raise_application_error(-20001, 'CLiente não encontrado');
    when exc then
        raise_application_error(-20001, 'Nome inválido');
end;

/*
2. Escreva uma função f_total_pedidos que receba o COD_CLIENTE e retorne o 
número total de pedidos.

Se o cliente não existir (NO_DATA_FOUND), retorne 0.

Se houver mais de uma linha inesperada (TOO_MANY_ROWS), trate a exceção 
exibindo uma mensagem no dbms_output.
*/

create or replace function f_total_pedidos(
    v_cod_cliente NUMBER
) RETURN NUMBER IS
    v_qtd_pedidos NUMBER;
BEGIN
    select count(cod_pedido) 
    into v_qtd_pedidos
    from cliente c join pedido p on c.cod_cliente = p.cod_cliente
    where c.cod_cliente = v_cod_cliente;
    
    return v_qtd_pedidos;  
    
exception 
    when no_data_found then
        return 0;
    when too_many_rows then
        dbms_output.put_line('Linha inesperada.');
 
end;

select f_total_pedidos(74) from dual;

/*3. Procedure com classificação de cliente e tratamento

Crie uma procedure p_classificar_cliente que:

Receba o COD_CLIENTE.

Calcule o número de pedidos.

Classifique:

1 a 5 pedidos → "Cliente iniciante"

> 5 pedidos → "Cliente recorrente"

0 pedidos → "Cliente sem pedidos".

Use NO_DATA_FOUND para tratar caso o cliente não exista.*/

create or replace procedure p_classificar_cliente(
    v_cod_cliente NUMBER
) AS 
    v_qtd_pedidos NUMBER;
BEGIN
    select count(cod_pedido)
    into v_qtd_pedidos
    from cliente c join pedido p on c.cod_cliente = p.cod_cliente
    where c.cod_cliente = v_cod_cliente;
    
    if v_qtd_pedidos between 1 and 5 then
        dbms_output.put_line('Cliente iniciante.');
    elsif v_qtd_pedidos > 5 then
        dbms_output.put_line('Cliente recorrente.');
    else
        dbms_output.put_line('Cliente sem pedidos.');
    end if;
exception
    when no_data_found then
        dbms_output.put_line('Cliente inexistente.');
        
end;

call p_classificar_cliente(74);

/*4. Loop com exceções

Monte um bloco que liste os 10 primeiros clientes (qualquer critério) e exiba 
a soma de seus pedidos.

Se algum cliente não tiver pedidos, capture uma exceção e mostre: 
"Cliente X não possui pedidos registrados".*/

declare 
    v_valor_total number;
    exc exception;
begin
    for x in (
        select c.nom_cliente, c.cod_cliente
        from cliente c
        order by c.cod_cliente
        fetch first 10 rows only
    ) loop
        select sum(p.val_total_pedido)
        into v_valor_total
        from cliente c
        join pedido p on c.cod_cliente = p.cod_cliente
        where c.cod_cliente = x.cod_cliente;
        
        if v_valor_total is null then
            raise exc;
        end if;
        
        dbms_output.put_line('Cliente: ' || x.nom_cliente || ' - Total de pedidos em R$' || v_valor_total);
        
    end loop;
    
exception
    when exc then
        raise_application_error(-20001, 'Algum cliente não possui pedido registrado.');
        
end;


   
    
    