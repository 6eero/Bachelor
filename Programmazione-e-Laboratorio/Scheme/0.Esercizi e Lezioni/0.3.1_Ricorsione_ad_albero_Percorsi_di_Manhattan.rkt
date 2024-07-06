;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname 0.3.1_Percorsi_di_Manhattan) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Formulazione del problema ed esemplificazione:
;; Quartiere stile "Manhattan", dove gli incroci A e B distano
;; fra loro i isolati verticalmente e j isolati orizzontalmente

;;       A   A'
;;       .---.---.---.---.---.---.---.
;;       |   |   |   |   |   |   |   |
;;    A" .---.---.---.---.---.---.---.
;;       |   |   |   |   |   |   |   |
;;       .---.---.---.---.---.---.---.
;;       |   |   |   |   |   |   |   |
;;       .---.---.---.---.---.---.---.
;;       |   |   |   |   |   |   |   |
;;       .---.---.---.---.---.---.---.
;;       |   |   |   |   |   |   |   |
;;       .---.---.---.---.---.---.---.
;;                                   B
     
;; In quanti modi diversi posso camminare dall'incrocio A
;; all'incrocio B senza fare piu' strada del necessario?


(define manh    ; val: intero
  (lambda (i j) ; i, j: interi non negativi

    (cond ((= i 0) 1) ; Solo una riga (i = 0)
          ((= j 0) 1) ; Solo una colonna (j = 0)
          (else
           (+ (manh (- i 1) j)
              (manh i (- j 1)))
           ))
    ))

