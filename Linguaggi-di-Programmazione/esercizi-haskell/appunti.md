# Appunti Haskell

## Operatori

#### Operatore di composizione di funzioni `$`
`$` esegue la funzione alla sua destra e da il suo risultato come input alla funzione a lla sua sinistra

~~~ haskell
-- rimuove elementi dispari dalla lista, ordina i restanti elementi, prende i primi due
take 2 $ quicksort $ filter odd [2, 4, 6, 8]  

-- calcola il valore assoluto e poi la radice quadrata
sqrt $ abs (-16)
~~~

#### Operatore di accesso per indice `!!`
`!!` data una lista ed un valore, restituisce l'elemento della lista la cui posizione è la stessa del numero.

~~~ haskell
[1,2,3,4] !! 0 -- 1
[1..1000] !! 453 -- 454
~~~

## Funzioni

#### Funzione `map`
`Map` restituisce una lista in cui ogni elemento è il risultato dell'applicazione della funzione passata come input all'elemento corrispondente nell'elenco di input.

~~~ haskell
map (*3) [1..5] -- [3,6,9,12,15]
map (\x -> even x) [2, 4, 6, 8] -- [True,True,True,True]
map ceiling $ map sqrt [10, 30, 60] -- [4,6,8]

-- fixPair prende una coppia e la ritorna ordinata
fixPair :: (Int, Int) -> (Int, Int)
fixPair (a, b) = if a > b then (b, a) else (a, b)
-- uso fixPair su ogni elemento di una lista di coppie per tornare una lista di coppie ordinate
fixListPairs :: [(Int, Int)] -> [(Int, Int)]
fixListPairs = map fixPair
~~~

#### Funzione `all`
`All` è una funzione standard in Haskell che prende in input una funzione e una lista, e verifica se la funzione restituisce True per ogni elemento della lista (scorre la lista e assegna ad x il valore in test). 

~~~ haskell
all (\x -> even x) [2, 4, 6, 8] -- true
all (\x -> even x) [2, 3, 6, 8] -- false
~~~

#### Funzione `filter`
`filter` applicato a un predicato e a una lista, restituisce una lista contenente tutti gli elementi della lista di input che soddisfano il predicato.. 

~~~ haskell
filter (\x -> even x) [1,2,3,4,5] -- [2,4]
filter (/= 3) [1..4] -- [1,2,4]

-- ritorna le coppie in cui il primo elemento è minore del secondo
filter (\lst -> (lst !! 0 < lst !! 1)) [[1,2],[3,2],[5,9]] -- [[1,2],[5,9]]
~~~

#### Funzione `zip`
`Zip` applicato a due liste, restituisce una lista di coppie formate tuplando insieme gli elementi corrispondenti delle liste date. Se le due liste sono di lunghezza diversa, la lunghezza della lista risultante è quella della più corta. 

~~~ haskell
zip [1..6] "abcd" -- [(1,'a'),(2,'b'),(3,'c'),(4,'d')]
~~~

#### Funzione `zipWith`
`zipWith` applicato ad una funzione binaria e a due liste, restituisce una lista contenente elementi formati applicando la funzione ai corrispettivi elementi nelle liste. 

~~~ haskell
zipWith (+) [1,2,3] [4,5,6] -- [5,7,9]
zipWith (\x y -> x == y) [1,2,3] [1,2,3] --[True,True,True]
~~~

#### Funzione `foldr`
`foldr` prende tre input:
1. una funzone binaria
2. un valore iniziale
3. una lista

La funzione `foldr` applica la funzione passata come input al valore iniziale e all' elemento piu a destra della lista, poi applica il risultato dell'operazione all'elemento successivo, e così via fino alla fine della lista.

~~~ haskell
-- Esegue l'or di tutti gli elementi della lista, partendo da un booleano falso
foldr (||) False [True,False,False] --True

-- Somma tutti gli elementi di una lista
foldr (+) 0 [1, 2, 3] -- 1 + (2 + (3 + 0)) = 6
~~~

#### Funzione `tail`
`tail` applicata ad una lista, la ritorna senza il primo elemento

~~~ haskell
tail [1,2,3] --[2,3]
~~~

<br>

# Liste
## Funzioni 
~~~ haskell
-- prende in input una lista e un elemento. Torna true se l'elemento si trova nella lista
containsElement :: Eq a => [a] -> a -> Bool
containsElement [] _ = False
containsElement (x:xs) el
  | x == el = True
  | otherwise = containsElement xs el

-- prende in input una lista e un elemento. Torna la lista senza tutte le occorrenze dell'elemento
removeElement :: Eq a => [a] -> a -> [a]
removeElement [] _ = []
removeElement (x:xs) el
  | x == el = removeElement xs el
  | otherwise = x : removeElement xs el

-- prende in input una lista. Torna true se tutti gli elementi che contiene sono uguali
areAllEqual :: Eq a => [a] -> Bool
areAllEqual [] = True
areAllEqual (x:xs) = all (== x) xs

