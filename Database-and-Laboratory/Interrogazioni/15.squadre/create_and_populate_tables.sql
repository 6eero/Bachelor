DROP DATABASE IF EXISTS squadre;
CREATE DATABASE squadre;
\c squadre

-- Creazione delle tabelle

CREATE TABLE SITROVA (
    Citta VARCHAR(100) PRIMARY KEY,
    Regione VARCHAR(100)
);

CREATE TABLE SQUADRA (
    NomeSquadra VARCHAR(100) PRIMARY KEY,
    Citta VARCHAR(100),
    Allenatore VARCHAR(100),
    Presidente VARCHAR(100),
    AnnoFondazione INT,
    FOREIGN KEY (Citta) REFERENCES SITROVA(Citta)
);

CREATE TABLE GIOCATORE (
    CodiceGiocatore INT PRIMARY KEY,
    Cognome VARCHAR(100),
    Nome VARCHAR(100),
    Sesso CHAR(1),
    AnnoNascita INT,
    Nazionalita VARCHAR(100),
    Squadra VARCHAR(100),
    FOREIGN KEY (Squadra) REFERENCES SQUADRA(NomeSquadra)
);

-- Popolamento delle tabelle con dati fittizi

-- Popolamento della tabella SITROVA
INSERT INTO SITROVA (Citta, Regione) VALUES
('Milano', 'Lombardia'),
('Torino', 'Piemonte'),
('Roma', 'Lazio'),
('Napoli', 'Campania'),
('Firenze', 'Toscana');

-- Popolamento della tabella SQUADRA
INSERT INTO SQUADRA (NomeSquadra, Citta, Allenatore, Presidente, AnnoFondazione) VALUES
('AC Milan', 'Milano', 'Stefano Pioli', 'Paolo Scaroni', 1899),
('Inter', 'Milano', 'Simone Inzaghi', 'Steven Zhang', 1908),
('Juventus', 'Torino', 'Massimiliano Allegri', 'Andrea Agnelli', 1897),
('AS Roma', 'Roma', 'José Mourinho', 'Dan Friedkin', 1927),
('SSC Napoli', 'Napoli', 'Luciano Spalletti', 'Aurelio De Laurentiis', 1926),
('ACF Fiorentina', 'Firenze', 'Vincenzo Italiano', 'Rocco Commisso', 1926),;

-- Popolamento della tabella GIOCATORE
INSERT INTO GIOCATORE (CodiceGiocatore, Cognome, Nome, Sesso, AnnoNascita, Nazionalita, Squadra) VALUES
(1, 'Rossi', 'Luca', 'M', 1995, 'Italia', 'AC Milan'),
(2, 'Bianchi', 'Marco', 'M', 1979, 'Italia', 'Juventus'),
(3, 'Verdi', 'Giuseppe', 'M', 1985, 'Italia', 'AS Roma'),
(4, 'Neri', 'Andrea', 'M', 1998, 'Italia', 'SSC Napoli'),
(5, 'Gialli', 'Francesco', 'M', 1993, 'Italia', 'ACF Fiorentina'),
(6, 'Smith', 'John', 'M', 1992, 'Inghilterra', 'AC Milan'),
(7, 'Müller', 'Hans', 'M', 1991, 'Germania', 'Juventus'),
(8, 'Lopez', 'Carlos', 'M', 1994, 'Spagna', 'AS Roma'),
(9, 'Fernandez', 'Miguel', 'M', 1988, 'Argentina', 'SSC Napoli'),
(10, 'Santos', 'Rafael', 'M', 1996, 'Brasile', 'ACF Fiorentina');
