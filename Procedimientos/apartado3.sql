create or replace procedure REVISA_PEDIDOS
IS

igual boolean := true;
rPedidos PEDIDOS%rowtype;
rContiene CONTIENE%rowtype;
vPrecioPedido number := 0;
vPrecio PLATOS.PRECIO%type;
vComision RESTAURANTES.COMISION%type;
vPrecioT CONTIENE.PRECIOCONCOMISION%type;

cursor cPedidos is
SELECT *
FROM
  PEDIDOS;

cursor cContiene is
SELECT *
FROM
  CONTIENE;

BEGIN

for rContiene in cContiene loop

SELECT PRECIO into vPrecio
FROM PLATOS
WHERE NOMBRE = rContiene.PLATO;

SELECT COMISION into vComision
FROM RESTAURANTES
WHERE CODIGO = rContiene.RESTAURANTE;

vPrecioT := vPrecio * vComision*0.01 + vPrecio;

if rContiene.PRECIOCONCOMISION != vPrecioT then
  igual := false;
  DBMS_OUTPUT.PUT_LINE('Datos modificados en el plato: '||rContiene.PLATO||rContiene.PEDIDO);

  UPDATE CONTIENE
  SET PRECIOCONCOMISION = vPrecio * vComision*0.01 + vPrecio
  WHERE CONTIENE.PLATO = rContiene.PLATO;
end if;

end loop;

for rPedidos in cPedidos loop

SELECT SUM(PRECIOCONCOMISION*UDS) into vPrecioPedido
FROM CONTIENE
WHERE PEDIDO = rPedidos.PEDIDO;

if vPrecioPedido != rPedidos.importeTotal then
  igual := false;
  DBMS_OUTPUT.PUT_LINE('Datos modificados en el pedido: '||rPedidos.PEDIDO||' Nuevo importe: '||vPrecioPedido);
  --Actualizamos en caso de que no haya consistencia
  UPDATE PEDIDOS
  SET importeTotal = vPrecioPedido
  WHERE PEDIDOS.CODIGO = rPedidos.CODIGO;
end if;
end loop;

if igual then
  DBMS_OUTPUT.PUT_LINE('Los datos son iguales');
end if;

END;
