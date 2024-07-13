;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname 0.2.2_Ricorsione_utilizzo_del_let) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; DEFINE VS LET

; define:
; -non restituisce un valore.
; -qualcosa definito con il define funziona in tutto il programma

; let:
; -restituisce un valore.
; -qualcosa definito con il let funziona solo tra le sue parentesi

;-------------------------------------------------------------------

(define compl-a-uno ; val stringa
  (lambda (seq)     ; seq: stringa non vuota di 0 e 1
    
    (let ((n (string-length seq)))
      
      (if (>= n 2)                
          (let ((k (quotien n 2)))
            
            (string-append
             (delega (substring seq 0 k)) ; divisione dalla posizione 0 fino alla k
             (delega (substring seq k))   ; divisione dalla posizione k fino alla fine
             ))
          
          (compl seq)
          ))
    ))
