LOAD DATA
INFILE 'areas.txt'
APPEND
INTO TABLE areas
FIELDS TERMINATED BY ';'
(
	restaurante,
	codigoPostal,
	