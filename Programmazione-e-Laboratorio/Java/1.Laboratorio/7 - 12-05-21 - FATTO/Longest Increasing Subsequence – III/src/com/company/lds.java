package com.company;

public class lds {

    /** Longest Dencreasing Subsequence (LDS): Programmazione dinamica bottom-up **/

    public static int[] ldsDP( int[] s ) {

        int n = s.length;
        int[][] mem = new int[n + 1][n + 1];

        for (int j=0; j<=n; j=j+1) {                // i = n : coda di s vuota
            mem[n][j] = 0;                          // return 0
        }

        for (int i=n-1; i>=0; i=i-1) {
            for (int j=0; j<=n; j=j+1) {

                if ((j < n) && (s[i] >= s[j])) {    // x = s[i] ≤ t : x non può essere scelto
                    mem[i][j] = mem[i + 1][j];      // lldsRec( s, i+1, t )

                } else {                            // x > t : x può essere scelto o meno
                    mem[i][j] = Math.max(
                            mem[i + 1][i] + 1,      // lldsRec(s,i+1,s[i]) + 1
                            mem[i + 1][j]           // lldsRec(s,i+1,t)
                    );
                }
            }
        }

        int[] array = {8, 4, 12, 2, 10, 6, 14, 1, 9, 5, 13, 3, 11, 7, 15};   // array di esempio
        int m = mem[0][n];  //m = lunghezza sottosequenza piú lunga

        int[] r = new int[m];  // per rappresentare una possibile LIS

        int i = 0;  // punto di partenza colonne
        int j = n;  // punto di partenza righe

        int x = 0;

        while (mem[i][j] > 0) {  // ripete il ciclo finche non raggiungo i casi base (mem[5][...])

            int a = mem[i][j];
            int b = mem[i+1][i] + 1;
            int t;

            if (a == b){   // se le due destinazioni sono di uguale valore
                j = i;

                if (j == n)
                    t = 0;
                else
                    t = s[j];

                r[x] = t;
                x = x + 1;
            }
            i = i + 1;
        }
        return r;
    }
}