CREATE DATABASE IF NOT EXISTS te_lo_vendo;
USE te_lo_vendo;

-- Crear un usuario y otorgarle privilegios en una base de datos
CREATE USER 'admin_telovendo'@'localhost' IDENTIFIED BY 'admin_root';
GRANT CREATE, INSERT, SELECT, UPDATE, DELETE ON te_lo_vendo TO 'admin_telovendo'@'localhost';

-- Crear tabla de proveedores
CREATE TABLE proveedores (
    id INT AUTO_INCREMENT PRIMARY KEY,
    representante_legal VARCHAR(100),
    nombre_corporativo VARCHAR(100),
    telefono1 VARCHAR(20),
    telefono2 VARCHAR(20),
    nombre_contacto VARCHAR(100),
    categoria_producto VARCHAR(100),
    correo_electronico VARCHAR(100)
);

-- Agregar 5 proveedores a la tabla
INSERT INTO proveedores (representante_legal, nombre_corporativo, telefono1, telefono2, nombre_contacto, categoria_producto, correo_electronico)
VALUES ('Pedro Jerez', 'SAEX', '1234567890', '9876543210', 'Juan Santos', 'Electrónicos', 'SAEX@sa.com'),
       ('Roberto Solano', 'Kinsgtone', '176789093', '22222233332', 'Mario Becerra', 'Electrónicos', 'Kinsgtone@sa.com'),
       ('Juan Castro', 'Brandt', '157896543', '4444223366', 'Mariano Jerez', 'Electrónicos', 'Brandt@set.com'),
       ('Mariela Bustamante', 'Bosh', '778907890', '61235666666', 'Marcelo Peña', 'Electrónicos', 'Bosh@limi.com'),
       ('Daniela Ramirez', 'San Pedro', '74040082', '5657888888', 'Francisca Gutierrez', 'Electrónicos', 'SanPedro@ters.com');

CREATE TABLE cliente (
	id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100),
    apellido VARCHAR(100),
    direccion VARCHAR(100)
);

INSERT INTO cliente (nombre, apellido, direccion)
VALUES 
  ('Juan', 'Perez', 'Calle 123'),
  ('Maria', 'Gonzalez', 'Avenida 456'),
  ('Pedro', 'Rodriguez', 'Calle 789'),
  ('Laura', 'Garcia', 'Avenida 012'),
  ('Carlos', 'Fernandez', 'Calle 345');


CREATE TABLE producto (
	id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100),
    precio decimal(10, 2),
    stock int,
    color VARCHAR(100),
    id_proveedor int,
    id_categoria int,
    FOREIGN KEY (id_proveedor) REFERENCES proveedores(id),
    FOREIGN KEY (id_categoria) REFERENCES categoria(id)
);

CREATE TABLE categoria (
	id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100)
);

INSERT INTO categoria (nombre) 
Values ('Electrónicos'), ('Accesorios'), ('Linea Blanca'), ('Audio'), ('Fotografia');

-- Agregar 10 productos a la tabla
INSERT INTO producto (nombre, precio, id_categoria, id_proveedor , color, stock)
VALUES ('Microfono', 99.99,1, 1, 'Rojo', 50),
       ('Celular Xiaomi 128Gb', 49.99, 1, 2, 'Azul', 30),
       ('Televisor', 199.99, 1, 3, 'Negro', 20),
       ('Mouse', 149.99, 1, 4, 'Blanco', 10),
       ('Pendrive', 79.99, 1, 5, 'Gris', 5),
       ('Teclado', 9.99, 2, 1, 'Verde ', 100),
       ('Gabinete', 29.99, 2, 2, 'Amarillo', 50),
       ('Memoria Ram', 19.99, 2, 3, 'Naranja', 30),
       ('Monitor', 39.99, 2, 4, 'Rosa', 20),
       ('Refrigerador', 49.99, 3, 5, 'Morado', 10),
       ('Lavadora', 49.99, 3, 5, 'Morado', 10),
       ('Secadora', 49.99, 3, 5, 'Morado', 56),
       ('Soundbar', 49.99, 4, 5, 'Morado', 15),
       ('camara', 49.99, 5, 5, 'Morado', 23),
       ('camara Video', 49.99, 5, 5, 'Morado', 34),
       ('Audifnos', 49.99, 2, 5, 'Moado', 38);
       
CREATE TABLE compra (
	id INT AUTO_INCREMENT PRIMARY KEY,
    boleta varchar(100),
    id_cliente int,
    id_producto int,
    FOREIGN KEY (id_cliente) REFERENCES cliente(id),
    FOREIGN KEY (id_producto) REFERENCES producto(id)
);

INSERT INTO compra (boleta, id_cliente, id_producto)
VALUES 
  ('compra de Celular Xiaomi Redmi 128Gb', 1, 2),
  ('compra de Teclado', 3, 6),
  ('Compra de monitor', 2, 9),
  ('compra de audifonos', 4, 10),
  ('compra de mouse', 1, 4);
  
  
-- Consultas

-- 1
SELECT c.nombre AS categoria, COUNT(*) as Mas_repite
FROM producto p
JOIN categoria c ON p.id_categoria = c.id
GROUP BY c.nombre 
ORDER BY COUNT(*) DESC LIMIT 1;

-- 2
SELECT * from producto ORDER BY stock DESC;

-- 3
SELECT color, COUNT(*) as cantidad FROM producto
GROUP BY color 
ORDER BY cantidad DESC LIMIT 1;

-- 4 
select pr.nombre_corporativo as proveedor, SUM(p.stock) as Stock from producto as p
join  proveedores pr
on p.id_proveedor = pr.id
GROUP BY pr.nombre_corporativo
order by SUM(p.stock) ASC;

-- 5
update categoria
set nombre = 'Electrónica y computación'
where id = (
	select id_categoria from producto
    group by id_categoria
    order by count(*) desc limit 1
);
select * from categoria;


