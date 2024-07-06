DROP DATABASE IF EXISTS studenti3;
CREATE DATABASE studenti3;
\c studenti3

-- Tabella STUDENTE
CREATE TABLE STUDENTE (
    codiceFiscale VARCHAR(16) PRIMARY KEY,
    nome VARCHAR(50),
    cognome VARCHAR(50),
    annoDiNascita INT,
    classe VARCHAR(3)
);

-- Tabella DOCENTE
CREATE TABLE DOCENTE (
    codiceFiscale VARCHAR(16) PRIMARY KEY,
    nome VARCHAR(50),
    cognome VARCHAR(50),
    annoDiNascita INT
);

-- Tabella MATERIA
CREATE TABLE MATERIA (
    nome VARCHAR(50) PRIMARY KEY,
    areaDisciplinare VARCHAR(50)
);

-- Tabella INSEGNA
CREATE TABLE INSEGNA (
    docente VARCHAR(16),
    materia VARCHAR(50),
    classe VARCHAR(3),
    PRIMARY KEY (docente, materia, classe),
    FOREIGN KEY (docente) REFERENCES DOCENTE(codiceFiscale),
    FOREIGN KEY (materia) REFERENCES MATERIA(nome)
);

-- Tabella RISULTATO
CREATE TABLE RISULTATO (
    studente VARCHAR(16),
    materia VARCHAR(50),
    voto INT,
    PRIMARY KEY (studente, materia),
    FOREIGN KEY (studente) REFERENCES STUDENTE(codiceFiscale),
    FOREIGN KEY (materia) REFERENCES MATERIA(nome)
);

-- Popolare la tabella STUDENTE
INSERT INTO STUDENTE (codiceFiscale, nome, cognome, annoDiNascita, classe) VALUES
('RSSMRA85M01H501Z', 'Mario', 'Rossi', 2005, '3A'),
('BNCLRA85M01H501Y', 'Laura', 'Bianchi', 2006, '3A'),
('VRDLGI85M01H501X', 'Luigi', 'Verdi', 2004, '3A'),
('BLUGFR85M01H501W', 'Francesca', 'Blu', 2005, '3A'),
('AMTUGFR85M01H5XX', 'Matteo', 'Neramerti', 2005, '3A'),
('NGRMRC85M01H501V', 'Marco', 'Neri', 2003, '3A');

-- Popolare la tabella DOCENTE
INSERT INTO DOCENTE (codiceFiscale, nome, cognome, annoDiNascita) VALUES
('GRDFNC75M01H501Z', 'Francesco', 'Grandi', 1975),
('BLMMRL70M01H501Y', 'Mariella', 'Belli', 1970),
('RZZMRG80M01H501X', 'Giorgio', 'Rizzo', 1980),
('NVDLRA85M01H501W', 'Lara', 'Nevada', 1985);

-- Popolare la tabella MATERIA
INSERT INTO MATERIA (nome, areaDisciplinare) VALUES
('Matematica', 'Scientifica'),
('Italiano', 'Linguistica'),
('Storia', 'Umanistica'),
('Fisica', 'Scientifica'),
('Inglese', 'Linguistica');

-- Popolare la tabella INSEGNA
INSERT INTO INSEGNA (docente, materia, classe) VALUES
('GRDFNC75M01H501Z', 'Matematica', '3A'),
('GRDFNC75M01H501Z', 'Fisica', '3A'),
('BLMMRL70M01H501Y', 'Italiano', '3A'),
('RZZMRG80M01H501X', 'Storia', '4B'),
('NVDLRA85M01H501W', 'Inglese', '3A'),
('NVDLRA85M01H501W', 'Inglese', '4B');

-- Popolare la tabella RISULTATO
INSERT INTO RISULTATO (studente, materia, voto) VALUES
('RSSMRA85M01H501Z', 'Matematica', 10),
('RSSMRA85M01H501Z', 'Italiano', 10),
('RSSMRA85M01H501Z', 'Storia', 10),
('RSSMRA85M01H501Z', 'Fisica', 10),
('RSSMRA85M01H501Z', 'Inglese', 10),

('AMTUGFR85M01H5XX', 'Matematica', 3),
('AMTUGFR85M01H5XX', 'Italiano', 2),
('AMTUGFR85M01H5XX', 'Storia', 4),
('AMTUGFR85M01H5XX', 'Fisica', 5),
('AMTUGFR85M01H5XX', 'Inglese', 1),

('BNCLRA85M01H501Y', 'Matematica', 10),
('BNCLRA85M01H501Y', 'Italiano', 4),
('BNCLRA85M01H501Y', 'Storia', 4),
('BNCLRA85M01H501Y', 'Fisica', 1),
('BNCLRA85M01H501Y', 'Inglese', 2),

('VRDLGI85M01H501X', 'Storia', 3),
('VRDLGI85M01H501X', 'Inglese', 3),

('BLUGFR85M01H501W', 'Matematica', 5),
('BLUGFR85M01H501W', 'Italiano', 4),
('BLUGFR85M01H501W', 'Fisica', 1),

('NGRMRC85M01H501V', 'Inglese', 1);

