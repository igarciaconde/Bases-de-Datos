 LOAD DATA
INFILE 'contiene.txt'
APPEND
INTO TABLE contiene
FIELDS TERMINATED BY ';'
(
	restaurante,
	plato,
	pedido,
	precioconcomision,
	unidades
	
)