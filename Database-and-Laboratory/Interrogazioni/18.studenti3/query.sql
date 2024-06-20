-- gli studenti che in tutte le materie hanno ricevuto un voto piu' alto di quello di tutti gli altri studenti della stessa classe

select codiceFiscale
from studente s0
where not exists (
    select * 
    from risultato r1
    where s0.codiceFiscale = r1.studente
    and exists (
        select *
        from risultato r2, studente s2
        where s2.codiceFiscale <> s0.codiceFiscale
        and s0.classe = s2.classe
        and r2.voto > r1.voto
        and r1.materia = r2.materia
    )
);

-- gli studenti che hanno insufficienza in 2 o 3 materie

select codiceFiscale
from studente s0
where exists (
    select *
    from risultato r1
    where s0.codiceFiscale = r1.studente
    and r1.voto < 6
    and exists (
        select *
        from risultato r2
        where s0.codiceFiscale = r2.studente
        and r2.voto < 6
        and r1.materia <> r2.materia
    )
)
except
select distinct r0.studente
from risultato r0, risultato r1, risultato r2, risultato r3
where r0.voto < 6 and r1.voto < 6 and r2.voto < 6 and r3.voto < 6
and r0.studente = r1.studente and r1.studente = r2.studente and r2.studente = r3.studente
and r0.materia <> r1.materia and r0.materia <> r2.materia and r0.materia <> r3.materia
and r1.materia <> r0.materia and r1.materia <> r2.materia and r1.materia <> r3.materia
and r2.materia <> r0.materia and r2.materia <> r1.materia and r2.materia <> r3.materia
and r3.materia <> r0.materia and r3.materia <> r2.materia and r3.materia <> r1.materia;