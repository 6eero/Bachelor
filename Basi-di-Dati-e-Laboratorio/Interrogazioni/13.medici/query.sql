-- QUERY 1: reparti privi di medici di sesso maschile, con almeno due medici 
--          che risiedono nella citt`a di Trieste;

select distinct reparto
from medico m
where not exists (
    select *
    from medico m1
    where m1.genere = 'uomo'
    and m1.reparto = m.reparto
)
and exists (
    select *
    from medico m1
    where m1.reparto = m.reparto
    and m.medicoid <> m1.medicoid
    and m.cittaresidenza = 'Trieste'
    and m1.cittaresidenza = m.cittaresidenza   
);

-- QUERY 2: fra i reparti con almeno un medico di sesso femminile, 
--          quelli col minor numero di medici di sesso femminile.

create view numerodidonneperreparto as
select reparto, count(*) as numerodidonne
from medico m
where exists (
    select *
    from medico m1
    where m1.medicoid = m.medicoid
    and m1.genere = 'donna'
)
group by reparto;

select *
from numerodidonneperreparto n
where not exists (
    select *
    from numerodidonneperreparto n1
    where n1.numerodidonne < n.numerodidonne
    and n1.reparto <> n.reparto
);

drop view numerodidonneperreparto;