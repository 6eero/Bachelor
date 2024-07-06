package com.company;

public class llis {

    public static int llis( int[] s ) { // s[i] > 0 per i in [0,n-1], dove n = s.length
        return llisRec( s, 0, 0 );
    }

    private static int llisRec(int[] s, int i, int t) {

        if (i == s.length) {                      // array vuoto,  ritorna 0
            return 0;

        } else if (s[i] <= t) {                   // se il primo elemento é <= t, ritorna un array a cui é stato tolto il primo elemento
            return llisRec(s, i+1, t);

        } else {                                  // l' elemento puo fare o meno parte della sottosequenza
            return Math.max(
                    1 + llisRec(s, i+1, s[i]),
                    llisRec(s, i+1, t)
            );
        }
    }
}
