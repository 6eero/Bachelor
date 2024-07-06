-- QUERY 1: gli scacchisti che hanno vinto almeno un’edizione del torneo che si svolge nella citta di Imperia;

-- SOLUZIONE 1
SELECT CodiceScacchista, Nome, Cognome
FROM Scacchista S1, EdizioneTorneo E1, Torneo T1
WHERE S1.CodiceScacchista = E1.Vincitore
AND E1.NomeTorneo = T1.NomeTorneo
AND T1.Citta = 'Imperia';

-- SOLUZIONE 2
SELECT CodiceScacchista, Nome, Cognome
FROM Scacchista S1, EdizioneTorneo E1
WHERE S1.CodiceScacchista = E1.Vincitore
AND EXISTS (
    SELECT *
    FROM Torneo T1
    WHERE T1.Citta = 'Imperia'
    AND E1.NomeTorneo = T1.NomeTorneo
);

-- QUERY 2: per ogni torneo, le nazioni i cui atleti hanno vinto complessivamente il maggior numero di edizioni.

CREATE VIEW TabellaVincitori AS
SELECT NomeTorneo, Nazione AS NazioneVincitore
FROM EdizioneTorneo E1, Scacchista S1 
WHERE E1.Vincitore = S1.CodiceScacchista;

-- SOLUZIONE 1: con COUNT
CREATE VIEW TabellaVincitori2 AS
SELECT NomeTorneo, NazioneVincitore, COUNT(*) AS EdizioniVinte
FROM TabellaVincitori T1
GROUP BY NomeTorneo, NazioneVincitore;

SELECT *
FROM TabellaVincitori2 T1
WHERE NOT EXISTS (
    SELECT *
    FROM TabellaVincitori2 T2
    WHERE T1.NomeTorneo = T2.NomeTorneo
    AND T1.EdizioniVinte < T2.EdizioniVinte
);

DROP VIEW TabellaVincitori CASCADE;


-- SOLUZIONE 2: senza COUNT

