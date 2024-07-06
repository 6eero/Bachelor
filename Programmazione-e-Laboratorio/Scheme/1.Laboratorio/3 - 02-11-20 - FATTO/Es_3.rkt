;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Es_3) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;------------- PARTE UNO ---------------------------------------------------
;Rappresentazione decimale di un numero binario con parte intera e frazionaria
;---------------------------------------------------------------------------

;;stabilisce quale carattere è il punto
;; ne restituisce la posizione nella stringa

(define pos_punto              ;val: uint
  (lambda (stringa pos)        ;stringa: string di 0/1 + "./+/-"
                               ;pos: uint posizione da cui iniziare a cercare (0)
          ;condizione ricorsiva, valida finchè non si trova il "."
          ; e sono presenti caratteri non controllati
    (cond ((and (< pos (string-length stringa))
                (not (char=? (string-ref stringa pos) #\.)))
           (pos_punto stringa (+ pos 1)))
          ;il "." è il primo carattere della stringa,
          ; ritorna la lunghezza della stringa
          ((and (= pos (string-length stringa))
                (not (char=? (string-ref stringa (- pos 1)) #\.)))
           (string-length stringa))
          ;in ogni altro caso ritorna la posizione del "."
          (else pos))
    ))


;;ritorna TRUE se è presente un segno nella stringa fornita

(define segno?             ;val: bool
  (lambda (stringa)        ;stringa: string di 0/1 + "./+/-"
    (cond ((or (char=? (string-ref stringa 0) #\+)
               (char=? (string-ref stringa 0) #\-))
           #t)
          (else #f))
    ))


;;ritorna i numeri 1 o 0 in relazione al carattere fornito

(define bit_val         ;val: uint
  (lambda (b)           ;b: char
    (if (string=? b "1")
        1
        0
        )
    ))


;;Trasforma una stringa di cifre binarie in un numero intero
;; il calcolo è basato sulla parte intera

(define calc_int          ;val: uint
  (lambda (n)             ;n: string di 0/1
    (let ((k (- (string-length n) 1)))
      (if (<= k 0)
          (bit_val n)             ;ultima cifra
          (+
           (* 2 (calc_int (substring n 0 k)))   ;ricorsione al numero precedente
           (bit_val (substring n k)))           ;valore del numero attuale
          ))
    ))


;;Trasforma una stringa di cifre binarie in un numero intero
;; il calcolo è basato sulla parte frazionaria

(define calc_fraz         ;val: uint
  (lambda (n)             ;n: string di 0/1
    (let ((k (string-length n)))
      (if (<= k 1)          
          (* 1/2 (bit_val n))     ;ultima cifra
          (+
           (calc_fraz (substring n 0 (- k 1)))         ;ricorsione al numero precedente
           (* (/ 1 (expt 2 k))
              (bit_val (substring n (- k 1))))))       ;valore del numero attuale
          )
    ))


;;Calcola il numero completo di parte intera e frazionaria

(define bin_rep
  (lambda (n)
    ;controllo se il punto è il primo carattere
    (cond ((= (pos_punto n 0) (string-length n))
              (calc_int n))
             (else
              (+ (calc_int (substring n 0 (pos_punto n 0)))
                 (calc_fraz (substring n (+ (pos_punto n 0) 1))))
             ))
    ))


;;chiama la funzione di calcolo e rende il numero negativo se necessario

(define bin_rep->number
 (lambda (n)
   (if (char=? (string-ref n 0) #\-)
       (- 0 (bin_rep (substring n 1)))
       (bin_rep n))
       ))

;-------------CALCOLI PARTE UNO --------------------------------------------
          
;(bin_rep->number "+1101")
;(bin_rep->number "0")
;(bin_rep->number "10110.011")
;(bin_rep->number "-0.1101001")


;------------- PARTE DUE ---------------------------------------------------
;Rappresentazione decimale di un numero con parte intera e frazionaria
; fornita la base con ogni carattere presente al suo interno
; partendo dall' elelemento con il minor peso e andando ad incrementare
;---------------------------------------------------------------------------

;;ritorna il peso del carattere in relazione alla base

(define bit_val_b         ;val: uint
  (lambda (base x)        ;b: string
                          ;x: char (carattere da controllare)
    (if (char=? x (string-ref base 0))
        0
        ;ricorsione finchè non viene trovato il carattere
        (+ 1 (bit_val_b (substring base 1) x)))
    ))

;;Trasforma una stringa di cifre in un numero intero di base fornita
;; il calcolo è basato sulla parte intera

(define calc_int_b        ;val: uint
  (lambda (base num)      ;base: string
                          ;num: string (parte int.)
    (let ((k (- (string-length num) 1)))
      (if (<= k 0)
          (bit_val_b base (string-ref num 0))            ;ultima cifra
          (+
           (* (string-length base)
              (calc_int_b base
                          (substring num 0 k)))          ;ricorsione al numero precedente
           (bit_val_b base
                      (string-ref num k)))               ;valore del numero attuale
          ))
    ))

;;Trasforma una stringa di cifre in un numero intero di base fornita
;; il calcolo è basato sulla parte frazionaria

(define calc_fraz_b       ;val: uint
  (lambda (base num)      ;base: string
                          ;num: string (parte fraz.)
    (let ((k (string-length num))
          (z (string-length base)))
      (if (<= k 1)          
          (* (/ 1 z) (bit_val_b base
                                (string-ref num 0)))     ;ultima cifra
          (+
           (calc_fraz_b base
                        (substring num 0 (- k 1)))       ;ricorsione al numero precedente
           (* (/ 1 (expt z k))
              (bit_val_b base
                         (string-ref num (- k 1)))))     ;valore del numero attuale
          ))
    ))

;;Calcola il numero completo di parte intera e frazionaria

(define rep_b
  (lambda (base num)
    ;controllo se il punto è l'ultimo carattere
    (cond ((= (pos_punto num 0) (string-length num))
              (calc_fraz_b base num))
             (else
              ;somma delle due parti
              (+ (calc_int_b base
                             (substring num 0 (pos_punto num 0)))
                 (calc_fraz_b base
                              (substring num (+ (pos_punto num 0) 1))))
             ))
    ))

;;chiama la funzione di calcolo e rende il numero negativo se necessario

(define rep->number
  (lambda (base num)
    
    (if (char=? (string-ref num 0) #\-)        ;caso -
        (- 0 (rep_b base (substring num 1)))
        (if (char=? (string-ref num 0) #\+)    ;caso +
            (rep_b base (substring num 1))
            (rep_b base num)))                 ;ogni altro caso
    ))

;---------------------------------------------------------------------------

;-------------CALCOLI PARTE DUE --------------------------------------------

;(rep->number "zu" "-uuzz")
;(rep->number "0123" "+21.1")
;(rep->number "01234" "-10.02")
;(rep->number "0123456789ABCDEF" "0.A")
;(rep->number "0123456789ABCDEF" "1CF.0")

;---------------------------------------------------------------------------
    
 
