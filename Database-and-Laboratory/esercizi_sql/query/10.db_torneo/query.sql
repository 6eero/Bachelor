-- QUERY 1: la nazionale (le nazionali, se piu di una) che hanno vinto il maggior numero di partite;
/*
CREATE VIEW TabellaVincitori AS
SELECT Data, Nazionale1 AS Vincitore
FROM PARTITA
WHERE GoalNazionale1 > GoalNazionale2
UNION All
SELECT Data, Nazionale2 AS Vincitore
FROM PARTITA
WHERE GoalNazionale2 > GoalNazionale1;

SELECT DISTINCT Vincitore
FROM TabellaVincitori T1
WHERE NOT EXISTS (
    SELECT *
    FROM TabellaVincitori T2
    WHERE T1.Vincitore = T2.Vincitore
    AND T1.Data <> T2.Data
);

DROP VIEW TabellaVincitori;
*/

-- QUERY 2: le nazionali che hanno giocato in tutti e soli gli stadi dove ha giocato il Belgio.
CREATE VIEW HaGiocato AS
SELECT Nazionale1 AS Nazionale, Stadio
FROM PARTITA
UNION
SELECT Nazionale2 AS Nazionale, Stadio
FROM PARTITA
ORDER BY Nazionale;

CREATE VIEW StadioDoveHaGiocatoIlBelgio AS
SELECT Stadio
FROM HaGiocato
WHERE Nazionale = 'Belgio';

/*
-- 2.1: Le nazioni che hanno giocato solo in stadi in cui ha giocato il Belgio
--      Non esiste un stadio in cui non ha giocato il Belgio in cui il candidato ha giocato
SELECT DISTINCT Nazionale
FROM HaGiocato HG1
WHERE Nazionale <> 'Belgio'
AND NOT EXISTS (
    SELECT *
    FROM HaGiocato HG2
    WHERE HG2.Nazionale = HG1.Nazionale
    AND HG2.Stadio NOT IN (SELECT Stadio FROM StadioDoveHaGiocatoIlBelgio)
);

-- 2.2: Le nazioni che hanno giocato in tutti gli stadi in ha giocato il Belgio
--      Non esiste uno stadio in cui ha giocato il Belgio in cui il candidato non ha giocato
SELECT DISTINCT Nazionale
FROM HaGiocato HG1
WHERE Nazionale <> 'Belgio'
AND NOT EXISTS (
    SELECT *
    FROM StadioDoveHaGiocatoIlBelgio S
    WHERE NOT EXISTS (
        SELECT *
        FROM HaGiocato HG2
        WHERE HG2.Nazionale = HG1.Nazionale
        AND HG2.Stadio = S.Stadio
    )
);
*/

SELECT DISTINCT Nazionale
FROM HaGiocato HG1
WHERE Nazionale <> 'Belgio'
AND NOT EXISTS (                -- 2.1: Le nazioni che hanno giocato solo in stadi in cui ha giocato il Belgio
    SELECT *
    FROM HaGiocato HG2
    WHERE HG2.Nazionale = HG1.Nazionale
    AND HG2.Stadio NOT IN (SELECT Stadio FROM StadioDoveHaGiocatoIlBelgio)
)
AND NOT EXISTS (                -- 2.2: Le nazioni che hanno giocato in tutti gli stadi in ha giocato il Belgio
    SELECT *
    FROM StadioDoveHaGiocatoIlBelgio S
    WHERE NOT EXISTS (
        SELECT *
        FROM HaGiocato HG2
        WHERE HG2.Nazionale = HG1.Nazionale
        AND HG2.Stadio = S.Stadio
    )
);

DROP VIEW HaGiocato CASCADE;