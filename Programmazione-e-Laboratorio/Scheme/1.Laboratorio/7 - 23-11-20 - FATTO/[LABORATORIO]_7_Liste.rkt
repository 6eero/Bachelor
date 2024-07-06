;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname |[LABORATORIO]_7_Liste|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(define belong?  ;val: valore booleano
  (lambda (x S)  ; x: numero intero, S: lista ordinata

    (if (null? S)
        #false
        (if (= (car S) x)
            #true
            (belong? x (cdr S))
            )
        )
    ))

(define position
  (lambda (x S)    ; x: intero, S: lista

    (if (null? S)
        #false
        (if (= (car S) x)
            0
            (+ 1 (position x (cdr S)))  ; incrementa e analizza la lista senza il primo elemento
            )
        )
    ))

(define sorted-ins
  (lambda (x S)

    (if (null? S)
        (cons x S)
        (if (> (car S) x)
            (cons x S)                         ; primo elemento della lista > x -> x come primo elemento
            (if (= x (car S))
                S
                (cons (car S)(sorted-ins x (cdr S))))  ; 
            )
        )
    ))

; idea: applico sorted-ins passandogli come parametri il primo elemento della lista e
;       la lista a cui è stato tolto il primo elemento in modo da inserirlo nella
;       posizione corretta. poi ricorsivamente faccio la stessa cosa

(define sorted-list
  (lambda (S)
    (cond ((null? (cdr S))
           (cons (car S) null))
          (else
           (sorted-ins (car S) (sorted-list(cdr S)))
          )
    )
  )
)

(belong? 18 '())
(belong? 18 '(5 7 10 18 23))
(belong? 18 '(5 7 10 12 23))

(position 7 '(7 8 24 35 41))
(position 35 '(7 8 24 35 41)) 
(position 41 '(7 8 24 35 41))

(sorted-ins 24 '()) 
(sorted-ins 5 '(7 8 24 35 41))
(sorted-ins 24 '(7 8 24 35 41))
(sorted-ins 27 '(7 8 24 35 41))

(sorted-list '(35 8 41 24 7))