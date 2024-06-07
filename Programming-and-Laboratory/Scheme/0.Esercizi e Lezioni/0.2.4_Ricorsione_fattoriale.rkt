;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname 0.2.4_Ricorsione_fattoriale) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(define (fattoriale n)
  (cond
    ((= n 1) 1)
    ((number? n)(* n (fattoriale (- n 1))))
    ))

(fattoriale 2)