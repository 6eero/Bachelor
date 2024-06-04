DROP DATABASE IF EXISTS festival1;
CREATE DATABASE festival1;
\c festival1

-- Creazione delle tabelle
CREATE TABLE Film (
    Codice SERIAL PRIMARY KEY,
    Titolo VARCHAR(255) NOT NULL,
    Regista VARCHAR(255) NOT NULL,
    AnnoProduzione INT NOT NULL,
    UNIQUE (Titolo, Regista, AnnoProduzione)
);

CREATE TABLE Festival (
    NomeFestival VARCHAR(255) NOT NULL,
    Luogo VARCHAR(255) NOT NULL,
    Anno INT NOT NULL,
    PRIMARY KEY (NomeFestival, Anno)
);

CREATE TABLE Partecipazione (
    Film INT NOT NULL,
    Festival VARCHAR(255) NOT NULL,
    Anno INT NOT NULL,
    Posizione INT NOT NULL,
    PRIMARY KEY (Film, Festival, Anno),
    FOREIGN KEY (Film) REFERENCES Film(Codice),
    FOREIGN KEY (Festival, Anno) REFERENCES Festival(NomeFestival, Anno)
);

-- Popolamento delle tabelle con dati fittizi
INSERT INTO Film (Codice, Titolo, Regista, AnnoProduzione) VALUES
(1, 'Inception', 'Christopher Nolan', 2010),
(2, 'The Prestige', 'Christopher Nolan', 2006),
(3, 'The Dark Knight', 'Christopher Nolan', 2008),

(4, 'Pulp Fiction', 'Quentin Tarantino', 1994),
(5, 'Kill Bill: Vol. 1', 'Quentin Tarantino', 2003),
(6, 'Kill Bill: Vol. 2', 'Quentin Tarantino', 2004);

INSERT INTO Festival (NomeFestival, Luogo, Anno) VALUES
('Festival di Cannes', 'Cannes', 2020),
('Festival di Cannes', 'Cannes', 2021),
('Festival di Venice', 'Venice', 2020),
('Festival di Venice', 'Venice', 2021),
('Festival di Berlin', 'Berlin', 2020),
('Festival di Berlin', 'Berlin', 2021),
('Festival del cinema muto', 'Roma', 2020),
('Festival del cinema muto', 'Roma', 2021),
('Festival del cinema muto', 'Roma', 2022);

INSERT INTO Partecipazione (Film, Festival, Anno, Posizione) VALUES
(1, 'Festival di Cannes', 2020, 1),
(3, 'Festival di Cannes', 2020, 3),
(2, 'Festival di Cannes', 2021, 2),

(4, 'Festival di Venice', 2020, 1),
(3, 'Festival di Venice', 2020, 2),
(5, 'Festival di Venice', 2021, 1),

(4, 'Festival di Berlin', 2021, 1),
(5, 'Festival di Berlin', 2021, 1),
(6, 'Festival di Berlin', 2021, 1),
(1, 'Festival di Berlin', 2021, 2),

(1, 'Festival del cinema muto', 2020, 1),
(2, 'Festival del cinema muto', 2021, 2),
(3, 'Festival del cinema muto', 2022, 3),

(4, 'Festival del cinema muto', 2021, 1);
