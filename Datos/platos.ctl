LOAD DATA
INFILE 'platos.txt'
APPEND
INTO TABLE platos
FIELDS TERMINATED BY ';'
(
	restaurante,
	nombre,
	precio,
	descripcion,
	categoria
	
)