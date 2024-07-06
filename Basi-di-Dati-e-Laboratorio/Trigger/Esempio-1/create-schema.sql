DROP DATABASE IF EXISTS filmedvd;
CREATE DATABASE filmedvd;
\c filmedvd

create table Prodotto (
    id integer primary key,
    titolo varchar(40)
);

create table Libro (
    id integer primary key,
    pagine integer constraint num_pagine_valido check (pagine > 0),
    foreign key (id) references Prodotto(id) on update cascade on delete cascade
);

create table DVD (
    id integer primary key,
    durata integer constraint durata_valida check (durata > 0),
    foreign key (id) references Prodotto(id) on update cascade on delete cascade
);