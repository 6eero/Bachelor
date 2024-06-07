drop database if exists dottorandi;
create database dottorandi;
\c dottorandi

-- Creazione delle tabelle
CREATE TABLE CORSI (
    corso VARCHAR(100) PRIMARY KEY,
    docente VARCHAR(100),
    Materia VARCHAR(100),
    Grado_specializzazione INT
);

CREATE TABLE DOTTORANDI (
    dottorando VARCHAR(100) PRIMARY KEY,
    Nome_dottorando VARCHAR(100),
    Cognome_dottorando VARCHAR(100),
    Area_interesse VARCHAR(100)
);

CREATE TABLE FREQUENTA (
    dottorando VARCHAR(100),
    corso VARCHAR(100),
    FOREIGN KEY (dottorando) REFERENCES DOTTORANDI(dottorando),
    FOREIGN KEY (corso) REFERENCES CORSI(corso)
);

-- Popolamento della tabella CORSI con dati fittizi
INSERT INTO CORSI (corso, docente, Materia, Grado_specializzazione) VALUES
(1, 'docente_1', 'Intelligenza Artificiale', 3),
(3, 'docente_1', 'Matematica', 3),
(4, 'docente_1', 'Geografia', 3),

(2, 'docente_2', 'Big Data', 2),
(7, 'docente_2', 'Arte', 2);

-- Popolamento della tabella DOTTORANDI con dati fittizi
INSERT INTO DOTTORANDI (dottorando, Nome_dottorando, Cognome_dottorando, Area_interesse) VALUES
('dottorando_1', 'Mario', 'Rossi', 'Intelligenza Artificiale'),
('dottorando_2', 'Luigi', 'Bianchi', 'Big Data'),
('dottorando_3', 'Matteo', 'Neri', 'Storia');

-- Popolamento della tabella FREQUENTA con dati fittizi
INSERT INTO FREQUENTA (dottorando, corso) VALUES
('dottorando_1', 1),
('dottorando_1', 3),
('dottorando_1', 4),
('dottorando_1', 7),

('dottorando_2', 2),
('dottorando_2', 4),

('dottorando_3', 2),
('dottorando_3', 7);
