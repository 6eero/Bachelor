package com.company;

public class llds {

    /*
    public static int llds( int[] s ) {                      // s[i] > 0 per i in [0,n-1], dove n = s.length

        return lldsRec( s, 0, 0 );
    }

    private static int lldsRec( int[] s, int i, int t ) {

        if ( i == s.length ) {               // i = n : coda di s vuota
            return 0;

        } else if ( s[i] <= t ) {            // elemento x nella posizione i é x <= t -> non può far parte della sottosequenza
            return lldsRec( s, i+1, t );

        } else {                             // x > t : x può essere scelto o meno
            return Math.max(
                    1+lldsRec(s,i+1,s[i]),
                    lldsRec(s,i+1,t) );
        }
    }
     */

    public static int llds( int[] s ) {

        int x = 0;

        for (int i : s) {
            x = (i > x) ? i : x;
        }
        x++;

        return lldsRec( s, 0, 100 );
    }

    private static int lldsRec( int[] s, int i, int t ) {

        if ( i == s.length ) {               // i = n : coda di s vuota
            return 0;

        } else if ( s[i] >= t ) {            // elemento x nella posizione i é x <= t -> non può far parte della sottosequenza
            return lldsRec( s, i+1, t );

        } else {                             // x > t : x può essere scelto o meno
            return Math.max(
                    1+lldsRec(s,i+1, s[i]),
                    lldsRec(s,i+1, t)
            );
        }
    }
}
