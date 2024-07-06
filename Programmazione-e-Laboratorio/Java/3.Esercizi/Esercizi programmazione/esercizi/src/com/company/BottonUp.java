package com.company;
import java.util.*;

public class BottonUp {

    public static long fib (int n){

        if (n < 2)
            return 1;
        else
            return fib(n-2) + fib(n-1);
    }

    public static long fibBU (int n){

        long mem[] = new long[n+1];

        for (int i = 0; i <= n; i++) {

            if (i < 2)
                mem[i] = 1;
            else
                mem[i] = mem[i-2] + mem[i-1];    // fibBU(n-2) + fibBU(n-1);
        }
        return mem[n];
    }

    /*********************************************************************************/

    public static int llcs(String u, String v){

        int m = u.length();
        int n = v.length();

        if((m == 0) || (n == 0))
            return 0;

        else if (u.charAt(0) == v.charAt(0))
            return 1 + llcs(u.substring(1), v.substring(1));

        else
            return Math.max(llcs(u.substring(1), v), llcs(u, v.substring(1)));
    }

    public static int llcsBU(String u, String v){

        int m = u.length();
        int n = v.length();

        int[][] mem = new int[m+1][n+1];

        for (int i = 0; i <= m; i++) {
            for (int j = 0; j <= n; j++) {

                if((i == 0) || (j == 0))
                    mem[i][j] = 0;

                else if (u.charAt(m-i) == v.charAt(n-j))
                    mem[i][j] = 1 + mem[i-1][j-1];       // 1 + llcsBU(u.substring(1), v.substring(1));

                else
                    mem[i][j] = Math.max(mem[i-1][j], mem[i][j-1]);      // Math.max(llcsBU(u.substring(1), v), llcsBU(u, v.substring(1)));
            }
        }
        return mem[m][n];
    }

    /*********************************************************************************/

    public static int llis( int[] s ) { // s[i] > 0 per i in [0,n-1], dove n = s.length
        return llisRec( s, 0, 0 );
    }

    private static int llisRec( int[] s, int i, int t ) {

        if ( i == s.length ) {
            return 0;

        } else if ( s[i] <= t ) {
            return llisRec( s, i+1, t );

        } else {
            return Math.max( 1+llisRec(s,i+1,s[i]), llisRec(s,i+1,t) );
        }
    }

    public static int llisBU( int[] s ) {

        return llisBU( s, 0, 0 );
    }

    private static int llisBU( int[] s, int x, int t ) {

        int n = s.length;
        int[][] mem = new int[n+1][n+1];

        for (int i = n; i >= 0; i--) {
            for (int j = 0; j <= n; j++) {

                if ( i == n ) {
                    mem[i][j] = 0;

                } else if ( s[i] <= j ) {
                    mem[i][j] = mem[i+1][j]; // llisBU( s, x+1, t );

                } else {                     // Math.max( 1+llisBU(s,x+1,s[x]), llisBU(s,x+1,t) );
                    mem[i][j] = Math.max(
                            1+mem[i+1][i],
                            mem[i+1][j]
                    );
                }
            }
        }
        return mem[0][n];
    }

    /*********************************************************************************/

    public static long rec( int x, int y, int z ) { // 1 <= x, y <= z

        if ( (x == 1) || (y == z) ) {
            return 1;
        } else {
            return rec( x-1, y, z ) + x * rec( x, y+1, z );
        }
    }

    public static long recBU( int x, int y, int z ) { // 1 <= x, y <= z

        long[][] mem = new long[x+1][z+1];

        for (int i = 1; i <= x; i++) {
            for (int j = z; j >= y; j--) {

                if ( (i == 1) || (j == z) ) {
                    mem[i][j] = 1;
                } else {
                    mem[i][j] = mem[i-1][j] + i * mem[i][j+1];     // recBU( x-1, y, z ) + x * recBU( x, y+1, z );
                }
            }
        }
        return mem[x][y];
    }

    /*********************************************************************************/

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

    public static long fBU (int u, int v, int x, int y) {

        long[][] mem = new long[x+1][y+1];

        for (int i = 0; i <= x; i++) {
            for (int j = 0; j <= y; j++) {

                if ((i == u) && (j == v)) {
                    mem[i][j] = 0;

                } else if (i == 0) {
                    if (u == 0)
                        mem[i][j] = 0;
                    else
                        mem[i][j] = 1;

                } else if (j == 0) {
                    if (v == 0)
                        mem[i][j] = 0;
                    else
                        mem[i][j] = 1;

                } else
                    mem[i][j] = mem[i-1][j] + mem[i][j-1]; // fBU(u, v, x-1, y) + fBU(u, v, x, y-1);
            }
        }
        return mem[x][y];
    }

    /***********************************non funziona**********************************************/

    public static int q( int[] s ) { // s.length > 0

        int n = s.length;
        int[] t = new int[n];
        t[0] = s[0];

        for ( int k=1; k<n; k=k+1 ) {
            int i=k-1;

            while ( (i >= 0) && (t[i] > s[k]) ) {
                t[i+1] = t[i]; i = i - 1;
            }

            t[i+1] = s[k];
        }
        return qRec( s, t, n, 0, 0 );
    }

    private static int qRec( int[] s, int[] t, int n, int i, int j ) {

        if ( (i == n) || (j == n) ) {
            return 0;

        } else if ( s[i] == t[j] ) {
            return 1 + qRec( s, t, n, i+1, j+1 );

        } else {
            return Math.max( qRec(s,t,n,i+1,j), qRec(s,t,n,i,j+1) );
        }
    }

