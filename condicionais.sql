set serveroutput on;

// Exercício 1
DECLARE
    v_n NUMBER(2) := 15;
BEGIN
    IF MOD(v_n, 2) = 0 THEN
        dbms_output.put_line('O número é par: ' || v_n);
    ELSE
        dbms_output.put_line('O número é ímpar: ' || v_n);
    END IF;
END;

// Exercício 2
DECLARE
    sexo VARCHAR2(1) := '&str';
BEGIN
    IF upper(sexo) = 'M' THEN
        dbms_output.put_line('Masculino');
    ELSIF upper(sexo) = 'F' THEN
        dbms_output.put_line('Feminino');
    ELSE
        dbms_output.put_line('Outros');
    END IF;
END;

// Exercício 3
DECLARE
    idade NUMBER := &valor;
BEGIN
    IF
        idade >= 0
        AND idade <= 12
    THEN
        dbms_output.put_line('Criança');
    ELSIF
        idade > 12
        AND idade < 18
    THEN
        dbms_output.put_line('Adolescente');
    ELSE
        dbms_output.put_line('Adulto');
    END IF;
END;

// Exercício 4
CREATE TABLE aluno (
    ra   CHAR(9),
    nome VARCHAR2(50),
    CONSTRAINT aluno_pk PRIMARY KEY ( ra )
);

INSERT INTO ALUNO(RA, NOME) VALUES ('111222333', 'Antonio Alves');
INSERT INTO ALUNO(RA, NOME) VALUES ('222333444', 'Beatriz Bernardes');
INSERT INTO ALUNO(RA, NOME) VALUES ('333444555', 'Cláudio Cardoso');

// Select
DECLARE
    v_ra   CHAR(9) := '333444555';
    v_nome VARCHAR2(50);
BEGIN
    SELECT
        nome
    INTO v_nome
    FROM
        aluno
    WHERE
        ra = v_ra;

    dbms_output.put_line('O nome do aluno é: ' || v_nome);
END;

// Insert
DECLARE
    v_ra   CHAR(9) := '444555666';
    v_nome VARCHAR2(50) := 'Daniela Dorneles';
BEGIN
    INSERT INTO aluno (
        ra,
        nome
    ) VALUES ( v_ra,
               v_nome );

END;

// Update
DECLARE
    v_ra CHAR(9) := '111222333';
    v_nome VARCHAR2(50) := 'Antonio Rodrigues';
BEGIN
    UPDATE ALUNO SET NOME = V_NOME WHERE RA = V_RA;
END;

// Delete
DECLARE 
    V_RA CHAR(9) := '444555666';
BEGIN
    DELETE FROM ALUNO WHERE RA = V_RA;
END;

SELECT * FROM ALUNO;

// Exercício 3
// 6, 12, 18
DECLARE

    VALOR_PRODUTO NUMBER := &valor;
    PORC_ENTRADA NUMBER;
    QTD_PARCELAS NUMBER := &parcela;
    VALOR_PARCELA NUMBER;

BEGIN

    PORC_ENTRADA := VALOR_PRODUTO * 0.2;
    dbms_output.put_line('valor de entrada: R$ ' || PORC_ENTRADA);
    
    IF QTD_PARCELAS = 6 THEN
        VALOR_PARCELA := ((VALOR_PRODUTO - PORC_ENTRADA) * 1.1) / 6;
        dbms_output.put_line('Valor da parcela em 6x é: R$ ' || VALOR_PARCELA);
    
    ELSIF QTD_PARCELAS = 12 THEN
        VALOR_PARCELA := ((VALOR_PRODUTO - PORC_ENTRADA) * 1.15) / 12;
        dbms_output.put_line('Valor da parcela em 12x é: R$ ' || VALOR_PARCELA);
        
    ELSIF QTD_PARCELAS = 18 THEN
        VALOR_PARCELA := ((VALOR_PRODUTO - PORC_ENTRADA) * 1.20) / 18;
        dbms_output.put_line('Valor da parcela em 18x é: R$ ' || VALOR_PARCELA);
        
    ELSE 
        dbms_output.put_line('Número de parcela indisponível!!!');

    END IF;
END;

