-- 1. Tabla Cliente (Independiente)
CREATE TABLE Cliente (
    idC SERIAL PRIMARY KEY,
    tipoDocumC VARCHAR(20) NOT NULL,
    nroDocumC VARCHAR(20) UNIQUE NOT NULL,
    nombresC VARCHAR(100) NOT NULL,
    paternoC VARCHAR(50) NOT NULL,
    maternoC VARCHAR(50),
    generoC VARCHAR(20),
    fechaNacimC DATE,
    enfermedadesC TEXT, -- Corregido de "enfremedadesC"
    celularC VARCHAR(15)
);

-- 2. Tabla Disciplina (Independiente)
CREATE TABLE Disciplina (
    idD SERIAL PRIMARY KEY,
    nombreD VARCHAR(100) NOT NULL,
    descripcionD TEXT
);

-- 3. Tabla GrupoDisciplina
-- Se relaciona con Disciplina (|| ------ |<)
CREATE TABLE GrupoDisciplina (
    idG SERIAL PRIMARY KEY,
    idD INTEGER NOT NULL, -- Llave foránea obligatoria (||)
    nombreG VARCHAR(100) NOT NULL,
    fechaInicioG DATE NOT NULL,
    fechaFinG DATE NOT NULL,
    CONSTRAINT fk_grupo_disciplina FOREIGN KEY (idD) REFERENCES Disciplina(idD)
);

-- 4. Tabla Asistencia
-- Se relaciona con Cliente (|| ------ |<) y GrupoDisciplina (|| ------ |<)
CREATE TABLE Asistencia (
    idA SERIAL PRIMARY KEY,
    idC INTEGER NOT NULL, -- Llave foránea obligatoria (||)
    idG INTEGER NOT NULL, -- Llave foránea obligatoria (||)
    fechaA DATE NOT NULL,
    diaA VARCHAR(20) NOT NULL,
    esFeriadoA BOOLEAN DEFAULT FALSE, -- Corregido de "esferiadoA"
    asistioA BOOLEAN DEFAULT FALSE,
    horaEntradaA TIME,
    CONSTRAINT fk_asistencia_cliente FOREIGN KEY (idC) REFERENCES Cliente(idC),
    CONSTRAINT fk_asistencia_grupo FOREIGN KEY (idG) REFERENCES GrupoDisciplina(idG)
);