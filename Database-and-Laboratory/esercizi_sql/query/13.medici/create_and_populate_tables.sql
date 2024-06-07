DROP DATABASE IF EXISTS medici;
CREATE DATABASE medici;
\c medici

CREATE TABLE reparto(
    nome varchar(50) primary key
);

CREATE TABLE medico(
    medicoid int primary key,
    specializzazione varchar(50),
    genere varchar(20),
    annonascita int,
    reparto varchar(50),
    foreign key(reparto) references reparto(nome),
    cittaresidenza varchar(50)
);

INSERT into reparto(nome) VALUES
('cardiologia'),
('oncologia'),
('ginecologia'),
('urologia');

INSERT into medico(medicoid, specializzazione, genere, annonascita, reparto, cittaresidenza) VALUES
(1, 'urologia', 'donna', 1900, 'urologia', 'Trieste'),
(2, 'urologia', 'donna', 1900, 'urologia', 'Trieste'),
(3, 'urologia', 'uomo', 1900, 'urologia', 'Udine'),
(4, 'cardiologia', 'donna', 1900, 'cardiologia', 'Trieste'),
(5, 'cardiologia', 'donna', 1900, 'cardiologia', 'Roma'),
(6, 'cardiologia', 'donna', 1900, 'cardiologia', 'Trieste'),
(7, 'oncologia', 'uomo', 1900, 'oncologia', 'Trieste');