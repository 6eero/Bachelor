package com.company;

public class bitComplement {

        /*
         * PARTE 1
         *
         * Dato un intero non negativo in notazione ternaria bilanciata (stringa di cifre –/./+), la seguente procedura in Scheme
         * restituisce la rappresentazione dell’intero successivo, calcolata operando direttamente sulle cifre a livello testuale:

         * (define btr-succ ; val: stringa di -/./+
         *    (lambda (btr) ; btr: stringa di -/./+
         *
         *       (let ((n (string-length btr))) ; (brt = "." oppure inizia con "+")
         *          (let ((lsb (string-ref btr (- n 1))))
         *             (if (= n 1)
         *                (if (char=? lsb #\+)
         *                    "+-"
         *                    "+")
         *             (let ((pre (substring btr 0 (- n 1))))
         *                (if (char=? lsb #\+)
         *                   (string-append (btr-succ pre) "-")
         *                   (string-append pre (if (char=? lsb #\-) "." "+"))
         *                   ))
         *              )))
         * ))
         *
         * Traduci in Java la procedura btr-succ e verifica sperimentalmente che i risultati siano consistenti con quelli ottenuti
         * applicando la procedura riportata sopra nell’ambiente DrRacket.
         *
         * (btr-succ "+")           ;"+-"
         * (btr-succ "-")           ;"+"
         * (btr-succ "+-.")         ;"+-+"
         * (btr-succ "-.+")         ;"-+-"
         * (btr-succ "+--.-.+")     ;"+--.-+-"
         * (btr-succ "+-...++-+--") ;"+-...++-+-."
         */

        public static String BtrSucc(String btr){

            int n = btr.length();
            char lsb = btr.charAt(n-1);         //last character
            String pre = btr.substring(0, n-1);

            if (n == 1){

                if (lsb == '+')
                    return "+-";
                else
                    return "+";

            } else {

                if (lsb == '+')
                    return BtrSucc(pre) + "-";
                else
                if (lsb == '-')
                    return pre + ".";
                else
                    return pre + "+";
            }
        }

        /*
         * PARTE 2
         *
         * Traduci in Java il programma relativo alla procedura ones-complement che, data una stringa di bit, restituisce la
         * rappresentazione del corrispondente complemento a uno, in cui le cifre 0 e 1 sono “scambiate” fra loro.
         *
         * Prova quindi a trasformare il programma per realizzarne una versione imperativa, che non si avvalga della ricorsione
         * ma applichi il costrutto for per l’iterazione.
         *
         * Sperimenta infine il programma nell’ambiente BlueJ oppure DrJava e verificane i risultati
         *
         * (define bit-complement   ; val: stringa
         *    (lambda (bit)          ; bit: stringa
         *       (if (string=? bit "0")
         *           "1"
         *           "0"
         *           )))
         *
         * (define ones-complement  ; val: stringa di 0/1
         *    (lambda (bin)          ; bin: stringa di 0/1
         *       (if (string=? bin "")
         *           ""
         *           (string-append
         *              (ones-complement (substring bin 0 (- (string-length bin) 1)))
         *              (bit-complement (substring bin (- (string-length bin) 1)))
         *              ))
         *     ))
         */

        private static String BitComplement(char bit){

            if (bit == '0')
                return "1";
            else
                return "0";
        }

        public static String RecursiveOnesComplement(String bin){

            int n = bin.length();

            if (n == 0)
                return "";
            else{
                return (RecursiveOnesComplement(bin.substring(0, n-1)) + BitComplement(bin.charAt(n-1)));
            }
        }

        public static String IterativeOnesComplement(String bin){

            // ris =   "" + BitComplement(bin.charAt(3-1)) -->   "" +  BitComplement(bin.charAt(2)) -->   "" + 0 --> ris = 0
            // ris =  "0" + BitComplement(bin.charAt(2-1)) -->  "0" +  BitComplement(bin.charAt(1)) -->  "0" + 1 --> ris = 01
            // ris = "01" + BitComplement(bin.charAt(1-1)) --> "01" +  BitComplement(bin.charAt(0)) --> "01" + 0 --> ris = 010

            String ris = "";
            int n = bin.length();

            for(int i = 0; i < n; i++){

                ris = ris + BitComplement(bin.charAt(i));
                // System.out.println("ris = "+ris);       // per debug
            }

            //System.out.println("Il complemento ad uno di "+bin+" é: "+ris);
            return ris;
        }
    }
