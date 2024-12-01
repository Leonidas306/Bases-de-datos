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