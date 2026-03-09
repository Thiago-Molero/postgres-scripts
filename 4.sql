-- ELIMINAR TABLAS SI EXISTEN
DROP TABLE IF EXISTS detalleDeIngresoSalida;
DROP TABLE IF EXISTS Comprobante;
DROP TABLE IF EXISTS OrdenDeCompra;
DROP TABLE IF EXISTS Electrodomestico;
DROP TABLE IF EXISTS Cliente;
DROP TABLE IF EXISTS Proveedor;

-- 1. TABLA PROVEEDOR
CREATE TABLE Proveedor (
    idP SERIAL PRIMARY KEY,
    razonSocialP VARCHAR(150) NOT NULL,
    direccionP VARCHAR(200)
);

-- 2. TABLA CLIENTE
CREATE TABLE Cliente (
    idC SERIAL PRIMARY KEY,
    tipoDocumC VARCHAR(20) NOT NULL,
    nombresC VARCHAR(100) NOT NULL,
    nroDocumC VARCHAR(20) UNIQUE NOT NULL,
    paternoC VARCHAR(50) NOT NULL,
    maternoC VARCHAR(50),
    celularC VARCHAR(15)
);

-- 3. TABLA ELECTRODOMESTICO
CREATE TABLE Electrodomestico (
    idE SERIAL PRIMARY KEY,
    nombreE VARCHAR(100) NOT NULL,
    marcaE VARCHAR(50),
    modeloE VARCHAR(50),
    precioVentaE DECIMAL(10,2) NOT NULL,
    precioCompraE DECIMAL(10,2) NOT NULL
);

-- 4. TABLA ORDEN DE COMPRA
CREATE TABLE OrdenDeCompra (
    idOrden SERIAL PRIMARY KEY,
    idP INTEGER NOT NULL,
    fechaHoraOrden TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    totalOrden DECIMAL(12,2) NOT NULL DEFAULT 0.00,
    CONSTRAINT fk_orden_proveedor 
        FOREIGN KEY (idP) REFERENCES Proveedor(idP)
);

-- 5. TABLA COMPROBANTE
CREATE TABLE Comprobante (
    idComp SERIAL PRIMARY KEY,
    idC INTEGER NOT NULL,
    tipoComp VARCHAR(50) NOT NULL,
    fechaHoraComp TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    totalComp DECIMAL(12,2) NOT NULL DEFAULT 0.00,
    CONSTRAINT fk_comprobante_cliente 
        FOREIGN KEY (idC) REFERENCES Cliente(idC)
);

-- 6. TABLA DETALLE DE INGRESO / SALIDA
CREATE TABLE detalleDeIngresoSalida (
    idDet SERIAL PRIMARY KEY,
    idOrden INTEGER,
    idComp INTEGER,
    idE INTEGER NOT NULL,
    tipoDet VARCHAR(50) NOT NULL,
    subtotalDet DECIMAL(12,2) NOT NULL,
    cantidadDet INTEGER NOT NULL,
    CONSTRAINT fk_detalle_orden 
        FOREIGN KEY (idOrden) REFERENCES OrdenDeCompra(idOrden),
    CONSTRAINT fk_detalle_comprobante 
        FOREIGN KEY (idComp) REFERENCES Comprobante(idComp),
    CONSTRAINT fk_detalle_electrodomestico 
        FOREIGN KEY (idE) REFERENCES Electrodomestico(idE)
);

-- DATOS PROVEEDOR
INSERT INTO Proveedor (razonSocialP,direccionP) VALUES
('ElectroDistribuciones SAC','Av. Industrial 120 Lima'),
('Importaciones Tecnológicas SAC','Av. Argentina 550 Lima'),
('Comercial ElectroHogar','Av. Abancay 890 Lima');

-- DATOS CLIENTE
INSERT INTO Cliente (tipoDocumC,nombresC,nroDocumC,paternoC,maternoC,celularC) VALUES
('DNI','Juan','70011111','Perez','Garcia','987111111'),
('DNI','Maria','70022222','Lopez','Torres','987222222'),
('DNI','Carlos','70033333','Ramirez','Flores','987333333');

-- DATOS ELECTRODOMESTICO
INSERT INTO Electrodomestico (nombreE,marcaE,modeloE,precioVentaE,precioCompraE) VALUES
('Refrigeradora','LG','LG300X',2500.00,1900.00),
('Lavadora','Samsung','WA19T',1800.00,1400.00),
('Televisor','Sony','Bravia55',3200.00,2500.00),
('Microondas','Panasonic','NN-ST34',450.00,320.00);

-- DATOS ORDEN DE COMPRA (INGRESO DE PRODUCTOS)
INSERT INTO OrdenDeCompra (idP,totalOrden) VALUES
(1,5000.00),
(2,2800.00);

-- DATOS COMPROBANTE (VENTAS)
INSERT INTO Comprobante (idC,tipoComp,totalComp) VALUES
(1,'Boleta',2500.00),
(2,'Factura',3200.00),
(3,'Boleta',450.00);

-- DETALLE INGRESO / SALIDA
INSERT INTO detalleDeIngresoSalida (idOrden,idComp,idE,tipoDet,subtotalDet,cantidadDet) VALUES
(1,NULL,1,'INGRESO',3800.00,2),
(1,NULL,2,'INGRESO',1400.00,1),
(NULL,1,1,'SALIDA',2500.00,1),
(NULL,2,3,'SALIDA',3200.00,1),
(NULL,3,4,'SALIDA',450.00,1);

-- CONSULTAS PARA VER LOS DATOS
SELECT * FROM Proveedor;
SELECT * FROM Cliente;
SELECT * FROM Electrodomestico;
SELECT * FROM OrdenDeCompra;
SELECT * FROM Comprobante;
SELECT * FROM detalleDeIngresoSalida;
