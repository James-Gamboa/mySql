create database supercompro;

use supercompro;

drop database supercompro;

create table  clientes (
	id_cliente int auto_increment primary key,
    nombre varchar(100) not null,
    correo varchar(100) unique not null,
    telefono varchar(20)
);

create table empleados (
	id_empleado int auto_increment primary key,
    nombre varchar(100) not null,
    puesto varchar(50) not null,
    salario varchar(10)
);

create table categorias(
	id_categoria int auto_increment primary key,
	nombre_categoria varchar(100) not null
);

create table productos (
	id_producto int auto_increment primary key,
    nombre_producto varchar(50) not null,
    precio decimal (10,2) not null,
    id_categoria int,
    foreign key(id_categoria) references categorias(id_categoria)
);

create table pedidos(
id_pedidos int auto_increment primary key,
fecha_pedidos date not null,
id_cliente int,
id_empleado int,
foreign key(id_cliente) references clientes(id_cliente),
foreign key(id_empleado) references empleados(id_empleado)
);


create table proveedores(
	id_proveedor int auto_increment primary key,
    nombre_proveedor varchar(100) not null,
    direccion_proveedor text not null,
    contacto varchar(40) not null
);


select *from categorias;

select *from productos;


insert into categorias (nombre_categoria) value ("granos");

insert into productos (nombre_producto,precio,id_categoria)
values  ("Mantequilla","500",1);

insert into productos (nombre_producto,precio,id_categoria)
values  ("Frijoles","1500",2);

insert into productos (nombre_producto,precio,id_categoria)
values  ("Arroz","2500",2);

insert into productos (nombre_producto,precio,id_categoria)
values  ("Garbanzos","1000",2);

select * from pedidos;

insert into pedidos (fecha_pedido,id_cliente,id_empleado)
values  ("2025-04-24",1,1);

select * from clientes;

insert into empleados (nombre,puesto,salario)
values  ("Pedrito","Jefe planta","60000");

insert into clientes (nombre,correo,telefono) 
values ("Pilar","pilar45@gmail.com","6784512")
