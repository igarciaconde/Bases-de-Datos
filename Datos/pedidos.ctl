LOAD DATA
INFILE 'pedidos.txt'
APPEND
INTO TABLE Pedidos
FIELDS TERMINATED BY ';'
(
	codigo,
	estado,
	fecha_hora_pedido,
	fecha_hora_entrega,
	"importe total",
	cliente,
	codigoDescuento
)