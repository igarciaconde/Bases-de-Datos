--terminal user 2


--1.BLOQUEOS UPDATE VS SELECT
--quitamos el autocommit de la sesion T2
SET AUTOCOMMIT OFF 

--Despues de que T1 cree y commitee la tabla cuentas insertamos unos datos
INSERT INTO cuentas VALUES (123, 400);
INSERT INTO cuentas VALUES (456, 300); 

--T1 incrementa en 100 la cuenta de 123
-- SIN commitear
select 
  * 
from 
  cuentas 
where 
  numero=123
;

-- la cuenta 123 tiene 400 de saldo

-- T2 commitea
select 
  * 
from 
  cuentas 
where 
  numero=123
;

-- la cuenta refleja los 500 que deberia

--2. BLOQUEOS UPDATE VS UPDATE

SET AUTOCOMMIT OFF 

--Hacemos el update tras otro update sin commitear
UPDATE 
  cuentas
set 
  saldo = saldo+200
where
  numero = 123;
  
--El SGBD se queda esperando a que se realice el commit de la otra sesión y seguidamente realiza la operación
--No será visible hasta commitear los cambios
commit;
--los cambios son visibles

--3.Bloqueos Deathlock

SET AUTOCOMMIT OFF 

--Actualizamos la cuenta de 456 
UPDATE 
  cuentas
set 
  saldo = saldo+200
where
  numero = 456;

--después de que t1 haga un cambio en la cuenta 123 sin confirmar, se crea un bloqueo
UPDATE 
  cuentas
set 
  saldo = saldo+400
where
  numero = 123;
  --Cuando T1 confirma sus cambios, la operaciòn termina y actualiza la cuenta.
  commit;
  --confirmamos los cambios para que la sesion de T1 vea los cambios

--4. NIVELES DE AISLAMIENTO
UPDATE 
  cuentas 
SET 
  saldo=saldo +100
; 

COMMIT; 

UPDATE 
  cuentas 
SET 
  saldo=saldo +100
; 

COMMIT; 