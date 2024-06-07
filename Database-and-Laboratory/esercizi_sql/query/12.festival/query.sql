-- QUERY 1: i registi che hanno presentato il maggior numero di film in una 
--          stessa edizione di un qualche festival;
/*
create view HaPresentato as
select f.regista, f.codice, p.festival, p.anno
from film f, partecipazione p 
where f.codice = p.film
order by anno;

select distinct *
from HaPresentato h1
where exists (
    select *
    from HaPresentato h2
    where h1.regista = h2.regista
    and h1.festival = h2.festival
    and h1.anno = h2.anno 
    and h1.codice <> h2.codice
);

drop view HaPresentato;
*/
-- QUERY 2: i registi che hanno partecipato a tutte le edizioni del Festival del Cinema Muto.

-- non esiste un'ed. del cinema muto a cui il regista non ha partecipato
select distinct f.regista
from film f
where 
not exists (
    select *
    from partecipazione p1
    where p1.festival = 'Festival del cinema muto'
    and not exists (
        select *
        from partecipazione p2 join film f2 on p2.film = f2.codice
        where p1.anno = p2.anno and p1.festival = p2.festival
        and f.regista = f2.regista 
    )
);


select distinct f.regista
from film f
where 
not exists (
    select *
    from partecipazione p1
    where p1.festival = 'Festival del cinema muto'
    and not exists (
        select *
        from partecipazione p2, film f2
        where p2.film = f2.codice
        and p1.anno = p2.anno 
        and p1.festival = p2.festival
        and f.regista = f2.regista 
    )
);

