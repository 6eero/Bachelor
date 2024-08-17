-- Scrivere il QuickSort (polimorfo)

{-
Pseudocodice:
Quicksort(A)
  begin
    if n ≤ 1 
      return A
    else
        scegli un elemento pivot
        calcola il vettore A1 dagli elementi ai di A tali che i ≠ k e ai ≤ pivot
        calcola il vettore A2 dagli elementi aj di A tali che j ≠ k e aj > pivot
        A1 ← Quicksort(A1)
        A2 ← Quicksort(A2)
        return A1 + (pivot) + A2;
-}

quicksort :: [Int] -> [Int]
quicksort [] = []
quicksort [x] = [x]
quicksort (pivot:xs) =  quicksort [x | x <- xs, x <= pivot] ++ [pivot] ++ quicksort [x | x <- xs, x > pivot]
