DROP DATABASE IF EXISTS prodotti;
CREATE DATABASE prodotti;
\c prodotti

create table Fornitore (
    codice integer primary key,
    data_contratto date not null
);

create table Prodotto (
    codice integer primary key,
    tipo varchar(50)
);

create table Disponibilita (
    fornitore integer,
    prodotto integer,
    data date not null,
    primary key (fornitore, prodotto),
    foreign key (fornitore) references Fornitore(codice)
        on update cascade
        on delete cascade,
    foreign key (prodotto) references Prodotto(codice)
        on update cascade
        on delete cascade
);