    public static int qBU(int[] s) { // s.length > 0

        int n = s.length;
        int[] t = new int[n];
        t[0] = s[0];
        int[][] mem = new int[n+1][n+1];

        for (int k=1; k<n; k=k+1) {
            int i = k-1;
            while ((i >= 0) && (t[i] > s[k])) {
                t[i+1] = t[i];
                i = i - 1;
            }
            t[i+1] = s[k];
        }

        for (int x = 0; x <= n; x++) {
            for (int y = 0; y <= n; y++) {

                if ((x == n) || (y == n)) {
                    mem[x][y] = 0;

                } else if (s[x] == t[y]) {
                    mem[x][y] = 1 + mem[x+1][y+1];   // 1 + qBU(s, t, n, i+1, j+1);

                } else {
                    mem[x][y] = Math.max(mem[x+1][y], mem[x][y+1]);   // Math.max(qBU(s, t, n, i+1, j), qBU(s, t, n, i, j+1));
                }
            }
        }
        return mem[n][n];
    }

    /*********************************************************************************/

    public static long q( int i, int j, int k ) { // i, j, k >= 0

        long x;
        long y;
        long z;

        if (i < 2)
            x = i;
        else
            x = q(i - 2, j, k);

        if (j < 2)
            y = j;
        else
            y = q(i, j - 2, k);

        if (k < 2)
            z = k;
        else
            z = q(i, j, k - 2);

        long m = x + y + z;

        if (m == 0)
            return 1;
        else
            return m;
    }

    public static long qBU( int i, int j, int k ) { // i, j, k >= 0

        long[][][] mem = new long[i+1][j+1][k+1];

        for (int a = 0; a <= i; a++) {
            for (int b = 0; b <= j; b++) {
                for (int c = 0; c <= k; c++) {

                    long x;
                    long y;
                    long z;

                    if (a < 2)
                        x = a;
                    else
                        x = mem[a-2][b][c];

                    if (b < 2)
                        y = b;
                    else
                        y = mem[a][b-2][c];

                    if (c < 2)
                        z = c;
                    else
                        z = mem[a][b][c-2];

                    long m = x + y + z;

                    if (m == 0)
                        mem[a][b][c] = 1;
                    else
                        mem[a][b][c] = m;
                }
            }
        }
        return mem[i][j][k];
    }

    /*********************************************************************************/

    public static long q2( int i, int j, int k ) { // i, j, k >= 0

        long x = ( i < 2 ) ? i : q2( i-2, j, k );
        long y = ( j < 2 ) ? j : q2( i, j-2, k );
        long z = ( k < 2 ) ? k : q2( i, j, k-2 );

        long m = x + y + z;

        return ( m == 0 ) ? 1 : m;
    }

    public static long q2BU( int i, int j, int k ) { // i, j, k >= 0

        long[][][] mem = new long[i+1][j+1][k+1];

        for (int a = 0; a <= i; a++) {
            for (int b = 0; b <= j; b++) {
                for (int c = 0; c <= k; c++) {

                    long x = ( a < 2 ) ? a : mem[a-2][b][c];  // q2BU( i-2, j, k );
                    long y = ( b < 2 ) ? b : mem[a][b-2][c];  // q2BU( i, j-2, k );
                    long z = ( c < 2 ) ? c : mem[a][b][c-2];  // q2BU( i, j, k-2 );

                    long m = x + y + z;

                    if (m == 0)
                        mem[a][b][c] = 1;
                    else
                        mem[a][b][c] = m;
                }
            }
        }
        return mem[i][j][k];
    }

    /*********************************************************************************/

    public static long fg( int i, int j ) { // i, j ≥ 0

        if ( i+j < 2 ) {
            return i+j;

        } else if ( j == 0 ) {
            return fg( 1, i-2 ) + fg( 0, i-1 );

        } else if ( j == 1 ) {
            return fg( 0, i ) + fg( i+1, 0 );

        } else {
            return fg( i+2, j-2 ) + fg( i+1, j-1 );
        }
    }

    public static long fgBU( int i, int j ) { // i, j ≥ 0

        long[][] mem = new long[i+1][j+1];

        for (int a = 0; a <= i; a++) {
            for (int b = 0; b <= j; b++) {

                if ( a+b < 2 ) {
                   mem[a][b] = i+j;

                } else if ( j == 0 ) {
                    mem[a][b] = mem[1][a-2] + mem[0][a-1]; // fgBU( 1, i-2 ) + fgBU( 0, i-1 );

                } else if ( j == 1 ) {
                    mem[a][b] = mem[0][a] + mem[a+1][0]; // fgBU( 0, i ) + fgBU( i+1, 0 );

                } else {
                    mem[a][b] = mem[a+2][a-2] + mem[a+1][b-1];// fgBU( i+2, j-2 ) + fgBU( i+1, j-1 );
                }
            }
        }
        return mem[i][j];
    }

    /*********************************************************************************/

    public static long s( int n, int k ) { // 1 ≤ k ≤ n

        if ( k == n ) {
            return 1;

        } else {
            long x = (n - 1) * s( n-1, k );

            if ( k == 1 ) {
                return x;

            } else {
                return x + s( n-1, k-1 );
            }
        }
    }

    public static long sBU( int n, int k ) { // 1 ≤ k ≤ n

        long[][] mem = new long[n+1][k+1];

        for (int i = 1; i <= n; i++) {
            for (int j = 1; j <= k; j++) {

                if ( j == i ) {
                   mem[i][j] = 1;

                } else {
                    long x = (i - 1) * mem[i-1][j]; // sBU( n-1, k );

                    if ( j == 1 ) {
                        mem[i][j] = x;

                    } else {
                        mem[i][j] = x + mem[i-1][j-1]; // sBU( n-1, k-1 );
                    }
                }
            }
        }
        return mem[n][k];
    }

}
