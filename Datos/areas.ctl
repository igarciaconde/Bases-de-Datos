LOAD DATA
INFILE 'areas.txt'
APPEND
INTO TABLE Areas
FIELDS TERMINATED BY ';'
(
	restaurante,
	codigoPostal,
	)