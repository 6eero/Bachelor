-- 4 luglio 2022
-- Su liste aventi come elementi coppie di valori di uno stesso tipo ordinabile, scrivere le seguenti funzioni Haskell:

-- una funzione che data una lista restituisce la lista contenente le sole coppie ordinate (il primo elemento della coppia e' minore del secondo);
orderedPairs :: [[Int]] -> [(Int, Int)]
orderedPairs [] = []
orderedPairs (x:xs) = 

-- una funzione che data una lista di coppie le ordina, ossia scambia tra loro gli elementi di una coppie in modo che il primo sia minore del secondo;


-- considerando l’ordine lessicografico tra le coppie, definire una funzione che data una lista di coppie la ordina.