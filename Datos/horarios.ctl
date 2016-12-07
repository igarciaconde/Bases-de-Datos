 LOAD DATA
INFILE 'horarios.txt'
APPEND
INTO TABLE Horarios
FIELDS TERMINATED BY ';'
(
	restaurante,
	diasemana,
	hora_apertura,
	hora_cierre
	
)