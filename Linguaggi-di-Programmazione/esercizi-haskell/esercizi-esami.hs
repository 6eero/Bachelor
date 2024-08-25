-- 12 settembre 2022 - Si scrivano le seguenti funzioni Haskell:

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
isPalyndrome [] = True
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

-- una funzione che data una lista determina la lunghezza della piu' lunga sottolista palindroma.
fun1 :: [Int] -> Int
fun1 [] = 0
fun1 [x] = 1
fun1 (x:xs) =
  if x == last xs && isPalyndrome (x:xs)
    then length (x:xs)
    else fun1 xs

fun2 :: [Int] -> Int
fun2 [] = 0
fun2 [x] = 1
fun2 (x:xs) =
  if x == last xs && isPalyndrome (x:xs)
    then length (x:xs)
    else fun2 (init xs)
