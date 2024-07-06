-- QUERY 1: i maratoneti che hanno vinto almeno una maratona tedesca, ma nessuna maratona italiana;

SELECT *
FROM Maratoneta M1
WHERE EXISTS (          -- esiste (almeno) una maratona tedesca vinta dal candidato
    SELECT *
    FROM Vincitore V1, Maratona M2, SiTrovaIn S1
    WHERE V1.Atleta = M1.CodiceMaratoneta
    AND V1.Maratona = M2.Nome
    AND M2.Citta = S1.Citta
    AND S1.Nazione = 'Germania'
)
AND NOT EXISTS (        -- non esiste (neanche) una maratona italiana vinta dal candidato
    SELECT *
    FROM Vincitore V1, Maratona M2, SiTrovaIn S1
    WHERE V1.Atleta = M1.CodiceMaratoneta
    AND V1.Maratona = M2.Nome
    AND M2.Citta = S1.Citta
    AND S1.Nazione = 'Italia' 
);

-- QUERY 2: i maratoneti che hanno vinto tutte le edizioni di (almeno) una maratona
CREATE VIEW TabelloneVincite AS
SELECT CodiceMaratoneta, M1.Nome, M1.Cognome, Maratona, V1.Anno
FROM Maratoneta M1, EdizioneMaratona E1, Vincitore V1
WHERE M1.CodiceMaratoneta = V1.Atleta
AND E1.Nome = V1.Maratona
ORDER BY V1.Anno, Maratona;

SELECT DISTINCT CodiceMaratoneta, Nome, Cognome
FROM TabelloneVincite T1
WHERE NOT EXISTS (          -- non esiste un maratoneta diverso dal candidato che ha vinto un'edizione diversa della stessa maratona candidata
    SELECT *
    FROM TabelloneVincite T2
    WHERE T1.CodiceMaratoneta <> T2.CodiceMaratoneta
    AND T1.Maratona = T2.Maratona
);

DROP VIEW TabelloneVincite;