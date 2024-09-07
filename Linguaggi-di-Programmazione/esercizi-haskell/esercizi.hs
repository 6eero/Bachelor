{----------------------------------------x NUMERI x----------------------------------------}

-- 1 Si scriva la funzione fattoriale. Si verifichi il funzionamento calcolando 10000!
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
treeFold :: (Eq a, Show a) => (a -> [b] -> b) -> b -> Tree a -> b
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


-- 4. Si scrivano le generalizzazioni delle funzioni foldr e foldl delle liste per Alberi Generici aventi i seguenti tipi (abbiamo bisogno di due “zeri” corrispondenti all’albero vuoto e alla lista di alberi vuota):
treefoldr :: (Eq a, Show a) => (a -> b -> b) -> b -> (b -> b -> b) -> b -> Tree a -> b
treefoldr _ z _ _ Nil = z
treefoldr f z g b (Vertex x ts) = f x (foldr (flip (treefoldr f z g)) b ts)
  where
    foldr _ z []     = z
    foldr k z (x:xs) = k x (foldr k z xs)


-- 7. Si scriva una funzione degree che restituisce il grado di un albero (il massimo del numero di figli per ogni nodo).
degree :: (Eq a, Show a) => Tree a -> Int
degree = treeFold (\_ children -> 1 + maximum (0 : children)) 0


