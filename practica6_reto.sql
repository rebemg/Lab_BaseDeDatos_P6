DROP TABLE IF EXISTS detalle_pedido CASCADE;
DROP TABLE IF EXISTS pedido CASCADE;
DROP TABLE IF EXISTS producto CASCADE;
DROP TABLE IF EXISTS cliente CASCADE;

CREATE TABLE cliente (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    direccion VARCHAR(100)
);

CREATE TABLE producto (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    precio NUMERIC(10,2)
);

CREATE TABLE pedido (
    id SERIAL PRIMARY KEY,
    cliente_id INT NOT NULL REFERENCES cliente(id),
    fecha DATE NOT NULL
);

CREATE TABLE detalle_pedido (
    pedido_id INT NOT NULL REFERENCES pedido(id),
    producto_id INT NOT NULL REFERENCES producto(id),
    cantidad INT NOT NULL,
    PRIMARY KEY(pedido_id, producto_id)
);

INSERT INTO cliente (nombre, direccion) VALUES
('Sofía Martínez', 'Av. Libertad 101'),
('Jorge Ramírez', 'Calle Hidalgo 202'),
('Valeria Torres', 'Av. Juárez 303'),
('Andrés López', 'Calle Morelos 404'),
('Camila Fernández', 'Av. Reforma 505');

INSERT INTO producto (nombre, precio) VALUES
('Cuaderno', 50.00),
('Bolígrafo', 20.00),
('Mochila', 600.00),
('Tablet', 8000.00),
('Audífonos', 1200.00);

INSERT INTO pedido (cliente_id, fecha) VALUES
(1, '2026-10-05'),
(2, '2026-10-06'),
(3, '2026-10-07'),
(4, '2026-10-08'),
(5, '2026-10-09');

INSERT INTO detalle_pedido (pedido_id, producto_id, cantidad) VALUES
(1, 1, 3),
(1, 2, 5),
(2, 3, 1),
(3, 4, 2),
(4, 5, 1),
(5, 2, 10);

CREATE OR REPLACE VIEW ranking_clientes AS
SELECT c.nombre AS cliente,
       SUM(dp.cantidad * pr.precio) AS total_compras
FROM cliente c
INNER JOIN pedido p ON c.id = p.cliente_id
INNER JOIN detalle_pedido dp ON p.id = dp.pedido_id
INNER JOIN producto pr ON dp.producto_id = pr.id
GROUP BY c.nombre
ORDER BY total_compras DESC
LIMIT 5;

SELECT * FROM ranking_clientes;

INSERT INTO pedido (cliente_id, fecha) VALUES
(1, '2025-09-10'),
(2, '2025-09-12'),
(3, '2025-09-15');

SELECT id, cliente_id, fecha
FROM pedido
WHERE EXTRACT(YEAR FROM fecha) = 2025

UNION

SELECT id, cliente_id, fecha
FROM pedido
WHERE EXTRACT(YEAR FROM fecha) = 2026
ORDER BY fecha;