-- 1. Tabla Proveedor (Independiente)
CREATE TABLE Proveedor (
    idP SERIAL PRIMARY KEY,
    razonSocialP VARCHAR(150) NOT NULL,
    direccionP VARCHAR(200)
);

-- 2. Tabla Cliente (Independiente)
CREATE TABLE Cliente (
    idC SERIAL PRIMARY KEY,
    tipoDocumC VARCHAR(20) NOT NULL,
    nombresC VARCHAR(100) NOT NULL,
    nroDocumC VARCHAR(20) UNIQUE NOT NULL,
    paternoC VARCHAR(50) NOT NULL,
    maternoC VARCHAR(50),
    celularC VARCHAR(15)
);

-- 3. Tabla Electrodomestico (Independiente)
CREATE TABLE Electrodomestico (
    idE SERIAL PRIMARY KEY,
    nombreE VARCHAR(100) NOT NULL,
    marcaE VARCHAR(50),
    modeloE VARCHAR(50),
    precioVentaE DECIMAL(10, 2) NOT NULL,
    precioCompraE DECIMAL(10, 2) NOT NULL
);

-- 4. Tabla OrdenDeCompra
-- Se relaciona con Proveedor (|| ------ |<)
CREATE TABLE OrdenDeCompra (
    idOrden SERIAL PRIMARY KEY,
    idP INTEGER NOT NULL, -- Obligatorio (||)
    fechaHoraOrden TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    totalOrden DECIMAL(12, 2) NOT NULL DEFAULT 0.00,
    CONSTRAINT fk_orden_proveedor FOREIGN KEY (idP) REFERENCES Proveedor(idP)
);

-- 5. Tabla Comprobante
-- Se relaciona con Cliente (|| ------ |<)
CREATE TABLE Comprobante (
    idComp SERIAL PRIMARY KEY,
    idC INTEGER NOT NULL, -- Obligatorio (||)
    tipoComp VARCHAR(50) NOT NULL,
    fechaHoraComp TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    totalComp DECIMAL(12, 2) NOT NULL DEFAULT 0.00,
    CONSTRAINT fk_comprobante_cliente FOREIGN KEY (idC) REFERENCES Cliente(idC)
);

-- 6. Tabla detalleDeIngresoSalida
-- Se relaciona con OrdenDeCompra (O), Comprobante (O) y Electrodomestico (||)
CREATE TABLE detalleDeIngresoSalida (
    idDet SERIAL PRIMARY KEY,
    idOrden INTEGER, -- Opcional (O): No lleva NOT NULL
    idComp INTEGER,  -- Opcional (O): No lleva NOT NULL
    idE INTEGER NOT NULL, -- Obligatorio (||)
    tipoDet VARCHAR(50) NOT NULL, -- Para identificar si es 'INGRESO' o 'SALIDA'
    subtotalDet DECIMAL(12, 2) NOT NULL,
    cantidadDet INTEGER NOT NULL,
    CONSTRAINT fk_detalle_orden FOREIGN KEY (idOrden) REFERENCES OrdenDeCompra(idOrden),
    CONSTRAINT fk_detalle_comprobante FOREIGN KEY (idComp) REFERENCES Comprobante(idComp),
    CONSTRAINT fk_detalle_electrodomestico FOREIGN KEY (idE) REFERENCES Electrodomestico(idE)
);