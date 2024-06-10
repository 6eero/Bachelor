DROP DATABASE studenti;
CREATE DATABASE studenti;
\c studenti

CREATE TABLE Studenti (
    Matricola VARCHAR(50) PRIMARY KEY,
    Nome VARCHAR(50),
    Cognome VARCHAR(50),
    AnnoNascita INT
);

CREATE TABLE Insegnamenti (
    Codice INT PRIMARY KEY,
    Materia VARCHAR(100),
    Docente VARCHAR(100),
    AnnoDiCorso INT
);

CREATE TABLE Esami (
    Studente VARCHAR(50),
    Insegnamento INT,
    Anno INT,
    Voto INT,
    PRIMARY KEY (Studente, Insegnamento),
    FOREIGN KEY (Studente) REFERENCES Studenti(Matricola),
    FOREIGN KEY (Insegnamento) REFERENCES Insegnamenti(Codice)
);

-- Popolazione della tabella Studenti
INSERT INTO Studenti (Matricola, Nome, Cognome, AnnoNascita)
VALUES
    ('Studente_1', 'Mario', 'Rossi', 1998),
    ('Studente_2', 'Giulia', 'Verdi', 1997),
    ('Studente_3', 'Luca', 'Bianchi', 1999),
    ('Studente_4', 'Pietro', 'Smusi', 2001),
    ('Studente_5', 'Anna', 'Neri', 2000),
    ('Studente_6', 'Maurizio', 'Gialli', 2003),
    ('Studente_7', 'Patrick', 'Spopovich', 1997),
    ('Studente_8', 'Matteo', 'Sasso', 1989),
    ('Studente_9', 'Jack', 'Rose', 1919);

-- Popolazione della tabella Insegnamenti
INSERT INTO Insegnamenti (Codice, Materia, Docente, AnnoDiCorso)
VALUES
    (1, 'Basi di Dati', 'Prof. Rossi', 1),
    (2, 'Analisi Matematica', 'Prof. Bianchi', 1),
    (3, 'Programmazione', 'Prof. Verdi', 2),
    (4, 'Sistemi Operativi', 'Prof. Neri', 3),
    (5, 'Reti', 'Prof. Marino', 2);

-- Popolazione della tabella Esami
INSERT INTO Esami (Studente, Insegnamento, Anno, Voto)
VALUES
    ('Studente_1', 1, 2020, 28),
    ('Studente_1', 2, 2023, 25), 
    ('Studente_1', 3, 2024, 30),

    ('Studente_2', 2, 2023, 30),
    ('Studente_2', 3, 2024, 28),

    ('Studente_3', 1, 2023, 27),
    ('Studente_3', 2, 2023, 26),
    ('Studente_3', 3, 2020, 29),

    ('Studente_4', 4, 2021, 19),
    ('Studente_4', 1, 2020, 28), 
    ('Studente_4', 2, 2021, 20),

    ('Studente_5', 1, 2023, 29),
    ('Studente_5', 2, 2020, 30),
    ('Studente_5', 3, 2020, 30),
    ('Studente_5', 5, 2024, 28),

    ('Studente_6', 1, 2021, 21),
    ('Studente_6', 2, 2021, 21),
    ('Studente_6', 5, 2021, 21),

    ('Studente_7', 1, 2021, 18),
    ('Studente_7', 2, 2021, 18),

    ('Studente_8', 3, 2021, 18),
    ('Studente_8', 5, 2021, 18),

    ('Studente_9', 5, 2021, 18);
