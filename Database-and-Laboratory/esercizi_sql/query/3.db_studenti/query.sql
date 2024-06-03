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
