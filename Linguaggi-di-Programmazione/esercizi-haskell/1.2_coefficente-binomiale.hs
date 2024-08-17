-- Si scriva la funzione (n su k), combinazioni di k elementi su n.

factorial :: Integer -> Integer
factorial 0 = 1
factorial n = n * factorial (n - 1)

binomial :: Integer -> Integer -> Integer
binomial n 0 = 1
binomial 0 k = 0
binomial n k = factorial n `div` (factorial k * factorial (n - k))