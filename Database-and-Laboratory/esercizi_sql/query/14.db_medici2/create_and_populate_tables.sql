DROP DATABASE IF EXISTS medici2;
CREATE DATABASE medici2;
\c medici2

-- Creazione della tabella MEDICO
CREATE TABLE MEDICO (
    MedicoId INT PRIMARY KEY,
    Nome VARCHAR(50),
    Cognome VARCHAR(50),
    Specializzazione VARCHAR(50),
    Genere VARCHAR(10),
    AnnoNascita INT,
    Reparto VARCHAR(50),
    CittaResidenza VARCHAR(50)
);

-- Creazione della tabella REPARTO
CREATE TABLE REPARTO (
    Nome VARCHAR(50) PRIMARY KEY,
    Edificio VARCHAR(50),
    Piano INT,
    Primario INT,
    FOREIGN KEY (Primario) REFERENCES MEDICO(MedicoId)
);

-- Creazione della tabella SI_TROVA_IN
CREATE TABLE SI_TROVA_IN (
    Citta VARCHAR(50) PRIMARY KEY,
    Regione VARCHAR(50)
);


-- Popolamento della tabella SI_TROVA_IN
INSERT INTO SI_TROVA_IN (Citta, Regione) VALUES
('Torino', 'Piemonte'),
('Biella', 'Piemonte'),
('Novara', 'Piemonte'),

('Venezia', 'Veneto'),
('Udine', 'Friuli Venezia Giulia'),
('Roma', 'Lazio');

-- Popolamento della tabella MEDICO
INSERT INTO MEDICO (MedicoId, Nome, Cognome, Specializzazione, Genere, AnnoNascita, Reparto, CittaResidenza) VALUES
(1, 'Mario', 'Rossi', 'Cardiologia', 'Maschio', 1970, 'Cardiologia', 'Torino'),
(2, 'Luigi', 'Bianchi', 'Chirurgia', 'Maschio', 1975, 'Chirurgia', 'Venezia'),

(3, 'Anna', 'Verdi', 'Ortopedia', 'Femmina', 1980, 'Ortopedia', 'Novara'),

(4, 'Paolo', 'Neri', 'Terapia Intensiva', 'Maschio', 1985, 'Terapia Intensiva', 'Udine'),
(5, 'Laura', 'Bruno', 'Cardiologia', 'Femmina', 1982, 'Cardiologia', 'Torino'),
(6, 'Giorgio', 'Gialli', 'Cardiologia', 'Maschio', 1978, 'Cardiologia', 'Roma'),
(7, 'Lucia', 'Viola', 'Chirurgia', 'Femmina', 1979, 'Chirurgia', 'Biella'),

(8, 'Maria', 'Rosa', 'Ginecologia', 'Femmina', 1975, 'Ginecologia', 'Torino'),
(9, 'Mattea', 'Verfina', 'Ginecologia', 'Femmina', 1939, 'Ginecologia', 'Biella'),
(10, 'Ettora', 'Rossina', 'Ginecologia', 'Femmina', 1934, 'Ginecologia', 'Novara');

-- Popolamento della tabella REPARTO
INSERT INTO REPARTO (Nome, Edificio, Piano, Primario) VALUES
('Cardiologia', 'Edificio A', 1, 1),
('Chirurgia', 'Edificio B', 2, 2),
('Ortopedia', 'Edificio C', 3, 3),
('Terapia Intensiva', 'Edificio D', 4, 4),
('Ginecologia', 'Edificio E', 5, 5);
