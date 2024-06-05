-- QUERY 1: gli attori che hanno recitato nel maggior numero di film;
create view numerorecitazioni as
select attore, count(*) as recitazioni
from interpretazione
group by attore;

select attore
from numerorecitazioni n 
where not exists (
    select *
    from numerorecitazioni n1
    where n1.attore <> n.attore
    and n1.recitazioni > n.recitazioni
);

drop view numerorecitazioni;

-- QUERY 2: con riferimento ai soli film del regista Akira Kurosawa, gli attori che hanno recitato assieme in al massimo un film

-- ????????????????????????

-- QUERY 3: gli attori che hanno recitato solo in film di Akira Kurosawa, ma non in tutti.

-- non esiste un film dell' attore candidato, che ha regista diverso da kurosawa
select distinct attore
from interpretazione i1
where not exists (
    select *
    from interpretazione i2, film f
    where i2.film = f.codicefilm
    and f.regista <> 'Akira Kurosawa'
    and i1.attore = i2.attore
)
-- esiste almeno un film di Akira Kurosawa in cui il candidato non ha recitato
and exists (
    select * 
    from film f 
    where f.regista = 'Akira Kurosawa'
    and not exists (
        select *
        from interpretazione i2
        where i2.attore = i1.attore
        and i2.film = f.codicefilm
    )
);
