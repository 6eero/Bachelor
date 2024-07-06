;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname |[LABORATORIO]_5_Percorsi_di_Manhattan_3D|) (read-case-sensitive #t) (teachpacks ((lib "drawings.ss" "installed-teachpacks"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "drawings.ss" "installed-teachpacks")) #f)))
(define manh      ; val: intero
  (lambda (i j k) ; i, j, k: interi non negativi

    (cond

      ; caso con due parametri = 0
      ((and (= i 0) (= j 0))
       1)
      
      ((and (= i 0) (= k 0))
       1)
      
      ((and (= j 0) (= k 0))
       1)

      
      ; caso con un parametro = 0    
      ((= i 0)
       (+ (manh i (- j 1) k)
          (manh i j (- k 1))))
      
      ((= j 0)
       (+ (manh (- i 1) j k)
          (manh i j (- k 1))))
      
      ((= k 0)
       (+ (manh (- i 1) j k)
          (manh i (- j 1) k)))
      
      
      ; caso con tutti i parametri != 0   
      (else 
       (+
        (manh i j (- k 1))
        (manh i (- j 1) k)
        (manh (- i 1) j k))
       )
      )
    ))

; Esempi
(manh 0 0 7) ; → 1
(manh 2 0 2) ; → 6
(manh 1 1 1) ; → 6
(manh 1 1 5) ; → 42
(manh 2 3 1) ; → 60
(manh 2 3 3) ; → 560