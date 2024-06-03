-- Gli attori che hanno recitato solo in film di Kurosawa (caso universale  not exists);

SELECT	CodiceAttore
FROM 	ATTORE A
WHERE	NOT EXISTS (SELECT 	*
			            FROM 	FILM F, INTERPRETAZIONE I
			            WHERE 	F.Regista <> 'Akira Kurosawa' AND 
                          F.CodiceFilm = I.Film AND 
                          I.Attore = A.CodiceAttore);
