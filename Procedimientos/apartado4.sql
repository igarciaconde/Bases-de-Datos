create or replace procedure DATOS_CLIENTES
IS

rClientes CLIENTES%rowtype;
vTotal number := 0;

cursor cClientes is
SELECT *
FROM
  CLIENTES;

BEGIN

for rClientes in cClientes loop

SELECT SUM(importeTotal) into vTotal
FROM PEDIDOS
WHERE DNI = rClientes.DNI;

if vTotal > 0 then
  DBMS_OUTPUT.PUT_LINE('Cliente: '||rClientes.DNI||' '||rClientes.NOMBRE||' Importe total de pedidos: '||vTotal);
else
  DBMS_OUTPUT.PUT_LINE('Cliente: '||rClientes.DNI||' '||rClientes.NOMBRE||' Importe total de pedidos: '||0);
end if;
end loop;
END;

exec DATOS_CLIENTES;
