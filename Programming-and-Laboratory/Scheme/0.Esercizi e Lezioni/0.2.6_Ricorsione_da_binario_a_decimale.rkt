;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname 0.2.6_Ricorsione_da_binario_a_decimale) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(define f ; val: intero
  (lambda (bin) ; bin: stringa di 0/1

    (let((k (- (string-length bin) 1))) ; Chiamo k la posizione della cifra meno significativa
      
      (if (= k 0)
          (g bin)
          (+                                   ; 2q
           (* 2 (f (substring bin 0 k))) ; Delego la rapp delle cifre piu significative
           (g (substring bin k))
           )))
    ))

(define g   ; val: intero
  (lambda(bit)    ; bit: stringa 0/1
    
    (if (string=? bit "0")
        0
        1)
    ))

(f "1010") ; -> 2




