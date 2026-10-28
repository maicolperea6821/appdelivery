PRAGMA foreign_keys = ON;
SELECT u.Nombre AS cliente, p.ID_Pedido, p.Estado, pl.Nombre AS plato,
       d.Cantidad, d.Precio_Unitario, d.Personalizacion
FROM Pedido p
JOIN Usuario u        ON u.ID_Usuario = p.ID_Usuario
JOIN Detalle_Pedido d ON d.ID_Pedido  = p.ID_Pedido
JOIN Plato pl         ON pl.ID_Plato  = d.ID_Plato;
SELECT ID_Detalle, ID_Pedido, json_extract(Personalizacion, '$.pan') AS pan
FROM Detalle_Pedido
WHERE json_extract(Personalizacion, '$.pan') = 'sin gluten';
SELECT ID_Pedido, Fecha_Pedido, Estado, Total
FROM Pedido
WHERE ID_Usuario = 1
ORDER BY Fecha_Pedido DESC
LIMIT 20;
EXPLAIN QUERY PLAN
SELECT ID_Pedido, Fecha_Pedido, Total
FROM Pedido
WHERE ID_Usuario = 1
ORDER BY Fecha_Pedido DESC;
SELECT u.Nombre, COUNT(p.ID_Pedido) AS pedidos, SUM(p.Total) AS total_gastado
FROM Usuario u
LEFT JOIN Pedido p ON p.ID_Usuario = u.ID_Usuario
GROUP BY u.ID_Usuario;
SELECT p.ID_Pedido, u.Nombre AS cliente, r.Nombre AS restaurante,
       COALESCE(rp.Nombre, 'Sin asignar') AS repartidor,
       p.Estado, p.Total
FROM Pedido p
JOIN Usuario u          ON u.ID_Usuario = p.ID_Usuario
JOIN Restaurante r      ON r.ID_Restaurante = p.ID_Restaurante
LEFT JOIN Repartidor rp ON rp.ID_Repartidor = p.ID_Repartidor
ORDER BY p.ID_Pedido;
SELECT r.Nombre AS restaurante, pl.Nombre AS plato, pl.Precio
FROM Plato pl
JOIN Restaurante r ON r.ID_Restaurante = pl.ID_Restaurante
WHERE r.ID_Restaurante = 1;
SELECT ID_Pedido, Estado, Total FROM Pedido WHERE ID_Repartidor IS NULL;
SELECT rp.Nombre, rp.Vehiculo, COUNT(p.ID_Pedido) AS pedidos_asignados
FROM Repartidor rp
LEFT JOIN Pedido p ON p.ID_Repartidor = rp.ID_Repartidor
GROUP BY rp.ID_Repartidor;
SELECT r.Nombre, COUNT(p.ID_Pedido) AS pedidos, SUM(p.Total) AS total_vendido
FROM Restaurante r
LEFT JOIN Pedido p ON p.ID_Restaurante = r.ID_Restaurante
GROUP BY r.ID_Restaurante;
SELECT ID_Repartidor, Nombre, Vehiculo FROM Repartidor WHERE Disponible = 1;

SELECT Nombre, Categoria, Calificacion
FROM Restaurante
WHERE Activo = 1
ORDER BY Calificacion DESC;