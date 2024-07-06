package com.company;
import java.util.*;

public class esame {

    /**
     * Applica la tecnica top-down di memoization per realizzare una versione più efficiente del seguente
     * programma, che risolve una variante del problema della sottosequenza comune più lunga (calcola la
     * differenza fra due stringhe, restituendo le sequenze di caratteri rimossi rispettivamente da u e da v):
     */

    public static String[] diff( String u, String v ) {

        if ( u.equals("") || v.equals("") ) {
            return new String[] { u, v };

        } else if ( u.charAt(0) == v.charAt(0) ) {
            return diff( u.substring(1), v.substring(1) );

        } else {
            String[] x = diff( u.substring(1), v );
            String[] y = diff( u, v.substring(1) );

            if ( x[0].length() < y[0].length() ) {
                return new String[] { u.charAt(0)+x[0], x[1] };

            } else {
                return new String[] { y[0], v.charAt(0)+y[1] };
            }
        }
    }

    public static String[] diffTD( String u, String v ) {

        int m = u.length();
        int n = v.length();
        String[][][] mem = new String[m+1][n+1][];

        for (int i = 0; i <= m; i++) {
            for (int j = 0; j <= n; j++){
                mem[i][j] = null;
            }
        }

        if (mem[m][n] == null){

            if ( u.equals("") || v.equals("") ) {
                mem[m][n] = new String[] { u, v };

            } else if ( u.charAt(0) == v.charAt(0) ) {
                mem[m][n] = diffTD( u.substring(1), v.substring(1) );

            } else {
                String[] x = diffTD( u.substring(1), v );
                String[] y = diffTD( u, v.substring(1) );

                if ( x[0].length() < y[0].length() ) {
                    mem[m][n] = new String[] { u.charAt(0)+x[0], x[1] };

                } else {
                    mem[m][n] = new String[] { y[0], v.charAt(0)+y[1] };
                }
            }
        }
        return mem[m][n];
    }

    /**
     * Attraverso il metodo statico st, il programma ricorsivo seguente calcola i numeri di Stirling del II tipo
     * (problema dei piatti e dei pasticcini). In particolare, è una variante della procedura ricorsiva standard,
     * che utilizza una variabile di stato come contatore. Trattandosi di una variabile condivisa da tutte le
     * invocazioni ricorsive, questa deve essere passata per riferimento, cosa possibile in Java solo con oggetti;
     * pertanto il contatore viene rappresentato da un array di un solo elemento. Completa la de%nizione del metodo
     * stIter che trasforma la ricorsione in iterazione applicando uno stack.
     */

    public static long st( int n, int k ) { // n, k > 0

        long[] ct = new long[] { 0 }; // contatore: variabile di stato
        sRec( n, k, 1, ct );

        return ct[0];
    }

    private static void sRec( int n, int k, int q, long[] ct ) {

        if ( (k == 1) || (k == n) ) {
            ct[0] = ct[0] + q;

        } else {
            sRec( n-1, k-1, q, ct );
            sRec( n-1, k, k*q, ct );
        }
    }

    public static long stIter( int n, int k ) { // n, k > 0

        long[] ct = new long[] { 0 };
        Stack<int[]> stack = new Stack<int[]>();

        int[] f = new int[] {n, k, 1};
        stack.push(f);

        while (!stack.empty()) {

            f = stack.pop();

            if ( (f[1] == 1) || (f[1] == f[0]) ) {
                ct[0] = ct[0] + f[2];

            } else {
                stack.push( new int[] { f[0]-1, f[1], f[2]*f[1]} );   // n-1, k  , q*k
                stack.push( new int[] { f[0]-1, f[1]-1, f[2]} );      // n-1, k-1, q
            }
        }
        return ct[0];
    }

