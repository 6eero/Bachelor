package com.company;

public class Esercizio2 {

    public static long rec(int x, int y, int z) {

        if ((x == 1) || (y == z))
            return 1;
        else
            return rec(z - 1, y, z) + x * rec(x, y + 1, z);
    }

    public static long recDP(int x, int y, int z) {

        long[][] mem = new long[x + 1][z + 1];

        for (int i = 1; i <= x; i++) {       // i: colonne
            for (int j = z; j >= y; j--) {   // j: righe

                if ((x == 1) || (y == z))
                    mem[i][j] = 1;
                else
                    mem[i][j] = mem[i-1][j] + i * mem[i][j+1];
            }
        }
        return mem[x][y];
    }
}
