/* Ejercicios SQL - Funciones Agregadas
Ejercicio 1: ¿Cuántos clientes hay registrados?
Objetivo: Usa COUNT() para contar el total de clientes.
Ejercicio 2: ¿Cuál es el precio promedio de todos los productos?
Objetivo: Utiliza AVG() sobre el precio de los productos.
Ejercicio 3: ¿Cuál es el precio más alto y más bajo entre los productos?
Objetivo: Usa MAX() y MIN() sobre la columna precio.
Ejercicio 4: ¿Cuántos pedidos ha realizado cada cliente?
Objetivo: Usa COUNT() con GROUP BY para agrupar por cliente.
Ejercicio 5: ¿Cuántos productos diferentes se han pedido en total?
Objetivo: Cuenta cuántos productos distintos hay en la tabla detalle_pedido.
Ejercicio 6: ¿Cuántos productos se han vendido en total (suma de cantidades)?
Objetivo: Sumar las cantidades de productos vendidos usando SUM().
Ejercicio 7: Precio promedio de productos por categoría
Objetivo: Combina AVG() con GROUP BY.
Ejercicio 8: obtener clientes con un correo especifico
Objetivo Escribe una consulta */

create database tienda;

use tienda;

create table clientes (
  id_cliente int auto_increment primary key,
  nombre_cliente varchar(100),
  correo_cliente varchar(100)
);

create table productos (
  id_producto int auto_increment primary key,
  nombre_producto varchar(100),
  precio decimal(10, 2),
  categoria varchar(50)
);

create table pedidos (
  id_pedido int auto_increment primary key,
  id_cliente int,
  fecha_pedido date,
  foreign key (id_cliente) references clientes(id_cliente)
);

create table detalle_pedido (
  id_detalle int auto_increment primary key,
  id_pedido int,
  id_producto int,
  cantidad int,
  foreign key (id_pedido) references pedidos(id_pedido),
  foreign key (id_producto) references productos(id_producto)
);

insert into clientes (nombre_cliente, correo_cliente) values
("goku", "goku@gmail.com"),
("vegeta", "vegeta@yahoo.com"),
("gohan", "gohan@gmail.com"),
("bulma", "bulma@hotmail.com");

insert into productos (nombre_producto, precio, categoria) values
("camisa", 19.99, "ropa"),
("pantalon", 39.99, "ropa"),
("zapatos", 49.99, "calzado"),
("bolso", 29.99, "accesorios");

insert into pedidos (id_cliente, fecha_pedido) values
(1, "2025-04-01"),
(2, "2025-04-03"),
(3, "2025-04-05"),
(4, "2025-04-07");

insert into detalle_pedido (id_pedido, id_producto, cantidad) values
(1, 1, 2),
(1, 2, 1),
(2, 3, 1),
(3, 4, 3),
(4, 2, 2),
(4, 3, 1);

select * from clientes;

select count(*) from clientes;

select avg(precio) from productos;

select max(precio) as precio_mas_alto, min(precio) as precio_mas_bajo from productos;

select id_cliente, Count(*) as total_pedidos
From pedidos
Group BY id_cliente;