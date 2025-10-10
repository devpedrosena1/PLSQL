set serveroutput on;

declare
    v_cod_cliente number := &cod;
    v_nom_cliente varchar2(50);
    exc exception;
begin
    select nom_cliente
    into v_nom_cliente
    from cliente
    where cod_cliente = v_cod_cliente;
    
    if v_nom_cliente is null then 
        raise exc;
    else
        dbms_output.put_line('Cliente encontrado!!!' || ' - Nome cliente: ' || v_nom_cliente);
    end if;
    
exception
    when exc then
        raise_application_error(-20001, 'Nome do cliente inválido.');

    
end;

// -------------------------------------------------------------

create or replace function f_total_pedidos(
    v_cod_cliente number
) return number is 
    v_qtd_pedidos number;
begin
    select count(p.cod_pedido)
    into v_qtd_pedidos
    from pedido p join cliente c on p.cod_cliente = c.cod_cliente
    where p.cod_cliente = v_cod_cliente;
    
    if v_qtd_pedidos = 0 then
        return 0;
    else
        dbms_output.put_line('Total de pedidos: ' || v_qtd_pedidos);
    end if;
    
    return v_qtd_pedidos;
    
exception
    when too_many_rows then
        dbms_output.put_line('Erro: multiplas linhas.');
    when no_data_found then
        dbms_output.put_line('Cliente inexistente.');
        
end;

select f_total_pedidos(74) from dual;

// -------------------------------------------------------------

create or replace procedure p_classificar_cliente(v_cod_cliente NUMBER)
as
    v_qtd_pedidos number;
begin
    select count(p.cod_pedido)
    into v_qtd_pedidos
    from pedido p join cliente c on p.cod_cliente = c.cod_cliente
    where p.cod_cliente = v_cod_cliente;
    
    if v_qtd_pedidos = 0 then 
        dbms_output.put_line('Cliente sem pedidos.');
        
    elsif v_qtd_pedidos < 5 then
        dbms_output.put_line('Cliente iniciante.');
        
    else 
        dbms_output.put_line('Cliente recorrente.');
        
    end if;
        
exception 
    when no_data_found then
        raise_application_error(-20001, 'Cliente inexistente.');
end;

call p_classificar_cliente(74);

// -------------------------------------------------------------

declare 
    v_nom_cliente varchar2(50);
    v_valor_total number;
    v_cod_cliente number := &cod;
    exc exception;
begin
    select c.nom_cliente, sum(p.val_total_pedido)
    into v_nom_cliente, v_valor_total
    from cliente c join pedido p on c.cod_cliente = p.cod_cliente
    where c.cod_cliente = v_cod_cliente
    group by c.nom_cliente;
    
    if v_valor_total is null then
        raise exc;
    else 
        dbms_output.put_line('Nome: ' || v_nom_cliente || ' - Valor total R$' || v_valor_total);
    end if;

exception 
    when exc then
        raise_application_error(-20001, 'Cliente não possui pedidos.');
end;

declare 
    v_valor_total number;
    v_nom_cliente varchar2(100);
    exc_sem_pedidos exception;
begin
    for x in (
        select c.cod_cliente, c.nom_cliente, sum(p.val_total_pedido) as valor_total
        from cliente c left join pedido p on c.cod_cliente = p.cod_cliente
        group by c.cod_cliente, c.nom_cliente
        order by c.cod_cliente
        fetch first 10 rows only
    ) loop
        v_valor_total := x.valor_total;
        v_nom_cliente := x.nom_cliente;
        
        if v_valor_total is null then
            raise exc_sem_pedidos;
        else 
            dbms_output.put_line('Nome: ' || v_nom_cliente || ' - Valor total R$' || v_valor_total);
        end if;
    
        
    end loop;
exception 
    when exc_sem_pedidos then
        dbms_output.put_line('Cliente: ' || v_nom_cliente || ' não tem pedidos.');
end;

