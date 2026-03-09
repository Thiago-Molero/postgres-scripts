-- ELIMINAR TABLAS SI EXISTEN
DROP TABLE IF EXISTS Detalle;
DROP TABLE IF EXISTS Comprobante;
DROP TABLE IF EXISTS Producto;
DROP TABLE IF EXISTS Categoria;
DROP TABLE IF EXISTS Cliente;

-- 1. TABLA CLIENTE
CREATE TABLE Cliente (
    idC SERIAL PRIMARY KEY,
    tipoDocumC VARCHAR(20) NOT NULL,
    nroDocumC VARCHAR(20) UNIQUE NOT NULL,
    nombresC VARCHAR(100) NOT NULL,
    paternoC VARCHAR(50) NOT NULL,
    maternoC VARCHAR(50),
    celularC VARCHAR(15)
);

-- 2. TABLA CATEGORIA
CREATE TABLE Categoria (
    idCat SERIAL PRIMARY KEY,
    nombreCat VARCHAR(100) NOT NULL,
    descripcionCat TEXT
);

-- 3. TABLA PRODUCTO
CREATE TABLE Producto (
    idP SERIAL PRIMARY KEY,
    idCat INTEGER NOT NULL,
    nombreP VARCHAR(150) NOT NULL,
    descripcionP TEXT,
    precioReferencialP DECIMAL(10,2) NOT NULL,
    CONSTRAINT fk_producto_categoria 
        FOREIGN KEY (idCat) REFERENCES Categoria(idCat)
);

-- 4. TABLA COMPROBANTE
CREATE TABLE Comprobante (
    idComp SERIAL PRIMARY KEY,
    idC INTEGER NOT NULL,
    fechaHoraComp TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    totalComp DECIMAL(12,2) NOT NULL DEFAULT 0.00,
    CONSTRAINT fk_comprobante_cliente 
        FOREIGN KEY (idC) REFERENCES Cliente(idC)
);

-- 5. TABLA DETALLE
CREATE TABLE Detalle (
    idDet SERIAL PRIMARY KEY,
    idComp INTEGER NOT NULL,
    idP INTEGER NOT NULL,
    cantidadDet INTEGER NOT NULL,
    precioRealUnitarioDet DECIMAL(10,2) NOT NULL,
    subtotalDet DECIMAL(12,2) NOT NULL,
    CONSTRAINT fk_detalle_comprobante 
        FOREIGN KEY (idComp) REFERENCES Comprobante(idComp),
    CONSTRAINT fk_detalle_producto 
        FOREIGN KEY (idP) REFERENCES Producto(idP)
);

-- DATOS CLIENTE
INSERT INTO Cliente (tipoDocumC,nroDocumC,nombresC,paternoC,maternoC,celularC) VALUES
('DNI','70011111','Juan','Perez','Garcia','987111111'),
('DNI','70022222','Maria','Lopez','Torres','987222222'),
('DNI','70033333','Carlos','Ramirez','Flores','987333333'),
('DNI','70044444','Ana','Gutierrez','Salas','987444444');

-- DATOS CATEGORIA
INSERT INTO Categoria (nombreCat,descripcionCat) VALUES
('Laptops','Computadoras portátiles'),
('Celulares','Teléfonos inteligentes'),
('Accesorios','Periféricos y accesorios tecnológicos');

-- DATOS PRODUCTO
INSERT INTO Producto (idCat,nombreP,descripcionP,precioReferencialP) VALUES
(1,'Laptop Lenovo IdeaPad','Laptop para trabajo y estudio',2800.00),
(1,'Laptop HP Pavilion','Laptop de alto rendimiento',3500.00),
(2,'Samsung Galaxy S23','Smartphone de última generación',3200.00),
(2,'iPhone 14','Teléfono Apple',4200.00),
(3,'Mouse Logitech','Mouse inalámbrico',80.00),
(3,'Teclado Mecánico Redragon','Teclado gamer',150.00);

-- DATOS COMPROBANTE
INSERT INTO Comprobante (idC,totalComp) VALUES
(1,2960.00),
(2,4200.00),
(3,160.00);

-- DATOS DETALLE
INSERT INTO Detalle (idComp,idP,cantidadDet,precioRealUnitarioDet,subtotalDet) VALUES
(1,1,1,2800.00,2800.00),
(1,5,2,80.00,160.00),
(2,4,1,4200.00,4200.00),
(3,5,2,80.00,160.00);

-- CONSULTAS PARA VER LOS DATOS
SELECT * FROM Cliente;
SELECT * FROM Categoria;
SELECT * FROM Producto;
SELECT * FROM Comprobante;
SELECT * FROM Detalle;
