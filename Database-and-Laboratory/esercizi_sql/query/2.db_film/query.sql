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

-- QUERY 4:  gli attori che non hanno recitato in alcun film di Akira Kurosawa;
-- non esiste un film di akira kurosawa in cui il candidato ha recitato

select distinct attore
from interpretazione i1
where not exists (
    select * 
    from film f 
    where f.regista = 'Akira Kurosawa'
    and exists (
        select *
        from interpretazione i2
        where i2.attore = i1.attore
        and i2.film = f.codicefilm
    )
);

-- QUERY 5:  per ogni regista, i film da lui/lei diretto col minor numero di attori;

create view numeroattori as
select film, regista, count(*) as numero_attori
from interpretazione i, film f
where i.film = f.codicefilm
group by film, regista;

-- non esiste un film, per il regista candidato, con il minor numero di attori
select *
from numeroattori n
where not exists (
    select *
    from numeroattori n1
    where n1.film < n.film
    and n1.regista = n.regista
);

drop view numeroattori;

-- QUERY 6: gli attori che hanno recitato in tutti i film di Akira Kurosawa e in almeno un film di un altro regista

--  non esiste un film di Kurosawa in cui l'attore candidato non ha recitato
select distinct attore
from interpretazione i1
where not exists (
    select *
    from film f
    where f.regista = 'Akira Kurosawa'
    and not exists (
        select *
        from interpretazione i2
        where i2.attore = i1.attore
        and i2.film = f.codicefilm
    )
)
-- esiste un film non di kurosawa in cui l'attore candidato ha recitato
and exists (
    select *
    from film f
    where f.regista <> 'Akira Kurosawa'
    and exists (
        select *
        from interpretazione i2
        where i2.attore = i1.attore
        and i2.film = f.codicefilm
    )
);