DROP DATABASE IF EXISTS giocatori;
CREATE DATABASE giocatori;
\c giocatori

/*Si immagini di voler progettare una base di dati che memorizza informazioni relative alle squadre partecipanti
ad un campionato di pallavolo. La base di dati è costituita da due tabelle: squadre e giocatori.

La tabella squadre è caratterizzata dai seguenti attributi: nome (stringa di al più 50 caratteri; è la chiave pri-
maria), anno fondazione (specifica quando la squadra è stata creata; può essere nullo) e capitano (identificativo
del giocatore che ha il ruolo di capitano nella stagione corrente; è chiave esterna verso giocatori, unica e non
nulla). 

La tabella giocatori è caratterizzata dai seguenti attributi: num cartellino (stringa di esattamente 5
caratteri; è la chiave primaria), nome (nome del giocatore, non nullo), ingaggio (ingaggio annuale del giocatore,
non nullo) e squadra (la squadra a cui il giocatore appartiene; è una chiave esterna che fa riferimento alla chiave
primaria di squadre e può essere nulla nel caso di giocatori temporaneamente svincolati).

Si scriva del codice SQL per creare (ma non popolare) le seguenti tabelle, usando dei tipi di attributo ragionevoli
in tutti quei casi in cui non siano stati esplicitamente specificati*/

create table Squadre (
    nome varchar(50) primary key,
    annoFondazione integer check (annoFondazione between 1900 and 2024),
    capitano char(5)
);

create table Giocatori (
    num_cartellino char(5) primary key,
    nome varchar(50) not null,
    ingaggio integer not null,
    squadra varchar(50),
    foreign key (squadra) references Squadre(nome)
    on update cascade
);

alter table Squadre
    add constraint fk_squadra_capitano
    foreign key (capitano) references Giocatori(num_cartellino);

insert into Giocatori(num_cartellino, nome, ingaggio, squadra) values ('c1111', 'Tizio', 105000, null);
insert into Giocatori(num_cartellino, nome, ingaggio, squadra) values ('c6666', 'Calpurnio', 75000, null);
insert into Giocatori(num_cartellino, nome, ingaggio, squadra) values ('c2222', 'Caio', 10000, null);
insert into Giocatori(num_cartellino, nome, ingaggio, squadra) values ('c3333', 'Sempronio', 80000, null);

insert into Squadre(nome, annoFondazione, capitano) values ('SiamoFortissimi', 1994, 'c1111');
insert into Squadre(nome, annoFondazione, capitano) values ('ANoiChiCiBatte', 1994, 'c2222');
insert into Squadre(nome, annoFondazione, capitano) values ('PerdiamoSempre', 1994, 'c3333');

update Giocatori set squadra = 'SiamoFortissimi' where num_cartellino = 'c1111';
update Giocatori set squadra = 'ANoiChiCiBatte' where num_cartellino = 'c2222';
update Giocatori set squadra = 'PerdiamoSempre' where num_cartellino = 'c3333';
update Giocatori set squadra = 'SiamoFortissimi' where num_cartellino = 'c6666';

insert into Giocatori(num_cartellino, nome, ingaggio, squadra) values ('sadf3', 'Ettore', 5000, 'PerdiamoSempre');
insert into Giocatori(num_cartellino, nome, ingaggio, squadra) values ('1234s', 'Maria', 1000, 'PerdiamoSempre');
insert into Giocatori(num_cartellino, nome, ingaggio, squadra) values ('sd2fc', 'Claudio', 10, 'PerdiamoSempre');

insert into Giocatori(num_cartellino, nome, ingaggio, squadra) values ('324ds', 'Claudio', 10, 'SiamoFortissimi');
insert into Giocatori(num_cartellino, nome, ingaggio, squadra) values ('sasd3', 'Adolfo', 10, 'SiamoFortissimi');
insert into Giocatori(num_cartellino, nome, ingaggio, squadra) values ('fvd32', 'Marco', 10, 'SiamoFortissimi');
insert into Giocatori(num_cartellino, nome, ingaggio, squadra) values ('dsc32', 'Eleno', 10, 'SiamoFortissimi');
insert into Giocatori(num_cartellino, nome, ingaggio, squadra) values ('dsv77', 'Marisa', 10, 'SiamoFortissimi');
insert into Giocatori(num_cartellino, nome, ingaggio, squadra) values ('1hj87', 'Ernesto', 10, 'SiamoFortissimi');
insert into Giocatori(num_cartellino, nome, ingaggio, squadra) values ('214cd', 'Samuele', 10, 'SiamoFortissimi');
insert into Giocatori(num_cartellino, nome, ingaggio, squadra) values ('dsiy7', 'Virgilio', 10, 'SiamoFortissimi');

/*Si ipotizzi di voler inserire un nuovo giocatore (PincoPallo) e la relativa squadra (IDisperati) (non presente nella
basi di dati). Si specifichi, se esiste, il corretto ordine delle operazioni necessarie per effettuare i due inserimenti,
motivando la risposta (non `e necessario scrivere il codice SQL).*/

insert into Giocatori(num_cartellino, nome, ingaggio, squadra) values ('cwe23', 'PincoPallo', 2113412, null);   -- il giocatore viene inserito con squadra null inizialmente
insert into Squadre(nome, annoFondazione, capitano) values ('IDisperati', 1994, 'cwe23');                       -- viene solo successivamente creata l sqaudra con lui come capitano
update Giocatori set squadra = 'IDisperati' where num_cartellino = 'cwe23';                                     -- infine viene aggiunto il giocatore alla squadra di cui e' capitano

/*Inoltre, si assuma che durante la sessione di mercato il giocatore Calpurnio sia stato venduto dalla squadra
SiamoFortissmi alla squadra ANoiChiCiBatte. Si scriva il codice SQL che effettua tale modifica.*/

update Giocatori set squadra = 'ANoiChiCiBatte' where nome = 'Calpurnio';

/*Infine, si immagini che al termine della stagione, la squadra PerdiamoSempre sia acquisita dalla squadra Siamo-
Fortissmi. Si scriva il codice SQL per spostare tutti i giocatori dalla squadra PerdiamoSempre alla squadra
SiamoFortissmi ed eliminare la squadra PerdiamoSempre dalla base di dati.*/

update Giocatori set squadra = 'SiamoFortissimi' where squadra = 'PerdiamoSempre';
delete from squadre where nome = 'PerdiamoSempre';