DROP DATABASE IF EXISTS pianeti;
CREATE DATABASE pianeti;
\c pianeti

/*Si immagini di dover progettare una base di dati che raccoglie informazioni sugli esopianeti (pianeti con caratteristiche simili alla Terra)
finora scoperti e sulle stelle attorno alle quali essi orbitano. La base di dati comprende le tabelle Stelle e Esopianeti.



La tabella Stelle ha due attributi:

• nome, che e una stringa di al piu 50 caratteri ed e la chiave primaria;

• classificazione, che e una stringa di al piu 50 caratteri, non nulla.



La tabella Esopianeti ha quattro attributi:

• nome, che e una stringa di al piu 50 caratteri ed e la chiave primaria;

• la stella attorno alla quale orbita, che e una stringa di al piu 50 caratteri, non nulla, ed e una chiave esterna che fa riferimento alla chiave 
  primaria della tabella Stelle;

• il parametro ESI (Earth Similarity Index), che e un valore decimale, non nullo, compreso tra 0 ("completamente diverso dalla Terra") ed 1 ("uguale 
  alla Terra");

• la distanza dalla Terra (espressa in anni luce), che e un valore decimale maggiore di 0 o nullo (nel caso non si sappia la distanza o il pianeta sia
  la Terra stessa).


Si scriva il codice SQL per creare e popolare le seguenti tabelle:*/

create table Stelle (
    nome varchar(50) primary key,
    classificazione varchar(50) not null
);

create table Esopianeti (
    nome varchar(50) primary key,
    stella_alla_quale_orbita varchar(50) not null,
    ESI real not null check ( ESI between 0 and 1),
    distanza_dalla_terra real check (distanza_dalla_terra > 0),
    foreign key (stella_alla_quale_orbita) references Stelle(nome)
        on update cascade
);

insert into Stelle(nome, classificazione) values
    ('sole', 'nana gialla'),
    ('teegarden', 'nana rossa'),
    ('trappist-1', 'nana rossa'),
    ('proxima century', 'nana rossa'),
    ('antares', 'supergigante rossa');

insert into Esopianeti(nome, stella_alla_quale_orbita, ESI, distanza_dalla_terra) values
    ('terra', 'sole', 1, null),
    ('trappist-1 d', 'trappist-1', 0.87, 39),
    ('proxima b', 'proxima century', 0.87, 4.22),
    ('teegarden b', 'teegarden', 0.93, 12.6);

/*Si ipotizzi che gli scienziati abbiano appena fatto dei calcoli piu precisi rivelando che la corretta distanza dalla Terra del pianeta teegarden b e
12.5 anni luce. Si scriva il codice SQL che effettua tale modifica.*/
update Esopianeti set distanza_dalla_terra = 12.5 where nome = 'teegarden b';

/*Si scriva il codice SQL per ordinare la tabella Esopianeti in ordine decrescente rispetto all'attributo ESI, escludendo la Terra. A parita di ESI, 
ordinare rispetto alla distanza crescente.*/
select *
from Esopianeti
where nome <> 'terra'
order by ESI desc, distanza_dalla_terra asc;