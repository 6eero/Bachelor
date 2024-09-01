{----------------------------------------x NUMERI x----------------------------------------}
-- 1.1 Si scriva la funzione fattoriale. Si verifichi il funzionamento calcolando 10000!
factorial :: Integer -> Integer
factorial 0 = 1
factorial n = n * factorial (n - 1)

-- 1.2 Si scriva la funzione (n su k), combinazioni di k elementi su n.
binomial :: Integer -> Integer -> Integer
binomial n 0 = 1
binomial 0 k = 0
binomial n k = factorial n `div` (factorial k * factorial (n - k))

-- 1.3 Si scriva una funzione che calcoli una lista con tutte le combinazioni su n elementi. Si usi opportunamente map :: ( a -> b ) -> [ a ] -> [ b ]
calculateList :: Int -> [a] -> [[a]]
calculateList 0 _  = [[]]
calculateList _ [] = []
calculateList n (x:xs) = map (x:) (calculateList (n-1) xs) ++ calculateList n xs



{----------------------------------------x LISTE x----------------------------------------}
-- 2.1 Scrivere una funzione che data una lista ne costruisce una rimuovendo gli elementi di posizione pari (si conti partendo da 1).
removeEvenPosition :: [Int] -> [Int]
removeEvenPosition xs = removeEvenPositionHelper xs 1
  where
    removeEvenPositionHelper :: [Int] -> Int -> [Int]
    removeEvenPositionHelper [] _ = []
    removeEvenPositionHelper (x:xs) pos
      | even pos  = removeEvenPositionHelper xs (pos + 1)
      | otherwise = x : removeEvenPositionHelper xs (pos + 1)

-- 2.2.versione_1 Scrivere una funzione che calcola la somma degli elementi di posizione dispari di una lista
sumOddPosition :: [Int] -> Int
sumOddPosition xs = sumOddPositionHelper xs 1
  where
    sumOddPositionHelper :: [Int] -> Int -> Int
    sumOddPositionHelper [] _ = 0
    sumOddPositionHelper (x:xs) pos
      | odd pos = x + sumOddPositionHelper xs (pos + 1)
      | otherwise = sumOddPositionHelper xs (pos + 1)

-- 2.2.versione_2 Scrivere una funzione che calcola la somma degli elementi di posizione dispari di una lista
sumOddPositionV2 :: [Int] -> Int
sumOddPositionV2 = sum . removeEvenPosition

-- 2.3 Scrivere il QuickSort.
quicksort :: [Int] -> [Int]
quicksort [] = []
quicksort [x] = [x]
quicksort (pivot:xs) = quicksort [x | x <- xs, x <= pivot] ++ [pivot] ++ quicksort [x | x <- xs, x > pivot]

-- 2.4 Scrivere una funzione che calcola i 2 minori elementi dispari di una lista (se esistono). Ad esempio minOdd([2,3,4,6,8,7,5]) riduce a (3,5)
minOdd :: [Int] -> [Int]
minOdd xs = take 2 $ quicksort $ filter odd xs -- minOdd xs = (take 2 . quicksort . filter odd) xs -- alternativamente

{-  2.5
Scrivere una funzione che costruisce, a partire da una lista di numeri interi, una lista di coppie in cui
  (a) il primo elemento di ogni coppia e' uguale all’elemento di corrispondente posizione nella lista originale
  (b) il secondo elemento di ogni coppia e' uguale alla somma di tutti gli elementi conseguenti della lista originale.
-}
getPairs :: [Int] -> [(Int, Int)]
getPairs [] = []
getPairs (x:xs) = (x, sum xs) : getPairs xs



{----------------------------------------x MATRICI x----------------------------------------}
-- 3.1 Si scriva una funzione matrixDim che data una matrice ne calcola le dimensioni, se la matrice e' ben formata, 
-- altrimenti restituisce (-1,-1).
matrixDim :: [[a]] -> (Int, Int)
matrixDim [] = (0, 0)
matrixDim (x:xs)
    | all (\row -> length row == length x) xs = (1 + length xs, length x)
    | otherwise = (-1, -1)

