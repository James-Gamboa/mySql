create database universidad;
use universidad;

create table estudiantes (
  id_estudiante int auto_increment primary key,
  nombre varchar(100) not null,
  edad int not null,
  correo varchar(100) unique not null
);

create table profesores (
  id_profesor int auto_increment primary key,
  nombre varchar(100) not null,
  edad int not null,
  correo varchar(100) unique not null,
  especialidad varchar(100) not null
);

create table cursos (
  id_curso int auto_increment primary key,
  nombre_curso varchar(100) not null,
  id_profesor int not null,
  foreign key (id_profesor) references profesores(id_profesor)
);

create table inscripciones (
  id_inscripcion int auto_increment primary key,
  id_estudiante int not null,
  id_curso int not null,
  fecha_inscripcion date,
  foreign key (id_estudiante) references estudiantes(id_estudiante),
  foreign key (id_curso) references cursos(id_curso)
);

insert into estudiantes (nombre, edad, correo) values
  ("Ellie Williams", 19, "ellie@fireflies.com"),
  ("Joel Miller",   52, "joel@fireflies.com"),
  ("Tommy Miller",  48, "tommy@jackson.com"),
  ("Dina",          20, "dina@jackson.com"),
  ("Jesse",         21, "jesse@jackson.com");

insert into profesores (nombre, edad, correo, especialidad) values
  ("Jerry Anderson", 45, "jerry@medicos.com", "Medicina"),
  ("Marlene Ruiz",   38, "marlene@bio.com", "Biología"),
  ("Isaac Dixon",    50, "isaac@estrategia.com", "Estrategia");

insert into cursos (nombre_curso, id_profesor) values
  ("Anatomía Humana",          1),
  ("Virología Aplicada",       2),
  ("Tácticas de Supervivencia",3),
  ("Medicina de Campo",        1);

insert into inscripciones (id_estudiante, id_curso, fecha_inscripcion) values
  (1, 1, current_date - interval 5 day),
  (2, 1, current_date - interval 2 day),
  (3, 1, current_date - interval 15 day),
  (1, 2, current_date - interval 20 day),
  (4, 2, current_date - interval 35 day),
  (5, 2, current_date - interval 10 day),
  (2, 3, current_date - interval 4 day),
  (3, 3, current_date - interval 1 day),
  (5, 3, current_date - interval 3 day),
  (1, 4, current_date - interval 28 day),
  (4, 4, current_date - interval 25 day),
  (2, 4, current_date - interval 30 day);

/*1. Número de Estudiantes por Curso: Crear una consulta que devuelva el nombre de
cada curso junto con el número de estudiantes inscritos.*/
select nombre_curso, count(*) as cantidad
from inscripciones
join cursos on inscripciones.id_curso = cursos.id_curso
group by nombre_curso;
/*2. Profesor Responsable de Cada Curso: Realizar una consulta que devuelva el nombre
del curso y el nombre del profesor responsable.*/
select cursos.nombre_curso, profesores.nombre
from cursos
join profesores on cursos.id_profesor = profesores.id_profesor;
/*3. Estudiantes Inscritos en Cursos de una Especialidad: Crear una consulta para listar
los estudiantes que están inscritos en cursos de una especialidad específica (por
ejemplo, "Matemáticas").*/
select estudiantes.nombre
from estudiantes
join inscripciones on estudiantes.id_estudiante = inscripciones.id_estudiante
join cursos on inscripciones.id_curso = cursos.id_curso
join profesores on cursos.id_profesor = profesores.id_profesor
where profesores.especialidad = "Medicina";
/*4. Promedio de Edad de Estudiantes por Curso: Crear una consulta que muestre la
edad promedio de los estudiantes inscritos en cada curso.*/
select cursos.nombre_curso, avg(estudiantes.edad) as promedio
from inscripciones
join cursos on inscripciones.id_curso = cursos.id_curso
join estudiantes on inscripciones.id_estudiante = estudiantes.id_estudiante
group by cursos.nombre_curso;
/*5. Cursos con más de 2 estudiantes inscritos
Crea una consulta que muestre el nombre del curso y la cantidad de estudiantes
inscritos, solo si esa cantidad es mayor a 2.*/
select nombre_curso, cantidad
from (
  select cursos.nombre_curso, count(*) as cantidad
  from inscripciones
  join cursos on inscripciones.id_curso = cursos.id_curso
  group by cursos.nombre_curso
) as sub
where cantidad > 2;
/*6. Profesores que dictan más de un curso
Consulta que devuelva el nombre del profesor y la cantidad de cursos que dicta,
pero solo si dicta más de uno.*/
select nombre, cantidad
from (
  select profesores.nombre, count(*) as cantidad
  from cursos
  join profesores on cursos.id_profesor = profesores.id_profesor
  group by profesores.nombre
) as sub
where cantidad > 1;
/*7. Inscripciones realizadas en el último mes
Consulta que devuelva todas las inscripciones hechas en los últimos 30 días.*/
select *from inscripciones
where fecha_inscripcion >= current_date - interval 30 day;