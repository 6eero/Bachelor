-- Scrivere una funzione che data una lista ne costruisce una rimuovendo gli elementi di posizione pari (si conti partendo da 1).

removeEvenPosition :: [Int] -> [Int]
removeEvenPosition xs = removeEvenPositionHelper xs 1
  where
    removeEvenPositionHelper :: [Int] -> Int -> [Int]
    removeEvenPositionHelper [] _ = []
    removeEvenPositionHelper (x:xs) pos
      | even pos  = removeEvenPositionHelper xs (pos + 1)
      | otherwise = x : removeEvenPositionHelper xs (pos + 1)

-- Esempio di esecuzione:
-- removeEvenPosition [1,2,3,4,5]
-- removeEvenPositionHelper (1:[2,3,4,5]) 1
-- [1]:removeEvenPositionHelper [2,3,4,5] 2 -> [1]:removeEvenPositionHelper (2:[,3,4,5]) 2 
-- [1]:removeEvenPositionHelper [3,4,5] 3 -> [1]:removeEvenPositionHelper (3:[4,5]) 3
-- [1,3]:removeEvenPositionHelper [4,5] 4 -> [1,3]:removeEvenPositionHelper (4:[5]) 4
-- [1,3]:removeEvenPositionHelper [5] 5 -> [1,3]:removeEvenPositionHelper (5:[]) 5
-- [1,3,5]:removeEvenPositionHelper [] 6 -> [1,3,5]:[] -> [1,3,5]

