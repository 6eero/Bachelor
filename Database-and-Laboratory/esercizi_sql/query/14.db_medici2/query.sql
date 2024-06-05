
-- QUERY 1: i reparti tali che 
--          (i) tutti i medici afferenti risiedano in citta' della regione Piemonte
--          (ii) almeno uno di loro risieda nella citta' Torino;

-- (i) -> non esiste un medico che non risiede in una citta' del piemonte
select distinct reparto
from medico m
where not exists (
    select *
    from si_trova_in s
    where m.cittaresidenza = s.citta
    and s.regione <> 'Piemonte'
)
-- (ii) -> esiste almeno un medico che risiede a Torino
and exists (
    select *
    from medico m1
    where m1.medicoid = m.medicoid
    and m1.cittaresidenza = 'Torino'
);

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

