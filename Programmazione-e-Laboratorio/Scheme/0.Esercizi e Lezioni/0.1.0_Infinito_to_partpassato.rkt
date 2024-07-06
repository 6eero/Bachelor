;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Infinito_to_partpassato) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(define COND
  (lambda (INF)
    (if
     (string=? (substring INF (- (string-length INF) 3)) "are")        ;X
     (string-append (substring INF 0 (- (string-length INF) 3)) "ato") ;Y
     (if                                                               ;Z
      
      (string=? (substring INF (- (string-length INF) 3)) "ere")        ;X
      (string-append (substring INF 0 (- (string-length INF) 3)) "uto") ;Y
      (if                                                               ;Z
       
       (string=? (substring INF (- (string-length INF) 3)) "ire")        ;X
       (string-append (substring INF 0 (- (string-length INF) 3)) "ito") ;Y
       "ao?")))))                                                        ;Z

(COND "andare")
(COND "cadere")
(COND "applaudire")
(COND "prova")
