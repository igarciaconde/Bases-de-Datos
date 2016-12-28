create or replace PROCEDURE PEDIDOS_CLIENTE(dni_cliente char)
IS

cursor cPedido is
  select *
  from
    PEDIDOS
  where
    cliente = dni_cliente
  order by
    FECHA_PEDIDO ;

  vDNI CLIENTES.DNI%TYPE;
  vNombre CLIENTES.nombre%TYPE;
  vApellido CLIENTES.apellido%TYPE;
  vTotal number := 0;
  rPedidos PEDIDOS%ROWTYPE;

  NO_PEDIDOS EXCEPTION;
BEGIN

  SELECT
    DNI,
    NOMBRE,
    APELLIDO
  INTO
    vDNI,
    vNombre,
    vApellido
  FROM
    CLIENTES
  WHERE
    DNI = dni_cliente;

  DBMS_OUTPUT.PUT_LINE('  Cliente: '||vDNI||' '||vNombre||' '||vApellido);

  open cPedido;

  LOOP
  FETCH
    cPedido
  into
    rPedidos;
  EXIT WHEN cPedido%NOTFOUND;

DBMS_OUTPUT.PUT_LINE('  Pedido: '||rPedidos.CODIGO||' Fecha del pedido: '||rPedidos.FECHA_HORA_PEDIDO||' Fecha de entrega: '||rPedidos.FECHA_HORA_ENTREGA||' Estado: '||rPedidos.ESTADO||' Importe: '||rPedidos.importeTotal);
vTotal := vTotal + rPedidos.importeTotal;

END LOOP;

IF cPedido%ROWCOUNT = 0 then raise NO_PEDIDOS;
END IF;

CLOSE cPedido;

DBMS_OUTPUT.PUT_LINE('  Total importe del cliente: '||vTotal);

EXCEPTION

WHEN NO_DATA_FOUND THEN
DBMS_OUTPUT.PUT_LINE('No existen clientes con DNI: '||dni_cliente);

WHEN NO_PEDIDOS THEN
DBMS_OUTPUT.PUT_LINE('No existen pedidos para cliente con DNI: '||dni_cliente);


END;
