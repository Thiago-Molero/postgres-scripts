-- ELIMINAR TABLAS SI EXISTEN
DROP TABLE IF EXISTS Operacion;
DROP TABLE IF EXISTS Cuenta;
DROP TABLE IF EXISTS Empleado;
DROP TABLE IF EXISTS Cliente;
DROP TABLE IF EXISTS Banco;

-- 1. TABLA BANCO
CREATE TABLE Banco (
    idB SERIAL PRIMARY KEY,
    nombreB VARCHAR(100) NOT NULL,
    paginaWebB VARCHAR(150)
);

-- 2. TABLA CLIENTE
CREATE TABLE Cliente (
    idC SERIAL PRIMARY KEY,
    tipoDocumC VARCHAR(20) NOT NULL,
    nroDocumC VARCHAR(20) UNIQUE NOT NULL,
    nombresC VARCHAR(100) NOT NULL,
    paternoC VARCHAR(50) NOT NULL,
    maternoC VARCHAR(50),
    celularC VARCHAR(15),
    idC_referencia INTEGER,
    CONSTRAINT fk_cliente_ref 
        FOREIGN KEY (idC_referencia) REFERENCES Cliente(idC)
);

-- 3. TABLA EMPLEADO
CREATE TABLE Empleado (
    idE SERIAL PRIMARY KEY,
    tipoDocumE VARCHAR(20) NOT NULL,
    nroDocumE VARCHAR(20) UNIQUE NOT NULL,
    nombresE VARCHAR(100) NOT NULL,
    paternoE VARCHAR(50) NOT NULL,
    maternoE VARCHAR(50),
    celularE VARCHAR(15)
);

-- 4. TABLA CUENTA
CREATE TABLE Cuenta (
    idCuenta SERIAL PRIMARY KEY,
    idB INTEGER NOT NULL,
    idC INTEGER NOT NULL,
    nroCuenta VARCHAR(30) UNIQUE NOT NULL,
    saldoCuenta DECIMAL(12,2) NOT NULL DEFAULT 0.00,
    CONSTRAINT fk_cuenta_banco 
        FOREIGN KEY (idB) REFERENCES Banco(idB),
    CONSTRAINT fk_cuenta_cliente 
        FOREIGN KEY (idC) REFERENCES Cliente(idC)
);

-- 5. TABLA OPERACION
CREATE TABLE Operacion (
    idOpe SERIAL PRIMARY KEY,
    idCuenta INTEGER NOT NULL,
    idE INTEGER NOT NULL,
    idC INTEGER NOT NULL,
    tipoOpe VARCHAR(50) NOT NULL,
    fechaHoraOpe TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    montoOpe DECIMAL(12,2) NOT NULL,
    comisionOpe DECIMAL(12,2) NOT NULL DEFAULT 0.00,
    CONSTRAINT fk_ope_cuenta 
        FOREIGN KEY (idCuenta) REFERENCES Cuenta(idCuenta),
    CONSTRAINT fk_ope_empleado 
        FOREIGN KEY (idE) REFERENCES Empleado(idE),
    CONSTRAINT fk_ope_cliente 
        FOREIGN KEY (idC) REFERENCES Cliente(idC)
);

-- DATOS BANCO
INSERT INTO Banco (nombreB, paginaWebB) VALUES
('Banco de Crédito del Perú','https://www.viabcp.com'),
('BBVA Perú','https://www.bbva.pe'),
('Interbank','https://www.interbank.pe'),
('Scotiabank Perú','https://www.scotiabank.com.pe');

-- DATOS CLIENTE
INSERT INTO Cliente (tipoDocumC,nroDocumC,nombresC,paternoC,maternoC,celularC,idC_referencia) VALUES
('DNI','70123456','Juan','Perez','Garcia','987654321',NULL),
('DNI','70234567','Maria','Lopez','Torres','986543210',1),
('DNI','70345678','Carlos','Ramirez','Flores','985432109',1),
('DNI','70456789','Ana','Gutierrez','Salas','984321098',2),
('DNI','70567890','Luis','Fernandez','Rojas','983210987',NULL);

-- DATOS EMPLEADO
INSERT INTO Empleado (tipoDocumE,nroDocumE,nombresE,paternoE,maternoE,celularE) VALUES
('DNI','60111222','Pedro','Castillo','Mendoza','912345678'),
('DNI','60222333','Lucia','Vargas','Paredes','923456789'),
('DNI','60333444','Diego','Morales','Campos','934567890');

-- DATOS CUENTA
INSERT INTO Cuenta (idB,idC,nroCuenta,saldoCuenta) VALUES
(1,1,'001-456789123',3500.50),
(2,2,'002-123456789',5200.00),
(3,3,'003-987654321',1200.75),
(4,4,'004-741852963',800.00),
(1,5,'001-159357258',6400.20);

-- DATOS OPERACION
INSERT INTO Operacion (idCuenta,idE,idC,tipoOpe,montoOpe,comisionOpe) VALUES
(1,1,1,'Deposito',500.00,2.00),
(2,2,2,'Retiro',300.00,1.50),
(3,1,3,'Transferencia',200.00,3.00),
(4,3,4,'Deposito',1000.00,2.50),
(5,2,5,'Retiro',400.00,1.80),
(1,3,1,'Transferencia',150.00,2.20);

-- CONSULTAS PARA VER DATA OUTPUT
SELECT * FROM Banco;
SELECT * FROM Cliente;
SELECT * FROM Empleado;
SELECT * FROM Cuenta;
SELECT * FROM Operacion;
