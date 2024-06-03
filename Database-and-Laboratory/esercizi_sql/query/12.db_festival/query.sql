-- QUERY 1: i registi che hanno presentato il maggior numero di film in una 
--          stessa edizione di un qualche festival;
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
-- QUERY 2: i registi che hanno partecipato a tutte le edizioni del Festival del Cinema Muto.