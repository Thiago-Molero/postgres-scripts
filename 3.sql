-- 1. Tabla Cliente (Tabla independiente)
CREATE TABLE Cliente (
    idC SERIAL PRIMARY KEY,
    tipoDocumC VARCHAR(20) NOT NULL,
    nroDocumC VARCHAR(20) UNIQUE NOT NULL,
    nombresC VARCHAR(100) NOT NULL,
    paternoC VARCHAR(50) NOT NULL,
    maternoC VARCHAR(50),
    celularC VARCHAR(15)
);

-- 2. Tabla Categoría (Tabla independiente)
CREATE TABLE Categoria (
    idCat SERIAL PRIMARY KEY,
    nombreCat VARCHAR(100) NOT NULL,
    descripcionCat TEXT
);

-- 3. Tabla Producto
-- Se relaciona con Categoría (|| ------ |<)
CREATE TABLE Producto (
    idP SERIAL PRIMARY KEY,
    idCat INTEGER NOT NULL, -- Llave foránea de Categoría (Obligatoria por el ||)
    nombreP VARCHAR(150) NOT NULL,
    descripcionP TEXT, 
    precioReferencialP DECIMAL(10, 2) NOT NULL,
    CONSTRAINT fk_producto_categoria FOREIGN KEY (idCat) REFERENCES Categoria(idCat)
);

-- 4. Tabla Comprobante
-- Se relaciona con Cliente (|| ------ |<)
CREATE TABLE Comprobante (
    idComp SERIAL PRIMARY KEY,
    idC INTEGER NOT NULL, -- Llave foránea de Cliente (Obligatoria por el ||)
    fechaHoraComp TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    totalComp DECIMAL(12, 2) NOT NULL DEFAULT 0.00,
    CONSTRAINT fk_comprobante_cliente FOREIGN KEY (idC) REFERENCES Cliente(idC)
);

-- 5. Tabla Detalle
-- Se relaciona con Comprobante (|| ------ |<) y Producto (|| ------ |<)
CREATE TABLE Detalle (
    idDet SERIAL PRIMARY KEY,
    idComp INTEGER NOT NULL, -- Llave foránea de Comprobante
    idP INTEGER NOT NULL,    -- Llave foránea de Producto
    cantidadDet INTEGER NOT NULL,
    precioRealUnitarioDet DECIMAL(10, 2) NOT NULL,
    subtotalDet DECIMAL(12, 2) NOT NULL,
    CONSTRAINT fk_detalle_comprobante FOREIGN KEY (idComp) REFERENCES Comprobante(idComp),
    CONSTRAINT fk_detalle_producto FOREIGN KEY (idP) REFERENCES Producto(idP)
);