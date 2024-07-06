DROP DATABASE IF EXISTS maratona;
CREATE DATABASE maratona;
\c maratona

-- Creazione delle tabelle
CREATE TABLE Maratoneta (
    CodiceMaratoneta INT PRIMARY KEY,
    Nome VARCHAR(50),
    Cognome VARCHAR(50),
    MigliorePrestazione INT
);

CREATE TABLE Maratona (
    Nome VARCHAR(50) PRIMARY KEY,
    Citta VARCHAR(50)
);

CREATE TABLE SiTrovaIn (
    Citta VARCHAR(50) PRIMARY KEY,
    Nazione VARCHAR(50)
);

CREATE TABLE EdizioneMaratona (
    Nome VARCHAR(50),
    Anno INT,
    PRIMARY KEY (Nome, Anno),
    FOREIGN KEY (Nome) REFERENCES Maratona(Nome)
);

CREATE TABLE Vincitore (
    Atleta INT,
    Maratona VARCHAR(50),
    Anno INT,
    PRIMARY KEY (Atleta, Maratona, Anno),
    FOREIGN KEY (Atleta) REFERENCES Maratoneta(CodiceMaratoneta),
    FOREIGN KEY (Maratona, Anno) REFERENCES EdizioneMaratona(Nome, Anno)
);

-- Popolamento delle tabelle con dati fittizi
INSERT INTO Maratoneta (CodiceMaratoneta, Nome, Cognome, MigliorePrestazione)
VALUES 
    (1, 'Mario', 'Rossi', 9000),
    (2, 'Luca', 'Bianchi', 8500),
    (3, 'Laura', 'Verdi', 9200),
    (4, 'Giacomo', 'Leopardi', 9100);

INSERT INTO Maratona (Nome, Citta)
VALUES 
    ('Maratona di Berlino', 'Berlino'),
    ('Maratona di Amburgo', 'Amburgo'),
    ('Maratona di Roma', 'Roma'),
    ('Maratona di Parigi', 'Parigi'),
    ('Maratona di New York', 'New York');

INSERT INTO SiTrovaIn (Citta, Nazione)
VALUES 
    ('Berlino', 'Germania'),
    ('Amburgo', 'Germania'),
    ('Roma', 'Italia'),
    ('Parigi', 'Francia'),
    ('New York', 'USA');

INSERT INTO EdizioneMaratona (Nome, Anno)
VALUES 
    ('Maratona di Berlino', 2020),
    ('Maratona di Berlino', 2021),
    ('Maratona di Berlino', 2022),
    ('Maratona di Berlino', 2023),

    ('Maratona di Amburgo', 2020),
    ('Maratona di Amburgo', 2021),

    ('Maratona di Roma', 2022),
    ('Maratona di Roma', 2023),

    ('Maratona di New York', 2020),
    ('Maratona di New York', 2021),
    ('Maratona di New York', 2022),

    ('Maratona di Parigi', 2022),
    ('Maratona di Parigi', 2023);

INSERT INTO Vincitore (Atleta, Maratona, Anno)
VALUES 
    (1, 'Maratona di Berlino', 2020),
    (1, 'Maratona di Berlino', 2021),
    (1, 'Maratona di Berlino', 2022),
    (2, 'Maratona di Berlino', 2023),

    (3, 'Maratona di Roma', 2022),
    (2, 'Maratona di Roma', 2023),

    (3, 'Maratona di Amburgo', 2020),
    (3, 'Maratona di Amburgo', 2021),

    (3, 'Maratona di New York', 2020),
    (3, 'Maratona di New York', 2021),
    (3, 'Maratona di New York', 2022),

    (4, 'Maratona di Parigi', 2022),
    (4, 'Maratona di Parigi', 2023);