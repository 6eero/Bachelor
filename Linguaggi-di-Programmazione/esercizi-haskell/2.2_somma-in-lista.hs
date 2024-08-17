-- Scrivere una funzione che calcola la somma degli elementi di posizione 
-- dispari di una lista

-- versione 1:
sumOddPosition :: [Int] -> Int
sumOddPosition xs = sumOddPositionHelper xs 1
  where
    sumOddPositionHelper :: [Int] -> Int -> Int
    sumOddPositionHelper [] _ = 0
    sumOddPositionHelper (x:xs) pos
      | odd pos = x + sumOddPositionHelper xs (pos + 1)
      | otherwise = sumOddPositionHelper xs (pos + 1)
  
-- versione 2: usando la funzione del es 2.1
removeEvenPosition :: [Int] -> [Int]
removeEvenPosition xs = removeEvenPositionHelper xs 1
  where
    removeEvenPositionHelper :: [Int] -> Int -> [Int]
    removeEvenPositionHelper [] _ = []
    removeEvenPositionHelper (x:xs) pos
      | even pos  = removeEvenPositionHelper xs (pos + 1)
      | otherwise = x : removeEvenPositionHelper xs (pos + 1)

sumOddPositionV2 :: [Int] -> Int
sumOddPositionV2 = sum . removeEvenPosition