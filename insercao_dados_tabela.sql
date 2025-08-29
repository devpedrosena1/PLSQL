// Inserindo dados em tabelas que tem PK
SELECT * FROM PAIS;
INSERT INTO PAIS SELECT * FROM PF1788.PAIS;
COMMIT;

SELECT * FROM ESTADO;
INSERT INTO ESTADO SELECT * FROM PF1788.ESTADO;
COMMIT;

SELECT * FROM CIDADE;
INSERT INTO CIDADE SELECT * FROM PF1788.CIDADE;
COMMIT;

ALTER TABLE CIDADE MODIFY NOM_CIDADE VARCHAR2(50);

SELECT * FROM produto;
INSERT INTO produto SELECT * FROM PF1788.produto;
COMMIT;

SELECT * FROM cliente;
INSERT INTO cliente SELECT * FROM PF1788.cliente;
COMMIT;

SELECT * FROM vendedor;
INSERT INTO vendedor SELECT * FROM PF1788.vendedor;
COMMIT;

SELECT * FROM estoque;
INSERT INTO estoque SELECT * FROM PF1788.estoque;
COMMIT;

SELECT * FROM tipo_movimento_estoque;
INSERT INTO tipo_movimento_estoque SELECT * FROM PF1788.tipo_movimento_estoque;
COMMIT;

SELECT * FROM tipo_movimento_estoque;
INSERT INTO tipo_movimento_estoque SELECT * FROM PF1788.tipo_movimento_estoque;
COMMIT;

SELECT * FROM usuario;
INSERT INTO usuario SELECT * FROM PF1788.usuario;
COMMIT;

SELECT * FROM tipo_endereco;
INSERT INTO tipo_endereco SELECT * FROM PF1788.tipo_endereco;
COMMIT;

SELECT * FROM endereco_cliente;
INSERT INTO endereco_cliente SELECT * FROM PF1788.endereco_cliente;
COMMIT;

SELECT * FROM estoque_produto;
INSERT INTO estoque_produto SELECT * FROM PF1788.estoque_produto;
COMMIT;

SELECT * FROM movimento_estoque;
INSERT INTO movimento_estoque SELECT * FROM PF1788.movimento_estoque;
COMMIT;

SELECT * FROM cliente_vendedor;
INSERT INTO cliente_vendedor SELECT * FROM PF1788.cliente_vendedor;
COMMIT;

ALTER TABLE PEDIDO ADD status VARCHAR2(50);

SELECT * FROM pedido;
INSERT INTO pedido SELECT * FROM PF1788.pedido;
COMMIT;

SELECT * FROM produto_composto;
INSERT INTO produto_composto SELECT * FROM PF1788.produto_composto;
COMMIT;

SELECT * FROM item_pedido;
INSERT INTO item_pedido SELECT * FROM PF1788.item_pedido;
COMMIT;

SELECT * FROM historico_pedido;
INSERT INTO historico_pedido SELECT * FROM PF1788.historico_pedido;
COMMIT;





