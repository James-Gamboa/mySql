CREATE DATABASE Universidad;
USE Universidad;
-- Tabla de Departamentos
CREATE TABLE Departamentos (
    id_departamento INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL
);

-- Tabla de Profesores
CREATE TABLE Profesores (
    id_profesor INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    email VARCHAR(100),
    id_departamento INT,
    FOREIGN KEY (id_departamento) REFERENCES Departamentos(id_departamento)
);

-- Tabla de Estudiantes
CREATE TABLE Estudiantes (
    id_estudiante INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    email VARCHAR(100),
    fecha_nacimiento DATE
);

-- Tabla de Cursos
CREATE TABLE Cursos (
    id_curso INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    id_profesor INT,
    FOREIGN KEY (id_profesor) REFERENCES Profesores(id_profesor)
);

-- Tabla de Inscripciones
CREATE TABLE Inscripciones (
    id_inscripcion INT AUTO_INCREMENT PRIMARY KEY,
    id_estudiante INT,
    id_curso INT,
    fecha_inscripcion DATE,
    FOREIGN KEY (id_estudiante) REFERENCES Estudiantes(id_estudiante),
    FOREIGN KEY (id_curso) REFERENCES Cursos(id_curso)
);

create table AuditoriaInscripciones (
    id_auditoria int auto_increment primary key,
    id_estudiante int not null,
    id_curso int not null,
    fecha_auditoria datetime not null,
    foreign key (id_estudiante) references estudiantes(id_estudiante),
    foreign key (id_curso) references cursos(id_curso)
);

select * from Inscripciones;
-- Insertar Departamentos
INSERT INTO Departamentos (nombre) VALUES 
('Ingeniería'), 
('Ciencias Sociales'), 
('Matemáticas'), 
('Humanidades');

-- Insertar Profesores
INSERT INTO Profesores (nombre, email, id_departamento) VALUES 
('Carlos Pérez', 'carlos.perez@universidad.edu', 1),
('Ana Gómez', 'ana.gomez@universidad.edu', 2),
('Luis Martínez', 'luis.martinez@universidad.edu', 3),
('María López', 'maria.lopez@universidad.edu', 4);

-- Insertar Estudiantes
INSERT INTO Estudiantes (nombre, email, fecha_nacimiento) VALUES 
('Juan Torres', 'juan.torres@correo.com', '2000-05-14'),
('Laura Sánchez', 'laura.sanchez@correo.com', '1999-11-23'),
('Miguel Díaz', 'miguel.diaz@correo.com', '2001-03-09');

-- Insertar Cursos
INSERT INTO Cursos (nombre, id_profesor) VALUES 
('Bases de Datos', 1),
('Psicología Social', 2),
('Álgebra Lineal', 3),
('Historia Contemporánea', 4);

-- Insertar Inscripciones
INSERT INTO Inscripciones (id_estudiante, id_curso, fecha_inscripcion) VALUES 
(1, 1, '2025-03-01'),
(1, 3, '2025-03-02'),
(2, 2, '2025-03-03'),
(3, 1, '2025-03-04'),
(3, 4, '2025-03-05');


/*Vista 1: Vista de Inscripciones de Estudiantes
Cree una vista llamada "Vista_Inscripciones_Estudiantes" que muestre los siguientes
datos de la tabla de "Inscripciones":
- ID del estudiante
- Nombre del estudiante
- Nombre del curso
- Fecha de inscripción
Para esto, deberá utilizar las tablas "Estudiantes", "Cursos" e "Inscripciones" y hacer las
uniones necesarias.
Utilice un "JOIN" para obtener los nombres de los estudiantes y cursos según sus
respectivos identificadores.
 */
create view vista_Inscripciones_Estudiante as
select 
 estudiantes.nombre as nombre_estudiante,
cursos.nombre as nombre_curso,
inscripciones.fecha_inscripcion
from inscripciones
join estudiantes on inscripciones.id_estudiante = estudiantes.id_estudiante
join cursos on inscripciones.id_curso = cursos.id_curso;
 
 select * from  vista_Inscripciones_Estudiante;
 
 /*Vista 2: Vista de Cursos de un Profesor
Cree una vista llamada "Vista_Cursos_Profesor" que muestre los cursos asignados a un
profesor en particular.
La vista deberá mostrar lo siguiente:
- Nombre del curso
- Nombre del profesor
Para esto, deberá hacer una unión entre la tabla de "Cursos" y la tabla de "Profesores".
Utilice el "id_profesor" de ambas tablas para realizar la unión.
*/
create view Vista_Cursos_Profesor as
select 
cursos.nombre as nombre_curso,
profesores.nombre as nombre_profesor
from cursos
join profesores on cursos.id_profesor= profesores.id_profesor;

 select * from  Vista_Cursos_Profesor;


/* Vista 3: Vista de Alumnos Inscritos por Curso
Cree una vista llamada "Vista_Alumnos_Curso" que muestre la siguiente información:
- Nombre del curso
- Número de estudiantes inscritos en ese curso
Para esto, deberá utilizar las tablas "Inscripciones" y "Cursos", y contar el número de
estudiantes inscritos por cada curso.*/

create view vista_alumnos_curso as
select 
cursos.nombre as nombre_curso,
count(inscripciones.id_estudiante) as numero_de_estudiantes
from inscripciones
join cursos on inscripciones.id_curso = cursos.id_curso
group by cursos.nombre;


 select * from  vista_alumnos_curso;


