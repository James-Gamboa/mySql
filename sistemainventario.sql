/* Primera Parte: Diseño y Creación de la Base de Datos 
Se requiere el diseño y desarrollo de una base de datos para un sistema de inventario. 
El trabajo debe cumplir con los siguientes requerimientos: 
 Modelado de Datos: 
   - Realizar un análisis previo del sistema a implementar. 
   - Identificar entidades, atributos y relaciones necesarias. 
 
 Normalización: 
   - Aplicar las formas normales hasta al menos la 2FN para garantizar la 
integridad y eficiencia del diseño. 
 
 Modelo Entidad-Relación (ER): 
   - Elaborar un diagrama ER que refleje claramente: 
     - Al menos 10 tablas. 
     - Relaciones entre entidades (uno a muchos, muchos a muchos, etc.). 
     - Llaves primarias y foráneas. 
 
 Implementación en MySQL: 
   - Crear la base de datos utilizando MySQL. 
   - Incluir la creación de las tablas con sus respectivas restricciones. 
   - Realizar la inserción de datos de prueba en cada tabla. */
   
create database SistemaInventario; 
Use SistemaInventario;
 
 
 create table Categorias (
    id_categoria int auto_increment primary key,
    nombre_categoria varchar(100) not null
);

create table Productos (
    id_producto int auto_increment primary key,
    nombre_producto varchar(100) not null,
    descripcion text,
    precio int not null,
    stock_actual int default 0,
    id_categoria int,
    foreign key (id_categoria) references categorias(id_categoria)
);

create table Proveedores (
    id_proveedor int auto_increment primary key,
    nombre_proveedor varchar(100) not null,
    telefono varchar(20),
    correo varchar(100)
);

create table Empleados (
    id_empleado int auto_increment primary key,
    nombre_empleado varchar(100) not null,
    puesto varchar(50),
    correo varchar(100)
);

create table clientes (
    id_cliente int auto_increment primary key,
    nombre_cliente varchar(100) not null,
    telefono varchar(20),
    correo varchar(100)
);

create table Ordenes_Compra (
    id_compra int auto_increment primary key,
    fecha date not null,
    id_proveedor int,
    id_empleado int,
    foreign key (id_proveedor) references proveedores(id_proveedor),
    foreign key (id_empleado) references empleados(id_empleado)
);

create table Detalle_Compra (
    id_detalle int auto_increment primary key,
    id_compra int,
    id_producto int,
    cantidad int not null,
    foreign key (id_compra) references ordenes_compra(id_compra),
    foreign key (id_producto) references productos(id_producto)
);

create table Ordenes_Venta (
    id_venta int auto_increment primary key,
    fecha date not null,
    id_cliente int,
    id_empleado int,
    foreign key (id_cliente) references clientes(id_cliente),
    foreign key (id_empleado) references empleados(id_empleado)
);

create table Detalle_Venta (
    id_detalle int auto_increment primary key,
    id_venta int,
    id_producto int,
    cantidad int not null,
    foreign key (id_venta) references ordenes_venta(id_venta),
    foreign key (id_producto) references productos(id_producto)
);

create table Movimientos_Inventario (
    id_movimiento int auto_increment primary key,
    id_producto int,
    fecha date not null,
    tipo_movimiento varchar(20) not null,
    cantidad int not null,
    foreign key (id_producto) references productos(id_producto)
);


insert into Categorias (nombre_categoria) values
("electrónica"),
("papelería");

insert into Productos (nombre_producto, descripcion, precio, stock_actual, id_categoria) values
("laptop hp", "computadora portátil", 85000, 10, 1),
("mouse inalámbrico", "mouse usb sin cables", 45000, 30, 1),
("cuaderno de resortes", "cuaderno de 100 hojas", 1000, 100, 2);

insert into Proveedores (nombre_proveedor, telefono, correo) values
("extremetech", "88881234", "extremetech@gmail.com"),
("universal", "88776655", "universal@gmail.com");

insert into Empleados (nombre_empleado, puesto, correo) values
("Michael de Santa", "administrador", "michael@gmail.com"),
("niko bellic", "almacén", "nikobellic@gmail.com");

insert into Clientes (nombre_cliente, telefono, correo) values
("tommy vercetti", "88889999", "vercetti@gmail.com"),
("claude speed", "87776655", "claude@gmail.com");

insert into Ordenes_Compra (fecha, id_proveedor, id_empleado) values
("2025-04-01", 1, 1),
("2025-04-02", 2, 2);

insert into Detalle_Compra (id_compra, id_producto, cantidad) values
(1, 1, 5),
(1, 2, 10),
(2, 3, 50);

insert into Ordenes_Venta (fecha, id_cliente, id_empleado) values
("2025-04-05", 1, 2),
("2025-04-06", 2, 1);

insert into Detalle_Venta (id_venta, id_producto, cantidad) values
(1, 2, 2),
(1, 3, 10),
(2, 1, 1);

insert into Movimientos_Inventario (id_producto, fecha, tipo_movimiento, cantidad) values
(1, "2025-04-01", "entrada", 5),
(2, "2025-04-01", "entrada", 10),
(3, "2025-04-02", "entrada", 50),
(2, "2025-04-05", "salida", 2),
(3, "2025-04-05", "salida", 10),
(1, "2025-04-06", "salida", 1);