// -------------------------------------------------------------

select * from produto;

create or replace procedure prc_verifica_produto(
    v_cod_produto number
) as
    v_nom_produto varchar2(100);
    v_ativo varchar(10);
    exc_cliente_invalido exception;
begin
    select nom_produto, sta_ativo
    into v_nom_produto, v_ativo
    from produto
    where cod_produto = v_cod_produto;
    
    if regexp_like(v_nom_produto, '[0-9]') then
        dbms_output.put_line('Nome invalido, contem numeros.');
    end if;
    
    if v_ativo = 'N' then
        raise exc_cliente_invalido;
    end if;
    
    dbms_output.put_line('Produto: ' || v_nom_produto || ' - Ativo/Desativado: ' || v_ativo);
    
exception 
    when exc_cliente_invalido then
        raise_application_error(-20001, 'Produto inativo.');
    when no_data_found then
        raise_application_error(-20002, 'Produto não encontrado.');

end;

BEGIN
    prc_verifica_produto(3);
END;

// -------------------------------------------------------------

create or replace function f_ticket_medio(
    v_cod_cliente number
) return number is 
    v_valor_medio number;
    exc_sem_pedidos exception;
begin
    select avg(val_total_pedido)
    into v_valor_medio
    from pedido p join cliente c on p.cod_cliente = c.cod_cliente
    where p.cod_cliente = v_cod_cliente;
    
    if v_cod_cliente is not null and v_valor_medio is null then
        raise exc_sem_pedidos;
    end if;
    
    return v_valor_medio;
    
exception
    when exc_sem_pedidos then
        raise_application_error(-20001, 'Cliente existe mas não tem pedidos.');
    when no_data_found then
        raise_application_error(-20002, 'Cliente não existe.');
end;

select f_ticket_medio(74) from dual;


// -------------------------------------------------------------

declare
    v_qtd_atualizada number := 0;
    exc_sem_produtos exception;
begin
    
    update produto
    set val_total_pedido = val_total_pedido * 1.10
    where val_total_pedido < 50;
    
    v_qtd_atualizada := SQL%ROWCOUNT;
    
    if v_qtd_atuaizada = 0 then
        raise exc_sem_produtos;
    else
        dbms_output.put_line('Produtos atualizados: ' || v_qtd_atualizada);
    end if;
    
exception
    when exc_sem_pedidos then 
        dbms_output.put_line('Nenhum produto atualizado.');
end;

// -------------------------------------------------------------

select * from cliente;

create or replace procedure prc_validar_cadastro(
    v_cod_cliente number
) as 
     v_dat_cadastro date;
     exc_data_invalida exception;
begin
    select dat_cadastro
    into v_dat_cadastro
    from cliente
    where cod_cliente = v_cod_cliente;
    
    if v_dat_cadastro > sysdate then
        raise exc_data_invalida; 
    else 
        dbms_output.put_line('Data correta. ' || v_dat_cadastro);
    end if;
    
exception
    when exc_data_invalida then
        raise_application_error(-20001, 'Data maior que a de hoje.');
end;
    
call prc_validar_cadastro(74);

// -------------------------------------------------------------

select * from produto_composto;
select * from pedido;
select * from cliente;

create or replace function f_qtd_produtos(
    v_cod_cliente number
) return number is
    v_total_produtos_dif number;
    exc_muitos_produtos exception;
begin 
    select count(distinct(cod_produto)) 
    into v_total_produtos_dif
    from cliente c join pedido p on c.cod_cliente = p.cod_cliente 
        join produto pr on p.cod_produto = p.cod_produto
    where c.cod_cliente = v_cod_cliente;
    
    if v_total_produtos_dif > 100 then
        raise exc_muitos_produtos;
    else
        dbms_output.put_line('Qtd produtos: ' || v_total_produtos_dif);
    end if;

exception
    when exc_muitos_produtos then
        raise_application_error(-20001, 'Muitos produtos.');
end;


        