CREATE DATABASE IF NOT EXISTS velcroCase;
USE velcroCase;

-- 1. Tabla de Clientes
CREATE TABLE Clientes (
    cliente_id INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    telefono VARCHAR(15),
    direccion TEXT,
    fecha_registro DATETIME,
    tipo_cliente ENUM('Regular', 'Premium') DEFAULT 'Regular'
);

-- 2. Tabla de Productos
CREATE TABLE Productos (
    producto_id INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100) NOT NULL,
    descripcion TEXT,
    precio DECIMAL(10, 2) NOT NULL,
    stock INT DEFAULT 0,
    activo BOOLEAN DEFAULT TRUE
);

-- 3. Tabla de Accesorios
CREATE TABLE Accesorios (
    accesorio_id INT PRIMARY KEY AUTO_INCREMENT,
    producto_id INT,
    nombre VARCHAR(100) NOT NULL,
    descripcion TEXT,
    precio DECIMAL(10, 2) NOT NULL,
    stock INT DEFAULT 0,
    FOREIGN KEY (producto_id) REFERENCES Productos(producto_id) ON DELETE CASCADE
);

-- 4. Tabla de Proveedores
CREATE TABLE Proveedores (
    proveedor_id INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100) NOT NULL,
    contacto VARCHAR(100),
    telefono VARCHAR(15),
    direccion TEXT,
    email VARCHAR(100)
);

-- 5. Tabla de Compras
CREATE TABLE Compras (
    compra_id INT PRIMARY KEY AUTO_INCREMENT,
    proveedor_id INT,
    producto_id INT,
    cantidad INT NOT NULL,
    costo_unitario DECIMAL(10, 2) NOT NULL,
    fecha_compra datetime,
    FOREIGN KEY (proveedor_id) REFERENCES Proveedores(proveedor_id) ON DELETE SET NULL,
    FOREIGN KEY (producto_id) REFERENCES Productos(producto_id) ON DELETE CASCADE
);

-- 6. Tabla de Inventario
CREATE TABLE Inventario (
    movimiento_id INT PRIMARY KEY AUTO_INCREMENT,
    producto_id INT,
    cantidad INT NOT NULL,
    tipo_movimiento ENUM('Entrada', 'Salida') NOT NULL,
    fecha_movimiento DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (producto_id) REFERENCES Productos(producto_id) ON DELETE CASCADE
);

-- 7. Tabla de Órdenes
CREATE TABLE Ordenes (
    orden_id INT PRIMARY KEY AUTO_INCREMENT,
    cliente_id INT,
    total DECIMAL(10, 2) NOT NULL,
    estado ENUM('Pendiente', 'Enviado', 'Entregado', 'Cancelado') DEFAULT 'Pendiente',
    fecha_orden DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (cliente_id) REFERENCES Clientes(cliente_id) ON DELETE SET NULL
);

-- 8. Tabla de DetalleOrden
CREATE TABLE DetalleOrden (
    detalle_id INT PRIMARY KEY AUTO_INCREMENT,
    orden_id INT,
    producto_id INT,
    accesorio_id INT,
    cantidad INT NOT NULL,
    subtotal DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (orden_id) REFERENCES Ordenes(orden_id) ON DELETE CASCADE,
    FOREIGN KEY (producto_id) REFERENCES Productos(producto_id) ON DELETE CASCADE,
    FOREIGN KEY (accesorio_id) REFERENCES Accesorios(accesorio_id) ON DELETE SET NULL
);

-- 9. Tabla de Campañas de Marketing
CREATE TABLE Campañas (
    campaña_id INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100) NOT NULL,
    descripcion TEXT,
    fecha_inicio DATE,
    fecha_fin DATE
);

-- 10. Tabla de ResultadosCampaña
CREATE TABLE ResultadosCampaña (
    resultado_id INT PRIMARY KEY AUTO_INCREMENT,
    campaña_id INT,
    cliente_id INT,
    tipo_interaccion ENUM('Compra', 'Clic', 'Consulta') NOT NULL,
    monto_generado DECIMAL(10, 2),
    fecha_interaccion DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (campaña_id) REFERENCES Campañas(campaña_id) ON DELETE CASCADE,
    FOREIGN KEY (cliente_id) REFERENCES Clientes(cliente_id) ON DELETE SET NULL
);

