DROP DATABASE IF EXISTS filmeattori;
CREATE DATABASE filmeattori;
\c filmeattori

CREATE TABLE FILM (
    CodiceFilm INT PRIMARY KEY,
    Titolo VARCHAR(100),
    Regista VARCHAR(100),
    Anno INT
);

CREATE TABLE ATTORE (
    CodiceAttore INT PRIMARY KEY,
    Cognome VARCHAR(100),
    Nome VARCHAR(100),
    Sesso CHAR(1),
    DataNascita DATE,
    Nazionalità VARCHAR(100)
);

CREATE TABLE INTERPRETAZIONE (
    Film INT,
    Attore INT,
    Ruolo VARCHAR(100),
    PRIMARY KEY (Film, Attore),
    FOREIGN KEY (Film) REFERENCES FILM(CodiceFilm),
    FOREIGN KEY (Attore) REFERENCES ATTORE(CodiceAttore)
);

-- Popolare la tabella FILM con dati fittizzi
INSERT INTO FILM (CodiceFilm, Titolo, Regista, Anno) VALUES
    (1, 'Rashomon', 'Akira Kurosawa', 1950),
    (2, 'I Sette Samurai', 'Akira Kurosawa', 1954),
    (3, 'Trono di Sangue', 'Gerry Scotti', 1957),
    (4, 'Barriera', 'Toshio Masuda', 1971),
    (5, 'Ran', 'Akira Kurosawa', 1985);

-- Popolare la tabella ATTORE con dati fittizzi
INSERT INTO ATTORE (CodiceAttore, Cognome, Nome, Sesso, DataNascita, Nazionalità) VALUES
    (1, 'Mifune', 'Toshiro', 'M', '1920-04-01', 'Giapponese'),
    (2, 'Shimura', 'Takashi', 'M', '1905-03-12', 'Giapponese'),
    (3, 'Kagawa', 'Kyōko', 'F', '1931-12-05', 'Giapponese'),
    (4, 'Nakadai', 'Tatsuya', 'M', '1932-12-13', 'Giapponese'),
    (5, 'Yamazaki', 'Tsutomu', 'M', '1936-12-31', 'Giapponese'),
    (6, 'Kawasaki', 'Suzuki', 'M', '1916-11-22', 'Giapponese');

-- Popolare la tabella INTERPRETAZIONE con dati fittizzi
INSERT INTO INTERPRETAZIONE (Film, Attore, Ruolo) VALUES
    (1, 1, 'Bandito'),
    (1, 2, 'Testimone'),
    (3, 1, 'Cecchino'),
    (2, 1, 'Rōnin'),
    (2, 2, 'Villaggio leader'),
 --   (2, 5, 'Samurai'),
    (3, 2, 'Comandante'),
--    (3, 4, 'Generale'),
    (4, 3, 'Venditore'),
    (4, 1, 'Clown'),
    (5, 1, 'Hidetora Ichimonji')
--    (5, 4, 'Saburo'),
--    (5, 5, 'Kyoami'),
--    (1, 6, 'Soldato'),
--   (2, 6, 'Sceriffo'),
--    (5, 6, 'Militare')
;