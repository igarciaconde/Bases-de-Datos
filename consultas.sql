--Consultas
--Listado con todos los datos de los clientes, ordenados por apellidos
SELECT *
FROM clientes
ODRER BY apellido ASC

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
WHERE codigo=restaurante

--Qué clientes (DNI, nombre y apellidos) han pedido alguna vez platos de la categoría “picante”?
SELECT DISTINCT
  DNI,
  nombre,
  apellido
FROM clientes a, pedidos b, contiene c, platos d
WHERE a.DNI=b.cliente
AND b.codigo=c.pedido
AND c.plato=d.nombre
AND d.categoria='picante'

--Mostrar el código de pedido de los pedidos con un importe total mayor de 100 euros junto con el
--nombre y teléfono del cliente


--Mostrar los clientes que no han realizado ningún pedido


--Mostrar el DNI los clientes que comparten teléfono
SELECT
  a.DNI,
  b.DNI
FROM clientes a, clientes b
WHERE a.telefono=b.telefono
AND a.DNI<>b.DNI

--¿Qué clientes (DNI, nombre y apellidos) han pedido platos en todos los restaurantes?


--¿Qué clientes (DNI, nombre y apellidos) no han recibido aún sus pedidos?


--Muestra todos los datos (salvo los platos que lo componen) del pedido (o pedidos) de mayor importe
--total. Considera que puede haber varios pedidos con el mismo importe.


--Obtén el valor medio de los pedidos de cada cliente, mostrando su DNI, nombre y apellidos.


--Muestra para cada restaurante (código y nombre) el número total de platos vendidos y el precio
--acumulado que obtuvieron.


--Nombre y apellidos de aquellos clientes que pidieron platos de más de 15 €


--Para cada cliente (mostrar DNI, nombre y apellidos) mostrar el número de restaurantes que cubren el
--área en el que vive el cliente. Si algún cliente no está cubierto por ninguno, debe aparecer 0
