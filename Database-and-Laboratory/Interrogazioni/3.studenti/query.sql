-- QUERY 1: gli studenti che non hanno superato neanche un esame del secondo anno;
/*
SELECT Matricola, Nome
FROM Studenti S0
WHERE NOT EXISTS (
      SELECT *
      FROM Insegnamenti I1, Esami E1
      WHERE I1.Codice  = E1.Insegnamento 
      AND I1.AnnoDiCorso = 2 
      AND S0.Matricola = E1.studente
);

-- QUERY 2: gli studenti che hanno superato almeno tutti gli esami superati dallo studente 
--          con matricola 17890714 -> non esiste un esame di 17890714 che il candidato S0 
--                                    non ha fatto

SELECT S0.Matricola
FROM Studenti S0
WHERE NOT EXISTS (
      SELECT *
      FROM Esami E1
      WHERE E1.Studente = '17890714' 
      AND NOT EXISTS (
            SELECT *
            FROM Esami E2
            WHERE E2.Studente = S0.Matricola 
            AND E2.Insegnamento = E1.Insegnamento
            )
);

-- QUERY 3: gli studenti tali che esista almeno un insegnamento del quale sono stati gli unici
--          a superare l’esame nell’anno 2020

SELECT DISTINCT studente
FROM Esami E1
WHERE anno = '2020' 
AND NOT EXISTS (
      SELECT * 
      FROM Esami E2 
      WHERE E2.Studente <> E1.Studente 
      AND E2.Insegnamento = E1.Insegnamento 
      AND E2.anno = E1.anno
);

-- QUERY 4: fra tutti gli studenti che hanno superato almeno un esame, lo studente (gli studenti se 
--          piu di uno) che ha superato il minor numero di esami;

SELECT *
FROM Esami E1
WHERE NOT EXISTS (
      SELECT *
      FROM ESAMI E2
      WHERE E1.Insegnamento <> E2.Insegnamento
      AND E1.Studente = E2.Studente
);
*/

-- QUERY 5: gli studenti che hanno superato tutti gli esami superati da 'Studente_7' (si assuma che tale studente abbia superato almeno un esame)


CREATE VIEW EsamiSuperatiDa7 AS
SELECT Insegnamento
FROM Esami
WHERE Studente = 'Studente_7';

SELECT E1.Studente
FROM Esami E1
WHERE NOT EXISTS (
    SELECT *
    FROM EsamiSuperatiDa7 E2
    WHERE NOT EXISTS (
        SELECT *
        FROM Esami E3
        WHERE E3.Studente = E1.Studente
        AND E3.Insegnamento = E2.Insegnamento
    )
)
GROUP BY E1.Studente;

DROP VIEW EsamiSuperatiDa7;


-- QUERY 6: gli studenti che hanno registrato solo esami relativi ad insegnamenti del biennio iniziale del corso di laurea
-- non esiste un esame con i2.annodicorso <> 2 che lo studente candidato ha superato

create view esamipassati as 
select e1.studente, e1.insegnamento, i1.annodicorso 
from esami e1, insegnamenti i1 
where e1.insegnamento = i1.codice;

select distinct studente
from esamipassati e1
where not exists (
      select *
      from esamipassati e2
      where e1.studente = e2.studente
      and e2.annodicorso > 2
);


-- QUERY 7: per ogni area disciplinare, gli insegnamenti col maggior numero di esami registrati;

create view esamiregistrati as
select i.materia, count(*) as esamiregistrati  
from insegnamenti i, esami e 
where i.codice = e.insegnamento group by i.materia;

select *
from esamiregistrati e1
where not exists (
      select *
      from esamiregistrati e2
      where e1.materia <> e2.materia
      and e2.esamiregistrati > e1.esamiregistrati
);

-- QUERY 8: gli studenti che hanno superato l’esame di un sottoinsieme proprio degli insegnamenti dei quali lo studente
--          con matricola 'Studente_3' ha superato l’esame.

-- esiste un esame che 'Studente_3' ha superato e il candidato no
select *
from esami e1
where exists (
      select *
      from esami e2
      where e2.studente = 'Studente_3'
      and not exists (
            select *
            from esami e3
            where e3.insegnamento = e2.insegnamento
            and e1.studente = e3.studente
      )
)
-- non esiste un esame che 'Studennte_3' non ha fatto e il candidato si
and not exists (
      select *
      from esami e2
      where e2.studente = e1.studente
      and not exists (
            select *
            from esami e3
            where e3.studente = 'Studente_3'
            and e3.insegnamento = e2.insegnamento
      )
);
