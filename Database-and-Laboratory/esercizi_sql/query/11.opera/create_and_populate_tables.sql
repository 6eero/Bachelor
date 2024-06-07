DROP DATABASE IF EXISTS opera;
CREATE DATABASE opera;
\c opera

-- Creazione delle tabelle
CREATE TABLE OPERA (
    IdOpera INT PRIMARY KEY,
    Titolo VARCHAR(100),
    Compagnia VARCHAR(100),
    Regista VARCHAR(100),
    AnnoProduzione INT
);

CREATE TABLE STAGIONE (
    NomeTeatro VARCHAR(100),
    Anno INT,
    PRIMARY KEY (NomeTeatro, Anno)
);

CREATE TABLE CARTELLONE (
    Opera INT,
    Teatro VARCHAR(100),
    Anno INT,
    FOREIGN KEY (Opera) REFERENCES OPERA(IdOpera),
    FOREIGN KEY (Teatro, Anno) REFERENCES STAGIONE(NomeTeatro, Anno)
);

-- Popolamento delle tabelle con dati fittizzi
INSERT INTO OPERA (IdOpera, Titolo, Compagnia, Regista, AnnoProduzione)
VALUES 
    (1, 'La traviata', 'compagnia 1', 'Franco Zeffirelli', 2005),
    (2, 'Romeo e Giulietta', 'compagnia 2', 'Luca Ronconi', 2010),
    (3, 'Hamlet', 'compagnia 3', 'Kenneth Branagh', 2000),
    (4, 'La boheme', 'compagnia 4', 'Franco Zeffirelli', 1996),
    (5, 'Il pianto', 'compagnia 5', 'Ettore Di Assisi', 2001);

INSERT INTO STAGIONE (NomeTeatro, Anno)
VALUES 
    ('teatro 1', 2019),
    ('teatro 1', 2020),
    ('teatro 2', 2020),
    ('teatro 3', 2020),
    ('teatro 4', 2020);

INSERT INTO CARTELLONE (Opera, Teatro, Anno)
VALUES 
    (1, 'teatro 1', 2020),
    (1, 'teatro 3', 2020),

    (2, 'teatro 2', 2020),
    (2, 'teatro 1', 2020),
    (2, 'teatro 4', 2020),

    (3, 'teatro 3', 2020),

    (4, 'teatro 1', 2019),
    (4, 'teatro 3', 2020),
    (4, 'teatro 2', 2020),

    (4, 'teatro 4', 2020),
    (1, 'teatro 4', 2020);

