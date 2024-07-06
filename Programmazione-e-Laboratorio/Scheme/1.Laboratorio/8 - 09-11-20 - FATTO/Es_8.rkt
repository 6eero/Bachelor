;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Es_8) (read-case-sensitive #t) (teachpacks ((lib "hanoi.ss" "installed-teachpacks"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "hanoi.ss" "installed-teachpacks")) #f)))
(define hanoi-moves ; val: lista di coppie
  (lambda (n)       ; n > 0 intero
    
    (hanoi-rec n 1 2 3)
    ))

(define hanoi-rec   ; val: lista di coppie
  (lambda (n s d t) ; n intero, s, d, t: posizioni
    
    (if (= n 1)
        (list (list s d))
        (let ((m1 (hanoi-rec (- n 1) s t d))
              (m2 (hanoi-rec (- n 1) t d s))
              )
          (append m1 (cons (list s d) m2))
          ))
    ))

; Nel caso di una torre iniziale di altezza n = 3, per esempio, il rompicapo
; viene risolto in 7 mosse, rappresentate dalla seguente lista di coppie che
; risulta dall’applicazione della procedura hanoi-moves:
(hanoi-moves 3)

(define hanoi-disks
  (lambda (n k)      ; n: # dischi, k: # mosse
    
    (hrec k n 1 2 3 0 0 0)
    ))

(define hrec                    ; s: asta iniziale, d: asta finale, t: asta di transito
  (lambda (k n s d t ns nd nt)  ; ns: # dischi in s, nd: # dischi in d, nt: # dischi in t

    (if (= n 0)
        (list (list s ns)(list d nd)(list t nt))
        (if (< k (expt 2 (- n 1)))
            (hrec k (- n 1) s t d (+ ns 1) nt nd)
            (hrec (- k (expt 2 (- n 1))) (- n 1) t d s nt (+ nd 1) ns)
            )
        )
    ))

(define hanoi-picture
  (lambda (n k)

    (han-pic-rec k n 1 2 3 0 0 0 (towers-background n) n)
    ))

(define han-pic-rec
  (lambda (k n s d t ns nd nt pic n-base)

    (if (= n 0)
        pic
        (if (< k (expt 2 (- n 1)))
            (han-pic-rec k (- n 1) s t d (+ ns 1) nt nd (above (disk-image n n-base s ns) pic) n-base)
            (han-pic-rec (- k (expt 2 (- n 1))) (- n 1) t d s nt (+ nd 1) ns (above (disk-image n n-base d nd) pic) n-base)
            )
        )
    ))

(hanoi-disks 3 0)
(hanoi-picture 3 0)
(hanoi-disks 5 19)
(hanoi-picture 5 19)