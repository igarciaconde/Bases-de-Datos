LOAD DATA
INFILE 'descuentos.txt'
APPEND
INTO TABLE descuentos
FIELDS TERMINATED BY ';'
(
	codigo,
	fecha_caducidad,
	"porcentaje descuento"
	
)