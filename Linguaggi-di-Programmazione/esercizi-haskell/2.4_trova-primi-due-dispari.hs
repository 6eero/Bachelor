-- Scrivere una funzione che calcola i 2 minori elementi dispari di una lista (se esistono). 
-- Ad esempio minOdd([2,3,4,6,8,7,5]) riduce a (3,5)


-- uso quicksort implementato nell'esercizio precedente
quicksort :: [Int] -> [Int]
quicksort [] = []
quicksort [x] = [x]
quicksort (pivot:xs) =  quicksort [x | x <- xs, x <= pivot] ++ [pivot] ++ quicksort [x | x <- xs, x > pivot]

minOdd :: [Int] -> [Int]
minOdd xs = take 2 $ quicksort $ filter odd xs
-- minOdd xs = (take 2 . quicksort . filter odd) xs -- alternativamente
