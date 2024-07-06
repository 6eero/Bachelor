;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname 0.2.7_Ricorsione_da_base_b_a_decimale) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Rappresentazione in base B di un intero non negativo
;; 2 <= B <= 16 (cifre in base >10: 0, 1, ..., 9, A, B, ..., F)

;; n = B*q + r

(define num-rep  ; bin-rep -> rapprenentazione binaria (val: string di 1/0)
  (lambda (n b)  ; n: intero non negativo, b: intero [2->16] -> rappresenta la base
    
    (if (< n b)
        (digit-rep n)       ; Caso base
        
        (let ((q (quotient  n b)) ; q -> quoziente della divisione per b (ha come risultato un intero)
              (r (remainder n b)) ; r -> resto della divisione per b
              )
          
          (string-append  ; Unisco le due stringhe (concretamente sto facendo 2q + r)
           (num-rep q b)  ; Delego l'interpretazione di q a qualcuno che la sa fare (2q) in base b
           (digit-rep r)  ; Rappresentazione della cifra r
           )))
    ))
  
(define digit-rep ;val: string, Rappresentazione del solo bit di valore r
  (lambda (b)     ; b: [0->9] + [A->F]
    (if (< b 10)
        (string (integer->char (+ zero b)))
        (string (integer->char (+ capa (- b 10))))
        )
    ))
  
(define zero (char->integer #\0))

(define capa (char->integer #\A))
