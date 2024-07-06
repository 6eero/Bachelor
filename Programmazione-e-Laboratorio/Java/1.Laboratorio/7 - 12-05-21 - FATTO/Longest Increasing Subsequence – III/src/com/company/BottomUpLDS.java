package com.company;

public class BottomUpLDS {

    /** Length of Longest Decreasing Subsequence (LLDS): Programmazione dinamica bottom-up **/

    public static int lldsDP(int[] s) {

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
        return mem[0][n];  // lldsRec( s, 0, 100 )
    }
}