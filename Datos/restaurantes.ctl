LOAD DATA
INFILE 'restaurantes.txt'
APPEND
INTO TABLE Restaurantes
FIELDS TERMINATED BY ';'
(
	codigo,
	nombre,
	calle,
	"c�digo postal",
	comision
)