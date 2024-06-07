DROP DATABASE navi;
CREATE DATABASE navi;
\c navi

-- Creazione delle tabelle
CREATE TABLE Porto (
    Citta VARCHAR(50) PRIMARY KEY,
    Nazione VARCHAR(50)
);

CREATE TABLE Banchina (
    Numero INT,
    Porto VARCHAR(50),
    Lunghezza INT,
    PRIMARY KEY (Numero, Porto),
    FOREIGN KEY (Porto) REFERENCES Porto(Citta)
);

CREATE TABLE TipoNave (
    NomeTipo VARCHAR(50) PRIMARY KEY,
    NumeroPasseggeri INT,
    QuantitaMerci INT
);

CREATE TABLE Nave (
    CodNave VARCHAR(50) PRIMARY KEY,
    TipoNave VARCHAR(50),
    AnnoCostruzione INT,
    FOREIGN KEY (TipoNave) REFERENCES TipoNave(NomeTipo)
);

CREATE TABLE CorsaGiornaliera (
    IdCorsa INT PRIMARY KEY,
    GiornoSettimana VARCHAR(20),
    CittaPartenza VARCHAR(50),
    OraPartenza TIME,
    CittaArrivo VARCHAR(50),
    OraArrivo TIME,
    Nave VARCHAR(50),
    FOREIGN KEY (CittaPartenza) REFERENCES Porto(Citta),
    FOREIGN KEY (CittaArrivo) REFERENCES Porto(Citta),
    FOREIGN KEY (Nave) REFERENCES Nave(CodNave)
);

-- Inserimento dati fittizi
INSERT INTO Porto (Citta, Nazione) VALUES
('Trieste', 'Italia'),
('Genova', 'Italia'),
('Roma', 'Italia'),
('Ancona', 'Italia'),
('Messina', 'Italia'),
('Marsiglia', 'Francia');

INSERT INTO Banchina (Numero, Porto, Lunghezza) VALUES
(1, 'Trieste', 300),
(2, 'Trieste', 200),
(1, 'Genova', 400),
(1, 'Marsiglia', 350),
(1, 'Roma', 300),
(1, 'Ancona', 100);

INSERT INTO TipoNave (NomeTipo, NumeroPasseggeri, QuantitaMerci) VALUES
('Crociera', 2000, 5000),
('Sottomarino', 120, 1000),
('Vela', 25, 10),
('Remi', 2, 5),
('Cargo', 0, 20000);

INSERT INTO Nave (CodNave, TipoNave, AnnoCostruzione) VALUES
('N001', 'Crociera', 2010),
('N002', 'Cargo', 2005),
('N003', 'Sottomarino', 2015),
('N004', 'Vela', 1442),
('N005', 'Remi', 2011);


INSERT INTO CorsaGiornaliera (IdCorsa, GiornoSettimana, CittaPartenza, OraPartenza, CittaArrivo, OraArrivo, Nave) VALUES
(1, 'Lunedi', 'Trieste', '08:00', 'Genova', '12:00', 'N001'),
(2, 'Mercoledi', 'Marsiglia', '10:00', 'Trieste', '14:00', 'N001'),
(3, 'Martedi', 'Genova', '09:00', 'Marsiglia', '13:00', 'N002'),
(4, 'Venerdi', 'Roma', '14:00', 'Trieste', '9:30', 'N003'),
(5, 'Venerdi', 'Messina', '17:00', 'Ancona', '2:30', 'N003'),
(6, 'Domenica', 'Messina', '11:00', 'Roma', '7:10', 'N004'),
(7, 'Lunedi', 'Ancona', '14:00', 'Genova', '10:45', 'N005'),
(8, 'Sabato', 'Genova', '1:00', 'Roma', '11:30', 'N005');

