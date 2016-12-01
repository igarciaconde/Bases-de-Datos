 LOAD DATA
INFILE 'horarios.txt'
APPEND
INTO TABLE horarios
FIELDS TERMINATED BY ';'
(
	restaurante,
	diasemana,
	hora_apertura,
	hora_cierre
	
)