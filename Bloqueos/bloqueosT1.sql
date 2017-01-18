--terminal user 1
-- 1.BLOQUEOS(UPDATE VS SELECT)
--Ponemos el autocommit a 'off' para poder trabajor con otro compañero y ver los problemas.

set autocommit off;


--Creamos tabla cuentas.

CREATE TABLE cuentas (
 numero number primary key,
 saldo number not null
 ); 

--Hacemos un commit (T2 observa los cambios tras realizar el commit).

commit;

--realizamos un update sin commit para observar que ocurre en T2.

update cuentas
set saldo=saldo+100
where numero=123;
commit;

-
-------------------------------------------------------------------------------------------------------------



-- 2. BLOQUEOS (UPDATE VS UPDATE)

-- Autocommit 'off' para trabajar los bloqueos.
set autocommit off;

--Actualizamos la tabla cuentas y el valor saldo de esta en '100' cuando numero es igual a '123'
update cuentas 
set saldo = saldo+100
where numero =123;


--Hasta que no hagamos commit no podra actualizar T2 ninguna fila de la base de datos.
commit;

--Una vez realizado el commit mi saldo se actualiza y T2 realiza su update sin poder yo observarlo.
select saldo
from cuentas
where numero=123;

--T2 realiza commit y yo puedo observar los cambios realizados por el.
select saldo
from cuentas
where numero=123;

--------------------------------------------------------------------------------------------------------------


-- 3. BLOQUEOS (DEADLOCK)

-- Autocommit 'off' para trabajar los bloqueos.
set autocommit off;

--No existen errores al actualizar la tabla.
UPDATE CUENTAS
SET SALDO =SALDO+100
WHERE NUMERO=123;

--SQl se queda esperando y me saca un erro de 'deadlock'.
--Al parecer t2 no ha hecho commit sobre la primera actualizacion y nos bloqueamos mutuamente
UPDATE CUENTAS
SET SALDO=SALDO+300
WHERE NUMERO =456;
--Al realizar los commit yo t1 actualizo la cuenta '123' pero no la '456'.
--Sin embargo cuando t2 hace commit se realizan sus dos updates de las cuentas '123' y '456'.

--------------------------------------------------------------------------------------------------------------


-- 3. BLOQUEOS(NIVELES DE AISLAMIENTO)


--Creamos un aislamiento de tipo 'serializable'
ALTER SESSION SET ISOLATION_LEVEL = SERIALIZABLE; 

SELECT SUM(saldo) FROM cuentas;

SELECT SUM(saldo) FROM cuentas;
--Tras los updates con commits de t2 no observo ningun cambio en los datos de la BD. 
--Este aislamiento me permite trabajar sin hacer reales los cambios de los demas usuarios en el momento.


--Cambiamos de nuevo el nivel de aislamiento y en esta ocasion si que prodemos observar 
--los cambios realizados por otros usuarios en el momento.
ALTER SESSION SET ISOLATION_LEVEL = READ COMMITTED;

SELECT SUM(saldo) FROM cuentas;

SELECT SUM(saldo) FROM cuentas;
