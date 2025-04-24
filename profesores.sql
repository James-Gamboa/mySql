/*Ejercicio Práctico #4
Crear una tabla profesores.
Insertar al menos 5 registros en la tabla profesores.
Consultar los profesores con más de 10 años de experiencia.
Consultar los profesores con 10 años de experiencia.
Consultar profesores con un rango de años de experiencia entre 10 y
20 años.
Ordenar los resultados por años de experiencia (ASC O DESC)*/

create database profesores

use profesores

create table profesores (
  id int auto_increment primary key,
  nombre varchar(200),
  especialidad varchar(200),
  anios_experiencia int
)

insert into profesores (nombre, especialidad, anios_experiencia)
values
("lady maria", "matematicas", 12),
("kratos cerdas", "educacion fisica", 18),
("lucyna kushinada", "quimica", 10),
("malenia vargas", "biologia", 15),
("arthur morgan", "estudios sociales", 25)

select * from profesores;

select * from profesores
where anios_experiencia > 10

insert into profesores (nombre, especialidad, anios_experiencia) 
values("Solid Snake", "filosofia ", 10) 


select * from profesores
where anios_experiencia = 10

select * from profesores
where anios_experiencia >= 10 and anios_experiencia <= 20 


select * from profesores
order by anios_experiencia asc

select * from profesores
order by anios_experiencia desc


