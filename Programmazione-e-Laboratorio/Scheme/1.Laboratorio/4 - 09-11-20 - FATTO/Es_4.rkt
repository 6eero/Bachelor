;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Es_4) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;Data una rappresentazione BTR, restituisce la cifra meno significativa
;; oppure zero (#\.) se l’argomento è la stringa vuota
(define lsd            ;val: char
  (lambda (str)        ;str: stringa
    (if (string=? str "")
        #\.                 ;stringa vuota, ritorna 0 (#\.)
        (string-ref str (- (string-length str) 1)))
    ))

;;Data una rappresentazione BTR, restituisce la parte che precede l’ultima
;; cifra oppure la stringa vuota ("") se l’argomento è la stringa vuota
(define head
  (lambda (str)
    (if (string=? str "")
        ""                  ;stringa vuota
        (substring str 0 (- (string-length str) 1)))
    ))

;;Date due cifre BTR restituisce il valore della somma senza riporto
(define btr_small_sum        ;val: char
  (lambda (a b)              ;a, b: char
    ;restiusce l'altro carattere se uno è 0
    (if (char=? a #\.)
        b
        (if (char=? b #\.)
            a
            ;se uguali ritorna il simbolo "opposto"
            (if (char=? a b)
                (if (char=? a #\+)
                    #\-
                    #\+)
                ;0 se diversi
                #\.)))
    ))

;;Date due cifre BTR restituisce il valore del riporto della somma
(define btr_small_carry     ;val: char
  (lambda (a b)             ;a, b: char
    ;ritorna il valore relativo se concordi e diversi da 0
    (cond ((and (char=? a b) (not (char=? a #\.)))
           (if (char=? a #\+)
            #\+
            #\-))
          ;0 negli altri casi
          (else #\.))
    ))

;;Date due cifre BTR “incolonnate” e il relativo riporto BTR restituisce 
;; la cifra BTR corrispondente della rappresentazione della somma
(define btr_digit_sum         ;val: char
  (lambda (a b carry)         ;a, b, carry: char
    (if (char=? carry #\.)
        (btr_small_sum a b)
        (btr_small_sum a (btr_small_sum b carry)))
    ))

;;Date due cifre BTR e il relativo riporto BTR, restituisce il riporto BTR
(define btr_digit_carry       ;val: char
  (lambda (a b carry)         ;a, b, carry: char
    (if (char=? carry #\.)
        ;semplifico le operazione se non c'è riporto
        (btr_small_carry a b)
              ;tutti i caratteri sono uguali
        (cond ((and (char=? a carry)
                    (char=? a b))
               carry)
              ;ho solo due cifre uguali e un punto
              ((and (or (char=? a #\.) (char=? b #\.))
                    (or (char=? a carry) (char=? b carry)))
               carry)
              ;tutti gli altri casi non generano riporto
              (else #\.)))
    ))

;;Data una rappresentazione BTR, restituisce la stessa rappresentazione
;; senza eventuali 0 privi di informazione utile in testa
(define normalized_btr       ;val: string
  (lambda (btr)              ;btr: string
    (cond ((and (> (string-length btr) 1)
                (char=? (string-ref btr 0) #\.))
           (normalized_btr (substring btr 1)))
           (else btr))
    ))

;;date le rappresentazioni BTR di due interi e il riporto,
;; restituisce la rappresentazione BTR della somma inclusiva del riporto
(define btr_carry_sum                   ;val: string
  (lambda (btr_1 btr_2 carry)           ;btr_1, btr_2: string
                                        ;carry: char
           ;stringhe vuote, fine ricorsione
    (cond ((and (string=? btr_1 "")
                (string=? btr_2 ""))
           (string carry))            ;possibile riporto finale
          (else
                          ;ricorsione ai due interi senza la cifra meno significativa
           (string-append (btr_carry_sum
                                   (head btr_1)
                                   (head btr_2)
                                   ;riporto generato dalla cifra meno significativa
                                   ;di questa ricorsione
                                   (btr_digit_carry (lsd btr_1)
                                                    (lsd btr_2)
                                                    carry))
                          ;calcolo del valore della somma delle cifre meno significative
                          ;di questa ricorsione 
                          (string (btr_digit_sum (lsd btr_1)
                                                 (lsd btr_2)
                                                 carry)))))
    ))
          
;;Dati due interi in notazione BTR, ritorna la rappresentazione BTR della somma.
(define btr_sum               ;val: string
  (lambda (btr_1 btr_2)       ;btr_1, btr_2: string
    (normalized_btr
     (string-append
      ;calcolo dei restanti valori delle somme
      (btr_carry_sum (head btr_1)
                     (head btr_2)
                     (btr_digit_carry (lsd btr_1)
                                      (lsd btr_2)
                                      #\.))
      ;calcolo del valore della somma delle cifre meno significative
      (string (btr_small_sum (lsd btr_1)
                             (lsd btr_2)))))
    ))

;--------------- ESEMPI ----------------------------------------------

(btr_sum "-+--" "+")
(btr_sum "-+--" "-")
(btr_sum "+-.+" "-+.-")
(btr_sum "-+--+" "-.--")
(btr_sum "-+-+." "-.-+")
(btr_sum "+-+-." "+.+-")

;---------------------------------------------------------------------