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


