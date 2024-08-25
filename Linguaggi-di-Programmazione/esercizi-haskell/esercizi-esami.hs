import Data.List (sort)
{----------------------------------------x 12 settembre 2022 x----------------------------------------}

-- Si scrivano le seguenti funzioni Haskell:

-- 1. una funzione che date due liste determina se una delle due e' una sottolista dell’altra; => per ogni elemento della prima lista lo cerco nella seconda
isSublist :: (Eq a) => [a] -> [a] -> Bool
isSublist _ [] = False
isSublist sub lst@(x:xs)
  | sub `isPrefixOf` lst = True
  | otherwise = sub `isPrefixOf` xs
  where
    isPrefixOf [] _ = True
    isPrefixOf _ [] = False
    isPrefixOf (p:ps) (l:ls) =
      (p == l) && isPrefixOf ps ls

-- 2. una funzione che data una lista determina se questa e' palindroma;
isPalyndrome :: [Int] -> Bool
isPalyndrome [] = False
isPalyndrome [x] = True
isPalyndrome (x:xs) =
  (x == last xs) && isPalyndrome (init xs)

-- 3. una funzione che data una lista determina la lunghezza della piu' lunga sottolista finale palindroma;
getLenOfTheLastPalyndrome :: [Int] -> Int
getLenOfTheLastPalyndrome [] = 0
getLenOfTheLastPalyndrome [x] = 0
getLenOfTheLastPalyndrome (x:xs) =
  if (x == last xs) && isPalyndrome (x:xs)
    then length (x:xs)
    else getLenOfTheLastPalyndrome xs

-- 4. una funzione che data una lista determina la lunghezza della piu' lunga sottolista palindroma.


{----------------------------------------x 4 luglio 2022 x----------------------------------------}

-- Su liste aventi come elementi coppie di valori di uno stesso tipo ordinabile, scrivere le seguenti funzioni Haskell:

-- 1. una funzione che data una lista restituisce la lista contenente le sole coppie ordinate (il primo elemento della coppia `e minore del secondo);
getOrderedPairs :: [[Int]] -> [[Int]]
getOrderedPairs = filter (\lst -> head lst < lst !! 1)

-- 2. una funzione che data una lista di coppie le ordina, ossia scambia tra loro gli elementi di una coppie in modo che il primo sia minore del secondo;
fixPair :: (Int, Int) -> (Int, Int)
fixPair (a, b) =
  if a > b
    then (b, a)
    else (a, b)

-- versione con funzione map: 
fixListPairs :: [(Int, Int)] -> [(Int, Int)]
fixListPairs = map fixPair

-- versione ricorsiva: 
--fixListPairs [] = []
--fixListPairs (x:xs) = fixPair x : fixListPairs xs

-- 3. considerando l’ordine lessicografico tra le coppie, definire una funzione che data una lista di coppie la ordina.
orderPairList :: [(Int, Int)] -> [(Int, Int)]
orderPairList [] = []
orderPairList xs = sort xs