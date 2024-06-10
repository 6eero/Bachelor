DROP DATABASE IF EXISTS scacchi;
CREATE DATABASE scacchi;
\c scacchi

CREATE TABLE Torneo (
    NomeTorneo VARCHAR(50) PRIMARY KEY,
    Citta VARCHAR(50)
);

CREATE TABLE SiTrovaIn (
    Citta VARCHAR(50) PRIMARY KEY,
    Nazione VARCHAR(50)
);

CREATE TABLE Scacchista (
    CodiceScacchista INT PRIMARY KEY,
    Nome VARCHAR(50),
    Cognome VARCHAR(50),
    DataDiNascita DATE,
    Nazione VARCHAR(50)
);

CREATE TABLE EdizioneTorneo (
    NomeTorneo VARCHAR(50),
    Anno INT,
    Vincitore INT,
    PRIMARY KEY (NomeTorneo, Anno),
    FOREIGN KEY (NomeTorneo) REFERENCES Torneo(NomeTorneo),
    FOREIGN KEY (Vincitore) REFERENCES Scacchista(CodiceScacchista)
);

INSERT INTO Torneo (NomeTorneo, Citta) 
VALUES 
('Torneo_A', 'Imperia'),
('Torneo_B', 'Foggia'),
('Torneo_C', 'Barcellona');


INSERT INTO SiTrovaIn (Citta, Nazione) 
VALUES 
('Imperia', 'Italia'),
('Foggia', 'Italia'),
('Barcellona', 'Spagna');


INSERT INTO Scacchista (CodiceScacchista, Nome, Cognome, DataDiNascita, Nazione)
VALUES
(1, 'Mario', 'Rossi', '1990-01-01', 'Italia'),
(2, 'Luigi', 'Verdi', '1985-03-15', 'Francia'),
(3, 'Giovanni', 'Bianchi', '1995-07-20', 'Germania'),
(4, 'Veronica', 'Martino', '1995-01-10', 'Francia');


INSERT INTO EdizioneTorneo (NomeTorneo, Anno, Vincitore)
VALUES 
('Torneo_A', 2020, 1),
('Torneo_A', 2021, 2),
('Torneo_A', 2022, 1),
('Torneo_B', 2020, 3),
('Torneo_B', 2021, 2),
('Torneo_B', 2022, 2),
('Torneo_B', 2023, 4),
('Torneo_C', 2022, 3);
