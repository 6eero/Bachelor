;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname |0.4-0_procedure di procedure|) (read-case-sensitive #t) (teachpacks ((lib "drawings.ss" "installed-teachpacks"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "drawings.ss" "installed-teachpacks")) #f)))
(define ascii-Z (char->integer #\Z))

(define codice-cesare
  (lambda (c)
    
    (let ((k (+ (char->integer c) 3)))
      (integer->char (if (> k ascii-Z)
                         (- k 26)
                         k)))
    ))

(define codice-augusto
  (lambda (c)
    
    (let ((k (+ (char->integer c) 1)))
      (integer->char (if (> k ascii-Z)
                         (- k 26)
                         k)))
    ))


(define crittazione-alla-cesare
  (lambda (msg regola)
    
    (if (string=? msg "")
        ""
        (string-append
         (string (regola (string-ref msg 0)))
         (crittazione-alla-cesare (substring msg 1) regola)
         ))
    ))

(define rotazione-alla-cesare
  (lambda (rot)
    
    (lambda (c)
      (let ((k (+ (char->integer c) rot)))
        (integer->char (if (> k ascii-Z)
                           (- k 26)
                           k)))
      )
    ))


