--Insertando datos
INSERT INTO Restaurantes VALUES (1234,'pizzahu','abascal 45','12345',2.0);
INSERT INTO AreasCobertura VALUES (1234,'12345');
INSERT INTO Horarios VALUES (1234,'X',to_date('12:00','HH24:MI'),to_date('23:00','HH24:MI'));
INSERT INTO Platos VALUES (1234,'pizza arrabiata',17.50,'pizza de carne y guindilla','picante');
INSERT INTO Clientes VALUES('12345678N','Pedro','Pérez','Torralba',29,'4B','Madrid','12345','12345612','pedro','pedro');
INSERT INTO Descuentos VALUES (1100,to_date('20-04-09', 'DD-MM-YY'),50);
INSERT INTO Pedidos VALUES (1,'REST',to_date('17-02-09:19:50','DD-MM-YY:HH24:MI'),to_date('17-02-09:20:50','DD-MM-YY:HH24:MI'),34.25, '12345678N',1100);
INSERT INTO Contiene VALUES (1234,'pizza arrabiata',1,NULL,2);


