-- QUERY 1: gli studenti che hanno superato tutti gli esami del secondo anno;
y
-- Nella subquery interna, selezioniamo tutti gli esami del secondo anno.
-- IN qella ancora piu interna verifichiamo che per ogni esame del secondo anno non ci sia nessun record nella tabella HaSostenutoEsame  che corrisponde a quell'esame e a quello studente.

SELECT *
FROM Studente S
WHERE NOT EXISTS (  -- Verifichiamo che non esistano esami del secondo anno (I) che non siano stati superati dallo studente S.
    SELECT *
    FROM Insegnamento I
    WHERE I.AnnoDiCorso = 2
    AND NOT EXISTS (    --  per ogni esame del secondo anno non ci sia nessun record nella tabella HaSostenutoEsame (alias H) che corrisponde a quell'esame e a quello studente.
        SELECT *
        FROM HaSostenutoEsame H
        WHERE H.Studente = S.Matricola
        AND H.Insegnamento = I.InsegnamentoId
    )
);

-- QUERY 2:  trovare l'insegnamento con il maggior numero di esami sostenuti da studenti non italiani

-- creo una vista per contare il numero di esami sostenuti da studenti non italiani per ciascun insegnamento
CREATE VIEW ConteggioStudentiNonIta AS
SELECT Insegnamento, COUNT(*) AS EsamiSostenutiDaStudentiNonItaliani 
FROM HaSostenutoEsame, Studente 
WHERE Studente = Matricola 
AND Nazione <> 'Italia' 
GROUP BY Insegnamento;

-- trovo il massimo nella colonna EsamiSostenutiDaStudentiNonItaliani
SELECT Insegnamento
FROM ConteggioStudentiNonIta C0
WHERE NOT EXISTS (
    SELECT *
    FROM ConteggioStudentiNonIta C1
    WHERE C1.EsamiSostenutiDaStudentiNonItaliani > C0.EsamiSostenutiDaStudentiNonItaliani
    AND C1.Insegnamento <> C0.Insegnamento
);

DROP VIEW ConteggioStudentiNonIta;