-- quicksort
quicksort :: Ord a => [a] -> [a]
quicksort [] = []
quicksort [x] = [x]
quicksort (pivot:xs) = quicksort [x | x <- xs, x <= pivot] ++ [pivot] ++ quicksort [x | x <- xs, x > pivot]
~~~ 

<br>

# Matrici
## Funzioni 
~~~ haskell
-- prende in input una matrice e ne scambia righe con colonne 
-- transpose [[1,2,3],[4,5,6],[7,8,9]] -> [[1,4,7],[2,5,8],[3,6,9]]
transpose :: [[a]] -> [[a]]
transpose ([]:_) = []
transpose x = map head x : transpose (map tail x)
~~~ 

<br>

# BST
## Definizione 
~~~ haskell
data BST a = Void | Node {
    val :: a,
    left :: BST a,
    right :: BST a
} deriving (Eq, Ord, Read, Show)
~~~ 
Un esempio e' il seguente: 

~~~ haskell
Node 22 
 (Node 12 (Node 8 Void Void) (Node 20 Void Void)) 
 (Node 30 (Node 25 Void Void) (Node 40 Void Void))

     22
    /  \
  12    30
 / \    / \
8  20  25  40
~~~ 

## Funzioni
~~~ haskell
-- inserisce un elemento in un BST
bstInsert :: (Ord a) => a -> BST a -> BST a
bstInsert x Void = Node x Void Void 
bstInsert x (Node val left right)
  | x < val = Node val (bstInsert x left) right
  | otherwise = Node val left (bstInsert x right)

-- ritorna true se l'elemento dato come input esiste nel BST
bstElem :: (Ord a) => BST a -> a -> Bool
bstElem Void _ = False
bstElem (Node val left right) n
  | n == val = True
  | n > val = bstElem right n
  | n < val = bstElem left n 

-- ritorna la somma di tutti gli elementi in un albero
bstSum :: Num a => BST a -> a
bstSum Void = 0
bstSum (Node val left right) = val + bstSum left + bstSum right

-- ritorna la lista ordinata degli elementi nell'albero
bstInorder :: BST a -> [a]
bstInorder Void = []
bstInorder (Node val left right) = bstInorder left ++ [val] ++ bstInorder right

-- ritorna l'altezza dell'albero
getHeight :: BST a -> Int
getHeight Void = 0
getHeight (Node val left right) = 1 + max (getHeight left) (getHeight right)
~~~ 

# Alberi Generici
## Definizione 
~~~ haskell
data Tree a = Nil | Vertex a [Tree a] deriving (Eq, Show)
~~~ 
Un esempio e' il seguente: 

~~~ haskell
Vertex 1 [
  Vertex 2 [],
  Vertex 3 [ Vertex 5 [], Vertex 6 [] ],
  Vertex 4 []
]
   1
 / | \
2  3  4
  / \
 5   6

 (Vertex x children):
 - x: int = 1
 - children: list =  [ Vertex 2 [], Vertex 3 [Vertex 5 [], Vertex 6 []], Vertex 4 [] ]
~~~ 

## Funzioni
### treeFold
La funzione `treeFold` riduce un albero a un singolo valore. Prende tre argomenti:

1. **Una funzione di accumulo**: Questa funzione definisce come combinare il valore del nodo corrente con i risultati dei suoi sottoalberi. La funzione di accumulo ha il tipo `a -> [b] -> b`, dove `a` è il valore del nodo corrente e `[b]` è la lista dei risultati accumulati dai sottoalberi.

2. **Un valore base**: Questo è il valore iniziale con cui iniziare il processo di accumulazione. Ha il tipo `b`.

3. **Un albero**: La struttura dell'albero su cui si desidera applicare il fold, con tipo `Tree a`.

Il risultato della funzione è un valore di tipo `b` che rappresenta il risultato finale dell'operazione di fold sull'intero albero.
~~~ haskell
treeFold :: (Eq a, Show a) => (a -> [b] -> b) -> b -> Tree a -> b
treeFold _ base Nil = base
treeFold fun base (Vertex x children) = fun x (map (treeFold fun base) children)

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

-- funzione ritorna che il minimo valore in un albero
minTree :: (Ord a) => Tree a -> a
minTree = treeFold (\x xs -> minimum (x : xs)) (error "Empty tree")

-- funzione che verifica se esiste un valore che soddisfa una certa condizione
-- existsCondition (==2) (Vertex 5 [Vertex 3 [], Vertex 2 []]) -> True
-- existsCondition (<3) (Vertex 5 [Vertex 3 [], Vertex 2 []]) -> True
-- existsCondition (even) (Vertex 5 [Vertex 3 [], Vertex 2 []]) -> True
existsCondition :: Eq a => (a -> Bool) -> Tree a -> Bool
existsCondition condition = treeFold (\x xs -> condition x || or xs) False
~~~ 