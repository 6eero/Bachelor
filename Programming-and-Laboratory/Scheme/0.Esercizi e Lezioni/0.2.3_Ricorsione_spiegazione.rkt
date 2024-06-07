;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname 0.2.3_Ricorsione_spiegazione) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(define (foo k)
  (cond ((= k  0) 0)
        (else (+
               (expt k (- k 1))
               (foo (- k 1))))))

(foo 5)
