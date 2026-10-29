
EXPLAIN QUERY PLAN
SELECT *
FROM Pedido
WHERE ID_Usuario = 1;

CREATE INDEX IF NOT EXISTS idx_pedido_usuario
ON Pedido(ID_Usuario);

EXPLAIN QUERY PLAN
SELECT *
FROM Pedido
WHERE ID_Usuario = 1;


SELECT *
FROM Pedido
WHERE ID_Usuario = 1;


PRAGMA index_list('Pedido');
