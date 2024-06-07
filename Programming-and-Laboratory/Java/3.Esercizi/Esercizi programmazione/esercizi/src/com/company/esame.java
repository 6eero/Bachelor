package com.company;

public class esame {

    public static int llis(double[] s) {  // s[i] > 0  per  i in [0,n-1],  dove n = s.length

        return llisRec(s, 0, 0);

    }

    private static int llisRec(double[] s, int i, double t) {

        if (i == s.length) {  // i = n :  coda di s vuota
            return 0;

        } else if (s[i] <= t) {                  // x = s[i] ≤ t :  x non può essere scelto
            return llisRec(s, i + 1, t);

        } else {                                   // x > t :  x può essere scelto o meno
            return Math.max(
                    1 + llisRec(s, i + 1, s[i]),
                    llisRec(s, i + 1, t)
            );
        }
    }

    public static int limis(double[] s) {  // s[i] > 0  per  i in [0,n-1],  dove n = s.length

        return limisRec(s, 0, 0);

    }

    private static int limisRec(double[] s, int i, double t) {

        if (i == s.length) {                                 // x non può essere scelto
            return 0;

        } else if (s[i] <= t) {                              // x non può essere scelto
            return limisRec(s, i + 1, t);

        } else if ((s[i] < s[i + 1]) && (s[i + 1] <= 2 * s[i])) {  // x può essere scelto
            return 1 + limisRec(s, i + 1, s[i]);

        } else
            return limisRec(s, i + 1, t);                    // x non può essere scelto
    }

    /***********************************************************************************/


    public static int limisTD(double[] s) {  // s[i] > 0  per  i in [0,n-1],  dove n = s.length

        int n = s.length;
        int[][] mem = new int[n+1][n+1];

        return limisRecTD(s, 0, 0, n, mem);

    }

    private final static int UNKNOWN = 0;

    private static int limisRecTD(double[] s, int i, double t, int n, int[][] mem) {

        for (int x = 0; x <= n; x++) {
            for (int y = 0; y <= n; y++) {

                mem[x][y] = UNKNOWN;
            }
        }

        if (mem[n][n] == 0) {     // se mem[n][n] non é ancora stato calcolato...

            if (i == s.length) {                                 // x non può essere scelto
                return 0;

            } else if (s[i] <= t) {                              // x non può essere scelto
                return limisRecTD(s, i + 1, t, n, mem);

            } else if ((s[i] < s[i + 1]) && (s[i + 1] <= 2 * s[i])) {  // x può essere scelto
                return 1 + limisRecTD(s, i + 1, s[i], n, mem);

            } else
                return limisRecTD(s, i + 1, t, n, mem);                    // x non può essere scelto
        }
        return mem[n][n];
    }
}