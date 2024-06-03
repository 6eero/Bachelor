DROP DATABASE studenti2;
CREATE DATABASE studenti2;
\c studenti2

CREATE TABLE Studente (
    Matricola INT PRIMARY KEY,
    Nome VARCHAR(50),
    Cognome VARCHAR(50),
    AnnoDiNascita INT,
    Telefono VARCHAR(15),
    Nazione VARCHAR(50)
);

CREATE TABLE Insegnamento (
    InsegnamentoId INT PRIMARY KEY,
    Nome VARCHAR(100),
    Docente VARCHAR(50),
    NumeroCrediti INT,
    AnnoDiCorso INT
);

CREATE TABLE HaSostenutoEsame (
    Studente INT,
    Insegnamento INT,
    Data DATE,
    Voto INT,
    PRIMARY KEY (Studente, Insegnamento, Data),
    FOREIGN KEY (Studente) REFERENCES Studente(Matricola),
    FOREIGN KEY (Insegnamento) REFERENCES Insegnamento(InsegnamentoId)
);

-- Inserimento dati nella tabella Studente
INSERT INTO Studente (Matricola, Nome, Cognome, AnnoDiNascita, Telefono, Nazione) VALUES
(1001, 'Mario', 'Rossi', 2000, '3331234567', 'Italia'),
(1002, 'Luca', 'Bianchi', 1999, '3332345678', 'Italia'),
(1003, 'Ana', 'Martinez', 2001, '3333456789', 'Spagna'),
(1004, 'John', 'Doe', 1998, '3334567890', 'USA'),
(1005, 'Hiroshi', 'Tanaka', 2002, '3335678901', 'Giappone');

-- Inserimento dati nella tabella Insegnamento
INSERT INTO Insegnamento (InsegnamentoId, Nome, Docente, NumeroCrediti, AnnoDiCorso) VALUES
(1, 'Analisi Matematica', 'Prof. Verdi', 9, 1),
(2, 'Fisica I', 'Prof. Bianchi', 6, 1),
(3, 'Programmazione I', 'Prof. Neri', 12, 1),
(4, 'Algoritmi e Strutture', 'Prof. Russo', 9, 2),
(5, 'Basi di Dati', 'Prof. Gialli', 6, 2),
(6, 'Fisica II', 'Prof. Rossi', 6, 2),
(7, 'Sistemi Operativi', 'Prof. Verdi', 9, 3);

-- Inserimento dati nella tabella HaSostenutoEsame
INSERT INTO HaSostenutoEsame (Studente, Insegnamento, Data, Voto) VALUES
(1001, 1, '2023-06-10', 28),
(1001, 2, '2023-07-15', 25),
(1001, 3, '2023-09-01', 30),
(1001, 5, '2024-03-05', 29),
(1001, 6, '2024-04-12', 26),
(1002, 1, '2023-06-11', 24),
(1002, 2, '2023-07-16', 27),
(1002, 3, '2023-09-02', 29),
(1002, 4, '2024-01-21', 28),
(1002, 5, '2024-03-06', 30),
(1002, 6, '2024-04-13', 30),
(1003, 1, '2023-06-12', 26),
(1003, 2, '2023-07-17', 28),
(1003, 3, '2023-09-03', 27),
(1003, 4, '2024-01-22', 30),
(1003, 5, '2024-03-07', 29),
(1003, 6, '2024-04-14', 28),
(1004, 1, '2023-06-13', 30),
(1004, 2, '2023-07-18', 29),
(1004, 3, '2023-09-04', 28),
(1004, 4, '2024-01-23', 27),
(1004, 5, '2024-03-08', 26),
(1004, 6, '2024-04-15', 25),
(1005, 1, '2023-06-14', 28),
(1005, 2, '2023-07-19', 30),
(1005, 3, '2023-09-05', 30);