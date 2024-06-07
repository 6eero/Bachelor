;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname 0.2_Ricorsione_calcolo_misure_foglio) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; s(k) lunghezza del lato piu lungo del formato Ak
;; s(k+2) = s(k)/ 2

;; s(0) = s0 -> lato piu lungo formato A0
;; s(1) = s1 -> layo piu corto formato A0 (= lato piu lungo formato A1)

(define s     ;;numero reale (misura)
  (lambda (k) ;;intero non negativo
    (if (> k 1)
        (/ (s (- k 2)) 2)
        (if (= k 0)
            s0
            s1))
    ))

;; A0: lunghezza del lato piu lungo (s0)  x lunghezza lato
;; piu corto (s1) = 10000cmq (convensione decisa da noi)

;; s0/s1 = s1/s2 = s1/(s0/s2)=2s1/s0 -> s0^2 = 2s1^2(il rapporto
;; tra i lati deve essere sempre costante)

;; s0^2 * s1^2 = 10^8 cm^4
;; s1^4 =10^8 /2
;; s0 = 2^(1/2) s1

(define s0 (* 100 (expt 2 1/4))) ;;misure in cm
(define s1 (/ 100 (expt 2 1/4))) ;;misure in cm