-- ELIMINAR TABLAS SI EXISTEN
DROP TABLE IF EXISTS Asistencia;
DROP TABLE IF EXISTS Ambiente;
DROP TABLE IF EXISTS Calendario;
DROP TABLE IF EXISTS Enfermero;

-- 1. TABLA ENFERMERO
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

-- 2. TABLA CALENDARIO
CREATE TABLE Calendario (
    idC SERIAL PRIMARY KEY,
    inicioC DATE NOT NULL,
    finC DATE NOT NULL,
    nombreC VARCHAR(100) NOT NULL
);

-- 3. TABLA AMBIENTE
CREATE TABLE Ambiente (
    idAmb SERIAL PRIMARY KEY,
    nroAmb VARCHAR(20) NOT NULL,
    ubicacionAmb VARCHAR(150) NOT NULL
);

-- 4. TABLA ASISTENCIA
CREATE TABLE Asistencia (
    idA SERIAL PRIMARY KEY,
    idE INTEGER NOT NULL,
    idC INTEGER NOT NULL,
    idAmb INTEGER NOT NULL,
    fechaA DATE NOT NULL,
    diaA VARCHAR(20) NOT NULL,
    asistioA BOOLEAN DEFAULT FALSE,
    tardoA BOOLEAN DEFAULT FALSE,
    horaEntradaA TIME,
    horaSalidaA TIME,
    justificacionA TEXT,
    esDescansoA BOOLEAN DEFAULT FALSE,
    CONSTRAINT fk_asistencia_enfermero 
        FOREIGN KEY (idE) REFERENCES Enfermero(idE),
    CONSTRAINT fk_asistencia_calendario 
        FOREIGN KEY (idC) REFERENCES Calendario(idC),
    CONSTRAINT fk_asistencia_ambiente 
        FOREIGN KEY (idAmb) REFERENCES Ambiente(idAmb)
);

-- DATOS ENFERMERO
INSERT INTO Enfermero (tipoDocumE,nroDocumE,nombresE,paternoE,maternoE,fechaNacimientoE,generoE) VALUES
('DNI','50011111','Ana','Perez','Gomez','1990-05-12','Femenino'),
('DNI','50022222','Carlos','Ramirez','Torres','1988-09-21','Masculino'),
('DNI','50033333','Lucia','Fernandez','Rojas','1992-03-10','Femenino'),
('DNI','50044444','Miguel','Lopez','Salas','1985-11-30','Masculino');

-- DATOS CALENDARIO
INSERT INTO Calendario (inicioC,finC,nombreC) VALUES
('2024-01-01','2024-06-30','Primer Semestre 2024'),
('2024-07-01','2024-12-31','Segundo Semestre 2024');

-- DATOS AMBIENTE
INSERT INTO Ambiente (nroAmb,ubicacionAmb) VALUES
('A101','Primer Piso - Emergencias'),
('B202','Segundo Piso - Hospitalización'),
('C303','Tercer Piso - UCI');

-- DATOS ASISTENCIA
INSERT INTO Asistencia (idE,idC,idAmb,fechaA,diaA,asistioA,tardoA,horaEntradaA,horaSalidaA,justificacionA,esDescansoA) VALUES
(1,1,1,'2024-03-01','Viernes',TRUE,FALSE,'08:00','16:00',NULL,FALSE),
(2,1,2,'2024-03-01','Viernes',TRUE,TRUE,'08:20','16:00','Tráfico intenso',FALSE),
(3,1,3,'2024-03-02','Sabado',TRUE,FALSE,'08:00','16:00',NULL,FALSE),
(4,1,1,'2024-03-02','Sabado',FALSE,FALSE,NULL,NULL,'Descanso médico',TRUE);

-- CONSULTAS PARA VER DATOS
SELECT * FROM Enfermero;
SELECT * FROM Calendario;
SELECT * FROM Ambiente;
SELECT * FROM Asistencia;
