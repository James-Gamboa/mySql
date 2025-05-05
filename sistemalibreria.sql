create database sistema_libreria;
use sistema_libreria;

create table categorias (
  id_categoria int auto_increment primary key,
  nombre_categoria varchar(100) not null
);

create table clientes (
  id_cliente int auto_increment primary key,
  nombre_cliente varchar(100) not null,
  correo varchar(250) not null,
  telefono varchar(20)
);

create table libros (
  id_libro int auto_increment primary key,
  titulo varchar(250) not null,
  id_categoria int not null,
  anios int not null,
  editorial varchar(250),
  precio int,
  cantidad int,
  foreign key (id_categoria) references categorias(id_categoria)
);

create table autores (
  id_autor int auto_increment primary key,
  nombre_autor varchar(100) not null,
  id_libro int not null,
  foreign key (id_libro) references libros(id_libro)
);

select * from autores;

create table ventas (
  id_venta int auto_increment primary key,
  id_cliente int not null,
  id_libro int not null,
  fecha_de_compra date not null,
  foreign key (id_cliente) references clientes(id_cliente),
  foreign key (id_libro) references libros(id_libro)
);

create table log_table (
  id_log int auto_increment primary key,
  evento varchar(255),
  id_afectado int,
  fecha_evento datetime
);


  select * from autores;
  
  /*Parte 4: Consultas SQL con Múltiples Tablas
1. Realice consultas para obtener la siguiente información:
o Lista de libros vendidos en el último mes, junto con la categoría y el autor.
o Clientes que han comprado más de 3 libros, con detalles de sus compras.
o Autores que han publicado libros en más de una categoría. */

-- Lista de libros vendidos en el último mes, junto con la categoría y el autor.
select libros.titulo, categorias.nombre_categoria, autores.nombre_autor, ventas.fecha_de_compra
from ventas
join libros on ventas.id_libro = libros.id_libro
join categorias on libros.id_categoria = categorias.id_categoria
join autores on libros.id_libro = autores.id_libro
where ventas.fecha_de_compra between "2025-04-01" and "2025-04-30";

-- Clientes que han comprado más de 3 libros, con detalles de sus compras.
select clientes.nombre_cliente,
count(ventas.id_libro) as cantidad_de_libros_vendidos
from ventas
join clientes on ventas.id_cliente = clientes.id_cliente
group by clientes.id_cliente
having cantidad_de_libros_vendidos > 3;

-- Autores que han publicado libros en más de una categoría.
select autores.nombre_autor
from autores
join libros on autores.id_libro = libros.id_libro
group by autores.nombre_autor
having count(distinct libros.id_categoria) > 1;

/*Parte 5: Comandos para Crear, Modificar y Borrar Tablas
1. Cree una nueva tabla para almacenar reseñas de libros.
2. Modifique la tabla de clientes para añadir un campo "fecha de registro".
3. Elimine una tabla que ya no sea relevante.
Criterios de evaluación:
 Aplicación correcta de los comandos CREATE, ALTER y DROP TABLE. */

create table resenas_libros (
  id_resena_libro int auto_increment primary key,
  id_cliente int not null,
  id_libro int not null,
  id_categoria int not null,
  comentario varchar(250),
  fecha_resena date,
  foreign key (id_cliente) references clientes(id_cliente),
  foreign key (id_libro) references libros(id_libro),
  foreign key (id_categoria) references categorias(id_categoria)
);

alter table clientes add fecha_de_registro date;

create table libros_archivados (
  id_libro_archivado int auto_increment primary key,
  titulo varchar(250),
  motivo_archivo varchar(255),
  fecha_archivo date
);

drop table libros_archivados;

/*Parte 6: SQL para Crear, Consultar y Manipular Datos (1 hora)
1. Inserte datos ficticios en las tablas de libros, autores, clientes y ventas.
2. Realice actualizaciones para corregir errores en los datos insertados. */

