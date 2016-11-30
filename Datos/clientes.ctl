 LOAD DATA
INFILE 'clientes.txt'
APPEND
INTO TABLE clientes
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
	"contraseña"
	
)