-- 3.2 Si scriva una funzione colsums che data una matrice calcola il vettore delle somme delle colonne.
colsums :: [[Int]] -> [Int]
colsums [] = []
colsums (x:xs) = foldr addLists x xs

addLists :: [Int] -> [Int] -> [Int]
addLists = zipWith (+)

-- 3.9 Si scriva una funzione che data una matrice di dimensioni m × n restituisce la corrispondente
-- matrice trasposta (di dimensioni n × m).
transpose :: [[a]] -> [[a]]
transpose ([]:_) = []
transpose x = map head x : transpose (map tail x)

-- 3.10. Si scriva un predicato isSymmetric che, data una matrice quadrata, determina se e' simmetrica.
isSymmetric :: Eq a => [[a]] -> Bool
isSymmetric [] = True
isSymmetric x = x == transpose x



{----------------------------------------x BST x----------------------------------------}
data Tree a = Void | Node {
    val :: a,
    left :: Tree a,
    right :: Tree a
} deriving (Eq, Ord, Read, Show)

-- 1. Scrivere una funzione che calcola la somma dei valori di un albero a valori sommabili
getSumTree :: Num a => Tree a -> a
getSumTree Void = 0
getSumTree (Node val left right) = val + getSumTree left + getSumTree right

-- 2. Scrivere una funzione che calcola la somma dei valori dispari di un albero a valori sommabili su cui
-- sia utilizzabile la funzione odd.
getOddSumTree :: (Num a, Integral a) => Tree a -> a
getOddSumTree Void = 0
getOddSumTree (Node val left right) = (if odd val then val else 0) + getOddSumTree left + getOddSumTree right

-- 3. Si scriva un predicato sameSums che presa una lista di alberi [t1, ..., tn] determina se le somme
-- s1, ..., sn dei valori degli elementi di ogni ti sono tutte uguali fra loro.

-- prende una lista di alberi e ritorna una lista di interi (somme di ogni albero)
sumListOfTrees :: Num a => [Tree a] -> [a]
sumListOfTrees = map getSumTree

-- prende una lista di interi e controlla se sono tutti uguali
areAllEqual :: Eq a => [a] -> Bool
areAllEqual [] = True
areAllEqual (x:xs) = all (== x) xs

sameSums :: (Num a, Eq a) => [Tree a] -> Bool
sameSums trees = areAllEqual (sumListOfTrees trees)

-- 4. Scrivere un predicato bstElem per determinare se un valore e' presente in un BST.
bstElem :: (Ord a) => Tree a -> a -> Bool
bstElem Void _ = False
bstElem (Node val left right) n
  | n == val = True
  | n > val = bstElem right n
  | n < val = bstElem left n 

-- 5. Si scriva una funzione per eseguire l’inserimento di un dato x in un albero t
bstInsert :: (Ord a) => a -> Tree a -> Tree a
bstInsert x Void = Node x Void Void 
bstInsert x (Node val left right)
  | x < val = Node val (bstInsert x left) right
  | otherwise = Node val left (bstInsert x right)

-- 6. Si scriva una funzione bst2List che calcola la lista ordinata degli elementi di un BST. Ci si assicuri
-- di scrivere una funzione lineare (Inorder Traversal).

-- (Node 22 (Node 12 (Node 8 Void Void) (Node 20 Void Void)) (Node 30 (Node 25 Void Void) (Node 40 Void Void)))
-- [8 12 20 22 25 30 40]

bst2List :: (Ord a) => Tree a -> [a]
bst2List Void = []
bst2List (Node val left right) = bst2List left ++ [val] ++ bst2List right

-- 8. Si scriva una funzione filtertree p t che costruisce una lista (ordinata) di tutti gli elementi
-- dell’albero t che soddisfano il predicato p.

