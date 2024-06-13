DROP DATABASE IF EXISTS bovini;
CREATE DATABASE bovini;
\c bovini

/*Si voglia progettare una base di dati che memorizzi le seguenti informazioni sui bovini e i loro allevatori.

Per quanto riguarda i bovini:
- ogni bovino sia identificato da un codice alfanumerico di lunghezza 5;
- ogni bovino sia caratterizzato da data di nascita e informazione circa l’avvenuta o meno vaccinazione;
- un bovino non debba essere necessariamente associato ad un allevatore (possa essere in attesa di), ma non
  possa essere allevato da più di una persona per volta (si assuma che tale persona possa cambiare nel tempo,
  ma di tale informazione non si tenga traccia);
- un bovino possa appartenere ad una specifica razza; il consorzio gestisca esclusivamente le razze Pezzata
  Rossa Friulana, Chianina e Bruna.

L’allevatore sia identificato dal codice fiscale (16 caratteri) e sia caratterizzato da nome, cognome, data di
nascita e codice univoco della licenza. Un allevatore possa allevare più bovini contemporaneamente.

Si scriva del codice SQL che implementi le due tabelle bovino e allevatore, definendo gli opportuni vincoli di
integrità, relativi sia ai singoli attributi che ai legami fra le due tabelle, facendo delle assunzioni ragionevoli ove
necessario.*/

create domain dom_razza_bovino as varchar(50) 
    check (value in ('Pezzata Rossa Friulana', 'Chianina', 'Bruna'));

create table Allevatore (
    cf char(16) primary key,
    nome varchar(50) not null,
    cognome varchar(50) not null,
    data_nascita date not null,
    licenza char(5) unique not null
);

create table Bovino (
    codice char(5) primary key,
    data_nascita date not null,
    vaccinato boolean not null,
    razza dom_razza_bovino not null,
    allevatore char(16),
    foreign key (allevatore) references Allevatore(cf)  -- puo essere null
        on delete restrict
);

insert into Allevatore(cf, nome, cognome, data_nascita, licenza) values
    ('MRCRSS88E17A757Y', 'Marco', 'Rossi', '1988-01-01', 'BL001'),
    ('LCUBCH82C09L195L', 'Luca', 'Bianchi', '1988-01-01', 'UD123');

insert into Bovino(codice, data_nascita, vaccinato, razza, allevatore) values
    ('aaaa1', '2022-01-01', true, 'Chianina', 'MRCRSS88E17A757Y'),
    ('abb23', '2022-01-01', true, 'Chianina', 'MRCRSS88E17A757Y'),
    ('c12a1', '2022-01-01', false, 'Bruna', null);
    

/*Successivamente, si assuma che venga specificato un nuovo vincolo: un allevatore, per essere tale, debba necessariamente 
allevare almeno un bovino. Qualora violi tale vincolo, un allevatore non potrà essere presente nella base di dati (ad esempio, 
nel caso delle tabelle sopra riportate, il vincolo risulta violato dall’allevatore Luca Bianchi).

Si identifichino le operazioni (inserimento, cancellazione, modifica) sulle tabelle bovino e allevatore che diventano problematiche 
in ragione del nuovo vincolo, motivando la risposta.

(1) inserimento in Allevatore: viola il vincolo quando in Bovino non e' presente alcun bovino che ha lui come allevatore.
(2) canecellazione in Bovino: cancellando tutti i bovini di un allevatore esso rimane senza.
(3) modifica in Bovino: modificando tutti gli allevatori con lo stesso cf in un bovino puo accadere che un allevatore resti senza.

Si noti come la modifica in Allevatore non sia problematica: 
    update allevatore set cf = 'LCUBCH82C09L195L' where cf = 'MRCRSS88E17A757Y';
    ERROR:  duplicate key value violates unique constraint "allevatore_pkey"
    DETAIL:  Key (cf)=(LCUBCH82C09L195L) already exists.

Infine, si implementi un trigger SQL che gestisca una delle operazioni identificate.*/