-- 11. Tabla de Feedback de Clientes
CREATE TABLE FeedbackClientes (
    feedback_id INT PRIMARY KEY AUTO_INCREMENT,
    cliente_id INT,
    producto_id INT,
    comentario TEXT,
    calificacion INT CHECK (calificacion BETWEEN 1 AND 5),
    fecha DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (cliente_id) REFERENCES Clientes(cliente_id) ON DELETE SET NULL,
    FOREIGN KEY (producto_id) REFERENCES Productos(producto_id) ON DELETE CASCADE
);

-- 12. Tabla de Usuarios
CREATE TABLE Usuarios (
    usuario_id INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    rol ENUM('Administrador', 'Empleado') DEFAULT 'Empleado',
    password_hash VARCHAR(255) NOT NULL
);

-- 13. Tabla de Permisos
CREATE TABLE Permisos (
    permiso_id INT PRIMARY KEY AUTO_INCREMENT,
    usuario_id INT,
    modulo VARCHAR(100),
    permiso ENUM('Lectura', 'Escritura', 'Modificación', 'Eliminación') NOT NULL,
    FOREIGN KEY (usuario_id) REFERENCES Usuarios(usuario_id) ON DELETE CASCADE
);

-- 14. Tabla de Logs de Actividad
CREATE TABLE LogsActividad (
    log_id INT PRIMARY KEY AUTO_INCREMENT,
    usuario_id INT,
    accion VARCHAR(255),
    descripcion TEXT,
    fecha DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (usuario_id) REFERENCES Usuarios(usuario_id) ON DELETE CASCADE
);

-- Insercion de datos

-- Insertar datos en la tabla de Clientes
INSERT INTO Clientes (nombre, email, telefono, direccion, fecha_registro, tipo_cliente) VALUES
('Leonardo Pérez', 'leonardo.perez@example.com', '1234567890', 'Calle 1, Ciudad A', '2024-01-15', 'Premium'),
('María López', 'maria.lopez@example.com', '0987654321', 'Calle 2, Ciudad B', '2024-02-10', 'Regular'),
('Carlos Ruiz', 'carlos.ruiz@example.com', '5556781234', 'Calle 3, Ciudad C', '2024-03-05', 'Regular');

-- Insertar datos en la tabla de Productos
INSERT INTO Productos (nombre, descripcion, precio, stock) VALUES
('VelcroCase Estándar', 'Funda básica con velcro en la parte trasera', 19.99, 50),
('VelcroCase Premium', 'Funda con mayor resistencia y soporte adicional', 29.99, 30);

-- Insertar datos en la tabla de Accesorios
INSERT INTO Accesorios (producto_id, nombre, descripcion, precio, stock) VALUES
(1, 'Soporte Modular', 'Soporte ajustable para mesas', 9.99, 100),
(2, 'Módulo de Batería', 'Batería adicional compatible con VelcroCase', 14.99, 80);

-- Insertar datos en la tabla de Proveedores
INSERT INTO Proveedores (nombre, contacto, telefono, direccion, email) VALUES
('Proveedor A', 'Juan Ramírez', '1234567890', 'Calle 4, Ciudad D', 'proveedor.a@example.com'),
('Proveedor B', 'Ana Gómez', '0987654321', 'Calle 5, Ciudad E', 'proveedor.b@example.com');

-- Insertar datos en la tabla de Compras
INSERT INTO Compras (proveedor_id, producto_id, cantidad, costo_unitario, fecha_compra) VALUES
(1, 1, 20, 10.99, '2024-01-20'),
(2, 2, 15, 15.49, '2024-01-25');

-- Insertar datos en la tabla de Inventario
INSERT INTO Inventario (producto_id, cantidad, tipo_movimiento) VALUES
(1, 20, 'Entrada'),
(2, 15, 'Entrada');

