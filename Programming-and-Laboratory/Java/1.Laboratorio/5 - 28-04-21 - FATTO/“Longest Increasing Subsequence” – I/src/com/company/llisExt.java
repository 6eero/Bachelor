package com.company;

public class llisExt {

    private static final int UNKNOWN = -1;

    public static int llisExt ( int[] s ) {

        // dichiarazione variabili
        int n = s.length;
        int[][] mem = new int[n+1][n+1];

        // riempimento della matrice con valori che indichino che non sono ancora stati calcolati
        for (int x = 0; x <= n; x++) {
            for (int y = 0; y <= n; y++) {
                mem[x][y] = UNKNOWN;
            }
        }
        return llisRecExt(s, n, n, n, mem);
    }

    private static int llisRecExt( int[] s, int n, int i, int j, int[][]mem) {

        // verifica che il valore non sia ancora stato calcolato
        if(mem[i][j] == UNKNOWN) {

            if (i == 0) {                                          // array vuoto,  ritorna 0
                mem[i][j] = 0;

            } else if ((j < n) && (s[i-1] >= s[j])) {              // se il primo elemento é <= t, ritorna un array a cui é stato tolto il primo elemento
                mem[i][j] = llisRecExt( s, n, i-1, j, mem );

            } else {                                               // l' elemento puo fare o meno parte della sottosequenza
                mem[i][j] = Math.max(
                        llisRecExt(s, n, i-1,i-1, mem) + 1,
                        llisRecExt(s, n, i-1, j, mem)
                );
            }
        }
        return mem[i][j];
    }
}
