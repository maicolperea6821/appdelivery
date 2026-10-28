PRAGMA foreign_keys = ON;

INSERT INTO Usuario (ID_Usuario, Nombre, Email, Telefono) VALUES
  (1, 'juan perez',    'juanperez@gmail.com',    '1234567890'),
  (2, 'maria lopez',   'marialopez@gmail.com',   '0987654321'),
  (3, 'carlos gomez',  'carlosgomez@gmail.com',  '1122334455'),
  (4, 'ana torres',    'anatorres@gmail.com',    '3105558899'),
  (5, 'luis ramirez',  'luisramirez@gmail.com',  '3112223344'),
  (6, 'sofia castro',  'sofiacastro@gmail.com',  '3207776655');

INSERT INTO Repartidor (ID_Repartidor, Nombre,Telefono,  Vehiculo) VALUES
  (1, 'carlos ruiz', '3135667203',   'moto'),
  (2, 'andrea torres','3102577243',  'bicicleta'),
  (3, 'miguel soto',  '3175007203',  'moto'),
  (4, 'paola diaz',   '3208767207',  'carro'),
  (5, 'jorge mejia',  '3135347288',  'bicicleta'),
  (6, 'daniela rojas','3218765922',  'moto');

INSERT INTO Restaurante (ID_Restaurante, Nombre, Direccion, Categoria, Calificacion, Icono_Categoria) VALUES
  (1, 'burger house',   'Calle Mayor 45, Bajo B, 28013 Madrid',  'Hamburguesas', 4.5, '/icons/burger.png'),
  (2, 'pizzeria napoli','Avenida de la Constitución 12, 3º Izquierda, 41001 Sevilla',  'Pizza',        4.2, '/icons/pizza.png'),
  (3, 'sushi zen',      'Carrer de Mallorca 234, Planta 2, Puerta 1, 08008 Barcelona',  'Sushi',        4.7, '/icons/sushi.png'),
  (4, 'dulce tentacion','Paseo de la Castellana 89, Piso 5A, 28046 Madrid',  'Postres',      4.0, '/icons/dessert.png'),
  (5, 'taco loco',      'Calle de Colón 7, Principal 2ª, 46004 Valencia',  'Mexicana',     4.3, '/icons/taco.png'),
  (6, 'pollo brasa',    'Avenida de la Libertad 18, 4º Derecha, 20004 San Sebastián',  'Pollo',        4.1, '/icons/chicken.png');

INSERT INTO Plato (ID_Plato, ID_Restaurante, Nombre, Precio) VALUES
  (1,  1, 'hamburguesa doble',    12.50),
  (2,  1, 'papas fritas',          4.00),
  (3,  2, 'pizza personal',        9.00),
  (4,  2, 'lasagna',              11.00),
  (5,  3, 'rollo california',     10.50),
  (6,  3, 'sopa miso',             5.00),
  (7,  4, 'brownie con helado',    6.00),
  (8,  4, 'cheesecake',            5.50),
  (9,  5, 'tacos al pastor',       8.50),
  (10, 5, 'nachos con queso',      6.50),
  (11, 6, 'pollo asado',          13.00),
  (12, 6, 'jugo natural',          3.00);

INSERT INTO Pedido (ID_Pedido, ID_Usuario, ID_Restaurante, ID_Repartidor, Total) VALUES
  (1, 1, 1, 1, 29.00),
  (2, 2, 2, 2, 20.00),
  (3, 3, 3, 3, 26.00),
  (4, 4, 4, 4, 17.00),
  (5, 5, 5, 5, 32.00),
  (6, 6, 6, 6, 19.00);

INSERT INTO Detalle_Pedido (ID_Detalle, ID_Pedido, ID_Plato, Cantidad, Precio_Unitario) VALUES
  (1,  1, 1,  2, 12.50),
  (2,  1, 2,  1,  4.00),
  (3,  2, 3,  1,  9.00),
  (4,  2, 4,  1, 11.00),
  (5,  3, 5,  2, 10.50),
  (6,  3, 6,  1,  5.00),
  (7,  4, 7,  1,  6.00),
  (8,  4, 8,  2,  5.50),
  (9,  5, 9,  3,  8.50),
  (10, 5, 10, 1,  6.50),
  (11, 6, 11, 1, 13.00),
  (12, 6, 12, 2,  3.00);