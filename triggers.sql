create table pedido_novos as select * from pedido;
alter table pedido_novos add status varchar2(30);
select * from pedido_novos;

CREATE OR REPLACE TRIGGER trg_pedido BEFORE
    INSERT ON pedido_novos
    FOR EACH ROW
BEGIN
-- atualiza o status do pedido para "Novo" após a inserção
    IF :new.status IS NULL THEN
        :new.status := 'Novo Pedido';
    END IF;
END;

INSERT INTO pedido_novos (
    cod_pedido,
    cod_pedido_relacionado,
    cod_cliente,
    cod_usuario,
    cod_vendedor,
    dat_pedido,
    dat_cancelamento,
    dat_entrega,
    val_total_pedido,
    val_desconto,
    seq_endereco_cliente,
    status
) VALUES (
    69,
    12,
    23,
    2,
    3,
    TO_DATE('17-12-2022','DD-MM-YYYY'),
    TO_DATE('03-05-2024','DD-MM-YYYY'),
    NULL,              
    8064.87,
    674.6,
    1,                 
    NULL               
);

select * from pedido_novos where cod_pedido = 1;

CREATE TABLE tb_auditoria (
    id       NUMBER
        GENERATED ALWAYS AS IDENTITY,
    tabela   VARCHAR2(30),
    operacao VARCHAR2(30),
    data     DATE,
    usuario  VARCHAR2(30)
)

select * from tb_auditoria;

CREATE OR REPLACE TRIGGER trg_auditoria AFTER
    INSERT OR UPDATE OR DELETE ON pedido_novos
    FOR EACH ROW
DECLARE
    operacao     VARCHAR2(30);
    nome_usuario VARCHAR2(100);
BEGIN
    -- Determina a operação realizada (insert, update ou delete)
    IF inserting THEN
        operacao := 'INSERT';
    ELSIF updating THEN
        operacao := 'UPDATE';
    ELSIF deleting THEN
        operacao := 'DELETE';
    END IF;
    
    -- obtém o nome de usuario da sessão atual
    nome_usuario := sys_context('USERENV', 'SESSION_USER');
    
    -- registra a auditoria na tabela de auditoria
    INSERT INTO tb_auditoria (
        tabela,
        operacao,
        data,
        usuario
    ) VALUES ( 'pedido_novos',
               operacao,
               sysdate,
               nome_usuario );

END;

----- Exercícios

CREATE OR REPLACE TRIGGER trg_alteracao BEFORE
    UPDATE ON pedido_novos
    FOR EACH ROW
BEGIN
    INSERT INTO tb_auditoria (
        tabela,
        operacao,
        data,
        usuario
    ) VALUES ( 'pedido_novos',
               'update',
               sysdate,
               user );

END;

update pedido_novos
set status = 'TESTE'
where cod_pedido = 69;

select * from tb_auditoria;
