/*
-- QUERY 1: il porto (i porti, se piu' d’uno) col minor numero di banchine

-- Creiamo una vista per ottenere il massimo numero di banchine per ogni porto 
CREATE VIEW ConteggioBanchine AS
SELECT Porto, COUNT(*) AS NumeroBanchine
FROM Banchina
GROUP BY Porto;

-- SOLUZIONE 1 (CON ALL)
-- uso la vista per ottenere i porti col minor numero di banchine
SELECT *
FROM ConteggioBanchine
WHERE NumeroBanchine <= ALL (
    SELECT NumeroBanchine
    FROM ConteggioBanchine
);

-- SOLUZIONE 2 (CON NOT EXISTS)
-- Il ragionamento e' che non esiste un porto diverso dal candidato con un numero di banchine minore
SELECT *
FROM ConteggioBanchine AS C
WHERE NOT EXISTS (
    SELECT *
    FROM ConteggioBanchine as C1
    WHERE C1.NumeroBanchine <C.NumeroBanchine
    AND C.Porto <> C1.Porto
);

DROP VIEW ConteggioBanchine;
*/

-- QUERY 2 (Non funziona correttamente): le navi tali che ogni porto in cui arrivano e' raggiunto solo da esse.

SELECT IdCorsa, Nave, CittaArrivo
FROM CorsaGiornaliera C0
WHERE NOT EXISTS (
    SELECT *
    FROM CorsaGiornaliera C1
    WHERE C0.Nave <> C1.Nave
    AND C0.CittaArrivo = C1.CittaArrivo
)
AND NOT EXISTS (
    SELECT *
    FROM CorsaGiornaliera C2
    WHERE C0.Nave = C2.Nave
    AND C0.CittaArrivo <> C2.CittaArrivo
);

