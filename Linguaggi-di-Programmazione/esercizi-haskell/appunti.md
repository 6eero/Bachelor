# Appunti Haskell

## Composizione di funzioni `$`
`$` esegue la funzione alla sua destra e da il suo risultato come input alla funzione a lla sua sinistra

~~~ haskell
-- rimuove elementi dispari dalla lista, ordina i restanti elementi, prende i primi due
take 2 $ quicksort $ filter odd [2, 4, 6, 8]  

-- calcola il valore assoluto e poi la radice quadrata
sqrt $ abs (-16)
~~~

## Funzione `map`
`Map` restituisce una lista in cui ogni elemento è il risultato dell'applicazione della funzione passata come input all'elemento corrispondente nell'elenco di input.

~~~ haskell
map (*3) [1..5] -- [3,6,9,12,15]
map (\x -> even x) [2, 4, 6, 8] -- [True,True,True,True]
map ceiling $ map sqrt [10, 30, 60] -- [4,6,8]
~~~

## Funzione `all`
`All` è una funzione standard in Haskell che prende in input una funzione e una lista, e verifica se la funzione restituisce True per ogni elemento della lista (scorre la lista e assegna ad x il valore in test). 

~~~ haskell
all (\x -> even x) [2, 4, 6, 8] -- true
all (\x -> even x) [2, 3, 6, 8] -- false
~~~

## Funzione `filter`
`All` è una funzione standard in Haskell che prende in input una funzione e una lista, e verifica se la funzione restituisce True per ogni elemento della lista (scorre la lista e assegna ad x il valore in test). 

~~~ haskell
all (\x -> even x) [2, 4, 6, 8] -- true
all (\x -> even x) [2, 3, 6, 8] -- false
~~~

## Funzione `zip`
`Zip` applicato a due liste, restituisce una lista di coppie formate tuplando insieme gli elementi corrispondenti delle liste date. Se le due liste sono di lunghezza diversa, la lunghezza della lista risultante è quella della più corta. 

~~~ haskell
zip [1..6] "abcd" -- [(1,'a'),(2,'b'),(3,'c'),(4,'d')]
~~~