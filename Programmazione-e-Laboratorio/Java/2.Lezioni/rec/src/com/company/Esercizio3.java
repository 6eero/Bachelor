package com.company;

public class Esercizio3 {

    public static String hanoi(Towers hts, int t) { // hts: stato iniziale gioco
        // t: posizione finale torre
        hanoiRec(t, hts.height(), hts);
        return hts.moves();
    }

    private static void hanoiRec(int t, int n, Towers hts) {

        if (n != 0) {
            if (n < 0) {
                hts.move(-n, t);

            } else if (hts.site(n) == t) {
                hanoiRec(t, n - 1, hts);

            } else {
                int x = hts.transit(n, t);

                hanoiRec(x, n - 1, hts);
                hanoiRec(t, n * -1, hts);  // sposto n in destinazione t
                hanoiRec(t, n - 1, hts);   // sposto la torre di n-1 dischi, che si trovava in x, in t
            }
        }
    }
}

    /**
    public static String hanoiIter( Towers hts, int t ) {

        int n = hts.height();
        Stack<int[]> stk = new Stack<int[]>();

        stk.push( new int[]{ t, n } );

        while (! stk.empty) {

            int[] f = stk.pop();
            t = f[0];
            n = f[1];

            if ( n != 0 ) {
                if ( n < 0 ) {
                    hts.move(-n, t);

                } else if ( hts.site(n) == t ) {
                    stk.push( new int[]{t, n-1} );

                } else {
                    int x = hts.transit( n, t );

                    stk.push(new int[]{t, n-1});
                    stk.push(new int[]{t, -n});
                    stk.push(new int[]{x, n-1});
                }
            }
        }
        return hts.moves();
    }
}
*/