    /**
     * Dato un intero n ≥ 0, il seguente metodo statico calcola la parte intera della radice quadrata di n
     * utilizzando solo somme, sottrazioni e confronti. Nel programma sono riportate precondizione, postcondizione
     * e invariante. Introduci opportune espressioni negli spazi previsti in modo tale che i valori assunti dalle
     * variabili soddisfino le relazioni specificate dalle asserzioni. Proponi inoltre una opportuna espressione
     * che definisca i valori della funzione di terminazione
     */

    public static int intSqrt( int n ) { // Pre: n ≥ 0

        int q = 0, x = 0, y = 1, z = n-1;

        while ( x <= z ) {          // Inv: 0 ≤ q ≤ √n , x = q2, y = 2q+1, y+z = n
                                    // Term: n-q
            q = q + 1;
            x = x + y;
            y = y + 2;
            z = z - 2;
        }
        return q;                // Post: valore restituito: ⎣√n ⎦
    }

    // (a) Sostituisco i valori conosciuti all'inizio (q, x) all'invatiante e semplifico:
    //
    //     Inv: 0 ≤ q^2 ≤ n , x = q^2, y = 2q+1, y+z = n
    //
    //         -> 0 ≤ 0^2 ≤ n , 0 = 0^2, y = 2*0+1, y+z = n
    //         -> 0 ≤ n , 0 = 0, y = 1, y+z = n
    //         -> 0 ≤ n , 0 = 0, y = 1, z = n-1
    //
    //     ...quindi y = 1 e z = n-1 (che posso scrivere nel proramma)
    //
    //
    // (b) Assumo che valga sia l'invariante che la condizione per entrare nel while:
    //
    //     Inv: 0 ≤ q^2 ≤ n , x = q^2, y = 2q+1, y+z = n & x ≤ z
    //
    //     ...e dimostro che l'invariante vale anche anche dopo la prima iterazione:
    //
    //         0 ≤ q'^2 ≤ n , x' = q^2, y' = 2q'+1, y'+z' = n   (n non viene modificato)
    //
    //     ...dopo la prima iterazione:
    //
    //         q' = q + 1  ->  0 ≤ (q+1)^2 ≤ n , x' = (q+1)^2, y' = 2(q+1)+1, y'+z' = n
    //         y' = y + 2  ->  0 ≤ (q+1)^2 ≤ n , x' = (q+1)^2, y+2 = 2(q+1)+1, y+2+z' = n
    //
    //         x' = x + A  ->  0 ≤ (q+1)^2 ≤ n , x+A = (q+1)^2, y+2 = 2(q+1)+1, y+2+z' = n
    //         z' = z - B  ->  0 ≤ (q+1)^2 ≤ n , x+A = (q+1)^2, y+2 = 2(q+1)+1, y+2+z-B = n
    //
    //     ...quindi:
    //
    //         -> 0 ≤ (q+1)^2 ≤ n , x+A = (q+1)^2, y+2 = 2(q+1)+1, y+2+z-B = n
    //         -> 0 ≤ (q+1)^2 ≤ n , A = 2q + 1, y+2 = 2(q+1)+1, y+2+z-B = n
    //         -> 0 ≤ (q+1)^2 ≤ n , A = y, y+2 = 2(q+1)+1, y+2+z-B = n      quindi A = y
    //         -> 0 ≤ (q+1)^2 ≤ n , A = y, y+2 = 2(q+1)+1, -B+2 = 0
    //         -> 0 ≤ (q+1)^2 ≤ n , A = y, y+2 = 2(q+1)+1, B = 2        quindi B = 2
    //
    //
    // (c) Assumo che l'invariante valga ma che la condizione per entrare nel while non valga:
    //
    //     Inv: 0 ≤ q^2 ≤ n , x = q^2, y = 2q+1, y+z = n & x > z
    //
    //     ...e dimostro che R^2 ≤ n < (R+1)^2:
    //
    //     R = q é la soluzione? -> x > z = n
    //                           -> x+y > y+z = n
    //                           -> q^2 + 2q+1 = x+y > y+x = n
    //                           -> (q+1)^2 = q^2 + 2q+1 = x+y > y+z = n
    //                           -> ok
}
