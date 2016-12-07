LOAD DATA
INFILE 'platos.txt'
APPEND
INTO TABLE Platos
FIELDS TERMINATED BY ';'
(
	restaurante,
	nombre,
	precio,
	descripcion,
	categoria
	
)