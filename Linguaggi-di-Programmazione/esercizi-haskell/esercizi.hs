{----------------------------------------x NUMERI x----------------------------------------}

-- 1 Si scriva la funzione fattoriale. Si verifichi il funzionamento calcolando 10000!
{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}
{-# HLINT ignore "Use foldr" #-}
factorial :: Int -> Int
factorial 0 = 1
factorial n = n * factorial (n - 1)


-- 2 Si scriva la funzione (n su k), combinazioni di k elementi su n.
binomial :: Int -> Int -> Int
binomial n 0 = 1
binomial 0 k = 0
binomial n k = factorial n `div` (factorial k * factorial (n - k))


-- 3 Si scriva una funzione che calcoli una lista con tutte le combinazioni su n elementi. Si usi opportunamente map :: ( a -> b ) -> [ a ] -> [ b ]
calculateList :: Int -> [a] -> [[a]]
calculateList 0 _  = [[]]
calculateList _ [] = []
calculateList n (x:xs) = map (x:) (calculateList (n-1) xs) ++ calculateList n xs




{----------------------------------------x LISTE x----------------------------------------}

-- 1 Scrivere una funzione che data una lista ne costruisce una rimuovendo gli elementi di posizione pari (si conti partendo da 1).
removeEvenPosition :: [a] -> [a]
removeEvenPosition xs = removeEvenPositionHelper xs 1
  where
    removeEvenPositionHelper :: [a] -> Int -> [a]
    removeEvenPositionHelper [] _ = []
    removeEvenPositionHelper (x:xs) pos
      | even pos  = removeEvenPositionHelper xs (pos + 1)
      | otherwise = x : removeEvenPositionHelper xs (pos + 1)


-- 2.a. Scrivere una funzione che calcola la somma degli elementi di posizione dispari di una lista
sumOddPosition :: [Int] -> Int
sumOddPosition xs = sumOddPositionHelper xs 1
  where
    sumOddPositionHelper :: [Int] -> Int -> Int
    sumOddPositionHelper [] _ = 0
    sumOddPositionHelper (x:xs) pos
      | odd pos = x + sumOddPositionHelper xs (pos + 1)
      | otherwise = sumOddPositionHelper xs (pos + 1)


-- 2.b. Scrivere una funzione che calcola la somma degli elementi di posizione dispari di una lista
sumOddPositionV2 :: [Int] -> Int
sumOddPositionV2 = sum . removeEvenPosition


-- 3. Scrivere il QuickSort.
quicksort :: Ord a => [a] -> [a]
quicksort [] = []
quicksort [x] = [x]
quicksort (pivot:xs) = quicksort [x | x <- xs, x <= pivot] ++ [pivot] ++ quicksort [x | x <- xs, x > pivot]


-- 4. Scrivere una funzione che calcola i 2 minori elementi dispari di una lista (se esistono). Ad esempio minOdd([2,3,4,6,8,7,5]) riduce a (3,5)
minOdd :: [Int] -> [Int]
minOdd xs = take 2 $ quicksort $ filter odd xs -- minOdd xs = (take 2 . quicksort . filter odd) xs -- alternativamente


-- 5. Scrivere una funzione che costruisce, a partire da una lista di numeri interi, una lista di coppie in cui il primo elemento di ogni coppia e' uguale all’elemento di corrispondente posizione nella lista originale e il secondo elemento di ogni coppia e' uguale alla somma di tutti gli elementi conseguenti della lista originale.
getPairs :: [Int] -> [(Int, Int)]
getPairs [] = []
getPairs (x:xs) = (x, sum xs) : getPairs xs




{----------------------------------------x MATRICI x----------------------------------------}

-- 1. Si scriva una funzione matrixDim che data una matrice ne calcola le dimensioni, se la matrice e' ben formata, altrimenti restituisce (-1,-1).
matrixDim :: [[a]] -> (Int, Int)
matrixDim [] = (0, 0)
matrixDim (x:xs)
    | all (\row -> length row == length x) xs = (1 + length xs, length x)
    | otherwise = (-1, -1)


-- 2. Si scriva una funzione colsums che data una matrice calcola il vettore delle somme delle colonne.
colsums :: [[Int]] -> [Int]
colsums [] = []
colsums (x:xs) = foldr addLists x xs

addLists :: [Int] -> [Int] -> [Int]
addLists = zipWith (+)


-- 9. Si scriva una funzione che data una matrice di dimensioni m × n restituisce la corrispondente matrice trasposta (di dimensioni n × m).
transpose :: [[a]] -> [[a]]
transpose ([]:_) = []
transpose x = map head x : transpose (map tail x)


-- 10. Si scriva un predicato isSymmetric che, data una matrice quadrata, determina se e' simmetrica.
isSymmetric :: Eq a => [[a]] -> Bool
isSymmetric [] = True
isSymmetric x = x == transpose x




{----------------------------------------x BST x----------------------------------------}

data BST a = Void | Node {
    val :: a,
    left :: BST a,
    right :: BST a
} deriving (Eq, Ord, Read, Show)


-- 1. Scrivere una funzione che calcola la somma dei valori di un albero a valori sommabili
getSumBST :: Num a => BST a -> a
getSumBST Void = 0
getSumBST (Node val left right) = val + getSumBST left + getSumBST right


-- 2. Scrivere una funzione che calcola la somma dei valori dispari di un albero a valori sommabili su cui sia utilizzabile la funzione odd.
getOddSumBST :: (Num a, Integral a) => BST a -> a
getOddSumBST Void = 0
getOddSumBST (Node val left right) = (if odd val then val else 0) + getOddSumBST left + getOddSumBST right


-- 3. Si scriva un predicato sameSums che presa una lista di alberi [t1, ..., tn] determina se le somme s1,...,sn dei valori degli elementi di ogni ti sono tutte uguali fra loro.
sumListOfBSTs :: Num a => [BST a] -> [a]  -- prende una lista di alberi e ritorna una lista di interi (somme di ogni albero)
sumListOfBSTs = map getSumBST

areAllEqual :: Eq a => [a] -> Bool  -- prende una lista e controlla se sono tutti uguali
areAllEqual [] = True
areAllEqual (x:xs) = all (== x) xs

sameSums :: (Num a, Eq a) => [BST a] -> Bool
sameSums trees = areAllEqual (sumListOfBSTs trees)


-- 4. Scrivere un predicato bstElem per determinare se un valore e' presente in un BST.
bstElem :: (Ord a) => BST a -> a -> Bool
bstElem Void _ = False
bstElem (Node val left right) n
  | n == val = True
  | n > val = bstElem right n
  | n < val = bstElem left n


-- 5. Si scriva una funzione per eseguire l’inserimento di un dato x in un albero t
bstInsert :: (Ord a) => a -> BST a -> BST a
bstInsert x Void = Node x Void Void
bstInsert x (Node val left right)
  | x < val = Node val (bstInsert x left) right
  | otherwise = Node val left (bstInsert x right)


-- 6. Si scriva una funzione bst2List che calcola la lista ordinata degli elementi di un BST. Ci si assicuri di scrivere una funzione lineare (Inorder Traversal).
bst2List :: BST a -> [a]
bst2List Void = []
bst2List (Node val left right) = bst2List left ++ [val] ++ bst2List right

bstPostorder :: BST a -> [a] -- 6.a. Postorder Traversal
bstPostorder Void = []
bstPostorder (Node val left right) = bstPostorder right ++ [val] ++ bstPostorder left


-- 8. Si scriva una funzione filterBST p t che costruisce una lista (ordinata) di tutti gli elementi dell’albero t che soddisfano il predicato p.
filterBST :: (a -> Bool) -> BST a -> [a]
filterBST p t = filter p (bst2List t)


-- 9. Si scriva una funzione annotate che costruisca un nuovo BST che in ogni nodo contenga, al posto del valore originale, una coppia composta dal medesimo valore e dall’altezza del nodo stesso (la lunghezza del massimo cammino, cioe' 1 + max(height(sx), height(dx)). Si scelga di attribuire all’albero vuoto 0 o -1 a seconda delle preferenze. [Con una opportuna scelta dell’ordine di ricorsione si puo' fare in tempo lineare]
getHeight :: BST a -> Int  -- costo = O(n)
getHeight Void = 0
getHeight (Node val left right) = 1 + max (getHeight left) (getHeight right)

annotate :: Ord a => BST a -> BST (a, Int)  -- costo = O(n): calcolo l'altezza una volta sola e la passo alle ricorsioni decrementata per ogni livello
annotate tree = annotateHelper tree (getHeight tree)
  where
    annotateHelper :: BST a -> Int -> BST (a, Int)
    annotateHelper Void _ = Void
    annotateHelper (Node val left right) h = Node
      (val, h)
      (annotateHelper left (h - 1))
      (annotateHelper right (h - 1))

annotateOld :: Ord a => BST a -> BST (a, Int) -- costo = O(n^2): getHeight viene chiamata n volte
annotateOld Void = Void
annotateOld (Node val left right) = Node
  (val, 1 + max (getHeight (annotateOld left)) (getHeight (annotateOld right)))
  (annotateOld left)
  (annotateOld right)




{----------------------------------------x ALBERI GENERICI x----------------------------------------}
data Tree a = Nil | Vertex a [Tree a] deriving (Eq, Show)

-- 1. Si scriva una generalizzazione della funzione foldr delle liste per Alberi Generici (applica una funzione ad ogni nodo dell'albero) che abbia il seguente tipo:
treeFold :: (Eq a) => (a -> [b] -> b) -> b -> Tree a -> b
treeFold _ base Nil = base
treeFold fun base (Vertex x children) = fun x (map (treeFold fun base) children)


-- 1.a. Usa la funzione treeFold per generare l'albero con tutti i nodi che hano valore moltiplicato per 3
tripleNodeValue :: (Num a, Eq a, Show a) => Tree a -> Tree a
tripleNodeValue = treeFold (\x children -> Vertex (3 * x) children) Nil


-- 2. Si scriva una funzione height per calcolare l’altezza di un albero usando opportunamente la treeFold dell’Esercizio 1. Si attribuisca altezza -1 all’albero vuoto.
height :: (Eq a, Show a) => Tree a -> Int
height = treeFold (\_ heights -> 1 + (if null heights then 0 else maximum heights)) (-1)


--3. Si scriva una funzione simplify per eliminare i figli Void ridondanti usando opportunamente la treefold dell’Esercizio 1.
simplify :: (Eq a, Show a) => Tree a -> Tree a
simplify = treeFold (\x children -> Vertex x (filter (/= Nil) children)) Nil


-- 7. Si scriva una funzione degree che restituisce il grado di un albero (il massimo del numero di figli per ogni nodo).
degree :: (Eq a, Show a) => Tree a -> Int
degree = treeFold (\_ children -> 1 + maximum (0 : children)) 0


-- funzione che somma tutti i nodi dell'albero
sumTree :: (Eq a, Num a) => Tree a -> a
sumTree = treeFold (\x xs -> x + sum xs) 0


-- funzione che concatena tutte le stringhe dell'albero
concatTree :: Tree String -> String
concatTree = treeFold (\x xs -> x ++ concat xs) ""


-- funzione che sostituise i numeri dispari con 0
removeOddTree :: Tree Int -> Tree Int
removeOddTree = treeFold (\x cleanChildren -> if odd x then Vertex 0 cleanChildren else Vertex x cleanChildren) Nil


-- funzione che conta il numero totale di nodi
countNodes :: Eq a => Tree a -> Int
countNodes = treeFold (\_ xs -> 1 + sum xs) 0


-- funzione che il minimo valore in un albero
maxTree :: (Ord a) => Tree a -> a
maxTree = treeFold (\x xs -> minimum (x : xs)) (error "Empty tree")


-- Funzione che verifica se esiste un valore che soddisfa una certa condizione
existsCondition :: Eq a => (a -> Bool) -> Tree a -> Bool
existsCondition condition = treeFold (\x xs -> condition x || or xs) False




{----------------------------------------x QUAD TREE x----------------------------------------}

data QT a = C a | Q (QT a) (QT a) (QT a) (QT a)
  deriving (Eq , Show)

-- 1. Si scriva una funzione buildNSimplify che dati 4 QuadTree costruisca un QuadTree la cui immagine codificata sia quella ottenuta dalle 4 immagini corrispondenti ai 4 QuadTree messe nei quadranti superiore-sinistro, superiore-destro, inferiore-sinistro, inferiore-destro, rispettivamente. (Attenzione che tutti sono e devono essere QuadTrees, non solo termini di tipo QT)
buildNSimplify :: (Eq a) => QT a -> QT a -> QT a -> QT a -> QT a
buildNSimplify qt1 qt2 qt3 qt4
  | areLeavesEqual qt1 qt2 qt3 qt4 = qt1
  | otherwise = Q qt1 qt2 qt3 qt4

areLeavesEqual :: (Eq a) => QT a -> QT a -> QT a -> QT a -> Bool  -- controlla se le foglie di un QT sono uguali
areLeavesEqual qt1 qt2 qt3 qt4
  | qt1 == qt2 && qt2 == qt3 && qt3 == qt4 = True
  | otherwise = False


-- 2. Si scriva una funzione simplify che dato un termine di tipo QT genera il QuadTree corrispondente.
simplifyQT :: (Eq a) => QT a -> QT a
simplifyQT (C a) = C a
simplifyQT (Q qt1 qt2 qt3 qt4) = buildNSimplify (simplifyQT qt1) (simplifyQT qt2) (simplifyQT qt3) (simplifyQT qt4)




{----------------------------------------x MATRICI MEDIANTE QUAD TREE x----------------------------------------}

data Mat a = Mat {
  nexp :: Int ,
  mat :: QT a
  }
  deriving (Eq , Show)

-- 1. Si scriva un predicato lowertriangular che determina se una matrice e' triangolare inferiore.
isZero :: (Eq a, Num a) => QT a -> Bool
isZero (C a) = a == 0
isZero (Q a b c d) = isZero a && isZero b && isZero c && isZero d

lowertriangular :: (Eq a, Num a) => Mat a -> Bool
lowertriangular (Mat 0 (C a)) = a == 0
lowertriangular (Mat n (Q a b c d)) =
  isZero b &&                       -- quadrante superiore dx
  lowertriangular (Mat (n-1) a) &&  -- quadrante superiore sx 
  lowertriangular (Mat (n-1) d)     -- quadrante inferiore sx
lowertriangular _ = False


-- 2. Si scriva un predicato uppertriangular che determina se una matrice e' triangolare superiore.
uppertriangular :: (Eq a, Num a) => Mat a -> Bool
uppertriangular (Mat 0 (C a)) = a == 0
uppertriangular (Mat n (Q a b c d)) =
  isZero c &&
  uppertriangular (Mat (n-1) a) &&
  uppertriangular (Mat (n-1) d)
uppertriangular _ = False




{----------------------------------------x ESERCIZI EXTRA DA VECCHI ESAMI, PER FARE PRATICA x----------------------------------------}

-- Esame 12 settembre 2022
-- Si scrivano le seguenti funzioni Haskell:
-- una funzione che date due liste determina se una delle due e' una sottolista dell’altra; => per ogni elemento della prima lista lo cerco nella seconda
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


-- una funzione che data una lista determina se questa e' palindroma;
isPalyndrome :: [Int] -> Bool
isPalyndrome [] = False
isPalyndrome [x] = True
isPalyndrome (x:xs) =
  (x == last xs) && isPalyndrome (init xs)


-- una funzione che data una lista determina la lunghezza della piu' lunga sottolista finale palindroma;
getLenOfTheLastPalyndrome :: [Int] -> Int
getLenOfTheLastPalyndrome [] = 0
getLenOfTheLastPalyndrome [x] = 0
getLenOfTheLastPalyndrome (x:xs) =
  if (x == last xs) && isPalyndrome (x:xs)
    then length (x:xs)
    else getLenOfTheLastPalyndrome xs




-- Esame 4 luglio 2022 
-- Su liste aventi come elementi coppie di valori di uno stesso tipo ordinabile, scrivere le seguenti funzioni Haskell:
-- una funzione che data una lista restituisce la lista contenente le sole coppie ordinate (il primo elemento della coppia e'minore del secondo);
getOrderedPairs :: [[Int]] -> [[Int]]
getOrderedPairs = filter (\lst -> head lst < lst !! 1)


-- una funzione che data una lista di coppie le ordina, ossia scambia tra loro gli elementi di una coppie in modo che il primo sia minore del secondo;
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


-- considerando l’ordine lessicografico tra le coppie, definire una funzione che data una lista di coppie la ordina.
orderPairList :: [(Int, Int)] -> [(Int, Int)]
orderPairList [] = []
orderPairList xs = quicksort xs




-- Esame 15 giugno 2022 
-- Scrivere le seguenti funzioni Haskell:
-- una funzione che in una lista di booleani conta il numero di elemeniti uguali a True presenti nella lista
countTrue :: [Bool] -> Int
countTrue [] = 0
countTrue (x:xs)
  | x = 1+countTrue xs
  | otherwise = countTrue xs


-- una funzione che data una lista di elementi ed un valore conta il numero di volte che il valore appare nella lista;
countVal :: Eq a => [a] -> a -> Int
countVal [] _ = 0
countVal (x:xs) n
  | x == n = 1+countVal xs n
  | otherwise = countVal xs n


-- una funzione che data una lista determina il numero di massimo di ripetizioni, non necessariamente consecutive, di una stesso valore nella lista.
countMax :: Eq a => [a] -> Int
countMax [] = 0
countMax x = countMaxHelper x 0
  where
    countMaxHelper :: Eq a => [a] -> Int -> Int
    countMaxHelper [] n = n
    countMaxHelper (x:xs) n
      | countVal (x:xs) x > n = countMaxHelper xs (countVal (x:xs) x)
      | otherwise = countMaxHelper xs n




-- Esame 7 settembre 2021 
-- Scrivere le seguenti funzioni Haskell:
-- una funzione che, dati un lista e un suo possibile elemento, determina se l’elemento appartiene alla lista;
checkElement :: Eq a => [a] -> a -> Bool
checkElement [] _ = False
checkElement (x:xs) el
  | x == el = True
  | otherwise = checkElement xs el


-- una funzione che, dati un lista e un suo elemento, restituisce la lista originale senza l’elemento;
{- 
-- versione non ricorsiva
removeElement :: [Int] -> Int -> [Int]
removeElement [] _ = []
removeElement xs n = filter (/= n) xs
-}
rmvElement :: Eq a => [a] -> a -> [a]
rmvElement [] _ = []
rmvElement (x:xs) el
  | x == el = rmvElement xs el
  | otherwise = x : rmvElement xs el


-- usando le due funzioni precedenti, definire una funzione che date due liste determina se una e'la permutazione dell’altra;
isAPermutation :: Eq a => [a] -> [a] -> Bool
isAPermutation [] _ = True
isAPermutation _ [] = True
isAPermutation (x:xs) y
  | checkElement y x = isAPermutation xs (rmvElement y x)
  | otherwise = False




-- Esame 15 giugno 2021
-- Si scrivano le seguenti funzioni Haskell:
-- una funzione che dato un naturale n costruisca la lista dei fattori primi di n, scritti in ordine crescente, es con ingresso 12 la funzione restituisce [2, 2, 3]
getPrime :: Int -> [Int]
getPrime 0 = []
getPrime 1 = []
getPrime x = getPrimeHelper x 2
  where
    getPrimeHelper :: Int -> Int -> [Int]
    getPrimeHelper x n
      | x `mod` n /= 0 = getPrimeHelper x (n+1)
      | otherwise = n : getPrime (x `div` n)


-- una funzione che date due liste di fattori primi, scritte in ordine crescente, restituisce la lista dei fattori primi presenti in almeno una delle due liste, con molteplicit`a massima.
mergePrimeLists :: [Int] -> [Int] -> [Int]
mergePrimeLists [] y = y
mergePrimeLists x [] = x
mergePrimeLists (x:xs) (y:ys)
  | x == y = x : mergePrimeLists xs ys
  | x < y = x : mergePrimeLists xs (y:ys)
  | otherwise = y : mergePrimeLists (x:xs) ys


-- usando le due funzione precedenti definire una funzione per il calcolo del minimo comune multiplo tra due naturali
getMCM :: Int -> Int -> Int
getMCM x y = product (mergePrimeLists (getPrime x) (getPrime y))


-- si scriva una versione alternativa alla funzione precedente, usando le funzioni fold, se non usate nella versione originale, o non usandole, in caso contrario.
getMCMRecursive :: Int -> Int -> Int
getMCMRecursive x y = getMCMRecursiveHelper (mergePrimeLists (getPrime x) (getPrime y))
  where
    getMCMRecursiveHelper :: [Int] -> Int
    getMCMRecursiveHelper [] = 1
    getMCMRecursiveHelper (x:xs) = x * getMCMRecursiveHelper xs




-- Esame 9 settembre 2019
-- Si scriva una funzione Haskell che, prese in ingresso due liste strettamente ordinate xs e ys, costruisca una terza lista strettamente ordinata contenente tutti gli elementi che appaiono in almeno una delle due le liste xs e ys. Si rispetti perci`o il vincolo che se un elemento appare sia in xs che in ys, allora deve apparire un’unica volta nella lista risultato.
mergeLists :: [Int] -> [Int] -> [Int]
mergeLists [] y = y
mergeLists x [] = x
mergeLists (x:xs) (y:ys)
  | x == y = x : mergeLists xs ys
  | x < y = x : mergeLists xs (y:ys)
  | otherwise = y : mergeLists (x:xs) ys


-- Si scriva inoltre una funzione Haskell che, presa in ingresso una matrice memorizzata per righe, in cui ogni riga `e strettamente ordinata, costruisca una lista strettamente ordinata contenente tutti gli elementi che appaiono in almeno una riga della matrice.
mergeMatrix :: [[Int]] -> [Int]
mergeMatrix = foldr mergeLists []

mergeMatrixRecursive :: [[Int]] -> [Int]
mergeMatrixRecursive [] = []
mergeMatrixRecursive (x:xs) = mergeLists x (mergeMatrixRecursive xs)




-- Esame 2 luglio 2019
-- Si scriva una funzione Haskell che, presa in ingresso una matrice quadrata, memorizzata per righe, restituisca in uscita la sottomatrice ottenuta eliminando la prima riga e la prima colonna alla matrice originaria. 
simplifyMatrix :: [[Int]] -> [[Int]]
simplifyMatrix [] = []
simplifyMatrix (x:xs) = map init xs


-- Si scriva inoltre una funzione Haskell che, preso in ingresso una matrice quadrata, memorizzata per righe, restituisca la lista degli elementi contenuti nella diagonale della matrice. Si commenti il codice e si definisca il tipo di ogni funzione definita
getMatrixDiagonal :: [[Int]] -> [Int]
getMatrixDiagonal [] = []
getMatrixDiagonal (x:xs) = head x : getMatrixDiagonal (map tail xs)




-- Esame 19 settembre 2018
-- Scrivere una funzione Haskell che dato un numero naturale n costruisca una scacchiara di dimensione n ossia una matrice quadrata contenenti i soli valori 0 e 1 alternati
buildList :: Int -> [Int]
buildList 0 = []
buildList n = 1 : buildList (n-1)

buildBoard :: Int -> [[Int]]
buildBoard 0 = []
buildBoard n = buildList n : buildBoardHelper n (n - 1)

buildBoardHelper :: Int -> Int -> [[Int]]
buildBoardHelper _ 0 = []
buildBoardHelper n m = buildList n : buildBoardHelper n (m-1)