insert into categorias (nombre_categoria) values
  ("novela"),
  ("ciencia"),
  ("historia"),
  ("fantasia"),
  ("terror"),
  ("romance"),
  ("autoayuda");

insert into clientes (nombre_cliente, correo, telefono) values
  ("Malenia","Malenia@gmail.com","50688881234"),
  ("Kratos","kratos@gmail.com","50685551234"),
  ("Big Boss","BigBoss@gmail.com","50684441234"),
  ("Geralt de Rivia", "geralt@witcher.com", "50689991234"),
  ("Lara Croft", "lara@gmail.com", "50687771234");

insert into libros (titulo, id_categoria, anios, editorial, precio, cantidad) values
  ("el principito", 1, 1943, "santillana", 9000, 10),
  ("breve historia del tiempo", 2, 1988, "bantam", 8500, 5),
  ("la odisea", 3, 1983, "alba", 5000, 12),
  ("el señor de los anillos", 4, 1954, "minotauro", 18000, 3),
  ("dracula", 5, 1897, "penguin", 7500, 4),
  ("orgullo y prejuicio", 6, 1813, "penguin classics", 8200, 7),
  ("el troll", 2, 2015, "rubius editorial", 6900, 6),
  ("nuevo libro de aventura", 3, 2020, "aventuras editoriales", 9500, 8),
  ("nuevo libro de ciencia ficción", 2, 2021, "ciencia y ficción", 12000, 6);

insert into autores (nombre_autor, id_libro) values
  ("antoine de saint", 1),
  ("stephen hawking", 2),
  ("homero", 3),
  ("j.r.r. tolkien", 4),
  ("bram stoker", 5),
  ("jane austen", 6),
  ("j.r.r. tolkien", 7),
  ("j.r.r. tolkien", 8),
  ("stephen hawking", 9);

insert into ventas (id_cliente, id_libro, fecha_de_compra) values
  (1, 1, "2025-04-15"),
  (2, 4, "2025-04-20"),
  (3, 2, "2025-04-22"),
  (4, 5, "2025-04-23"),
  (5, 6, "2025-04-24"),
  (1, 7, "2025-04-25"),
  (1, 2, "2025-04-17"),
  (1, 3, "2025-04-18"),
  (1, 4, "2025-04-19");

insert into resenas_libros (id_cliente, id_libro, id_categoria, comentario) values
  (1, 1, 1, "una lectura encantadora, muy recomendable para todas las edades."),
  (2, 4, 4, "una épica fantástica que atrapa de principio a fin."),
  (3, 2, 2, "excelente introducción a la cosmología."),
  (4, 5, 5, "terror clásico que aún hoy da escalofríos."),
  (5, 6, 6, "romántico, pero con personajes muy bien construidos."),
  (1, 7, 2, "el troll mezcla humor y ciencia de forma curiosa.");

  
update libros 
set anios = 800 
where titulo = "la odisea";

update autores
set nombre_autor = "Antoine de Saint-Exupéry"
where nombre_autor = "antoine de saint";

update libros
set editorial = "gredos"
where titulo = "la odisea";

update libros
set titulo = "El Principito"
where titulo = "el principito";

update clientes
set correo = lower(correo)
where nombre_cliente = "Malenia";

update libros
set cantidad = cantidad + 5
where titulo = "el señor de los anillos";

update libros
set anios = -800
where titulo = "la odisea";

update libros
set editorial = "Planeta"
where titulo = "el troll";

update autores
set nombre_autor = "El Rubius"
where id_libro = (select id_libro from libros where titulo = "el troll");

delete from resenas_libros
 where id_cliente = 1;

delete from ventas 
where id_libro = (select id_libro from libros where titulo = "la odisea");

delete from autores 
where nombre_autor = "antoine de saint-exupéry";

delete from libros
 where titulo = "el principito";

