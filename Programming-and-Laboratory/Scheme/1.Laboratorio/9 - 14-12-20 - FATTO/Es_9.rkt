;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Es_9) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;*--------------------------------------------------------------------*
;|   Rotazione alla cesare con alfabeto latino ABCDEFGHILMNOPQRSTVX   |
;*--------------------------------------------------------------------*

(define ascii_J (char->integer #\J))
(define ascii_U (char->integer #\U))
(define ascii_W (char->integer #\W))
(define ascii_X (char->integer #\X))

(define rotazione_cesare_lat        ;val procedura
  (lambda (r)                       ;r: intero in [0,25]
    
    (lambda (c)                     ;c lettera maiuscola
      (let ((k (+ (char->integer c) r)))
        (integer->char
         (cond ((> k ascii_X) (- k 24))
               ((= k ascii_J) (+ k 2))
               ((= k ascii_U) (+ k 1))
               ((= k ascii_W) (+ k 1)))
         ))
      )))

;*----------------------------------------------------------*
;|   PARTE 2: Operazioni sotto forma procedurale con succ   |
;*----------------------------------------------------------*

;+---------------+ funzione con 1 argomento +---------------+

(define succ
  (lambda (v)
    
    (+ v 1)
    ))

(define add
  (lambda (m n)
    (if (= n 0)
        m
        (succ (add m (- n 1))))
    ))

(define mul
  (lambda (m n)
    (if (= n 0)
        0
        (add m (mul m (- n 1))))
    ))

(define pow
  (lambda (m n)
    (if (= n 0)
        1
        (mul m (pow m (- n 1))))
    ))

;+---------------+ funzione con 2 argomento +---------------+

(define s2
  (lambda (u v)
    (+ v 1)
    ))

(define H
  (lambda (f g)
    (lambda (m n)
      (if (= n 0)
        (f m)
        (g m ((H f g) m (- n 1))))
      )))

(define add_ (H (lambda (x) x) s2))
(define mul_ (H (lambda (x) 0) add_))
(define pow_ (H (lambda (x) 1) mul_))



(add_ 9 0)
(mul_ 9 0)
(pow_ 9 0)

(add_ 7 1)
(mul_ 7 1)
(pow_ 7 1)

(add_ 4 3)
(mul_ 4 3)
(pow_ 4 3)