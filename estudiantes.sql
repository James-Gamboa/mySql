/*Ejercicio Práctico #3
Insertar datos en la tabla estudiantes y hacer consultas
Insertar al menos 5 registros a la tabla
consultar estudiantes mayores a 15 años
ordenar esa consulta por edad descendentemente
*/

create database estudiantes

use estudiantes

create table estudiantes (
  id int auto_increment primary key,
  nombre varchar(200),
  grupo varchar(50),
  carrera varchar(100),
  edad varchar(20)
);

insert into estudiantes (nombre, grupo, carrera, edad)
values
("solid snake", "snk001", "infiltracion", 38),
("big boss", "bb002", "estrategia militar", 45),
("otacon", "otc003", "ingenieria robotica", 32),
("raiden", "rd004", "ciberseguridad", 29),
("the boss", "tb005", "filosofia de combate", 42);

select * from estudiantes
where edad >= 15 ;



select * from estudiantes
order by edad desc;
