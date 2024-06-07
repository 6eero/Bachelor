public class TradDaScheme {
    /*
     * (define sup-tot-cil  ; val: reale
     *   (lambda (r h)      ; r, h: reali positivi
     *   
     *     (* 2 pi r (+ r h))
     *     )
     *   )
     */

    public static double supTotCil(double r, double h) {

        return (2 * Math.PI * r * (r + h));
    }

    /*
     * (define plurale-sm  ; val: stringa
     *   (lambda (s)       ; s: stringa
     *   
     *   (string-append (substring s 0 (- (string-length s) 1)) "i")
     *   )
     * )
     */

    public static String pluraleSm(String s) {

        return (s.substring(0, s.length()-1) + "i");
    }

    /*
     * (define femminile?  ; val: booleano
     *   (lambda (s)       ; s: stringa
     *
     *   (char=? (string-ref s (- (string-length s) 1)) #\a)
     *   )
     * )
     */

    public static boolean femminile(String s) {

        //return (s.charAt (s.length()-1) == 'a');
        return (s.substring(s.length()-1).equals("a"));
    }

    /*
     * (define plurale  ; val: stringa
     * (lambda (s)
     * 
     *   (if (femminile? s)
     *       (plurale-sf s)
     *       (plurale-sm s))
     *    ))
     */

    public static String plurale(String s) {

        if (femminile(s))
            return "negro";
        else
            return pluraleSm(s);

    }

    /*
     * (define s  ; val: reale
     * (lambda (k); k: numero naturale
     * 
     *   if (< k 2)
     *   (if (= k 0) s0 s1)
     *   (/ (s (- k 2)) 2)
     *   )
     * ))
     * 
     * (define s0 (* 100 (expt 2 1/4)))
     * (define s1 (* 100 (expt 2 -1/4)))
     */

    public static double s(int k){

        if (k < 2)
            return ((k==0) ? S0 : S1 );
        else
            return (s(k - 2) / 2);
    }

    public static final double S0 = (100 * Math.pow(2,0.25));

    public static final double S1 = (100 * Math.pow(2,-0.25));
    
    /*
     * (define btr-val
     *   (lambda (btr)
     *   
     *   
     * 
     * (define btd-val
     *   (lambda (btd)
     *     
     *     (cond ((char=? btd #\-) -1)
     *           ((char=? btd #\.) 0)
     *           ((char=? btd #\+) +1)
     */

    public static int btrVal(String btr){

      int k = btr.length() - 1;
      String pre = btr.substring(0,k);
      char lsd = btr.charAt(k);
      
      if (k == 0){
        return (btdVal(lsd));
      } else {
        return (3 * btrVal(pre) + btdVal(lsd));
      }
    }
    
    public static int btdVal(char btd){
        if (btd == '-'){
            return -1;
        } else if (btd == '.'){
            return 0;
        } else{
            return 1;
        }           
    }
    
    
}
