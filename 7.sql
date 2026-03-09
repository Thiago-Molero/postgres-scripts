-- ELIMINAR TABLAS SI EXISTEN
DROP TABLE IF EXISTS Asistencia;
DROP TABLE IF EXISTS GrupoDisciplina;
DROP TABLE IF EXISTS Disciplina;
DROP TABLE IF EXISTS Cliente;

-- 1. TABLA CLIENTE
CREATE TABLE Cliente (
    idC SERIAL PRIMARY KEY,
    tipoDocumC VARCHAR(20) NOT NULL,
    nroDocumC VARCHAR(20) UNIQUE NOT NULL,
    nombresC VARCHAR(100) NOT NULL,
    paternoC VARCHAR(50) NOT NULL,
    maternoC VARCHAR(50),
    generoC VARCHAR(20),
    fechaNacimC DATE,
    enfermedadesC TEXT,
    celularC VARCHAR(15)
);

-- 2. TABLA DISCIPLINA
CREATE TABLE Disciplina (
    idD SERIAL PRIMARY KEY,
    nombreD VARCHAR(100) NOT NULL,
    descripcionD TEXT
);

-- 3. TABLA GRUPODISCIPLINA
CREATE TABLE GrupoDisciplina (
    idG SERIAL PRIMARY KEY,
    idD INTEGER NOT NULL,
    nombreG VARCHAR(100) NOT NULL,
    fechaInicioG DATE NOT NULL,
    fechaFinG DATE NOT NULL,
    CONSTRAINT fk_grupo_disciplina 
        FOREIGN KEY (idD) REFERENCES Disciplina(idD)
);

-- 4. TABLA ASISTENCIA
CREATE TABLE Asistencia (
    idA SERIAL PRIMARY KEY,
    idC INTEGER NOT NULL,
    idG INTEGER NOT NULL,
    fechaA DATE NOT NULL,
    diaA VARCHAR(20) NOT NULL,
    esFeriadoA BOOLEAN DEFAULT FALSE,
    asistioA BOOLEAN DEFAULT FALSE,
    horaEntradaA TIME,
    CONSTRAINT fk_asistencia_cliente 
        FOREIGN KEY (idC) REFERENCES Cliente(idC),
    CONSTRAINT fk_asistencia_grupo 
        FOREIGN KEY (idG) REFERENCES GrupoDisciplina(idG)
);

-- DATOS CLIENTE
INSERT INTO Cliente (tipoDocumC,nroDocumC,nombresC,paternoC,maternoC,generoC,fechaNacimC,enfermedadesC,celularC) VALUES
('DNI','71011111','Juan','Perez','Garcia','Masculino','1995-05-10','Ninguna','987111111'),
('DNI','71022222','Maria','Lopez','Torres','Femenino','1998-08-21','Asma','987222222'),
('DNI','71033333','Carlos','Ramirez','Flores','Masculino','1993-02-15','Diabetes','987333333'),
('DNI','71044444','Ana','Gutierrez','Salas','Femenino','2000-12-05','Ninguna','987444444');

-- DATOS DISCIPLINA
INSERT INTO Disciplina (nombreD,descripcionD) VALUES
('Yoga','Ejercicios de relajación y flexibilidad'),
('Crossfit','Entrenamiento físico de alta intensidad'),
('Spinning','Entrenamiento cardiovascular en bicicleta'),
('Pilates','Ejercicios para fortalecer el core');

-- DATOS GRUPO DISCIPLINA
INSERT INTO GrupoDisciplina (idD,nombreG,fechaInicioG,fechaFinG) VALUES
(1,'Yoga Mañana','2024-03-01','2024-06-30'),
(2,'Crossfit Avanzado','2024-03-01','2024-06-30'),
(3,'Spinning Tarde','2024-03-01','2024-06-30'),
(4,'Pilates Básico','2024-03-01','2024-06-30');

-- DATOS ASISTENCIA
INSERT INTO Asistencia (idC,idG,fechaA,diaA,esFeriadoA,asistioA,horaEntradaA) VALUES
(1,1,'2024-03-01','Viernes',FALSE,TRUE,'08:00'),
(2,1,'2024-03-01','Viernes',FALSE,TRUE,'08:05'),
(3,2,'2024-03-01','Viernes',FALSE,TRUE,'09:00'),
(4,4,'2024-03-02','Sabado',FALSE,FALSE,NULL);

-- CONSULTAS PARA VER DATA OUTPUT
SELECT * FROM Cliente;
SELECT * FROM Disciplina;
SELECT * FROM GrupoDisciplina;
SELECT * FROM Asistencia;
