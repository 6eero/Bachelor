;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname |[LABORATORIO]_1_frase|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(define frase     ; var: stinga
  (lambda (s v c) ; s, v, c: stringhe

    ; primo articolo

    (let((a1 (cond
               [(char=? (string-ref s (- (string-length s) 1)) #\o) " il "]
               [(char=? (string-ref s (- (string-length s) 1)) #\a) " la "]
               [(char=? (string-ref s (- (string-length s) 1)) #\e) " le "]
               [(char=? (string-ref s (- (string-length s) 1)) #\i) " i "])))

      ; secondo articolo

      (let((a2 (cond
                 [(char=? (string-ref c (- (string-length c) 1)) #\o) " il "]
                 [(char=? (string-ref c (- (string-length c) 1)) #\a) " la "]
                 [(char=? (string-ref c (- (string-length c) 1)) #\e) " le "]
                 [(char=? (string-ref c (- (string-length c) 1)) #\i) " i "])))

        ; unione frase

        (string-append a1
                       s
                       " "
                       (if (string=? (substring v (- (string-length v) 3)) "are")
                           (if (or (char=? (string-ref s (- (string-length s) 1)) #\o)(char=? (string-ref s (- (string-length s) 1)) #\a))
                               (substring v 0 (- (string-length v) 2))
                               (string-append (substring v 0 (- (string-length v) 3)) "ano"))
                                     
                           (if (string=? (substring v (- (string-length v) 2)) "re")
                               (if (or (char=? (string-ref s (- (string-length s) 1)) #\e)(char=? (string-ref s (- (string-length s) 1)) #\i))
                                   
                                   (string-append (substring v 0 (- (string-length v) 3)) "ono")
                                   (substring v 0 (- (string-length v) 2)))
                                        
                               "non va"))
                       a2
                       c)
        ))
    ))

(frase "gatto" "cacciare" "topi")
(frase "mucca" "mangiare" "fieno")
(frase "sorelle" "leggere" "novella")
(frase "bambini" "amare" "favole")
(frase "musicisti" "suonare" "pianoforti")
(frase "cuoco" "friggere" "patate")
(frase "camerieri" "servire" "clienti")
(frase "mamma" "chiamare" "figlie")




    
      
    