/*Segunda Parte: Análisis y Objetos de Base de Datos 
Una vez creada e implementada la base de datos del sistema de inventario, se debe 
realizar un análisis funcional y estructural de la misma. Este análisis es fundamental 
para detectar oportunidades de mejora, optimización y automatización dentro del 
sistema. Se deben considerar los siguientes aspectos: 
1. Análisis de la Base de Datos: 
o Examinar las operaciones típicas del sistema de inventario. 
o Identificar necesidades de optimización o automatización. 
2. Objetos de Base de Datos: 
o Crear vistas que faciliten consultas frecuentes o complejas. 
o Implementar procedimientos almacenados que automaticen procesos 
comunes (por ejemplo, agregar productos, actualizar inventarios, generar 
reportes). 
o Definir triggers que respondan a eventos relevantes (por ejemplo, 
actualización automática de stock, control de registros eliminados). */

create view Productos_Stock as
select productos.id_producto, productos.nombre_producto, productos.stock_actual, categorias.nombre_categoria
from productos
join categorias on productos.id_categoria = categorias.id_categoria;

create view Ventas_Detalles as
select ordenes_venta.id_venta, ordenes_venta.fecha, clientes.nombre_cliente, productos.nombre_producto, detalle_venta.cantidad
from ordenes_venta
join clientes on ordenes_venta.id_cliente = clientes.id_cliente
join detalle_venta on ordenes_venta.id_venta = detalle_venta.id_venta
join productos on detalle_venta.id_producto = productos.id_producto;

create view Compras_Detalle as
select ordenes_compra.id_compra, ordenes_compra.fecha, proveedores.nombre_proveedor, productos.nombre_producto, detalle_compra.cantidad
from ordenes_compra
join proveedores on ordenes_compra.id_proveedor = proveedores.id_proveedor
join detalle_compra on ordenes_compra.id_compra = detalle_compra.id_compra
join productos on detalle_compra.id_producto = productos.id_producto;

create view Valor_Total_Inventario as
select productos.id_producto, productos.nombre_producto, productos.stock_actual, productos.precio,
(productos.stock_actual * productos.precio) as valor_total
from productos;

select * from Valor_Total_Inventario;
select * from Productos_Stock;
select * from Ventas_Detalles;
select * from Compras_Detalle;

DELIMITER $$
create procedure Agregar_Producto (
    in nombre varchar(100),
    in descripcion text,
    in precio int,
    in stock int,
    in categoria int
)
begin
    insert into productos (nombre_producto, descripcion, precio, stock_actual, id_categoria)
    values (nombre, descripcion, precio, stock, categoria);
end $$
DELIMITER ;

call Agregar_Producto("monitor gamer", "monitor 144hz", 180000, 5, 1);

DELIMITER $$
create procedure Actualizar_Stock (
    in producto_id int,
    in nuevo_stock int
)
begin
    update productos set stock_actual = nuevo_stock where id_producto = producto_id;
end $$
DELIMITER ;

call Actualizar_Stock(1, 15);

DELIMITER $$
create procedure Generar_Reporte_Ventas ()
begin
    select ordenes_venta.id_venta, ordenes_venta.fecha, clientes.nombre_cliente, productos.nombre_producto, detalle_venta.cantidad
    from ordenes_venta
    join clientes on ordenes_venta.id_cliente = clientes.id_cliente
    join detalle_venta on ordenes_venta.id_venta = detalle_venta.id_venta
    join productos on detalle_venta.id_producto = productos.id_producto;
end $$
DELIMITER ;

call Generar_Reporte_Ventas();

DELIMITER $$
create procedure Procedimiento_Eliminar_Producto_Por_Id (in id_producto int)
begin
    delete from productos where id_producto = id_producto;
end $$
DELIMITER ;

call Procedimiento_Eliminar_Producto_Por_Id(6);

DELIMITER $$
create procedure Procedimiento_Registrar_Nueva_Orden_De_Compra (
    in fecha_orden date,
    in id_proveedor int,
    in id_empleado int
)
begin
    insert into ordenes_compra (fecha, id_proveedor, id_empleado)
    values (fecha_orden, id_proveedor, id_empleado);
end $$
DELIMITER ;

call Procedimiento_Registrar_Nueva_Orden_De_Compra("2025-04-29", 1, 1);

DELIMITER $$
create trigger Insertar_Movimiento_Compra
after insert on Detalle_Compra
for each row
begin
    insert into Movimientos_Inventario (id_producto, fecha, tipo_movimiento, cantidad)
    values (new.id_producto, now(), "entrada", new.cantidad);
end $$
DELIMITER ;

insert into Detalle_Compra (id_compra, id_producto, cantidad) values (1, 1, 3);

DELIMITER $$
create trigger Insertar_Movimiento_Venta
after insert on Detalle_Venta
for each row
begin
    insert into Movimientos_Inventario (id_producto, fecha, tipo_movimiento, cantidad)
    values (new.id_producto, now(), "salida", new.cantidad);
end $$
DELIMITER ;

insert into Detalle_Venta (id_venta, id_producto, cantidad) values (1, 2, 1);


DELIMITER $$
create trigger Actualizar_Stock_Luego_De_Venta
after insert on detalle_venta
for each row
begin
    update productos
    set stock_actual = stock_actual - new.cantidad
    where id_producto = new.id_producto;
end $$
DELIMITER ;

insert into detalle_venta (id_venta, id_producto, cantidad) values (1, 3, 5);

DELIMITER $$
create trigger Actualizar_Stock_Luego_De_Compra
after insert on detalle_compra
for each row
begin
    update productos
    set stock_actual = stock_actual + new.cantidad
    where id_producto = new.id_producto;
end $$
DELIMITER ;

insert into detalle_compra (id_compra, id_producto, cantidad) values (1, 2, 4);