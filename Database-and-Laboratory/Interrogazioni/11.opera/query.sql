-- QUERY 1: le opere che nel 2020 sono state inserite nel cartellone di esattamente 2 teatri;
/*
select *
from (
    select opera, count(*) as numeroinseriment
    from cartellone c1
    where anno = '2020'
    group by c1.opera
)
where numeroinseriment = 2;


select idopera, titolo
from opera o
where exists (
    select *
    from cartellone c
    where o.idopera = c.opera
    and exists (
        select *
        from cartellone c1
        where c1.opera = c.opera
        and c1.teatro <> c.teatro
    )
)
and not exists (
    select *
    from cartellone c1, cartellone c2, cartellone c3
    where c1.opera <> c2.opera and c2.opera <> c3.opera and c3.opera <> c1.opera
    and c1.opera = o.idopera and c2.opera = o.idopera and c3.opera = o.idopera
);


-- versione 1
select distinct opera
from cartellone as c
where anno = '2020'
and exists (                            -- esiste la stessa opera nello stesso anno ma in teatri diversi
    select * 
    from cartellone as c1
    where c1.opera=c.opera              -- la stessa opera
    and c1.anno=c.anno                  -- nello stesso anno
    and c1.teatro <> c.teatro           -- in teatri diversi --> vuol dire che sono due
   
    and not exists (                    -- non esiste 
        select *
        from cartellone as c2 
        where c2.opera=c1.opera         -- la stessa opera
        and c2.anno=c.anno              -- nello stesso anno
        and c2.teatro <> c1.teatro      -- in teatri diversi
        and c2.teatro <> c.teatro       -- in teatri diversi
    )
);


-- versione 2
select distinct c1.opera
from cartellone c1, cartellone c2 

-- almeno 2: esistono due entry in cui l'anno e' uguale (2020), l'opera e' uguale ma il teatro e' diverso
where c1.anno = 2020 
and c2.anno = 2020 

and c1.opera = c2.opera 

and c1.teatro <> c2.teatro

-- al massimo 2: non esistono tre entry in cui l'opera e' la stessa, l'anno e' lo stesso, ma il teatro e' diverso
and not exists (
    select *
    from cartellone c3
    where c2.opera = c3.opera
    --and c1.opera = c2.opera

    --and c1.anno = c2.anno
    and c2.anno = c3.anno

    --and c1.teatro <> c2.teatro
    and c2.teatro <> c3.teatro
    and c3.teatro <> c1.teatro
);
*/
-- QUERY 2:  i teatri che nella stagione 2020 avevano in cartellone tutte le opere presenti 
--           nel cartellone del 'teatro 2' di quell’anno.


select distinct teatro
from cartellone c1
where c1.teatro <> 'teatro 2'
and c1.anno = '2020'
and not exists (
    select *
    from cartellone c2
    where c2.teatro = 'teatro 2'
    and not exists (
        select *
        from cartellone c3
        where c3.teatro = c1.teatro
        and c3.opera = c2.opera
    )
);