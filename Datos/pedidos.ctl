LOAD DATA
INFILE 'pedidos.txt'
APPEND
INTO TABLE Pedidos
FIELDS TERMINATED BY ';'
TRAILING NULLCOLS
(
	codigo "Seq_CodPedidos.nextval",
	estado,
	fecha_hora_pedido DATE "DD.MM.YYYY HH24:MI:SS",
	fecha_hora_entrega DATE "DD.MM.YYYY HH24:MI:SS",
	"importe total",
	cliente,
	codigoDescuento
)