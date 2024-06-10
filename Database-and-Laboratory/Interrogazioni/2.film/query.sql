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

select i1.attore, i2.attore, f1.codicefilm
from interpretazione i1, interpretazione i2, film f1
where f1.regista = 'Akira Kurosawa'
and i1.attore < i2.attore
and i1.film = f1.codicefilm
and i2.film = f1.codicefilm
and not exists (
    select *
    from interpretazione i3, interpretazione i4, film f2
    where f2.regista = 'Akira Kurosawa'
    and i3.attore = i1.attore
    and i4.attore = i2.attore
    and i3.film = f2.codicefilm
    and i4.film = f2.codicefilm
    and f2.codicefilm <> f1.codicefilm
);

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


-- QUERY 7: gli attori che hanno recitato solo in film di Kurosawa
-- non esiste un film f1, il cui regista non e' kurosawa, per cui esiste un attore, uguale al candidato, che ha recitato in quel film f1

select distinct attore
from interpretazione i1
where not exists (
    select *
    from film f1
    where f1.regista <> 'Akira Kurosawa'
    and exists (
        select *
        from interpretazione i2
        where i1.attore = i2.attore
        and i2.film = f1.codicefilm
    )
);


-- QUERY 8: gli attori che hanno recitato in tutti i film di Kurosawa;
-- non esiste un film di Kurosawa per cui non esiste un attore uguale al candidato che ha recitato in quel film

select distinct attore
from interpretazione i1
where not exists (
    select *
    from film f1
    where f1.regista = 'Akira Kurosawa'
    and not exists (
        select *
        from interpretazione i2
        where i1.attore = i2.attore
        and i2.film = f1.codicefilm
    )
);


-- QUERY 9: gli attori che hanno recitato in tutti e soli i film di Kurosawa.
-- AND delle soluzioni sopra

select distinct attore
from interpretazione i1
where not exists (
    select *
    from film f1
    where f1.regista <> 'Akira Kurosawa'
    and exists (
        select *
        from interpretazione i2
        where i1.attore = i2.attore
        and i2.film = f1.codicefilm
    )
)
and not exists (
    select *
    from film f1
    where f1.regista = 'Akira Kurosawa'
    and not exists (
        select *
        from interpretazione i2
        where i1.attore = i2.attore
        and i2.film = f1.codicefilm
    )
);


-- QUERY 10: gli attori che hanno recitato in al massimo due film diretti dal regista 'Akira Kurosawa' (2, 3, 4, 5)
-- non eistono tre film diversi con regista kurosawa per cui lo stesso candidato attore ha recitato

create view harecitato as
select i.film, i.attore, f.regista
from interpretazione i, film f
where i.film = f.codicefilm;

select *
from harecitato h1
where  not exists (
    select *
    from harecitato h2, harecitato h3
    where h1.film <> h2.film and h2.film <> h3.film and h3.film <> h1.film  -- tre film diversi
    and h2.regista = 'Akira Kurosawa' and h3.regista = 'Akira Kurosawa'     -- con regista kurosawa
    and h1.attore = h2.attore and h2.attore = h3.attore                     -- con lo stesso attore
);

-- QUERY 11: le coppie di attori diversi tali che esista un film in cui il primo ha recitato e il secondo no, e viceversa.

select distinct i1.attore, i2.attore
from interpretazione i1, interpretazione i2
where i1.attore <> i2.attore
and exists (
    select *
    from interpretazione i3
    where i3.attore = i1.attore
    and not exists (
        select *
        from interpretazione i4
        where i4.film = i3.film
        and i4.attore =i2.attore
    )
)
and exists (
    select *
    from interpretazione i5
    where i5.attore = i2.attore
    and not exists (
        select *
        from interpretazione i6
        where i6.film = i5.film
        and i6.attore = i1.attore
    )
);