/*Crea un procedimiento almacenado llamado InsertarEstudiante que permita insertar
un nuevo estudiante en la tabla Estudiantes. El procedimiento debe recibir dos
parámetros de entrada:
 nombre
 email
 fecha_nacimeinto
El procedimiento debe insertar estos valores en la tabla Estudiantes, donde se
almacenarán los datos del nuevo estudiante.
Requisitos:
1. El procedimiento debe aceptar tres parámetros
2. El procedimiento debe realizar una inserción en la tabla Estudiantes usando los
parámetros proporcionados.
Trigger: Auditoría de Inscripciones
Cree un trigger llamado "Trigger_Auditoria_Inscripcion" que se ejecute después de
insertar una fila en la tabla "Inscripciones".
Este trigger debe insertar un registro en la tabla "AuditoriaInscripciones" cada vez que
un estudiante se inscriba en un curso. El registro debe contener:
- ID del estudiante
- ID del curso
- Fecha de inscripción (usando la función NOW()) */

DELIMITER $$ 
create procedure InsertarEstudiante(
in nombre varchar(100),
in email varchar(100),
in fecha_nacimiento date 
)
begin
insert into estudiantes(nombre,email,fecha_nacimiento)
values (nombre, email, fecha_nacimiento);
end $$
DELIMITER ;

call InsertarEstudiante("James","jjgamboag@gmail.com","2025-04-28");

select * from  estudiantes;
DELIMITER $$

create trigger Trigger_Auditoria_Inscripcion
after insert on inscripciones
for each row
begin
insert into AuditoriaInscripciones(id_estudiante,id_curso,fecha_auditoria)
values (new.id_estudiante,new.id_curso,now());
end $$
DELIMITER ;

insert into inscripciones(id_estudiante,id_curso,fecha_inscripcion)
values(2,3,"2025-04-28");

select * from inscripciones;
/*Utilizando la base de datos ya creada, analice y realice las siguientes
actividades:
1. Vistas:
o Cree dos vistas que resuman o presenten datos relevantes.
o Cada vista debe tener un propósito claro, por ejemplo: facilitar
consultas frecuentes, unir información de varias tablas, o aplicar
filtros específicos.
*/
-- Muestra estudiantes nacidos antes de 2002
create view vista_estudiantes_mayores as
select 
id_estudiante,
nombre,
email,
fecha_nacimiento
from estudiantes
where fecha_nacimiento <= "2002-12-31";

select * from vista_estudiantes_mayores;

-- Muestra el nombre del profesor y el nombre del departamento
create view profesores_departamentos as
select
profesores.nombre as nombre_profesor,
departamentos.nombre as nombre_departamento
from profesores
join departamentos on profesores.id_departamento = departamentos.id_departamento;

select * from profesores_departamentos;

/*2. Procedimientos Almacenados:
o Desarrolle dos procedimientos almacenados que realicen
operaciones específicas sobre la base de datos.
o Los procedimientos pueden incluir, por ejemplo: inserciones,
actualizaciones, búsquedas filtradas, o reportes automáticos.*/

-- actualizar el email de un estudiante
DELIMITER $$
create procedure ActualizarEmailEstudiante (
in id_estudiante int,
in nuevo_email varchar(100)
)
begin 
update estudiantes
set email = nuevo_email
where estudiantes.id_estudiante = id_estudiante;
end $$
DELIMITER ;

call ActualizarEmailEstudiante (2, "solidsnake@yahoo.com");

select * from estudiantes;

-- listar que curso esta inscrito cada estudiante
DELIMITER $$
create procedure ListarInscripcionesPorEstudiante(
    in nombre_estudiante varchar(100)
)
begin
    select 
        estudiantes.nombre,
        cursos.nombre,
        inscripciones.fecha_inscripcion
    from inscripciones
    join estudiantes 
      on inscripciones.id_estudiante = estudiantes.id_estudiante
    join cursos 
      on inscripciones.id_curso = cursos.id_curso
    where estudiantes.nombre = nombre_estudiante;
end $$
DELIMITER ;

call ListarInscripcionesPorEstudiante("Laura Sánchez");

/*3. Triggers:
o Implemente dos triggers que se activen ante eventos como
INSERT, UPDATE o DELETE.
o Los triggers deben tener un objetivo claro, como: mantener la
integridad de los datos, registrar cambios en una tabla de auditoría,
o generar acciones automáticas basadas en modificaciones.*/

-- registra en auditoria cuando se actualiza la fecha de inscripción
DELIMITER $$

create trigger Trigger_Auditoria_Actualizar_Inscripcion
after update on Inscripciones
for each row
begin
    insert into AuditoriaInscripciones  (id_estudiante, id_curso, fecha_auditoria)
    values (new.id_estudiante, new.id_curso, now());
end $$

DELIMITER ;

-- incrementa el número de estudiantes inscritos en el curso cuando se agrega una inscripción

alter table Cursos add column numero_estudiantes int not null default 0;

DELIMITER $$
create trigger Actualizar_Numero_Estudiantes
after insert on Inscripciones
for each row
begin
    update cursos
    set numero_estudiantes = numero_estudiantes + 1
    where id_curso = new.id_curso;
end $$

DELIMITER  ;