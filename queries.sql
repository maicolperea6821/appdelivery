-- ============================================================
-- queries.sql: consultas de AppDeliveryDB
-- Autor: Maicol Perea | Materia: Bases de Datos
-- ============================================================

SELECT
    -- Datos principales del pedido
    p.ID_Pedido,
    -- Mostramos el nombre del cliente y del plato en lugar de sus IDs
    u.Nombre AS Cliente,
    pl.Nombre AS Plato,
    dp.Cantidad,
    -- Uso de json_extract para sacar elementos específicos del texto JSON
    json_extract(dp.Personalizacion, '$.quitar[0]')  AS Ingrediente_Quitado,
    json_extract(dp.Personalizacion, '$.agregar[0]') AS Ingrediente_Agregado

-- Tabla principal
FROM Pedido p

-- Buscamos el nombre del cliente
JOIN Usuario u ON p.ID_Usuario = u.ID_Usuario

-- Buscamos los detalles del pedido
JOIN Detalle_Pedido dp ON p.ID_Pedido = dp.ID_Pedido

-- Buscamos el nombre del plato
JOIN Plato pl ON dp.ID_Plato = pl.ID_Plato;


-- 2. Pedidos pendientes de entrega (pagados o en camino)
SELECT
    p.ID_Pedido,
    u.Nombre AS Cliente,
    r.Nombre AS Restaurante,
    p.Fecha_Pedido,
    p.Estado,
    p.Total

-- Tabla principal
FROM Pedido p

-- Buscamos el nombre del cliente
JOIN Usuario u ON p.ID_Usuario = u.ID_Usuario

-- Buscamos el nombre del restaurante
JOIN Restaurante r ON p.ID_Restaurante = r.ID_Restaurante

-- Mostramos solamente los pedidos que todavía no se entregan
WHERE p.Estado IN ('pagado', 'enviado');

SELECT
    pl.ID_Plato,
    pl.Nombre AS Plato,
    r.Nombre AS Restaurante,
    pl.Precio,
    pl.Disponible

-- Tabla principal
FROM Plato pl

-- Relacionamos cada plato con su restaurante
JOIN Restaurante r ON pl.ID_Restaurante = r.ID_Restaurante

-- Organizamos los platos por precio
ORDER BY pl.Precio DESC;

SELECT
    p.ID_Pedido,
    u.Nombre AS Cliente,
    r.Nombre AS Restaurante,
    -- Si el pedido no tiene repartidor mostramos "Sin asignar"
    COALESCE(rp.Nombre, 'Sin asignar') AS Repartidor,
    rp.Vehiculo,
    p.Estado

FROM Pedido p
JOIN Usuario u ON p.ID_Usuario = u.ID_Usuario
JOIN Restaurante r ON p.ID_Restaurante = r.ID_Restaurante

-- LEFT JOIN para que también salgan los pedidos sin repartidor
LEFT JOIN Repartidor rp ON p.ID_Repartidor = rp.ID_Repartidor

ORDER BY p.ID_Pedido;

SELECT
    r.Nombre AS Restaurante,
    -- Contamos los pedidos y sumamos el dinero de cada restaurante
    COUNT(p.ID_Pedido) AS Pedidos,
    SUM(p.Total) AS Total_Vendido

FROM Restaurante r
LEFT JOIN Pedido p ON r.ID_Restaurante = p.ID_Restaurante

-- Agrupamos por restaurante
GROUP BY r.ID_Restaurante

-- Del que más vendió al que menos
ORDER BY Total_Vendido DESC;

SELECT
    u.Nombre AS Cliente,
    COUNT(p.ID_Pedido) AS Pedidos,
    SUM(p.Total) AS Total_Gastado

FROM Usuario u
LEFT JOIN Pedido p ON u.ID_Usuario = p.ID_Usuario
GROUP BY u.ID_Usuario
ORDER BY Total_Gastado DESC;

SELECT
    pl.Nombre AS Plato,
    r.Nombre AS Restaurante,
    SUM(dp.Cantidad) AS Unidades_Vendidas

FROM Detalle_Pedido dp
JOIN Plato pl ON dp.ID_Plato = pl.ID_Plato
JOIN Restaurante r ON pl.ID_Restaurante = r.ID_Restaurante

GROUP BY pl.ID_Plato
ORDER BY Unidades_Vendidas DESC;

SELECT
    ID_Repartidor,
    Nombre,
    Vehiculo,
    Telefono
FROM Repartidor
WHERE Disponible = 1;

SELECT
    dp.ID_Detalle,
    dp.ID_Pedido,
    pl.Nombre AS Plato,
    json_extract(dp.Personalizacion, '$.pan') AS Pan
FROM Detalle_Pedido dp
JOIN Plato pl ON dp.ID_Plato = pl.ID_Plato
WHERE json_extract(dp.Personalizacion, '$.pan') = 'sin gluten';

SELECT
    ID_Pedido,
    Fecha_Pedido,
    Estado,
    Total
FROM Pedido
WHERE ID_Usuario = 1
ORDER BY Fecha_Pedido DESC
LIMIT 20;

SELECT
    Nombre,
    Precio
FROM Plato
WHERE ID_Categoria = 5;

SELECT
    pl.Nombre,
    pl.Precio,
    c.Nombre AS Categoria
FROM Plato pl
JOIN Categoria c ON pl.ID_Categoria = c.ID_Categoria
WHERE c.ID_Categoria = 5;

EXPLAIN QUERY PLAN
SELECT Nombre, Precio
FROM Plato
WHERE ID_Categoria = 5;