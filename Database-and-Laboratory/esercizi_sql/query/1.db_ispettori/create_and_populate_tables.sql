CREATE DATABASE ispettori;
\c ispettori

-- Creazione della tabella ISPETTORE
CREATE TABLE ISPETTORE (
    CF_ispettore VARCHAR(20) PRIMARY KEY,
    Grado VARCHAR(50),
    AnnoNascita INT
);

-- Creazione della tabella HA_CONTROLLATO
CREATE TABLE HA_CONTROLLATO (
    Ispettore VARCHAR(20),
    Azienda VARCHAR(50),
    Anno INT,
    Valutazione INT,
    FOREIGN KEY (Ispettore) REFERENCES ISPETTORE(CF_ispettore),
    PRIMARY KEY (Ispettore, Azienda, Anno)
);

-- Creazione della tabella SI_TROVA_IN
CREATE TABLE SI_TROVA_IN (
    Azienda VARCHAR(50),
    Città VARCHAR(50),
    PRIMARY KEY (Azienda),
    FOREIGN KEY (Azienda) REFERENCES HA_CONTROLLATO(Azienda)
);

-- Popolamento della tabella ISPETTORE
INSERT INTO ISPETTORE (CF_ispettore, Grado, AnnoNascita) VALUES
('CF1', 'Capo ispettore', 1980),
('CF2', 'Ispettore', 1985),
('CF3', 'Ispettore', 1990),
('CF4', 'Ispettore', 1988);

-- Popolamento della tabella HA_CONTROLLATO
INSERT INTO HA_CONTROLLATO (Ispettore, Azienda, Anno, Valutazione) VALUES
('CF1', 'Azienda1', 2013, 8),
('CF1', 'Azienda2', 2013, 7),
('CF2', 'Azienda1', 2013, 9),
('CF2', 'Azienda3', 2013, 6),
('CF3', 'Azienda2', 2013, 8),
('CF3', 'Azienda3', 2013, 7),
('CF4', 'Azienda1', 2013, 6),
('CF4', 'Azienda2', 2013, 8);

-- Popolamento della tabella SI_TROVA_IN
INSERT INTO SI_TROVA_IN (Azienda, Città) VALUES
('Azienda1', 'Roma'),
('Azienda2', 'Milano'),
('Azienda3', 'Napoli');
