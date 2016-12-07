LOAD DATA
INFILE 'descuentos.txt'
APPEND
INTO TABLE Descuentos
FIELDS TERMINATED BY ';'
(
	codigo,
	fecha_caducidad,
	"porcentaje descuento"
	
)