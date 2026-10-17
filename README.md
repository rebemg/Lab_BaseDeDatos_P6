# Práctica 6
Reebeca Moreno González

**Objetivo**

Escribir consultas complejas que combinen múltiples tablas mediante diferentes tipos de joins, utilizar subconsultas, operadores de conjunto y comprender la utilidad de las vistas.

**Decisiones**

Para la actividad guiada:

- Decidí usar INNER JOIN entre empleado y departamento para mostrar únicamente los empleados que tienen un departamento asignado.

  **Justificación:** Se buscaba evidenciar la relación directa entre ambas tablas y obtener solo coincidencias reales.

- Apliqué LEFT JOIN entre departamento y empleado para mostrar todos los departamentos, incluso los que no tienen empleados.

  **Justificación:** Esto permite identificar departamentos vacíos y comprobar la integridad de la relación.

- Usé RIGHT JOIN para obtener todos los departamentos desde la perspectiva de empleados.

  **Justificación:** Se quería verificar que ningún departamento quedara fuera, aunque no tuviera empleados asociados.

- Usé FULL JOIN para mostrar todos los empleados y todos los departamentos, aunque no estén relacionados.

  **Justificación:** Se buscaba una visión completa del sistema, incluyendo registros sin correspondencia.

- Agregué una subconsulta con AVG(salario) para filtrar empleados con salario superior al promedio.

  **Justificación:** Esto permite comparar cada registro contra un valor agregado y obtener información más analítica.

- Creé la vista vista_empleados para simplificar consultas repetitivas.

  **Justificación:** Facilita la reutilización de consultas complejas y mejora la legibilidad del código.

Para el reto:

- Creé la vista ranking_clientes para mostrar los cinco clientes con mayor gasto.
- Inserté pedidos de distintos años y apliqué UNION para combinarlos en una sola lista.
- Apliqué INTERSECT entre empleado y cliente para mostrar nombres que aparecen en ambas tablas.
- Utilicé EXCEPT para mostrar empleados que no aparecen como clientes.

**Pruebas realizadas**

Para la actividad guiada:

- Ejecución de consultas de selección y filtrado (WHERE, BETWEEN, ORDER BY).
- Uso de funciones de agregación (AVG, SUM) para cálculos de promedios y totales.
- Creación de vistas (CREATE VIEW) y validación con SELECT *.
- Ejecución de operadores de conjunto (UNION, INTERSECT, EXCEPT) para comparar resultados entre tablas.

Para el reto:

- Inserción de productos tecnológicos y clientes ficticios.
- Creación de pedidos en distintos años (2025 y 2026).
- Ejecución de la vista ranking_clientes para calcular el gasto total por cliente.
- Uso de UNION para combinar pedidos de dos años distintos en una sola lista.

**Errores**

En la actividad guiada y en el reto no se presentó ningún error a la hora de ejecutar el script.

**Conclusión**

En esta práctica aprendí a manejar mejor las bases de datos con SQL, desde crear tablas y relacionarlas con claves primarias y foráneas, hasta realizar consultas con joins para entender cómo se conectan los datos entre sí. También practiqué funciones de agregación como AVG y SUM, y operadores de conjunto como UNION, INTERSECT y EXCEPT para comparar resultados entre tablas. Reforcé lo básico de inserciones, actualizaciones y eliminaciones, y en el reto pude aplicar vistas y ejemplos más reales, como identificar clientes con mayor gasto o combinar pedidos de distintos años.
