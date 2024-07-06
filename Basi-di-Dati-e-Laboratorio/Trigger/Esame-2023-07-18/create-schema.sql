DROP DATABASE IF EXISTS archeologia;
CREATE DATABASE archeologia;
\c archeologia

/*Si immagini di voler progettare una base di dati che memorizza informazioni relative ai reperti archeologici esposti 
e conservati nelle sale di un museo.

Ogni reperto sia identificato da un codice alfanumerico di lunghezza 5. Di ogni reperto si vogliono memorizzare la data in cui è 
stato scoperto e la data in cui è stato consegnato al museo, con l’accortezza che la seconda sia sempre successiva alla prima. 
Di ogni reperto si vuole sapere la collocazione, ovvero la sala in cui è esposto (questo attributo non può essere nullo).

Ogni sala è identificata da un codice di al più tre cifre ed è caratterizzata dal nome (che può essere nullo), dall’apertura o meno 
al pubblico e dalla capacità espositiva, ovvero il numero massimo di manufatti che la sala può ospitare (tale valore viene espresso 
mediante un numero intero maggiore di zero). Esiste una sala speciale, chiamata magazzino, che ospita i reperti non esposti in altre 
sale, la cui capacità espositiva si assume essere illimitata (per semplicità, un intero molto grande).

Si scriva il codice SQL per definire le due tabelle reperto e sala, definendo gli opportuni vincoli di integrità, sia interrelazionali 
che dei singoli attributi, facendo ragionevoli assunzioni dove non espressamente specificato.*/


create table Sala (
    codice integer check (codice < 999 and codice > 0) primary key,
    nome varchar(50),
    aperta boolean not null,
    capacita_expo integer check (capacita_expo > 0)
);

create table Reperto (
    codice char(5) primary key,
    data_scoperta date,
    data_consegna date check (data_consegna > data_scoperta),
    collocazione integer not null,
    foreign key (collocazione) references Sala(codice)
        on update cascade
        on delete restrict
);

insert into Sala(codice, nome, aperta, capacita_expo) values (100, 'Magazzino', false, 999999);
insert into Reperto(codice, data_scoperta, data_consegna, collocazione) values ('c12a1', '2024-01-01', '2024-01-04', 100);

/*Si ipotizzi di voler inserire un nuovo reperto (bb123) e, contestualmente, si realizzi una nuova sala espositiva (Antica
Grecia), non gia presente nella basi di dati, ove inserire tale reperto. Si scriva il codice SQL per lo svolgimento di
tali operazioni, tenendo conto del loro ordine di esecuzione.*/

insert into Sala(codice, nome, aperta, capacita_expo) values (101, 'Antica Grecia', true, 3);
insert into Reperto(codice, data_scoperta, data_consegna, collocazione) values ('bb123', '2024-01-01', '2024-01-04', 101);

/*Successivamente, si scriva il codice SQL per cancellare dalla base di dati il reperto c12a1.*/
delete from Reperto where codice = 'c12a1';