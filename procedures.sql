select * from estado;

// exemplo de procedure
CREATE OR REPLACE PROCEDURE prd_insert_estado (
    p_cod_est  NUMBER,
    p_nom_est  VARCHAR2,
    p_cod_pais NUMBER
) AS
BEGIN
    INSERT INTO estado (
        cod_estado,
        nom_estado,
        cod_pais
    ) VALUES ( p_cod_est,
               p_nom_est,
               p_cod_pais );

    COMMIT;
END prd_insert_estado;

// exemplo de como utilizar a procedure
select * from estado where cod_estado = 100; // apenas visualizando se 
                                             // existe estado com cod 100   

CALL prd_insert_estado(100, 'Salvador', 1); // pode passar os parametros
                                            // mas ou passa todos ou não 
                                            // passa nenhuma
                                                           
// delete                                            
CREATE OR REPLACE PROCEDURE prd_delete_estado (
    p_cod_est  NUMBER
) AS
BEGIN
    DELETE FROM estado
    WHERE
        cod_estado = p_cod_est;
    COMMIT;
END;

CALL prd_delete_estado(100);

// outras formas de chamar a procedure
exec prd_delete_estado(100);
execute prd_delete_estado(100);

begin
    prd_delete_estado(101);
end;

// update
CREATE OR REPLACE PROCEDURE prd_update_estado (
    p_cod_est  NUMBER,
    p_nom_est VARCHAR2
) AS
BEGIN
    update estado
    set nom_estado = p_nom_est
    where cod_estado = p_cod_est;
    COMMIT;
END;

execute prd_update_estado(100, 'Bahia');

select * from estado where cod_estado = 100