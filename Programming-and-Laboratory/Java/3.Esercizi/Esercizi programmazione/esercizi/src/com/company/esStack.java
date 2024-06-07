package com.company;
import java.util.*;

public class esStack {

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
        stack.push( f );

        while (!stack.empty()) {
            f = stack.pop();

            if ( (f[1] == 1) || (f[1] == f[0]) ) {
                ct[0] = ct[0] + f[2];

            } else {
                stack.push( new int[] { f[0]-1, f[1], f[1]*f[2]} );
                stack.push( new int[] { f[0]-1, f[1]-1, f[2]} );
            }
        }
        return ct[0];
    }

    /*********************************************************************************/

/*
    La procedura tessellations, determina il numero di modi in cui si può “piastrellare” un cordolo di lunghezza
    n utilizzando piastrelle quadrate rosse di lunghezza 1x1 e piastrelle rettangolari blu di lunghezza k, dove
    k ≥ 1.
*/

    public static long tessellations( int n, int k ) {

        long[] c = new long[1];
        c[0] = 0;

        tessRec(n, k, c);

        return c[0];
    }


    public static void tessRec( int n, int k, long[] c ) {

        if (n < k) {
            c[0] = c[0] + 1;

        } else {
            tessRec(n-1, k, c);
            tessRec(n-k, k, c);
        }
    }

    public static long tessIter(int n, int k) {

        long[] c = new long[ 1 ];
        c[0] = 0;
        Stack<Integer> s = new Stack<Integer>();
        s.push(n);

        do {
            n = s.pop();

            if (n < k) {
                c[0] = c[0] + 1;

            } else {
                s.push(n-1);
                s.push(n-k);
            }

        } while ( ! s.empty() );
        return c[0];
    }

    /*********************************************************************************/

    /*
    (define f ; val: intero
        (lambda (u v x y) ; u, v, x, y ≥ 0 interi
            (cond ((and (= x u) (= y v)) 0)
                  ((= x 0) (if (= u 0) 0 1))
                  ((= y 0) (if (= v 0) 0 1))
                  (else (+ (f u v (- x 1) y) (f u v x (- y 1))))
                  )))
     */

    public static long f (int u, int v, int x, int y) {

        if ((x == u) && (y == v)) {
            return 0;

        } else if (x == 0) {
            if (u == 0)
                return 0;
            else
                return 1;

        } else if (y == 0) {
            if (v == 0)
                return 0;
            else
                return 1;

        } else
            return f(u, v, x-1, y) + f(u, v, x, y-1);
    }

    public static long fIter( int u, int v, int x, int y ) { // u, v, x, y ≥ 0

        long c = 0;
        Stack<int[]> s = new Stack<int[]>();

        int[] f = new int[]{x, y};
        s.push(f);

        while (!s.empty()) {
            int[] r = s.pop();

            x = r[0];
            y = r[1];

            if ( (x == u) && (y == v) ) {
                ; // skip: nessuna azione da eseguire

            } else if ( x == 0 ) {
                c = c + 0;

            } else if ( y == 0 ) {
                c = c + 0;

            } else {
                s.push(new int[] {x-1});   // u, v, x-1, y
                s.push(new int[] {y-1});   // u, v, x, y-1
            }
        }
        return c;
    }

    /*********************************************************************************/

    public static String hanoiMoves( int n ) {
        return hanoiRec( n, 1, 2, 3 );
    }

    private static String hanoiRec( int n, int s, int d, int t ) {
        if ( n == 1 ) {
            return ( " " + s + "->" + d );
        } else {
            String m1 = hanoiRec( n-1, s, t, d );
            String m2 = hanoiRec( n-1, t, d, s );
            return ( m1 + " " + s + "->" + d + m2 );
        }
    }

    /*
    public static String hanoiMovesIter( int n ) {

        Stack<int[]> stack = new Stack<int[]>();
        stack.push(new int[] {n, 1, 2, 3});               // stack.push( new int[] {xxxx} );

        String moves = "";
        int s, d, t;

        while (!stack.empty()) {    // while (xxxx)

            int[] args = stack.pop();    // int[] args = xxxx;
            n = args[0];
            s = args[1];
            d = args[2];
            t = args[3];

            if ( n == 1 ) {
                moves = moves + " " + s + "->" + d;

            } else {
                stack.push( new int[] {n-1, t, d, s} );     // stack.push( new int[] {n-1, xxxx} );
                stack.push( new int[] {1, s, d, t} );
                moves = xxxx;         // xxxx
            }
        }
        return moves;
    }

     */

    /*********************************************************************************/


    public static long manhattan3D(int i, int j, int k) { // i, j, k ≥ 0

        Counter v = new Counter();
        manhattan3DRec(i, j, k, v);
        return v.count();
    }
    private static void manhattan3DRec(int i, int j, int k, Counter v) {

        if ((i == 0) && (j == 0) && (k == 0)) {
            v.incr();

        } else {
            if (i > 0) {manhattan3DRec( i-1, j, k, v);}
            if (j > 0) {manhattan3DRec( i, j-1, k, v);}
            if (k > 0) {manhattan3DRec( i, j, k-1, v);}
        }
    }

    public static long manha3D( int i, int j, int k ) { // i, j, k ≥ 0

        Counter v = new Counter();
        Stack<int[]> s = new Stack<int[]>();
        s.push( new int[] {i, j, k} );                             // s.push( new int[] {xxxx} );

        do {
            int[] f = s.pop();                                     // int[] f = xxxx;
            if ((f[0] == 0) && (f[1] == 0) && (f[2] == 0)) {
                v.incr();                                           // xxxx;
            } else {
                if (f[0] > 0) {s.push(new int[] {f[0]-1, f[1], f[2]});}      // if (xxxx > 0) {s.push( new int[] {xxxx});}
                if (f[1] > 0) {s.push(new int[] {f[0], f[1]-1, f[2]});}      // if (xxxx > 0) {xxxx}
                if (f[2] > 0) {s.push(new int[] {f[0], f[1], f[2]-1});}      // if (xxxx > 0) {xxxx}
            }
        } while (!s.empty());   // while (xxxx);
        return v.count();
    }

    /*********************************************************************************/
/*
    private static String flattenTree( Node n ) {
        if ( n.isLeaf() ) {                         // foglia: codifica del carattere
            char c = n.character();
            if ( (c == '\\') || (c == '@') ) {
                return ( "\\" + c );                // caratteri speciali: \, @
            } else {
                return ( "" + c );                  // altri caratteri
            }
        } else {
            return ( "@"                            // @
                    + flattenTree( n.left() )       // codifica lineare del sottoalbero sinistro
                    + flattenTree( n.right() )      // codifica lineare del sottoalbero destro
            );
        }
    }

    public static String flattenTree( Node n ) {

        Stack<Node> stack = new Stack<Node>();
        stack.push(n);
        String ht = "";

        while (!stack.empty()) {

            n = stack.pop();

            if ( n.isLeaf() ) {
                char c = n.character();
                if ( (c == '\\') || (c == '@') ) {
                    ht = ht + "\\" + c;
                } else {
                    ht = ht + c;
                }
            } else {
                ht = ht + "@;";
                stack.push(n.right());
                stack.push(n.left());
            }
        }
        return ht;
    }
 */




}

