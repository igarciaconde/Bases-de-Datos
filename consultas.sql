--Consultas
--Listado con todos los datos de los clientes, ordenados por apellidos
SELECT *
FROM clientes
ODRER BY apellido ASC;

--Horarios de cada uno de los restaurantes. Para cada restaurante aparecerá su
--nombre y el día de la semana (sustituyendo la letra por el nombre completo
--del día) y la hora de apertura y de cierre, en formato HH:MM
SELECT
  nombre,
  CASE diaSemana
    WHEN 'L' THEN 'Lunes'
    WHEN 'M' THEN 'Martes'
    WHEN 'X' THEN 'Miércoles'
    WHEN 'J' THEN 'Jueves'
    WHEN 'V' THEN 'Viernes'
    WHEN 'S' THEN 'Sábado'
    WHEN 'D' THEN 'Domingo'
    ELSE diaSemana,
  CONVERT(VARCHAR(5),hora_apertura,108), --convertir hora_apertura(date) to hora_apertura(HH:MM) | comprobar que esto funciona
  CONVERT(VARCHAR(5),hora_cierre,108)
FROM Restaurantes, Horarios
WHERE codigo=restaurante;

--Qué clientes (DNI, nombre y apellidos) han pedido alguna vez platos de la categoría “picante”?
SELECT DISTINCT
  DNI,
  nombre,
  apellido
FROM clientes a, pedidos b, contiene c, platos d
WHERE a.DNI=b.cliente
AND b.codigo=c.pedido
AND c.plato=d.nombre
AND d.categoria='picante';

--Mostrar el código de pedido de los pedidos con un importe total mayor de 100 euros junto con el
--nombre y teléfono del cliente
SELECT
codigo,
nombre,
telefono
FROM pedidos, clientes
WHERE DNI=cliente
AND importeTotal > 100 ;


--Mostrar los clientes que no han realizado ningún pedido
SELECT
nombre
FROM clientes t
WHERE NOT EXISTS (SELECT * 
                  FROM pedidos
                  WHERE t.DNI = cliente
                  ); 

--Mostrar el DNI los clientes que comparten teléfono
SELECT
  a.DNI,
  b.DNI
FROM clientes a, clientes b
WHERE a.telefono=b.telefono
AND a.DNI<>b.DNI ;

--¿Qué clientes (DNI, nombre y apellidos) han pedido platos en todos los restaurantes?
CREATE VIEW restauCientes (restaurant, client)
            AS SELECT restaurante,cliente 
            FROM restaurantes, clientes, pedidos
            WHERE DNI=cliente;




--¿Qué clientes (DNI, nombre y apellidos) no han recibido aún sus pedidos?
SELECT
DNI,
nombre,
apellido
FROM clientes, pedidos
WHERE DNI=cliente
AND estado<>'ENTREGADO';


--Muestra todos los datos (salvo los platos que lo componen) del pedido (o pedidos) de mayor importe
--total. Considera que puede haber varios pedidos con el mismo importe.
SELECT 
t.codigo,
t.estado,
t.fecha_hora_pedido,
t.fecha_hora_entrega,
t.importeTotal,
t.cliente,
t.codigoDescuento,
z.precioConComision,
z.unidades
FROM clientes z, pedidos t
WHERE t.importeTotal = ( SELECT 
                       MAX(importeTotal)
                       FROM pedidos
                       );


--Obtén el valor medio de los pedidos de cada cliente, mostrando su DNI, nombre y apellidos.
SELECT 
DNI,
nombre,
apellido,
AVG(importeTotal) AS mediaPedidos
FROM clientes, pedidos
WHERE DNI=cliente;


--Muestra para cada restaurante (código y nombre) el número total de platos vendidos y el precio
--acumulado que obtuvieron.
SELECT 
a.nombre,
a.codigo,
SUM(b.importeTotal) AS precioAcumulado,
COUNT(ALL b.codigo) AS numeroPedidos,
FROM restaurantes a, pedidos b
WHERE a.codigo=b.codigo;

--Nombre y apellidos de aquellos clientes que pidieron platos de más de 15 €
SELECT
nombre,
apellido
FROM clientes, pedidos, contiene , platos t
WHERE DNI=cliente
AND codigo = pedido 
AND t.restaurante = restaurante
AND t.precio > 15; --- comprobar, igual con subconsultas es mejor


--Para cada cliente (mostrar DNI, nombre y apellidos) mostrar el número de restaurantes que cubren el
--área en el que vive el cliente. Si algún cliente no está cubierto por ninguno, debe aparecer 0

SELECT
a.DNI,
a.nombre,
a.apellido
b.restaurante
FROM clientes a , restaurantes b
WHERE a.codigoPostal=b.codigoPostal
UNION
SELECT 
c.DNI
c.nombre
c.apellido
0 AS d.restaurante
FROM cliente c, restaurantes d
WHERE NOT EXISTS(SELECT *
                 FROM Restaurantes z, clientes t
                 WHERE z.codigoPostal = t.codigoPostal);