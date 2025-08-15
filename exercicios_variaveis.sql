set serveroutput on; // sempre executar isso primeiro que tudo

DECLARE
    meu_numero       NUMBER;
    meu_outro_numero meu_numero%TYPE := 45555;
    meu_nome         VARCHAR2(30) := 'Pedro';
BEGIN
    meu_numero := 144455;
    meu_numero := meu_numero + meu_outro_numero;
    dbms_output.put_line('O número informado é: ' || meu_numero);
    dbms_output.put_line('O nome informado é: ' || meu_nome);
END;

// uma forma de fazer, mais complexa, mais variáveis
DECLARE
    salario      NUMBER := 1518;
    novo_salario NUMBER;
    valor        NUMBER;
BEGIN
    valor := salario * 0.25;
    novo_salario := valor + salario;
    dbms_output.put_line('O novo salário é: ' || novo_salario);
END;

// outra forma de fazer, menos variaveis
DECLARE
    novo_salario FLOAT := 1518;
BEGIN
    novo_salario := novo_salario + ( novo_salario * 0.25 );
    dbms_output.put_line('O novo salário é: ' || novo_salario);
END;

// exercicio 2 -> conversao de dolar para reais
DECLARE
    valor_dolar FLOAT := 5.5;
BEGIN
    dbms_output.put_line('O valor convertido em para R$ é: ' || 45 * valor_dolar);
END;

// exercicio 3
// &VALOR
DECLARE
    qtd_parcelas  NUMBER := 10;
    valor_produto FLOAT := &valor;
    valor_juros   FLOAT := 0.03;
    valor_parcela FLOAT;
    valor_total   FLOAT;
BEGIN
    valor_parcela := ( valor_produto + ( valor_produto * 0.03 ) ) / qtd_parcelas;
    dbms_output.put_line('O valor das parcelas fica em: ' || valor_parcela);
    valor_total := valor_parcela * qtd_parcelas;
    dbms_output.put_line('O valor do veículo total foi: ' || valor_total);
END;

// exercicio 4
DECLARE
    valorcarro NUMBER := &carro;
    carrovinte NUMBER;
    parcela6   NUMBER;
    parcela12  NUMBER;
    parcela18  NUMBER;
BEGIN
    carrovinte := valorcarro * 0.2;
    dbms_output.put_line('Valor de entrada R$: ' || carrovinte);
    parcela6 := ROUND(( ( valorcarro - carrovinte ) * 1.1 ) / 6);
    dbms_output.put_line('Valor da parcela em 6x R$: ' || parcela6);
    parcela6 := ROUND(( ( valorcarro - carrovinte ) * 1.15 ) / 12);
    dbms_output.put_line('Valor da parcela em 12x R$: ' || parcela6);
    parcela6 := ROUND(( ( valorcarro - carrovinte ) * 1.20 ) / 18);
    dbms_output.put_line('Valor da parcela em 18x R$: ' || parcela6);
END;