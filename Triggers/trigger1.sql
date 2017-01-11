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
    "importe total"="importe total" - (:OLD.precioconcomision * :OLD.unidades)
  WHERE
    codigo = :OLD.pedido;
ELSIF INSERTING THEN
  UPDATE
    pedidos
  SET
    "importe total"="importe total" + (:NEW.precioconcomision * :NEW.unidades)
  WHERE
    codigo = :NEW.pedido;
ELSE
  UPDATE
    pedidos
  SET
    "importe total"="importe total" - (:OLD.precioconcomision * :OLD.unidades) + (:NEW.precioconcomision * :NEW.unidades)
  WHERE
    codigo = :NEW.pedido;
END IF;
END; 
