DROP TABLE IF EXISTS Pedido;
drop TABLE IF EXISTS Detalle_Pedido;
drop TABLE IF EXISTS Plato;
drop TABLE IF EXISTS Restaurante;
drop TABLE IF EXISTS Repartidor;
drop TABLE IF EXISTS Usuario;
PRAGMA foreign_keys = ON;


-- ============================================================
-- AppDeliveryDB: Módulo "Carrito de Compras"
-- Autor: Maicol Perea | Materia: Bases de Datos
-- Motor: SQLite
-- ============================================================

CREATE TABLE IF NOT EXISTS Usuario (
  ID_Usuario     INTEGER PRIMARY KEY AUTOINCREMENT,
  Nombre         TEXT NOT NULL,
  Email          TEXT NOT NULL UNIQUE,
  Telefono       TEXT,
  Fecha_Registro TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS Plato (
  ID_Plato    INTEGER PRIMARY KEY AUTOINCREMENT,
  Nombre      TEXT NOT NULL,
  Descripcion TEXT,
  Precio      REAL NOT NULL CHECK (Precio >= 0),
  Foto_URL    TEXT,
  Disponible  INTEGER NOT NULL DEFAULT 1 CHECK (Disponible IN (0, 1))
);

CREATE TABLE IF NOT EXISTS Pedido (
  ID_Pedido    INTEGER PRIMARY KEY AUTOINCREMENT,
  ID_Usuario   INTEGER NOT NULL,
  Fecha_Pedido TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP,
  Estado       TEXT NOT NULL DEFAULT 'carrito'
               CHECK (Estado IN ('carrito', 'pagado', 'enviado', 'entregado', 'cancelado')),
  Total        REAL NOT NULL DEFAULT 0,
  Datos_Extra  TEXT CHECK (Datos_Extra IS NULL OR json_valid(Datos_Extra)),
  FOREIGN KEY (ID_Usuario) REFERENCES Usuario(ID_Usuario)
);

CREATE TABLE IF NOT EXISTS Detalle_Pedido (
  ID_Detalle      INTEGER PRIMARY KEY AUTOINCREMENT,
  ID_Pedido       INTEGER NOT NULL,
  ID_Plato        INTEGER NOT NULL,
  Cantidad        INTEGER NOT NULL CHECK (Cantidad > 0),
  Precio_Unitario REAL NOT NULL,
  Personalizacion TEXT CHECK (Personalizacion IS NULL OR json_valid(Personalizacion)),
  FOREIGN KEY (ID_Pedido) REFERENCES Pedido(ID_Pedido) ON DELETE CASCADE,
  FOREIGN KEY (ID_Plato)  REFERENCES Plato(ID_Plato)
);

CREATE TABLE IF NOT EXISTS Repartidor (
  ID_Repartidor INTEGER PRIMARY KEY AUTOINCREMENT,
  Nombre        TEXT NOT NULL,
  Telefono      TEXT NOT NULL,
  Vehiculo      TEXT NOT NULL CHECK (Vehiculo IN ('moto', 'bicicleta', 'carro')),
  Placa         TEXT UNIQUE,
  Disponible    INTEGER NOT NULL DEFAULT 1 CHECK (Disponible IN (0, 1))
);

CREATE TABLE Restaurante (
  ID_Restaurante INTEGER PRIMARY KEY AUTOINCREMENT,
  Nombre         TEXT NOT NULL,
  Direccion      TEXT NOT NULL,
  Telefono       TEXT,
  Categoria      TEXT,
  Icono_Categoria TEXT,
  Calificacion   REAL CHECK (Calificacion IS NULL OR Calificacion BETWEEN 0 AND 5),
  Activo         INTEGER NOT NULL DEFAULT 1 CHECK (Activo IN (0, 1))
);

ALTER TABLE Pedido ADD COLUMN ID_Repartidor INTEGER REFERENCES Repartidor(ID_Repartidor);
ALTER TABLE Pedido ADD COLUMN ID_Restaurante INTEGER REFERENCES Restaurante(ID_Restaurante);
ALTER TABLE Plato  ADD COLUMN ID_Restaurante INTEGER REFERENCES Restaurante(ID_Restaurante);

CREATE INDEX IF NOT EXISTS idx_pedido_repartidor ON Pedido(ID_Repartidor);
CREATE INDEX IF NOT EXISTS idx_pedido_usuario ON Pedido(ID_Usuario, Fecha_Pedido DESC);
CREATE INDEX IF NOT EXISTS idx_detalle_pedido ON Detalle_Pedido(ID_Pedido);
CREATE INDEX IF NOT EXISTS idx_detalle_plato  ON Detalle_Pedido(ID_Plato);
CREATE INDEX IF NOT EXISTS idx_pedido_restaurante ON Pedido(ID_Restaurante);
CREATE INDEX IF NOT EXISTS idx_plato_restaurante  ON Plato(ID_Restaurante);