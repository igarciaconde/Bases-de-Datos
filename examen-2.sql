
--JAVIER MARTIN VILLARREAL

-- Crear tablas

create table pedidos(
  codigo number(8) primary key,
  fecha_pedido date not null,
  fecha_entrega date,
  importeTotal number (8,2),
  cliente varchar(40) not null on delete cascade references clientes(DNI)
);

create table clientes(
  DNI char(9) primary key,
  nombre varchar(50) not null,
  apellido varchar(50) not null,
  codigoPostal varchar(5),
  telefono number(9)
);

create sequence seq_codigo increment by 1 start with 1 nomaxvalue;

-- Insertar datos
insert into clientes values(
  '00000000A',
  'Javier',
  'Martin',
  '88888',
  666666666
);

insert into pedidos values(
  seq_codigo.nextVal,
  to_date('25-12-16:11:20','DD-MM-YY:HH24:MI'),
  to_date('25-12-16:15:50','DD-MM-YY:HH24:MI'),
  225.55,
  '00000000A'
);


-- Consultas SQL
--a
select
  p.codigo,
  c.nombre,
  c.apellido,
  c.telefono
from
  pedidos p,
  clientes c
where
  c.DNI = p.cliente
  and
  p.importeTotal>100
order by
  p.importeTotal
;

--b
select distinct
  c1.DNI
from
  clientes c1,
  clientes c2
where
  c1.telefono = c2.telefono
  and
  c1.DNI <> c2.DNI
;

--c
select
  c.nombre,
  c.apellido
from
  clientes c
where
  c.DNI not in(
    select
      cliente
    from
      pedidos
  )
;

--e
select
  c.nombre,
  c.apellido,
  count(*)
from
  clientes c
order by
  c.nombre
  c.apellido
;

--f (probadas las 2 formas)
select
  c.nombre,
  c.apellido,
  avg(p."importe total") as media
from
  clientes c,
  pedidos p
where
  c.dni = p.cliente
group by (c.nombre, c.apellido)
having
  avg(p."importe total") > 10;

--f (misma consulta con left join de dos consultas)
SELECT
  t2.nombre,
  t2.apellido,
  t1.media
FROM(
  SELECT
    AVG(p1."importe total") as media,
    p1.cliente
  FROM
    pedidos p1,
    pedidos p2
  WHERE
    p1.cliente = p2.cliente
  Group BY (p1.cliente)
) t1
left JOIN
(
  SELECT
    c.DNI,
    c.Nombre,
    c.Apellido
  FROM
    clientes c
  ) t2
ON
  t1.cliente = t2.DNI;
