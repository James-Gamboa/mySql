use universidad;

CREATE VIEW Vista_Cursos_Informatica AS
SELECT nombre FROM cursos where id_profesor =1;

SELECT * FROM vista_cursos_informatica;


CREATE VIEW Vista_Cursos_Otros AS
SELECT nombre FROM cursos where id_profesor !=1;

SELECT * FROM vista_cursos_otros;


CREATE VIEW Vista_Curso_Profesor AS
SELECT Cursos.nombre as curso,
	   Profesores.nombre
FROM Cursos
JOIN Profesores ON Cursos.id_profesor = Profesores.id_profesor
WHERE Cursos.id_profesor =1;


SELECT * FROM vista_curso_profesor;



DELIMITER $$

CREATE PROCEDURE ObtenerCursosPorProfesor (IN profesor_id INT)
BEGIN
	SELECT cursos.nombre AS nombre_curso
    FROM Cursos 
    WHERE id_profesor = profesor_id;
    
END $$
DELIMITER ;


CALL ObtenerCursosPorProfesor(1)



DELIMITER $$

CREATE PROCEDURE CursoNoDisponible(IN id_curso_parametro INT)
BEGIN
	UPDATE Cursos
    SET nombre = "No Disponible"
    WHERE id_curso = id_curso_parametro;
END $$

DELIMITER ;


CALL CursoNoDisponible(5);


DELIMITER $$

CREATE PROCEDURE InsertarEstudianteNuevo (in nombre_estudiante VARCHAR(100), in email_estudiante VARCHAR(100), fecha_nacimiento DATE)
BEGIN
	INSERT INTO Estudiantes(nombre,email,fecha_nacimiento)
    VALUES(nombre_estudiante,email_estudiante,fecha_nacimiento);
    
END $$


DELIMITER ;

CALL InsertarEstudianteNuevo ("Pedrito","pedritoescamoso@gmail.com","2002-05-23");





DELIMITER $$


CREATE TRIGGER Triger_Auditoria_Inscripcion
AFTER INSERT ON Inscripciones
FOR EACH ROW
BEGIN
	INSERT INTO auditoriainscripciones (id_estudiante,id_curso,fecha_inscripcion)
    VALUES (NEW.id_estudiante,NEW.id_curso,CURRENT_TIMESTAMP());
END $$
	
DELIMITER ;


CREATE TABLE ContarEstudiantesEliminados(
	id_contador int primary key auto_increment,
    cantidad_eliminados int default 0
);

INSERT INTO ContarEstudiantesEliminados (cantidad_eliminados) values (1);




DELIMITER $$

CREATE TRIGGER Triger_Contar_Estudiantes_Eliminados
AFTER DELETE ON Estudiantes
FOR EACH ROW
BEGIN
	UPDATE ContarEstudiantesEliminados
    SET cantidad_eliminados = cantidad_eliminados +1
    WHERE id_contador = 1;
END $$
DELIMITER ;


DROP TRIGGER  triger_Contar_Estudiantes_Eliminados