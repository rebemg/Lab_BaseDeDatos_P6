DROP TABLE IF EXISTS detalle_pedido CASCADE;
DROP TABLE IF EXISTS pedido CASCADE;
DROP TABLE IF EXISTS producto CASCADE;
DROP TABLE IF EXISTS cliente CASCADE;
DROP TABLE IF EXISTS empleado CASCADE;
DROP TABLE IF EXISTS departamento CASCADE;

CREATE TABLE IF NOT EXISTS empleado (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(50),
    puesto VARCHAR(50),
    salario NUMERIC(10,2),
    fecha_contratacion DATE
);


CREATE TABLE IF NOT EXISTS departamento (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(50)
);


INSERT INTO empleado (nombre, puesto, salario, fecha_contratacion)
VALUES ('Ana Torres', 'Analista', 15000, '2026-10-02');


CREATE TABLE IF NOT EXISTS cliente (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    direccion VARCHAR(100)
);


CREATE TABLE IF NOT EXISTS producto (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    precio NUMERIC(10,2)
);


CREATE TABLE IF NOT EXISTS pedido (
    id SERIAL PRIMARY KEY,
    cliente_id INT NOT NULL REFERENCES cliente(id),
    fecha DATE NOT NULL
);


CREATE TABLE IF NOT EXISTS detalle_pedido (
    pedido_id INT NOT NULL REFERENCES pedido(id),
    producto_id INT NOT NULL REFERENCES producto(id),
    cantidad INT NOT NULL,
    PRIMARY KEY(pedido_id, producto_id)
);

INSERT INTO empleado (nombre, puesto, salario, fecha_contratacion)
VALUES 
('Ana Torres', 'Analista', 15000, '2026-10-02'),
('Luis Gómez', 'Gerente', 30000, '2026-09-15'),
('Marta Ruiz', 'Desarrolladora', 22000, '2026-08-10'),
('Carlos Pérez', 'Soporte', 14000, '2026-07-01'),
('Diana López', 'Analista', 16000, '2026-10-01');

INSERT INTO departamento (nombre)
VALUES 
('Recursos Humanos'),
('Finanzas'),
('Tecnología'),
('Ventas');

INSERT INTO cliente (nombre, direccion) VALUES
('Luis Gómez', 'Av. Universidad 123'),
('Marta Ruiz', 'Calle Reforma 456'),
('Carlos Pérez', 'Av. Central 789'),
('Diana López', 'Calle Norte 22'),
('Ana Torres', 'Av. Sur 77');

INSERT INTO producto (nombre, precio) VALUES
('Libro A', 250.00),
('Libro B', 300.00),
('Libro C', 150.00),
('Laptop', 25000.00),
('Mouse', 500.00);

INSERT INTO pedido (cliente_id, fecha) VALUES
(1, '2026-10-05'),
(2, '2026-10-06'),
(3, '2026-10-07'),
(4, '2026-10-08'),
(5, '2026-10-09');

INSERT INTO detalle_pedido (pedido_id, producto_id, cantidad)
VALUES 
(1, 1, 2),
(1, 2, 1),
(2, 3, 3),
(3, 4, 1),
(4, 5, 2),
(5, 2, 1)
ON CONFLICT (pedido_id, producto_id)
DO UPDATE SET cantidad = detalle_pedido.cantidad + EXCLUDED.cantidad;

SELECT nombre, salario FROM empleado WHERE salario >= 15000;
SELECT nombre, puesto, salario FROM empleado WHERE salario BETWEEN 15000 AND 25000;
SELECT nombre, puesto, salario FROM empleado WHERE puesto = 'Analista' OR puesto = 'Desarrolladora';

SELECT nombre, salario FROM empleado ORDER BY salario DESC LIMIT 3;

SELECT AVG(salario) AS promedio FROM empleado;

SELECT puesto, SUM(salario) AS total_salario
FROM empleado
GROUP BY puesto
HAVING SUM(salario) > 20000;

UPDATE empleado SET salario = salario * 1.05 WHERE puesto = 'Analista';
DELETE FROM empleado WHERE id = 3;

-- Pedidos con nombre del cliente y fecha
SELECT p.id AS pedido_id, c.nombre AS cliente, p.fecha
FROM pedido p
INNER JOIN cliente c ON p.cliente_id = c.id;

-- Clientes sin pedidos
SELECT c.id, c.nombre
FROM cliente c
LEFT JOIN pedido p ON c.id = p.cliente_id
WHERE p.id IS NULL;

-- Total de productos por pedido
SELECT p.id AS pedido_id, c.nombre AS cliente,
       SUM(dp.cantidad) AS total_productos
FROM pedido p
INNER JOIN cliente c ON p.cliente_id = c.id
INNER JOIN detalle_pedido dp ON p.id = dp.pedido_id
GROUP BY p.id, c.nombre
HAVING SUM(dp.cantidad) > 2;

ALTER TABLE empleado ADD COLUMN IF NOT EXISTS depto_id INT REFERENCES departamento(id);

SELECT * FROM empleado;

UPDATE empleado SET depto_id = 1 WHERE nombre = 'Ana Torres';
UPDATE empleado SET depto_id = 2 WHERE nombre = 'Luis Gómez';
UPDATE empleado SET depto_id = 3 WHERE nombre = 'Marta Ruiz';
UPDATE empleado SET depto_id = 4 WHERE nombre = 'Carlos Pérez';
UPDATE empleado SET depto_id = 1 WHERE nombre = 'Diana López';

-- INNER JOIN
SELECT e.nombre, d.nombre AS departamento
FROM empleado e
INNER JOIN departamento d ON e.depto_id = d.id;

-- LEFT JOIN
INSERT INTO departamento (nombre) VALUES ('Marketing');
SELECT d.nombre AS departamento, e.nombre AS empleado
FROM departamento d
LEFT JOIN empleado e ON d.id = e.depto_id;

-- RIGHT JOIN
SELECT e.nombre, d.nombre AS departamento
FROM empleado e
RIGHT JOIN departamento d ON e.depto_id = d.id;

-- FULL JOIN
SELECT e.nombre, d.nombre AS departamento
FROM empleado e
FULL JOIN departamento d ON e.depto_id = d.id;

-- Subconsulta: empleados con salario mayor al promedio
SELECT nombre, salario
FROM empleado
WHERE salario > (SELECT AVG(salario) FROM empleado);

-- Vista
CREATE OR REPLACE VIEW vista_empleados AS
SELECT e.nombre, d.nombre AS departamento
FROM empleado e
INNER JOIN departamento d ON e.depto_id = d.id;

SELECT * FROM vista_empleados;

SELECT nombre FROM empleado
UNION
SELECT nombre FROM cliente;

SELECT nombre FROM empleado
INTERSECT
SELECT nombre FROM cliente;

SELECT nombre FROM empleado
EXCEPT
SELECT nombre FROM cliente;