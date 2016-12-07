 LOAD DATA
INFILE 'clientes.txt'
APPEND
INTO TABLE Clientes
FIELDS TERMINATED BY ';'
(
	dni,
	nombre,
	apellido,
	calle,
	numero,
	piso,
	localidad,
	codigopostal,
	telefono,
	usuario,
	contraseña
	
)