-- Insertar datos en la tabla de Órdenes
INSERT INTO Ordenes (cliente_id, total, estado) VALUES
(1, 34.98, 'Pendiente'),
(2, 19.99, 'Enviado'),
(3, 0.00, 'Pendiente');

-- Insertar datos en la tabla de DetalleOrden
INSERT INTO DetalleOrden (orden_id, producto_id, accesorio_id, cantidad, subtotal) VALUES
(1, 1, 1, 1, 19.99),
(1, 1, 2, 1, 14.99),
(2, 1, NULL, 1, 19.99);

-- Insertar datos en la tabla de Campañas
INSERT INTO Campañas (nombre, descripcion, fecha_inicio, fecha_fin) VALUES
('Descuento Invierno', 'Promoción de accesorios con un 20% de descuento', '2024-01-01', '2024-01-31');

-- Insertar datos en la tabla de ResultadosCampaña
INSERT INTO ResultadosCampaña (campaña_id, cliente_id, tipo_interaccion, monto_generado) VALUES
(1, 1, 'Compra', 34.98),
(1, 2, 'Compra', 19.99),
(1, 3, 'Clic', 0.00);

-- Insertar datos en la tabla de FeedbackClientes
INSERT INTO FeedbackClientes (cliente_id, producto_id, comentario, calificacion) VALUES
(1, 1, 'Muy buena funda, excelente calidad.', 5),
(2, 2, 'La funda es funcional, pero puede mejorar.', 3);

-- Insertar datos en la tabla de Usuarios
INSERT INTO Usuarios (nombre, email, rol, password_hash) VALUES
('Juan', 'admin@example.com', 'Administrador', 'hashed_password'),
('Eduardo', 'empleado1@example.com', 'Empleado', 'hashed_password');

-- Insertar datos en la tabla de Permisos
INSERT INTO Permisos (usuario_id, modulo, permiso) VALUES
(1, 'Inventario', 'Modificación'),
(2, 'Ordenes', 'Lectura');

-- Insertar datos en la tabla de Logs de Actividad
INSERT INTO LogsActividad (usuario_id, accion, descripcion) VALUES
(1, 'Actualizar stock', 'Se incrementó el stock de VelcroCase Estándar en 10 unidades'),
(2, 'Registrar orden', 'Se creó una nueva orden para el cliente María López');

-- 1. Consultar productos en inventario con bajo stock (<50 unidades):
SELECT nombre, stock 
FROM Productos 
WHERE stock < 50;

-- 1. Consultar productos en inventario con bajo stock (>10 unidades):
SELECT nombre, stock 
FROM Productos 
WHERE stock > 30;


-- 2. Obtener el historial de compras de un cliente:
SELECT O.orden_id, O.fecha_orden, D.producto_id, D.cantidad, D.subtotal
FROM Ordenes O
JOIN DetalleOrden D ON O.orden_id = D.orden_id
WHERE O.cliente_id = 1;

-- 3 Consultar las interacciones de clientes con campañas de marketing

SELECT C.nombre AS Campaña, R.tipo_interaccion, R.monto_generado, R.fecha_interaccion
FROM ResultadosCampaña R
JOIN Campañas C ON R.campaña_id = C.campaña_id;

-- 4. Analizar el rendimiento de una campaña específica

SELECT R.tipo_interaccion, COUNT(*) AS Total_Interacciones, SUM(R.monto_generado) AS Ingresos_Generados
FROM ResultadosCampaña R
WHERE R.campaña_id = 1
GROUP BY R.tipo_interaccion;

-- 5.Consultar logs de actividad del sistema por usuario

SELECT L.fecha, U.nombre AS Usuario, L.accion, L.descripcion
FROM LogsActividad L
JOIN Usuarios U ON L.usuario_id = U.usuario_id
WHERE U.rol = 'Administrador';

-- 6. Ver el feedback de los clientes sobre un producto
SELECT F.cliente_id, C.nombre AS Cliente, F.comentario, F.calificacion
FROM FeedbackClientes F
JOIN Clientes C ON F.cliente_id = C.cliente_id
WHERE F.producto_id = 1;


