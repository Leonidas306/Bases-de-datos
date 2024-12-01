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
