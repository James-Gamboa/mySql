/* 1. Crear y eliminar una base de datos
a) Crea una base de datos llamada 'ejemplo'.
b) Verifica que se ha creado listando las bases de datos.
c) Utiliza la base de datos 'ejemplo'.
d) Finalmente, elimina la base de datos.
e) Vuelve a crearla

2. Crear dos tablas
a) Crea una tabla llamada 'usuarios' con las siguientes columnas:
id (INT, auto-incremental, clave primaria)
nombre (VARCHAR(100), obligatorio)
correo (VARCHAR(100), único y obligatorio)
fecha_registro (DATE)
activo (BOOLEAN, por defecto TRUE)
contraseña (VARCHAR(30) obligatorio)
b) Crea una tabla productos con las siguientes columnas
nombre_producto (VARCHAR(100), obligatorio)
precio_producto( int)
stock_producto(int)

unico = unique
obligatorio = not null

3. Modificar la table Usuarios
a) Añade una columna llamada 'telefono' de tipo VARCHAR(20).
b) Cambia el tipo de la columna 'telefono' a INT

4. Insertar datos en las tablas
a) Inserta 5 registros en la tabla 'usuarios':
a) Inserta 5 registros en la tabla 'productos': (Registra un producto que tenga un stock de
40)

5. Eliminar datos
a) Elimina al usuario cuyo id sea 4
b) Elimina al usuario con id 3.
b) Elimina el producto con el stock mayor a 20 y menor a 50.

6. Actualizar datos
a) Actualiza un número de teléfono

7. Consultas
a) Selecciona todos los usuarios cuya edad sea mayor a 18.
b) Repite la consulta anterior, pero ordenando los resultados por edad descendente.

Nota: La columna 'edad' no fue creada en la tabla original. ¿Qué error crees que aparecerá?
¿Cómo lo solucionarías?
c) consulta solamente el nombre correo y fecha registro de la tabla de usuarios.
d) consulta los precios de la tabla de productos donde los cuales son mayores a 100

*/

create database ejemplo

use ejemplo

drop database ejemplo

create database ejemplo

create table usuarios (
  id int auto_increment primary key,
  nombre varchar (100) not null,
  correo varchar (100)  unique not null,
  fecha_registro date,
  activo boolean default true,
  contraseña varchar (30) not null
)

create table producto (
id int auto_increment primary key,
nombre_producto varchar(100) not null,
precio_producto int,
stock_producto int,
unico varchar (50) unique,
obligatorio varchar (50) not null
)


alter table usuarios add column telefono varchar (50)

alter table usuarios modify telefono int

insert into usuarios (nombre, correo, fecha_registro,activo,contraseña,telefono) 
values
("luke skywalker", "luke@gmail.com", "2024-04-20", true, "1234abcd", "+50688888888"),
("hermione granger", "hermione@gmail.com", "2024-04-21", true, "pass5678", "+50689999999"),
("tony stark", "tony@gmail.com", "2024-04-22", false, "tony129", "+50687777777"),
("elsa arendelle", "elsa@gmail.com", "2024-04-23", true, "elsa12374", "+50686666666"),
("indiana jones", "india@gmail.com", "2024-04-24", true, "pedrito", "+50685555555")


insert into producto (nombre_producto,precio_producto,stock_producto,unico, obligatorio) 
values
("espada láser", 1200, 40, "ep4-skywalker", "galaxia"),
("varita mágica", 500, 80, "hogwarts-01", "hogwarts"),
("armadura iron man", 5000, 10, "stark-mark3", "avengers"),
("trineo mágico", 900, 25, "arendelle-elsa", "arendelle"),
("sombrero fedora", 200, 50, "indy-hat1", "aventura");

delete from usuarios
where id = 4

delete from usuarios
where id = 3

delete from producto
where stock_producto > 20 and < 50 stock_producto

update usuarios
set telefono = "+5069994563"
where id = 3

select*from usuarios
where edad > 18
order by edad desc

/*Nota: La columna 'edad' no fue creada en la tabla original. ¿Qué error crees que aparecerá?
ERROR: column "edad" does not exist
¿Cómo lo solucionarías? */
alter table "usuarios" add column "edad" int

update usuarios set edad = 25 where id = 1
update usuarios set edad = 22 where id = 2
update usuarios set edad = 35 where id = 3
update usuarios set edad = 28 where id = 4
update usuarios set edad = 45 where id = 5

select nombre,correo,fecha_registro from usuarios

select * from producto
where precio_producto > 100
