-- QUERY 1: l codice dei docenti che tengono il minor numero di corsi

create view numerocorsi as
select c.cod_docente, count(*) as numerocorsi
from corsi c
group by cod_docente;

select *
from numerocorsi n1
where not exists (
    select *
    from numerocorsi n2
    where n1.cod_docente <> n2.cod_docente
    and n2.numerocorsi < n1.numerocorsi
);


-- QUERY 2: i corsi di livello 2 frequentati solo da dottorandi che frequentano anche (almeno) un corso di livello 1

-- i corsi di livello 2, per i quali:
--      non esiste un dottorando che frequenta il corso candidato c (di livello 2) per cui 
--      non esiste un corso di livello 1 che il candidato c frequenta

create view freq as 
select f.cod_dottorando, f.cod_corso, c.grado_specializzazione 
from frequenta f, corsi c 
where c.cod_corso = f.cod_corso;

select *
from freq f1
where f1.grado_specializzazione = 2
and not exists (
    select *
    from freq f2
    where f2.grado_specializzazione = 2
    and not exists (
        select *
        from freq f3
        where f3.grado_specializzazione = 1
        and f3.cod_dottorando = f1.cod_dottorando
    )
);


-- QUERY 3: le coppie (docente,dottorando) tali che il dottorando segua tutti e soli i corsi tenuti dal docente

-- le coppie (docente,dottorando) tali che il dottorando segua tutti i corsi tenuti dal docente
-- le coppie (docente,dottorando) tali che non esiste un corso del docente candidato che il dottorando non segue

create view freq as
select c.corso, docente, dottorando
from corsi c, frequenta f
where f.corso = c.corso;

select distinct docente, dottorando
from freq f1
where not exists (                              -- non esiste
    select *
    from corsi c                                -- un corso
    where c.docente = f1.docente                -- del docente candidato
    and not exists (                            -- per cui non esiste
        select *
        from freq f2
        where f2.docente = c.docente
        and f2.corso = c.corso
        and f2.dottorando = f1.dottorando
    )
)
-- le coppie (docente,dottorando) tali che il dottorando segua soli corsi tenuti dallo stesso docente
-- non esistono due corsi tenuti da due docenti diversi seguiti dallo stesso dottorando candidato
and not exists (
    select *
    from freq f2
    where f2.docente <> f1.docente
    and f1.dottorando = f2.dottorando
);