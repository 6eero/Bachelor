DROP DATABASE IF EXISTS torneo;
CREATE DATABASE torneo;
\c torneo

CREATE TABLE NAZIONALE (
    Nazione VARCHAR(50) PRIMARY KEY,
    Allenatore VARCHAR(50) UNIQUE NOT NULL,
    PosizioneRanking INT UNIQUE NOT NULL
);

CREATE TABLE PARTITA (
    Nazionale1 VARCHAR(50),
    GoalNazionale1 INT,
    Nazionale2 VARCHAR(50),
    GoalNazionale2 INT,
    Stadio VARCHAR(50),
    Data DATE,
    PRIMARY KEY (Nazionale1, Nazionale2, Data),
    FOREIGN KEY (Nazionale1) REFERENCES NAZIONALE(Nazione),
    FOREIGN KEY (Nazionale2) REFERENCES NAZIONALE(Nazione)
);

-- Inserimento dati nella tabella NAZIONALE
INSERT INTO NAZIONALE (Nazione, Allenatore, PosizioneRanking) VALUES
('Italia', 'Roberto Mancini', 1),
('Belgio', 'Roberto Martinez', 2),
('Francia', 'Didier Deschamps', 3),
('Germania', 'Joachim Low', 4),
('Spagna', 'Luis Enrique', 5);

-- Inserimento dati nella tabella PARTITA
INSERT INTO PARTITA (Nazionale1, GoalNazionale1, Nazionale2, GoalNazionale2, Stadio, Data) VALUES
('Germania', 2, 'Belgio', 1, 'Stadio Olimpico', '2024-05-01'),
('Francia', 1, 'Germania', 1, 'King Baudouin Stadium', '2024-05-02'),
('Spagna', 3, 'Italia', 2, 'Santiago Bernabeu', '2024-05-03'),
('Belgio', 2, 'Spagna', 0, 'King Baudouin Stadium', '2024-05-04'),
('Francia', 2, 'Italia', 2, 'Stade de France', '2024-05-05'),
('Belgio', 1, 'Germania', 3, 'King Baudouin Stadium', '2024-05-06'),
('Germania', 2, 'Italia', 7, 'King Baudouin Stadium', '2024-05-07');

