LOAD DATA
INFILE 'areas.txt'
APPEND
INTO TABLE Areascobertura
FIELDS TERMINATED BY ';'
(
	restaurante,
	codigoPostal
	)