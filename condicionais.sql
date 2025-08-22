set serveroutput on;

DECLARE
    v_n NUMBER(2) := 15;
BEGIN
    IF MOD(v_n, 2) = 0 THEN
        dbms_output.put_line('É par');
    ELSE
        dbms_output.put_line('É impar');
    END IF;
END;