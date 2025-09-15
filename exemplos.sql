set serveroutput on;

// exemplo1
DECLARE
    p_number NUMBER;
BEGIN
    p_number := 12 + 20;
    dbms_output.put_line(p_number);
END;

// exemplo 1 com funcao
CREATE OR REPLACE FUNCTION fn_calculo RETURN NUMBER IS
    p_number NUMBER;
BEGIN
    p_number := 12 + 20;
    RETURN p_number;
END;

// chamando funcao
SELECT fn_calculo() FROM DUAL;

// outra forma de executar funcao
CALL FN_CALCULO(); // RETORNA NADA 

// exemplo 2
CREATE OR REPLACE FUNCTION fn_calc_inss (
    p_sal NUMBER
) RETURN NUMBER IS
    p_number NUMBER;
BEGIN
    p_number := p_sal * 0.08;
    RETURN p_number;
END;

SELECT FN_CALC_INSS(1500) FROM DUAL;