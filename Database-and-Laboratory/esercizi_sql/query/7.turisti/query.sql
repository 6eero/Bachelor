
--  QUERY 1: i turisti che nel 2018 hanno visitato almeno una citta della propria nazione e nessuna citta di altre nazioni;

SELECT H.TuristaId, H.Citta, H.Anno, S.Nazione
FROM HaVisitato H, SiTrovaIn S, Turista T
WHERE H.Citta = S.Citta
AND H.Anno = 2018
AND S.Nazione = T.Nazione
AND H.TuristaId = T.TuristaId
AND NOT EXISTS (
    SELECT *
    FROM HaVisitato H1, SiTrovaIn S1
    WHERE H1.Citta = S1.Citta
    AND H1.TuristaId = T.TuristaId
    AND H1.Anno = 2018
    AND S1.Nazione <> T.Nazione
);

--  QUERY 2: i turisti italiani che nell’anno 2019 non hanno visitato alcuna citta visitata (quell’anno) anche da altri turisti italiani

CREATE VIEW ViaggiDiItalianiNel2019 AS
SELECT T.TuristaId, H.Citta 
FROM HaVisitato H, Turista T 
WHERE H.TuristaId = T.TuristaId 
AND T.Nazione = 'Italia' 
AND H.Anno = '2019';

CREATE VIEW NumeroVisite AS
SELECT citta, COUNT(*) AS NumeroVisite
FROM ViaggiDiItalianiNel2019
GROUP BY (Citta);

SELECT *
FROM Turista T, HaVisitato H
WHERE T.TuristaId = H.TuristaId
AND T.Nazione = 'Italia'
AND H.Anno = '2019'
AND NOT EXISTS (
    SELECT *
    FROM NumeroVisite N
    WHERE H.Citta = N.Citta
    AND NumeroVisite > 1
);

DROP VIEW ViaggiDiItalianiNel2019 CASCADE;

-- QUERY 3: i turisti non francesi, che nel 2020 hanno visitato il maggior numero di citta francesi;

CREATE VIEW ViaggiDiTuristiNonFrancesiNel2020 AS
SELECT T.TuristaId, T.Nazione AS NazioneTurista, H.Citta AS CittaVisitata
FROM Turista T, HaVisitato H, SiTrovaIn S
WHERE T.Nazione <> 'Francia'
AND T.TuristaId = H.TuristaId
AND H.Citta = S.Citta
AND H.Anno = '2020'
GROUP BY T.TuristaId, H.Citta;

CREATE VIEW NumeroCittaFrancesiVisitateDaTuristiNonFrancesi AS
SELECT V1.TuristaId, COUNT(*) AS NumeroCittaFrancesiVisitate
FROM ViaggiDiTuristiNonFrancesiNel2020 V1, SiTrovaIn S1
WHERE V1.CittaVisitata = S1.Citta
AND S1.Nazione = 'Francia'
GROUP BY TuristaId;

SELECT TuristaId
FROM NumeroCittaFrancesiVisitateDaTuristiNonFrancesi N
WHERE NOT EXISTS (
    SELECT *
    FROM NumeroCittaFrancesiVisitateDaTuristiNonFrancesi T
    WHERE T.TuristaId <> N.TuristaId
    AND T.NumeroCittaFrancesiVisitate > N.NumeroCittaFrancesiVisitate
);

DROP VIEW ViaggiDiTuristiNonFrancesiNel2020 CASCADE;

-- QUERY 4:  i turisti che nell’anno 2021 hanno effettuato delle visite (esattamente) nelle stesse nazioni
