create database pali

create database megasuper

show databases

use pali

drop database megasuper

use megasuper

create table usuarios (
	id_usuarios int AUTO_INCREMENT PRIMARY KEY,
    nombre varchar(100) NOT NULL,
    correo varchar(100) UNIQUE NOT NULL,
    fecha_registro DATE NOT NULL,
    activo Boolean Default True
);

select * from usuarios


alter table usuarios add column telefono varchar (20)

alter table usuarios add column edad varchar (20)

alter table usuarios modify telefono int

alter table usuarios drop telefono 

insert into usuarios(nombre,correo,fecha_registro,activo,telefono,edad)
values ("Jose","joseleiva@gmail.com","2025-04-23",False,"+50665458700","43")

insert into usuarios(nombre,correo,fecha_registro,activo,telefono,edad)
values ("James","jjguevarag@gmail.com","2025-04-23",False,"+50688456345","23")

delete from usuarios
where id_usuarios = 1

delete from usuarios
where edad >=15 and edad <=19

update usuarios
set telefono = "+5069994563"
where id_usuarios = 5


update usuarios
set telefono = "+5069994563"
where correo = "jjguevarag@gmail.com"

select nombre, correo from usuarios

select*from usuarios
where edad > 18
order by edad asc