/*Parte 7: Vistas
1. Cree una vista que muestre los libros más vendidos junto con el nombre del autor y la
categoría.
2. Cree una vista que resuma las ventas mensuales de cada cliente.
Criterios de evaluación:
 Corrección en la creación y uso de vistas.*/

-- 1. Cree una vista que muestre los libros más vendidos junto con el nombre del autor y la categoría.

create view vista_libros_mas_vendidos as
select libros.id_libro, libros.titulo, autores.nombre_autor, categorias.nombre_categoria, count(ventas.id_libro) as total_ventas
from ventas
join libros on ventas.id_libro = libros.id_libro
join autores on libros.id_libro = autores.id_libro
join categorias on libros.id_categoria = categorias.id_categoria
group by libros.id_libro, libros.titulo, autores.nombre_autor, categorias.nombre_categoria
order by total_ventas desc;


select * from vista_libros_mas_vendidos;

-- 2. Cree una vista que resuma las ventas mensuales de cada cliente.

create view vista_ventas_mensuales_cliente as
select clientes.nombre_cliente, month(ventas.fecha_de_compra) as mes, count(*) as total_compras
from ventas
join clientes on ventas.id_cliente = clientes.id_cliente
group by clientes.id_cliente, month(ventas.fecha_de_compra);

select * from  vista_libros_mas_vendidos;

/*Parte 8: Procedimientos Almacenados
1. Cree un procedimiento almacenado que permita registrar una nueva venta, actualizando
el inventario y la información del cliente.
2. Cree un procedimiento que calcule y devuelva el total de ventas de un autor específico.
Criterios de evaluación:
 Uso adecuado de parámetros y estructuras de control en procedimientos almacenados. */

-- 1. Cree un procedimiento almacenado que permita registrar una nueva venta, actualizando el inventario y la información del cliente.

DELIMITER $$

create procedure registrar_venta_completa (
  in cliente_id int,
  in libro_id int,
  in fecha_de_compra date
)
begin
  insert into ventas (id_cliente, id_libro, fecha_de_compra) values (cliente_id, libro_id, fecha_de_compra);
  update libros set cantidad = cantidad - 1 where id_libro = libro_id;
end $$

DELIMITER ;


insert into clientes (id_cliente, nombre_cliente) values ("juan perez");
insert into libros (id_libro, titulo, cantidad) values (101, "el principito", 10);

call registrar_venta_completa(1, 101, now());

-- 2. Cree un procedimiento que calcule y devuelva el total de ventas de un autor específico.

DELIMITER $$

create procedure ventas_totales_por_autor (
  in autor_nombre_completo varchar(100)
)
begin
  select sum(ventas_totales.cantidad) as total_ventas from (
    select count(*) as cantidad
    from ventas ventas_totales
    join autores autores_completos on ventas_totales.id_libro = autores_completos.id_libro 
    where autores_completos.nombre_autor = autor_nombre_completo
    group by ventas_totales.id_venta
  ) ventas_totales;
end $$

DELIMITER ;

insert into autores (id_libro, nombre_autor) values (101, "antoine de saint-exupéry");
insert into ventas (id_venta, id_cliente, id_libro, fecha_de_compra) values (201, 1, 101, now());

call ventas_totales_por_autor("antoine de saint-exupéry");

/* Parte 9: Triggers
1. Cree un trigger que automáticamente actualice el stock de libros cuando se realice una
venta.
2. Cree un trigger que registre en una tabla llamada log_table cada vez que se borre un
cliente. */

-- 1. Cree un trigger que automáticamente actualice el stock de libros cuando se realice una venta.

DELIMITER $$
create trigger actualizar_stock_libros_al_vender after insert on ventas
for each row
begin
  update libros set cantidad = cantidad - 1 where id_libro = new.id_libro;
end $$

DELIMITER ;

select cantidad from libros where id_libro = 101;

insert into ventas (id_cliente, id_libro, fecha_de_compra) values (1, 101, now());

select cantidad from libros where id_libro = 101;

