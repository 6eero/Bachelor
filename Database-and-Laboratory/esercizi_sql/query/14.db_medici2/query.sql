
-- QUERY 1: i reparti tali che 
--          (i) tutti i medici afferenti risiedano in citta' della regione Piemonte
--          (ii) almeno uno di loro risieda nella citta' Torino;

-- (i) -> non esiste un medico che non risiede in una citta' del piemonte (ortopedia, ginecologia)

create view medicoo as
select medicoid, reparto, cittaresidenza, regione 
from medico m, si_trova_in s 
where m.cittaresidenza = s.citta;

select distinct reparto
from medicoo d
where not exists (
    select *
    from medicoo d1
    where d1.reparto = d.reparto
    and d1.regione <> 'Piemonte'
)
-- (ii) -> esiste almeno un medico che risiede a Torino (ginecologia)
and exists (
    select *
    from medico m1
    where m1.medicoid = d.medicoid
    and m1.cittaresidenza = 'Torino'
);

drop view medicoo;

-- QUERY 2: i reparti con lo stesso numero di medici del reparto di terapia intensiva

create view numeromedicinelrepartoterapiaintensiva as
select reparto, count(*) as numero_medici
from medico
where reparto = 'Terapia Intensiva'
group by reparto;

create view numeromedicinelreparto as
select m.reparto, count(*) as numero_medici
from medico m
group by reparto;

select n1.reparto
from numeromedicinelrepartoterapiaintensiva n, numeromedicinelreparto n1
where n1.reparto <> 'Terapia Intensiva'
and n.numero_medici = n1.numero_medici;

-- QUERY 2: i reparti i cui medici risiedono solo in citta' del Piemonte, ma non in tutte

-- (i) -> non esiste un medico che non risiede in una citta' del piemonte (ortopedia, ginecologia)

-- soluzione con la view:
/*
create view medicoo as select medicoid, reparto, cittaresidenza, regione from medico m, si_trova_in s where m.cittaresidenza = s.citta;
select distinct reparto
from medicoo d
where not exists (
    select *
    from medicoo d1
    where d1.reparto = d.reparto
    and d1.regione <> 'Piemonte'
)
drop view medicoo;
*/

-- soluzione senza view:
select distinct reparto
from medicoo d, si_trova_in s
where d.cittaresidenza = s.citta
and not exists (
    select *
    from medicoo d1
    where d1.reparto = d.reparto
    and d1.regione <> 'Piemonte'
)
-- esiste una citta del Piemonte in cui nessun medico abita (ortopedia)
and exists (
    select *
    from si_trova_in s
    where s.regione = 'Piemonte'
    and s.citta not in (
        select d2.cittaresidenza
        from medico d2
        where d2.reparto = d.reparto
    )
);

-- QUERY 4: i reparti in cui sono presenti sia medici di sesso femminile che medici di sesso maschile, 
--          tutti nati dopo il 1960 (al piu 59 anni);

-- esiste un medico maschio con anno nascita > 1960
-- siste un medico femmina con anno nascita > 1960
-- nello stesso reparto

select distinct reparto
from medico m
where exists (
    select *
    from medico m1
    where m1.medicoid = m.medicoid
    and m1.genere = 'Maschio'
    and m1.annonascita > 1960
    and exists (
        select *
        from medico m2
        where m2.reparto = m1.reparto
        and m2.genere = 'Femmina'
        and m2.annonascita > 1960
    )
);

-- QUERY 5: (FACOLTATIVO) i reparti col numero piu' alto di medici di sesso femminile.

create view donneneireparti as
select reparto, count(*) as numerodonne
from medico m
where m.genere = 'Femmina'
group by reparto;

select reparto
from donneneireparti d
where not exists (
    select *
    from donneneireparti d1
    where d.reparto <> d1.reparto
    and d1.numerodonne > d.numerodonne
);

drop view donneneireparti;