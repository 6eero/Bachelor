-- QUERY 1: i partiti che nella tornata elettorale del 1998 non hanno eletto alcun politico;

SELECT NomePartito
FROM Partiti P0
WHERE NOT EXISTS (
      SELECT *
      FROM Eletti E1
      WHERE P0.NomePartito = E1.Partito 
      AND E1.AnnoElezione = 1998
);


-- QUERY 2: i partiti che hanno eletto almeno un politico in tutte le tornate elettorali.


-- QUERY 3:  i partiti che nella tornata elettorale del 2020 hanno eletto non piu' di 2 persone nate dopo il 1990;

SELECT NomePartito
FROM Partiti P0
WHERE NOT EXISTS (
      SELECT *
      FROM Eletti E1, Politici P1
      WHERE E1.Politico = P1.codicefiscale 
      AND P1.AnnoNascita > 1990 
      AND E1.AnnoElezione = 2020 
      AND E1.Partito = P0.NomePartito
      AND EXISTS (
            SELECT *
            FROM Eletti E2, Politici P2
            WHERE E2.Politico = P2.codicefiscale 
            AND P2.AnnoNascita > 1990 
            AND E2.AnnoElezione = 2020 
            AND E2.Politico <> E1.Politico 
            AND E2.Partito = P0.NomePartito
            AND EXISTS (
                  SELECT *
                  FROM Eletti E3, Politici P3
                  WHERE E3.Politico = P3.codicefiscale 
                  AND P3.AnnoNascita > 1990 
                  AND E3.AnnoElezione = 2020 
                  AND E3.Politico <> E1.Politico 
                  AND E3.Politico <> E2.Politico 
                  AND E3.Partito = P0.NomePartito
            )
      )
);

select * from politici; 
select * from partiti; 
select * from eletti;


-- QUERY 4: per ogni elezione, il partito (i partiti se piu' di uno) che ha eletto il maggior numero di candidati.

-- Creiamo una vista per contare i candidati eletti per ciascun partito in ogni anno
CREATE VIEW ConteggioEletti AS
SELECT AnnoElezione, Partito, COUNT(*) AS NumeroCandidati
FROM Eletti
GROUP BY AnnoElezione, Partito;

/*
 annoelezione |  partito  | numerocandidati
--------------+-----------+-----------------
         2002 | Partito A |               1
         2020 | Partito C |               1
         1999 | Partito A |               1
         2002 | Partito C |               2
         2006 | Partito A |               1
         1998 | Partito B |               2
         2006 | Partito B |               1
         1998 | Partito A |               2
         2020 | Partito A |               2
         2020 | Partito B |               3
         2002 | Partito B |               1
         2006 | Partito C |               2
(12 rows)
*/

-- Creiamo una vista per ottenere il massimo numero di candidati eletti in ogni anno
CREATE VIEW MassimoEletti AS
SELECT AnnoElezione, MAX(NumeroCandidati) AS NumeroCandidatiMax
FROM ConteggioEletti
GROUP BY AnnoElezione;

/*
 annoelezione | numerocandidatimax
--------------+--------------------
         2006 |                  2
         2020 |                  3
         2002 |                  2
         1998 |                  2
         1999 |                  1
(5 rows)
*/

SELECT C.AnnoElezione, C.Partito, C.NumeroCandidati
FROM ConteggioEletti C, MassimoEletti M
WHERE C.AnnoElezione = M.AnnoElezione
AND C.NumeroCandidati = M.NumeroCandidatiMax
ORDER BY AnnoElezione;

/*
 annoelezione |  partito  | numerocandidati
--------------+-----------+-----------------
         1998 | Partito B |               2
         1998 | Partito A |               2
         1999 | Partito A |               1
         2002 | Partito C |               2
         2006 | Partito C |               2
         2020 | Partito B |               3
(6 rows)
*/

DROP VIEW ConteggioEletti CASCADE;

