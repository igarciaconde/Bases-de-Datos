CREATE TABLE Restaurantes(
 codigo           NUMBER(8) NOT NULL
 , nombre         CHAR(20) NOT NULL
 , calle          CHAR(30) NOT NULL
 , "código postal" CHAR(5) NOT NULL
 , comision       NUMBER(8,2)
 , PRIMARY KEY(codigo)
);
drop table restaurantes;
delete from restaurantes;
delete from horarios;
delete from clientes;
delete from contiene;
delete from areascobertura;
delete from platos;
delete from pedidos;

CREATE TABLE clientes (
  DNI       char(9) primary key,
  nombre    VARCHAR(40) NOT NULL,
  apellido  VARCHAR(40) NOT NULL,
  calle     CHAR(20),
  numero    number(4) not null,
  piso      char(5),
  localidad CHAR(20),
  codigopostal char(5),
  telefono number(9),
  usuario   CHAR(8) NOT NULL unique,
  contraseña CHAR(8) default 'Nopass'
);
--probando alter
alter table clientes modify contraseña default 'Nopass';
alter table clientes modify usuario unique;
drop table clientes;

CREATE TABLE Pedidos(
 codigo           NUMBER(8) NOT NULL
 , estado         CHAR(9) DEFAULT 'REST' NOT NULL
 , fecha_hora_pedido DATE NOT NULL
 , fecha_hora_entrega DATE
 , "importe total" NUMBER(8,2)
 , cliente        CHAR(9) NOT NULL REFERENCES Clientes(DNI)
 , codigoDescuento Number(8) REFERENCES Descuentos(codigo) ON DELETE SET NULL
 , PRIMARY KEY(codigo)
 , CHECK (estado IN ('REST', 'CANCEL', 'RUTA', 'ENTREGADO', 'RECHAZADO'))
);
CREATE SEQUENCE Seq_CodPedidos INCREMENT BY 1 START WITH 1 NOMAXVALUE;
drop table pedidos;

create table horarios (
  restaurante     number(8),
  diasemana       char(1),
  hora_apertura   date not null,
  hora_cierre     date not null,
  primary key(restaurante,diasemana) ,
  foreign key (restaurante) references restaurantes (codigo),
  check (diasemana in('L','M','X','J','V','S','D'))
);
drop table horarios;
alter table horarios add constraint diaSemana check (diasemana in('L','M','X','J','V','S','D'));
create table platos (
restaurante number (8),
nombre      char(20) not null ,
precio      number(8, 2),
descripcion char (30),
categoria   char(10),
primary key(restaurante,nombre),
foreign key (restaurante) references restaurantes (codigo) on delete cascade
);
drop table platos;
CREATE INDEX I_CatPlatos ON Platos(categoria);

CREATE TABLE Descuentos (
 codigo NUMBER(8) NOT NULL
 , fecha_caducidad DATE
 , "porcentaje descuento" NUMBER(3)not null,
 CHECK ("porcentaje descuento" >0 AND "porcentaje descuento"<=100)
 , PRIMARY KEY(codigo)
 );
 drop table descuentos;
 
 create table areasCobertura (
  restaurante   number(8),
  codigoPostal  char (5),
  primary key(restaurante,codigoPostal),
  foreign key (restaurante) references restaurantes (codigo)
  );
  drop table areasCobertura;
 
 CREATE TABLE Contiene (
 restaurante        NUMBER(8)
 , plato            CHAR(20)
 , pedido           NUMBER(8) REFERENCES Pedidos(codigo) ON DELETE CASCADE
 , precioConComisión NUMBER(8,2)
 , unidades         NUMBER(4)NOT NULL
 , PRIMARY KEY(restaurante, plato, pedido)
 , FOREIGN KEY(restaurante, plato) REFERENCES Platos(restaurante,nombre)
 
);
drop table contiene;

