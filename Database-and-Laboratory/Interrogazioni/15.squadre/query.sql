-- QUERY 1: le squadre i cui giocatori sono tutti nati dal 1990 in poi
-- non esiste un giocatore della squadra candidata che e' nato prima del 1990

select *
from squadra s
where not exists (
    select *
    from giocatore g
    where g.squadra = s.nomesquadra
    and g.annonascita < '1990'
);

-- QUERY 2: le regioni col maggior numero di squadre;
-- non esiste una regione diversa dalla candidata che ha piu squadre della candidata

create view numerosquadre as
select si.regione, count(*) as numero_squadre
from sitrova si, squadra sq
where si.citta = sq.citta
group by regione;

select *
from numerosquadre n1
where not exists (
    select *
    from numerosquadre n2
    where n1.regione <> n2.regione
    and n2.numero_squadre > n1.numero_squadre
);

-- QUERY 3: le coppie di squadre(x, y) tali che esistano:
--          (i) almeno una nazionalita presente fra i giocatori di x e non fra i giocatori di y,
--          (ii) almeno una nazionalita presente fra i giocatori di y e non fra i giocatori di x.