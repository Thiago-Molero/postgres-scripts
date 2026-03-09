-- 1. Tabla Año
CREATE TABLE Año (
    idAño SERIAL PRIMARY KEY,
    inicioAño DATE NOT NULL,
    finAño DATE NOT NULL
);

-- 2. Tabla Empleado (Incluye la relación recursiva Supervisor/Supervisado)
CREATE TABLE Empleado (
    idE SERIAL PRIMARY KEY,
    tipoDocumE VARCHAR(20) NOT NULL,
    nroDocumE VARCHAR(20) UNIQUE NOT NULL,
    nombresE VARCHAR(100) NOT NULL,
    paternoE VARCHAR(50) NOT NULL,
    maternoE VARCHAR(50),
    celularE VARCHAR(15),
    idSupervisor INTEGER, -- FK para la relación recursiva (puede ser NULL para el jefe máximo)
    CONSTRAINT fk_empleado_supervisor FOREIGN KEY (idSupervisor) REFERENCES Empleado(idE)
);

-- 3. Tabla Turno
-- Se relaciona con Año (|| ------ |<)
CREATE TABLE Turno (
    idT SERIAL PRIMARY KEY,
    idAño INTEGER NOT NULL, -- Llave foránea que viene de Año
    nombreT VARCHAR(50) NOT NULL,
    inicioT TIME NOT NULL,
    finT TIME NOT NULL,
    CONSTRAINT fk_turno_anio FOREIGN KEY (idAño) REFERENCES Año(idAño)
);

-- 4. Tabla Asistencia
-- Se relaciona con Turno (|| ------ |<) y Empleado (|| ------ |<)
CREATE TABLE Asistencia (
    idA SERIAL PRIMARY KEY,
    idE INTEGER NOT NULL, -- Llave foránea que viene de Empleado
    idT INTEGER NOT NULL, -- Llave foránea que viene de Turno
    fechaA DATE NOT NULL,
    diaA VARCHAR(20),
    esFeriadoA BOOLEAN DEFAULT FALSE,
    asistioA BOOLEAN DEFAULT FALSE,
    tardoA BOOLEAN DEFAULT FALSE,
    horaEntradaA TIME,
    horaSalidaA TIME,
    CONSTRAINT fk_asistencia_empleado FOREIGN KEY (idE) REFERENCES Empleado(idE),
    CONSTRAINT fk_asistencia_turno FOREIGN KEY (idT) REFERENCES Turno(idT)
);