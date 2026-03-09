-- 1. Tabla Enfermero (Independiente)
CREATE TABLE Enfermero (
    idE SERIAL PRIMARY KEY,
    tipoDocumE VARCHAR(20) NOT NULL,
    nroDocumE VARCHAR(20) UNIQUE NOT NULL,
    nombresE VARCHAR(100) NOT NULL,
    paternoE VARCHAR(50) NOT NULL,
    maternoE VARCHAR(50),
    fechaNacimientoE DATE NOT NULL,
    generoE VARCHAR(20)
);

-- 2. Tabla Calendario (Independiente)
CREATE TABLE Calendario (
    idC SERIAL PRIMARY KEY,
    inicioC DATE NOT NULL,
    finC DATE NOT NULL,
    nombreC VARCHAR(100) NOT NULL
);

-- 3. Tabla Ambiente (Independiente)
CREATE TABLE Ambiente (
    idAmb SERIAL PRIMARY KEY,
    nroAmb VARCHAR(20) NOT NULL,
    ubicacionAmb VARCHAR(150) NOT NULL
);

-- 4. Tabla Asistencia
-- Se relaciona con Enfermero (||), Calendario (||) y Ambiente (||)
CREATE TABLE Asistencia (
    idA SERIAL PRIMARY KEY,
    idE INTEGER NOT NULL,    -- Llave foránea de Enfermero
    idC INTEGER NOT NULL,    -- Llave foránea de Calendario
    idAmb INTEGER NOT NULL,  -- Llave foránea de Ambiente
    fechaA DATE NOT NULL,
    diaA VARCHAR(20) NOT NULL,
    asistioA BOOLEAN DEFAULT FALSE,
    tardoA BOOLEAN DEFAULT FALSE,
    horaEntradaA TIME,
    horaSalidaA TIME,
    justificacionA TEXT,
    esDescansoA BOOLEAN DEFAULT FALSE,
    CONSTRAINT fk_asistencia_enfermero FOREIGN KEY (idE) REFERENCES Enfermero(idE),
    CONSTRAINT fk_asistencia_calendario FOREIGN KEY (idC) REFERENCES Calendario(idC),
    CONSTRAINT fk_asistencia_ambiente FOREIGN KEY (idAmb) REFERENCES Ambiente(idAmb)
);