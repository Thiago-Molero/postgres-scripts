-- 1. Tabla Cliente (Independiente)
CREATE TABLE Cliente (
    idC SERIAL PRIMARY KEY,
    tipoDocumC VARCHAR(20) NOT NULL,
    nroDocumC VARCHAR(20) UNIQUE NOT NULL,
    nombresC VARCHAR(100) NOT NULL,
    paternoC VARCHAR(50) NOT NULL,
    maternoC VARCHAR(50),
    celularC VARCHAR(15)
);

-- 2. Tabla Categoria (Independiente)
CREATE TABLE Categoria (
    idCat SERIAL PRIMARY KEY,
    nombreCat VARCHAR(100) NOT NULL,
    descripcionCat TEXT
);

-- 3. Tabla Producto
-- Se relaciona con Categoria (|| ------ |<)
CREATE TABLE Producto (
    idP SERIAL PRIMARY KEY,
    idCat INTEGER NOT NULL, -- Obligatorio (||)
    nombreP VARCHAR(150) NOT NULL,
    descripcionP TEXT, 
    precioReferencialP DECIMAL(10, 2) NOT NULL,
    CONSTRAINT fk_producto_categoria FOREIGN KEY (idCat) REFERENCES Categoria(idCat)
);

-- 4. Tabla Comprobante
-- Se relaciona con Cliente (|| ------ |<)
CREATE TABLE Comprobante (
    idComp SERIAL PRIMARY KEY,
    idC INTEGER NOT NULL, -- Obligatorio (||)
    fechaHoraComp TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    totalComp DECIMAL(12, 2) NOT NULL DEFAULT 0.00,
    CONSTRAINT fk_comprobante_cliente FOREIGN KEY (idC) REFERENCES Cliente(idC)
);

-- 5. Tabla Detalle
-- Se relaciona con Comprobante (|| ------ |<) y Producto (|| ------ |<)
CREATE TABLE Detalle (
    idDet SERIAL PRIMARY KEY,
    idComp INTEGER NOT NULL, -- Obligatorio (||)
    idP INTEGER NOT NULL,    -- Obligatorio (||)
    cantidadDet INTEGER NOT NULL,
    precioRealUnitarioDet DECIMAL(10, 2) NOT NULL,
    subtotalDet DECIMAL(12, 2) NOT NULL,
    CONSTRAINT fk_detalle_comprobante FOREIGN KEY (idComp) REFERENCES Comprobante(idComp),
    CONSTRAINT fk_detalle_producto FOREIGN KEY (idP) REFERENCES Producto(idP)
);