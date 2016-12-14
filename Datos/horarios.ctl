 LOAD DATA
INFILE 'horarios.txt'
APPEND
INTO TABLE Horarios
FIELDS TERMINATED BY ';'
(
	restaurante,
	diasemana,
	hora_apertura DATE "HH24:MI",
	hora_cierre DATE "HH24:MI"
)