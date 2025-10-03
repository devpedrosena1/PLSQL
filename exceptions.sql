
/*Exceptions*/
DECLARE
    minhex EXCEPTION;
BEGIN
    FOR x IN 1..50 LOOP
        IF x * 5 = 15 THEN
            RAISE minhex;
        END IF;
    END LOOP;
EXCEPTION
    WHEN minhex THEN
        raise_application_error(-20005, 'Voce não pode multiplicar 5 por 3.');
END;

/*1. Crie um procedimento chamando prc_insere_produto. para todas as colunas da tabela
de produtos, valide: Se o nome do produto tem mais de 3 caracteres e não contém números*/
select * from produto;

create or replace procedure prc_consulta_produto(
    p_cod_produto NUMBER
) AS 
    p_nom_produto VARCHAR2(50);
    exc EXCEPTION;
BEGIN
    SELECT nom_produto
    INTO p_nom_produto
    FROM produto
    where cod_produto = p_cod_produto;
    
    if length(p_nom_produto) > 3 and not regexp_like(p_nom_produto, '[0-9]') then
        RAISE exc;
    end if;
exception
    when exc then 
        raise_application_error(-20005, 'Nome inválido');
end;

call prc_consulta_produto(2);

CREATE OR REPLACE PROCEDURE prc_insere_produto (
    p_cod_produto      NUMBER,
    p_nom_produto      VARCHAR2,
    p_cod_barra        NUMBER,
    p_sta_ativo        CHAR,
    p_dat_cadastro     DATE,
    p_dat_cancelamento DATE
) AS
    exc EXCEPTION;
BEGIN
    IF
        length(p_nom_produto) > 3
        AND NOT regexp_like(p_nom_produto, '[0-9]')
    THEN
        INSERT INTO produto (
            cod_produto,
            nom_produto,
            cod_barra,
            sta_ativo,
            dat_cadastro,
            dat_cancelamento
        ) VALUES ( p_cod_produto,
                   p_nom_produto,
                   p_cod_barra,
                   p_sta_ativo,
                   p_dat_cadastro,
                   p_dat_cancelamento );

        COMMIT;
    ELSE
        RAISE exc;
    END IF;
EXCEPTION
    WHEN exc THEN
        raise_application_error(-20005, 'Nome inválido');
END;

call prc_insere_produto(52, 'ASU', 12345678901, 'Ativo', '03-MAY-24', '28-MAY-25'); // isso deve dar erro porque
                                                                                    // nome < 3

