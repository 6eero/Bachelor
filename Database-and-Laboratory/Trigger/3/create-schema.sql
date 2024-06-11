DROP DATABASE IF EXISTS ricercatori;
CREATE DATABASE ricercatori;
\c ricercatori

create table Dipartimento (
    id_dip varchar(5) primary key,
    nome_dip varchar(50),
    universita varchar(50),
    direttore varchar(50)
);

create table Ricercatore (
    nome varchar(50) primary key,
    eta integer,
    afferenza varchar(5),
    foreign key (afferenza) references Dipartimento(id_dip)
        on update cascade
        on delete restrict
);

insert into Dipartimento(id_dip, nome_dip, universita, direttore) values
    ('id111', 'Computer Science', 'Stanford University', 'Donald Knuth'),
    ('id000', 'Computer Science', 'Cambridge University', 'Alan Turing'),
    ('id222', 'Computer Science', 'California Insitute of Technology', 'Jhon McCarthy'),
    ('id333', 'Computer Science', 'Carnegie Mellon University', 'Lukas Marcovich');

insert into Ricercatore(nome, eta, afferenza) values
    ('Alan Turing', 41, 'id000'),
    ('Donald Knuth', 82, 'id111'),
    ('Jhon McCarthy', 84, 'id222'),
    ('Robert Tarjan', 72, 'id222');

-- si scriva codice corrispondente allo spostamento del ricercatore Robert Tarjan dal California Insitute of Technology 
-- verso la Stanford University
-- update Ricercatore set afferenza = 'id111' where nome = 'Robert Tarjan'; 

-- versione piu dettagliata:
update Ricercatore set afferenza = (
    select id_dip
    from Dipartimento
    where universita = 'Stanford University'
) 
where nome = 'Robert Tarjan'; 