DROP DATABASE IF EXISTS vino;
CREATE DATABASE vino;
\c vino

-- Si consideri un azienda vinicola che utilizza una base di dati per raccogliere informazioni riguardanti le botti, e i vini in esse conservati, attualmente 
-- presenti in cantina. La base di dati contenga le tabelle Vini e Botti. La tabella Vini abbia i seguenti attributi:
-- il nome del vino, che è una stringa di al più 50 caratteri ed è la chiave primaria;
-- la tipologia di vino (rosso, bianco, rosé, ecc.), che è una stringa di al più 50 caratteri;
-- La tabella Botti contenga i seguenti attributi:
-- il codice della botte, che è un numero intero compreso tra 0 e 9999, ed è la chiave primaria;
-- il vino contenuto nella botte, che è una stringa di al più 50 caratteri ed è una chiave esterna che fa riferimento alla chiave primaria della tabella Vini;
-- la gradazione del vino, che è un numero floating-point non nullo.
-- Si scriva il codice SQL per creare e popolare le seguenti tabelle.

create domain dom_tipologia_vino varchar(50)
    check(value in ('rosso', 'bianco', 'rosé'));

create table Vini (
    nome varchar(50) primary key,
    tipologia dom_tipologia_vino not null
);

create table Botti (
    codice integer check (codice between 0 and 9999) primary key,
    vino varchar(50),
    gradazione real check (gradazione > 0) not null,
    foreign key (vino) references Vini(nome)
);

insert into Vini(nome, tipologia) values
    ('cabernet', 'rosso'),
    ('merlot', 'rosso'),
    ('riesling', 'bianco'),
    ('tocai', 'bianco');

insert into Botti(codice, vino, gradazione) values
    (0000, 'cabernet', 13),
    (0001, 'merlot', 10),
    (0002, 'cabernet', 12.5);

/*Si aggiorni la tabella Botti in modo che la botte con codice 0002 abbia gradazione 13*/
update Botti set gradazione = 13 where codice = 0002;