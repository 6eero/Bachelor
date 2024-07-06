DROP DATABASE turisti;
CREATE DATABASE turisti;
\c turisti

-- Creazione della tabella Turista
CREATE TABLE Turista (
    TuristaId INT PRIMARY KEY,
    AnnoNascita INT,
    Nazione VARCHAR(50)
);

-- Creazione della tabella SiTrovaIn
CREATE TABLE SiTrovaIn (
    Citta VARCHAR(100) PRIMARY KEY,
    Nazione VARCHAR(50)
);

-- Creazione della tabella HaVisitato
CREATE TABLE HaVisitato (
    TuristaId INT,
    Citta VARCHAR(100),
    Anno INT,
    PRIMARY KEY (TuristaId, Citta, Anno),
    FOREIGN KEY (TuristaId) REFERENCES Turista(TuristaId),
    FOREIGN KEY (Citta) REFERENCES SiTrovaIn(Citta)
);


-- Popolazione della tabella Turista
INSERT INTO Turista (TuristaId, AnnoNascita, Nazione) VALUES
(1, 1980, 'Italia'),
(2, 1990, 'Francia'),
(3, 1985, 'Italia'),
(4, 1992, 'Germania'),
(5, 1988, 'Italia'),
(6, 2001, 'Italia'),
(7, 1993, 'Francia'),
(8, 1972, 'Spagna');

-- Popolazione della tabella SiTrovaIn
INSERT INTO SiTrovaIn (Citta, Nazione) VALUES
('Roma', 'Italia'),
('Milano', 'Italia'),
('Parigi', 'Francia'),
('Marsiglia', 'Francia'),
('Lione', 'Francia'),
('Berlino', 'Germania'),
('Bucarest', 'Romania'),
('Madrid', 'Spagna');

-- Popolazione della tabella HaVisitato
INSERT INTO HaVisitato (TuristaId, Citta, Anno) VALUES
(1, 'Roma', 2018),
(1, 'Madrid', 2018),
(1, 'Parigi', 2019),
(1, 'Parigi', 2020),
(1, 'Milano', 2020),
(1, 'Madrid', 2020),
(1, 'Roma', 2019),
(1, 'Parigi', 2021),
(2, 'Parigi', 2018),
(2, 'Lione', 2021),
(3, 'Milano', 2019),
(3, 'Roma', 2019),
(3, 'Parigi', 2020),
(3, 'Marsiglia', 2020),
(3, 'Berlino', 2020),
(3, 'Lione', 2020),
(3, 'Roma', 2021),
(3, 'Marsiglia', 2021),
(4, 'Roma', 2018),
(4, 'Berlino', 2021),
(4, 'Milano', 2021),
(5, 'Madrid', 2018),
(5, 'Milano', 2019),
(5, 'Marsiglia', 2020),
(5, 'Lione', 2020),
(5, 'Parigi', 2020),
(5, 'Roma', 2020),
(5, 'Parigi', 2021),
(5, 'Berlino', 2021),
(5, 'Milano', 2021),
(6, 'Bucarest', 2019),
(7, 'Parigi', 2020),
(7, 'Marsiglia', 2020),
(7, 'Lione', 2020),
(7, 'Lione', 2021),
(8, 'Parigi', 2020),
(8, 'Lione', 2020);


