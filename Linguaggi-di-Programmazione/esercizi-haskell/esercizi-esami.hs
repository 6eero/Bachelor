import Data.List (sort)
{----------------------------------------x 12 settembre 2022 x----------------------------------------}
-- Si scrivano le seguenti funzioni Haskell:

-- 1. una funzione che date due liste determina se una delle due e' una sottolista dell’altra; => per ogni elemento 
-- della prima lista lo cerco nella seconda
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

-- 1. una funzione che data una lista restituisce la lista contenente le sole coppie ordinate (il primo elemento della 
-- coppia `e minore del secondo);
getOrderedPairs :: [[Int]] -> [[Int]]
getOrderedPairs = filter (\lst -> head lst < lst !! 1)

-- 2. una funzione che data una lista di coppie le ordina, ossia scambia tra loro gli elementi di una coppie in modo che 
-- il primo sia minore del secondo;
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


{----------------------------------------x 4 luglio 2022 x----------------------------------------}
-- Scrivere le seguenti funzioni in Haskell:

-- 1. una funzione che, dati un lista e un suo possibile elemento, determina se l’elemento appartiene alla lista;
containsElement :: [Int] -> Int -> Bool
containsElement [] _ = False
containsElement (x:xs) n =
  (x == n) || containsElement xs n

-- 2. una funzione che, dati un lista e un suo elemento, restituisce la lista originale senza l’elemento;
removeElement :: [Int] -> Int -> [Int]
removeElement [] _ = []
removeElement xs n = filter (/= n) xs

-- 3. usando le due funzioni precedenti, definire una funzione che date due liste determina se una e' la permutazione 
-- dell’altra;
checkPermutation :: [Int] -> [Int] -> Bool
checkPermutation [] _ = False
checkPermutation _ [] = False
checkPermutation [a] [b] = a == b
checkPermutation (x:xs) ls =
  containsElement ls x && checkPermutation xs (removeElement ls x)

-- 4. una funzione che data una matrice, memorizzata per righe, determina se le righe della matrice sono le sono 
-- tutte permutazioni di una stessa lista
checkRows :: [[Int]] -> Bool  --[[1,2,3], [2,1,3], [3,2,1]]
checkRows [] = True
checkRows (x:xs) = all (checkPermutation x) xs


{----------------------------------------x 9 settembre 2019 x----------------------------------------}
-- Si scriva una funzione Haskell che, prese in ingresso due liste strettamente ordinate xs e ys, costruisca una 
-- terza lista strettamente ordinata contenente tutti gli elementi che appaiono in almeno una delle due le liste 
-- xs e ys. Si rispetti percio il vincolo che se un elemento appare sia in xs che in ys, allora deve apparire 
-- un’unica volta nella lista risultato.
mergeAndOrderLists :: [Int] -> [Int] -> [Int]
mergeAndOrderLists [] ys = quicksort ys
mergeAndOrderLists xs [] = quicksort xs
mergeAndOrderLists (x:xs) ys =
  if containsElement ys x
    then mergeAndOrderLists xs ys
    else mergeAndOrderLists xs (ys ++ [x])

quicksort :: [Int] -> [Int]
quicksort [] = []
quicksort [x] = [x]
quicksort (pivot:xs) =  quicksort [x | x <- xs, x <= pivot] ++ [pivot] ++ quicksort [x | x <- xs, x > pivot]

-- Si scriva inoltre una funzione Haskell che, presa in ingresso una matrice memorizzata per righe, in cui ogni 
-- riga e' strettamente ordinata, costruisca una lista strettamente ordinata contenente tutti gli elementi che 
-- appaiono in almeno una riga della matrice.
mergeAndOrderMatrix :: [[Int]] -> [Int]
mergeAndOrderMatrix [] = []
mergeAndOrderMatrix xs = foldr mergeAndOrderLists [] xs


{----------------------------------------x 2 luglio 2019 x----------------------------------------}
-- Si scriva una funzione Haskell che, presa in ingresso una matrice quadrata, memorizzata per righe,
-- restituisca in uscita la sottomatrice ottenuta eliminando la prima riga e la prima colonna alla matrice
-- originaria. 
removeRows :: [[Int]] -> [[Int]]
removeRows [] = []
removeRows (x:xs) = init xs

-- Si scriva inoltre una funzione Haskell che, preso in ingresso una matrice quadrata, memoriz-
-- zata per righe, restituisca la lista degli elementi contenuti nella diagonale della matrice. Si commenti
-- il codice e si definisca il tipo di ogni funzione definita.
getDiagonal :: [[Int]] -> [Int]
getDiagonal [] = []
getDiagonal xs = getDiagonalHelper xs 0
  where
    getDiagonalHelper :: [[Int]] -> Int -> [Int]
    getDiagonalHelper [] _ = []
    getDiagonalHelper (x:xs) pos = (x !! pos) : getDiagonalHelper xs (pos + 1)