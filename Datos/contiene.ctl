 LOAD DATA
INFILE 'contiene.txt'
APPEND
INTO TABLE Contiene
FIELDS TERMINATED BY ';'
(
	restaurante,
	plato,
	pedido,
	precioConComision,
	unidades
	
)