;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname 0.3.0_Tassellazione) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Problema irrisolvibile senza l'utilizzo della ricorsione:

;; Tassellazioni lineari con piastrelle quadrate e rettangolari

(define tass-qr  ; val: intero
  (lambda (n)    ; n: intero positivo (spazio da tassellare)
    
    (cond ((= n 1) 1) ; In quanti modi posso riempire uno spazio 1x1
          ((= n 2) 2) ; In quanti modi posso riempire uno spazio 2x1
          (else
           (+ (tass-qr (- n 2))
              (tass-qr (- n 1)))
           ))
    ))


;; Tassellazioni lineari con piastrelle quadrate rosse o blu senza
;; avere due rosse adiacenti

(define tass-rb  ; val: intero
  (lambda (n)    ; n: intero positivo (spazio da tassellare)
    
    (cond ((= n 1) 2) ; In quanti modi posso riempire uno spazio 1x1
          ((= n 2) 3) ; In quanti modi posso riempire uno spazio 2x1
          (else
           (+ (tass-rb (- n 2))
              (tass-rb (- n 1)))
           ))
    ))