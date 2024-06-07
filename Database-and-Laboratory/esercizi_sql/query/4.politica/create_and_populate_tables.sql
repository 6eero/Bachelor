DROP DATABASE politica;
CREATE DATABASE politica;
\c politica

-- Creazione della tabella Politici
CREATE TABLE Politici (
    CodiceFiscale VARCHAR(20) PRIMARY KEY,
    Nome VARCHAR(50),
    Cognome VARCHAR(50),
    AnnoNascita INT
);

-- Creazione della tabella Partiti
CREATE TABLE Partiti (
    NomePartito VARCHAR(100) PRIMARY KEY,
    Segretario VARCHAR(50),
    Sede VARCHAR(100)
);

-- Creazione della tabella Eletti
CREATE TABLE Eletti (
    Politico VARCHAR(20),
    Partito VARCHAR(100),
    AnnoElezione INT,
    PRIMARY KEY (Politico, AnnoElezione),
    FOREIGN KEY (Politico) REFERENCES Politici(CodiceFiscale),
    FOREIGN KEY (Partito) REFERENCES Partiti(NomePartito)
);

-- Inserimento di dati fittizzi nella tabella Politici
INSERT INTO Politici (CodiceFiscale, Nome, Cognome, AnnoNascita) VALUES
('1', 'Mario', 'Rossi', 1975),
('2', 'Anna', 'Bianchi', 1980),
('3', 'Luca', 'Verdi', 1968),
('4', 'Laura', 'Neri', 1985),
('5', 'Matteo', 'Fucsia', 1992),
('6', 'Sandro', 'Grigi', 1995),
('7', 'Pietro', 'Gialli', 1998),
('8', 'Franco', 'Violi', 1999);

-- Inserimento di dati fittizzi nella tabella Partiti
INSERT INTO Partiti (NomePartito, Segretario, Sede) VALUES
('Partito A', 'Giuseppe', 'Roma'),
('Partito B', 'Carla', 'Milano'),
('Partito C', 'Antonio', 'Napoli');

-- Inserimento di dati fittizzi nella tabella Eletti
INSERT INTO Eletti (Politico, Partito, AnnoElezione) VALUES
('1', 'Partito A', 1998),
('2', 'Partito B', 1998),
('3', 'Partito A', 1998),
('4', 'Partito B', 1998),
('1', 'Partito A', 1999),
('1', 'Partito B', 2002),
('2', 'Partito C', 2002),
('3', 'Partito C', 2002),
('4', 'Partito A', 2002),
('1', 'Partito C', 2006),
('2', 'Partito B', 2006),
('3', 'Partito A', 2006),
('4', 'Partito C', 2006),
('3', 'Partito A', 2020),
('5', 'Partito A', 2020),
('8', 'Partito B', 2020), 
('6', 'Partito B', 2020),
('7', 'Partito B', 2020), 
('1', 'Partito C', 2020);
