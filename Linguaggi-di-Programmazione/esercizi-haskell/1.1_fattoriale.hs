-- Si scriva la funzione fattoriale. Si verifichi il funzionamento calcolando 10000!

factorial :: Integer -> Integer
factorial 0 = 1
factorial n = n * factorial (n - 1)
