;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname 0.3.2_Ricorsione_ad_albero_Piattini_e_pasticcini) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Numeri di Stirling del 2 tipo

(define stirling ; val: 
  (lambda (n k)  ; n, k: interi con 1 <= k <= n

    (if (or (= k 1) (= k n))
        1
        (+ (stirling (- n 1) (- k 1))
           (* k (stirling (- n 1) k)))
        ))
  )