DROP DATABASE IF EXISTS officina;
CREATE DATABASE officina;
\c officina

create table Proprietario (
    cf char(16) primary key,
    nome varchar(50) not null,
    telefono char(10) unique not null                   -- stringa di 10 caratteri, unico e non nullo;
);

create table Auto (
    targa char(7) primary key,
    proprietario char(16),
    foreign key (proprietario) references Proprietario(cf)
        on update cascade
        on delete restrict
);

create domain dom_tipo_servizio as varchar(50)
    check (value in ('riparazione', 'sostituzione'));

create table Servizio (
    id integer check (id > 0),                          -- numero intero positivo, chiave primaria;
    tipo dom_tipo_servizio not null,                    -- riparazione” o “sostituzione”, non nullo
    data_inizio date not null,
    data_fine date check (data_fine > data_inizio),     -- data di fine del servizio, che deve essere successiva alla data di inizio;
    auto char(7) not null,
    foreign key (auto) references Auto(targa)
        on update cascade
        on delete restrict
);

/* Si scriva il codice SQL per inserire un nuovo proprietario ('RSSMRA80L01E200R', 'Mario Rossi', '3471234567')
e la sua auto targata 'AA123BB'. Motivare, se esiste, il corretto ordine delle operazioni necessarie per effet-
tuare i due inserimenti. */

-- E' necessario inserire prima il proprietaio altrimenti l'inserimento fallisce a causa della FK
insert into Proprietario(cf, nome, telefono) values ('RSSMRA80L01E200R', 'Mario Rossi', '3471234567');
insert into Auto(targa, proprietario) values ('AA123BB', 'RSSMRA80L01E200R');

/*Si scriva il codice SQL per inserire il servizio “1” iniziato il “2024-01-01” e terminato il “2024-01-04” sull’auto
'AA123BB' */
insert into Servizio(id, tipo, data_inizio, data_fine, auto) values (1, 'riparazione', '2024-01-01', '2024-01-04', 'AA123BB');

/*Si assuma che, a causa di un ritardo, il servizio “1” sia terminato il “2024-01-06”. Si scriva il codice SQL per
apportare tale modifica.*/
update Servizio set data_fine = '2024-01-06' where id = 1;