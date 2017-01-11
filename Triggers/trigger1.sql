CREATE OR REPLACE TRIGGER
  control_detalle_pedidos
BEFORE
  INSERT OR
  DELETE OR
  UPDATE
ON
  contiene
FOR EACH ROW
BEGIN
IF DELETING THEN
  UPDATE
    pedidos
  SET
  commit;
    "importe total"="importe total" - :OLD.precioconcomision
  WHERE
    codigo = :OLD.pedido;
ELSIF INSERTING THEN
  UPDATE
    pedidos
  SET
    "importe total"="importe total" + :NEW.precioconcomision
  WHERE
    codigo = :NEW.pedido;
ELSE
  UPDATE
    pedidos
  SET
    "importe total"="importe total" - :OLD.precioconcomision + :NEW.precioconcomision
  WHERE
    codigo = :NEW.pedido;
END IF;
END; 
