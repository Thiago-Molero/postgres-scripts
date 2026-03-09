-- 1. Tabla Banco
CREATE TABLE Banco (
    idB SERIAL PRIMARY KEY,
    nombreB VARCHAR(100) NOT NULL,
    paginaWebB VARCHAR(150)
);

-- 2. Tabla Cliente (incluye relación recursiva)
CREATE TABLE Cliente (
    idC SERIAL PRIMARY KEY,
    tipoDocumC VARCHAR(20) NOT NULL,
    nroDocumC VARCHAR(20) UNIQUE NOT NULL,
    nombresC VARCHAR(100) NOT NULL,
    paternoC VARCHAR(50) NOT NULL,
    maternoC VARCHAR(50),
    celularC VARCHAR(15),
    idC_referencia INTEGER, -- El círculo (O) indica que es opcional
    CONSTRAINT fk_cliente_ref FOREIGN KEY (idC_referencia) REFERENCES Cliente(idC)
);

-- 3. Tabla Empleado
CREATE TABLE Empleado (
    idE SERIAL PRIMARY KEY,
    tipoDocumE VARCHAR(20) NOT NULL,
    nroDocumE VARCHAR(20) UNIQUE NOT NULL,
    nombresE VARCHAR(100) NOT NULL,
    paternoE VARCHAR(50) NOT NULL,
    maternoE VARCHAR(50),
    celularE VARCHAR(15)
);

-- 4. Tabla Cuenta
-- Se relaciona con Banco y Cliente
CREATE TABLE Cuenta (
    idCuenta SERIAL PRIMARY KEY,
    idB INTEGER NOT NULL, -- Doble palito (||) desde Banco
    idC INTEGER NOT NULL, -- Doble palito (||) desde Cliente
    nroCuenta VARCHAR(30) UNIQUE NOT NULL,
    saldoCuenta DECIMAL(12, 2) NOT NULL DEFAULT 0.00,
    CONSTRAINT fk_cuenta_banco FOREIGN KEY (idB) REFERENCES Banco(idB),
    CONSTRAINT fk_cuenta_cliente FOREIGN KEY (idC) REFERENCES Cliente(idC)
);

-- 5. Tabla Operacion
-- Se relaciona con Cuenta, Empleado Y Cliente (corregido)
CREATE TABLE Operacion (
    idOpe SERIAL PRIMARY KEY,
    idCuenta INTEGER NOT NULL, -- Doble palito (||) desde Cuenta
    idE INTEGER NOT NULL,      -- Doble palito (||) desde Empleado
    idC INTEGER NOT NULL,      -- Doble palito (||) desde Cliente
    tipoOpe VARCHAR(50) NOT NULL,
    fechaHoraOpe TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    montoOpe DECIMAL(12, 2) NOT NULL,
    comisionOpe DECIMAL(12, 2) NOT NULL DEFAULT 0.00,
    CONSTRAINT fk_ope_cuenta FOREIGN KEY (idCuenta) REFERENCES Cuenta(idCuenta),
    CONSTRAINT fk_ope_empleado FOREIGN KEY (idE) REFERENCES Empleado(idE),
    CONSTRAINT fk_ope_cliente FOREIGN KEY (idC) REFERENCES Cliente(idC)
);