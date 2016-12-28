create or replace procedure REVISA_PRECIO_CON_COMISION
IS

igual boolean := true;
rContiene CONTIENE%rowtype;
vPrecio PLATOS.PRECIO%type;
vComision RESTAURANTES.COMISION%type;
vPrecioT CONTIENE.PRECIOCONCOMISION%type;


--Cursor para contiene
cursor cContiene is
SELECT *
FROM
  CONTIENE;

BEGIN

for rContiene in cContiene loop

SELECT
  PRECIO into vPrecio
FROM
  PLATOS
WHERE
  NOMBRE = rContiene.PLATO;

SELECT
  COMISION into vComision
FROM
  RESTAURANTES
WHERE
  CODIGO = rContiene.RESTAURANTE;

vPrecioT := vPrecio * vComision*0.01 + vPrecio;

if rContiene.PRECIOCONCOMISION != vPrecioT then
  igual := false;
  DBMS_OUTPUT.PUT_LINE('Datos modificados en el plato: '||rContiene.PLATO||rContiene.PEDIDO);

  UPDATE
    CONTIENE
  SET
    PRECIOT = vPrecio * vComision*0.01 + vPrecio
  WHERE
    CONTIENE.PLATO = rContiene.PLATO;
end if;

end loop;

if igual then
  DBMS_OUTPUT.PUT_LINE('Los datos son iguales');
end if;

END;
