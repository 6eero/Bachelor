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

La funzione `foldr` applica la funzione passata come input al al valore iniziale e al primo elemento della lista, poi applica il risultato dell'operazione all'elemento successivo, e così via fino alla fine della lista.

~~~ haskell
-- Esegue l'or di tutti gli elementi della lista, partendo da un booleano falso
foldr (||) False [True,False,False] --True

-- Somma tutti gli elementi di una lista
foldr (+) 0 [1..5] -- 15
~~~