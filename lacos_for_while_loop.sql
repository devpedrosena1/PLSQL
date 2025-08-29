set serveroutput on;

// LOOP
DECLARE
    v_contador NUMBER(2) := 1;
BEGIN
    LOOP
        dbms_output.put_line(v_contador);
        v_contador := v_contador + 1;
        EXIT WHEN v_contador > 20;
    END LOOP;
END;

// WHILE
DECLARE 
    v_contador NUMBER(2) := 1;
BEGIN
    WHILE V_CONTADOR <= 20 LOOP
        dbms_output.put_line(v_contador);
        v_contador := v_contador + 1;
    END LOOP;
END;

// FOR
BEGIN
    FOR V_CONTADOR IN 1..20 LOOP
        dbms_output.put_line(v_contador);
    END LOOP;
END;

// REVERSE
BEGIN
    FOR V_CONTADOR IN REVERSE 1..20 LOOP
        dbms_output.put_line(v_contador);
    END LOOP;
END;

// EXERCICIO 1
DECLARE
    v_valor  NUMBER := &valor;
    v_result NUMBER;
BEGIN
    FOR v_cont IN 1..10 LOOP
        v_result := v_valor * v_cont;
        dbms_output.put_line(v_valor || ' X ' || v_cont || ' = ' || v_result);
    END LOOP;
END;

// EXERCICIO 2
DECLARE

n_par NUMBER := 0;
n_impar NUMBER := 0;

BEGIN
    FOR V_CONT IN 1..10 LOOP
        IF MOD(V_CONT, 2) = 0 THEN
            n_par := n_par + 1;
        ELSE 
            n_impar := n_par + 1;
        END IF;
          
    END LOOP;
    dbms_output.put_line('QTD PAR: ' || n_par);
    dbms_output.put_line('QTD IMPAR:' || n_impar);
END;