-- 2.  Cree un trigger que registre en una tabla llamada log_table cada vez que se borre un cliente.

DELIMITER $$

create trigger borrado_cliente after delete on clientes
for each row
begin
  insert into log_table (evento, id_afectado, fecha_evento)
  values ("borrado de cliente", old.id_cliente, current_timestamp);
end $$

DELIMITER ;

insert into clientes (id_cliente, nombre) values (11, "Roman");

delete from clientes where id_cliente = 11;


select * from log_table;

/*Parte 9: Análisis de la base de datos
Como parte de su proceso de aprendizaje, analice la base de datos creada y desarrolle vistas,
procedimientos almacenados y triggers que considere útiles para facilitar la gestión futura por
parte de los administradores de bases de datos.
Nota: No hay limite ni mínimo en la cantidad de mejoras a realizar*/

-- Una vista para mostrar los clientes y la cantidad de libros que han comprado

create view clientes_libros_comprados as
select 
    clientes.nombre_cliente,
    count(ventas.id_libro) as cantidad_libros_comprados,
    group_concat(libros.titulo separator ", ") as libros_comprados
from 
    clientes
join ventas on clientes.id_cliente = ventas.id_cliente
join libros on ventas.id_libro = libros.id_libro
group by 
    clientes.id_cliente;
    
select * from clientes_libros_comprados;

-- una vista que muestra los libro que pronto se le acabara el stock

create view libros_bajo_stock as
select 
    libros.titulo, 
    libros.cantidad
from 
    libros
where 
    libros.cantidad <= 3;

select * from libros_bajo_stock;

-- procedimiento almacenado devuelve todos los libros disponibles en una categoría específica

DELIMITER $$

create procedure obtener_libros_por_categoria(in categoria_id int)
begin
    select 
        libros.titulo, 
        libros.anios, 
        libros.editorial, 
        libros.precio, 
        libros.cantidad
    from 
        libros
    where 
        libros.id_categoria = categoria_id;
end $$

DELIMITER ;

  call obtener_libros_por_categoria(2);

--  procedimiento almacenado agrega por cada vennta de un libro un registro 

DELIMITER $$

create procedure agregar_venta(in cliente_id int, in libro_id int, in fecha_compra date)
begin
    insert into ventas (id_cliente, id_libro, fecha_de_compra)
    values (cliente_id, libro_id, fecha_compra);    
    update libros
    set cantidad = cantidad - 1
    where id_libro = libro_id;
end $$

DELIMITER ;

call agregar_venta(1, 2, "2025-04-27");

-- procedimiento que haria que los adminstradores se les haga facil actualizar el precio de los libros solo ocupan poner el id del libro

DELIMITER $$

create procedure actualizar_precio_libro(in libro_id int, in nuevo_precio int)
begin
    update libros
    set precio = nuevo_precio
    where id_libro = libro_id;
end $$

DELIMITER ;

call actualizar_precio_libro(1, 9500);

-- y este trigger haria por cada venta de libro se actualize el stock de libros disponible

DELIMITER $$

create trigger disminuir_cantidad_libro
after insert on ventas
for each row
begin
    update libros
    set cantidad = cantidad - 1
    where id_libro = new.id_libro;
end $$

DELIMITER ;

insert into ventas (id_cliente, id_libro, fecha_de_compra)
values (2, 4, "2025-05-02");

-- este trigger haria que se evite una venta cuando no hay stock de ese libro que compraria el usuario 

DELIMITER $$

create trigger prevenir_venta_sin_stock
before insert on ventas
for each row
begin
    declare cantidad_stock int;

    select cantidad into cantidad_stock
    from libros
    where id_libro = new.id_libro;

    if cantidad_stock <= 0 then
        signal sqlstate "45000"
        set message_text = "no hay suficiente stock para realizar la venta";
    end if;
end $$

DELIMITER ;

insert into ventas (id_cliente, id_libro, fecha_de_compra)
values (3, 5, "2025-05-02");

