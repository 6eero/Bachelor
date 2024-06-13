DROP DATABASE IF EXISTS progetti;
CREATE DATABASE progetti;
\c progetti

create table Referenti (    -- sempre prima chi non ha fk
    matricola integer primary key,
    nome varchar(50) not null,
    cognome varchar(50) not null,
    dataNascita date not null
);

create domain dom_stato as varchar(50)
    check (value in ('proposto', 'attivo', 'terminato'));

create table Progetti (
    codice char(5) primary key,
    nome varchar(50) not null,
    numDipendenti integer not null check (numDipendenti > 0),
    referente integer,
    stato dom_stato not null,
    foreign key (referente) references Referenti(matricola)
        on delete set null  -- imposta il campo referente a null se il referente viene eliminato da Referenti
        on update cascade
);

insert into Referenti(matricola, nome, cognome, dataNascita) values 
    (1111, 'Mario', 'Rossi', '1985-09-03'),
    (2222, 'Franca', 'Gialli', '1972-07-05'),
    (3333, 'Luca', 'Verdi', '1990-12-27'),
    (4444, 'Anna', 'Rosa', '1987-12-16');

insert into Progetti(codice, nome, numDipendenti, referente, stato) values
    ('1aaa1', 'Lancio', 12, 1111, 'terminato'),
    ('2bbb2', 'Green Economy', 7, 1111, 'attivo'),
    ('3ccc3', 'Marte', 3, 3333, 'attivo'),
    ('4ddd4', 'AGI', 35, null, 'proposto');

/*Si scriva un’interrogazione SQL per cambiare da attivo a terminato lo stato di tutti i progetti in stato attivo*/
update Progetti set stato = 'terminato' where stato = 'attivo';