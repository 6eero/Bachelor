package com.company;

public class llis {

    private static final int UNKNOWN = -1;

/*
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
*/

    public static int llis ( int[] s ) {

        // dichiarazione variabili
        int n = s.length;
        int[][] mem = new int[n + 1][n + 1];

        // riempimento della matrice con valori che indichino che non sono ancora stati calcolati
        for (int x = 0; x <= n; x++) {
            for (int y = 0; y <= n; y++) {
                mem[x][y] = UNKNOWN;
            }
        }
        return llisRec(s, 0, 0, mem);
    }

    private static int llisRec(int[] s, int i, int t, int[][] mem) {

        // verifica che il valore non sia ancora stato calcolato
        if(mem[i][t] == UNKNOWN) {

            if ( i == s.length ) {                            // array vuoto,  ritorna 0
                mem[i][t] = 0;

            } else if ( s[i] <= t ) {                         // se il primo elemento é <= t, ritorna un array a cui é stato tolto il primo elemento
                mem[i][t] = llisRec( s, i+1, t, mem );

            } else {                                          // l' elemento puo fare o meno parte della sottosequenza
                mem[i][t] = Math.max(
                        1+llisRec(s, i+1, s[i], mem),
                        llisRec(s, i+1, t, mem)
                );
            }
        }
        return mem[i][t];
    }
}
