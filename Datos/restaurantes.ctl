LOAD DATA
INFILE 'restaurantes.txt'
APPEND
INTO TABLE restaurantes
FIELDS TERMINATED BY ';'
(
	codigo,
	nombre,
	calle,
	"código postal",
	comision
)