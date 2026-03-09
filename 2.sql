-- ELIMINAR TABLAS SI EXISTEN
DROP TABLE IF EXISTS Asistencia;
DROP TABLE IF EXISTS Turno;
DROP TABLE IF EXISTS Empleado;
DROP TABLE IF EXISTS Año;

-- 1. TABLA AÑO
CREATE TABLE Año (
    idAño SERIAL PRIMARY KEY,
    inicioAño DATE NOT NULL,
    finAño DATE NOT NULL
);

-- 2. TABLA EMPLEADO
CREATE TABLE Empleado (
    idE SERIAL PRIMARY KEY,
    tipoDocumE VARCHAR(20) NOT NULL,
    nroDocumE VARCHAR(20) UNIQUE NOT NULL,
    nombresE VARCHAR(100) NOT NULL,
    paternoE VARCHAR(50) NOT NULL,
    maternoE VARCHAR(50),
    celularE VARCHAR(15),
    idSupervisor INTEGER,
    CONSTRAINT fk_empleado_supervisor 
        FOREIGN KEY (idSupervisor) REFERENCES Empleado(idE)
);

-- 3. TABLA TURNO
CREATE TABLE Turno (
    idT SERIAL PRIMARY KEY,
    idAño INTEGER NOT NULL,
    nombreT VARCHAR(50) NOT NULL,
    inicioT TIME NOT NULL,
    finT TIME NOT NULL,
    CONSTRAINT fk_turno_anio 
        FOREIGN KEY (idAño) REFERENCES Año(idAño)
);

-- 4. TABLA ASISTENCIA
CREATE TABLE Asistencia (
    idA SERIAL PRIMARY KEY,
    idE INTEGER NOT NULL,
    idT INTEGER NOT NULL,
    fechaA DATE NOT NULL,
    diaA VARCHAR(20),
    esFeriadoA BOOLEAN DEFAULT FALSE,
    asistioA BOOLEAN DEFAULT FALSE,
    tardoA BOOLEAN DEFAULT FALSE,
    horaEntradaA TIME,
    horaSalidaA TIME,
    CONSTRAINT fk_asistencia_empleado 
        FOREIGN KEY (idE) REFERENCES Empleado(idE),
    CONSTRAINT fk_asistencia_turno 
        FOREIGN KEY (idT) REFERENCES Turno(idT)
);

-- DATOS AÑO
INSERT INTO Año (inicioAño, finAño) VALUES
('2024-01-01','2024-12-31'),
('2025-01-01','2025-12-31');

-- DATOS EMPLEADO
INSERT INTO Empleado (tipoDocumE,nroDocumE,nombresE,paternoE,maternoE,celularE,idSupervisor) VALUES
('DNI','50011222','Carlos','Gomez','Ramos','987111111',NULL),
('DNI','50022333','Maria','Lopez','Salas','987222222',1),
('DNI','50033444','Pedro','Torres','Diaz','987333333',1),
('DNI','50044555','Lucia','Vargas','Perez','987444444',2),
('DNI','50055666','Juan','Rojas','Mendoza','987555555',2);

-- DATOS TURNO
INSERT INTO Turno (idAño,nombreT,inicioT,finT) VALUES
(1,'Mañana','08:00','16:00'),
(1,'Tarde','16:00','23:00'),
(2,'Mañana','08:00','16:00'),
(2,'Noche','23:00','07:00');

-- DATOS ASISTENCIA
INSERT INTO Asistencia (idE,idT,fechaA,diaA,esFeriadoA,asistioA,tardoA,horaEntradaA,horaSalidaA) VALUES
(2,1,'2024-03-01','Viernes',FALSE,TRUE,FALSE,'08:00','16:00'),
(3,1,'2024-03-01','Viernes',FALSE,TRUE,TRUE,'08:15','16:00'),
(4,2,'2024-03-01','Viernes',FALSE,TRUE,FALSE,'16:00','23:00'),
(5,2,'2024-03-02','Sabado',FALSE,TRUE,FALSE,'16:00','23:00'),
(2,1,'2024-03-02','Sabado',FALSE,FALSE,FALSE,NULL,NULL);

-- CONSULTAS PARA VER DATA OUTPUT
SELECT * FROM Año;
SELECT * FROM Empleado;
SELECT * FROM Turno;
SELECT * FROM Asistencia;
