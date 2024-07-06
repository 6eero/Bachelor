package com.company;

public class TopDown {

    public static long fib (int n){

        if (n < 2)
            return 1;
        else
            return fib(n-2) + fib(n-1);
    }

    public static long fibTD (int n){

        long mem[] = new long[n+1];

        for (int i = 0; i <= n; i++) {
            mem[i] = 0;
        }

        if (mem[n] == 0) {

            if (n < 2)
                mem[n] = 1;
            else
                mem[n] = fibTD(n-2) + fibTD(n-1);
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

    public static int llcsTD(String u, String v){

        int m = u.length();
        int n = v.length();

        int[][] mem = new int[m+1][n+1];

        for (int i = 0; i <= m; i++) {
            for (int j = 0; j <= n; j++) {
                mem[i][j] = -1;
            }
        }

        if (mem[m][n] == -1){

            if((m == 0) || (n == 0))
                mem[m][n] = 0;

            else if (u.charAt(0) == v.charAt(0))
                mem[m][n] = 1 + llcsTD(u.substring(1), v.substring(1));

            else
                mem[m][n] = Math.max(llcsTD(u.substring(1), v), llcsTD(u, v.substring(1)));
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

    public static int llisTD( int[] s ) { // s[i] > 0 per i in [0,n-1], dove n = s.length

        return llisTD( s, 0, 0 );
    }

    private static int llisTD( int[] s, int i, int t ) {

        int n = s.length;
        int[][] mem = new int[n+1][n+1];

        for (int x = 0; x <= n; x++) {
            for (int y = 0; y <= n; y++) {

                mem[x][y] = 0;
            }
        }

        if (mem[n][n] == 0) {

            if ( i == s.length ) {
                mem[n][n] = 0;

            } else if ( s[i] <= t ) {
                mem[n][n] = llisTD( s, i+1, t );

            } else {
                mem[n][n] = Math.max( 1+llisTD(s,i+1,s[i]), llisTD(s,i+1,t) );
            }
        }
        return mem[n][n];
    }

    /*********************************************************************************/

    public static long rec( int x, int y, int z ) { // 1 <= x, y <= z

        if ( (x == 1) || (y == z) ) {
            return 1;

        } else {
            return rec( x-1, y, z ) + x * rec( x, y+1, z );
        }
    }

    public static long recTD( int x, int y, int z ) { // 1 <= x, y <= z

        long[][] mem = new long[x+1][z+1];

        for (int i = 1; i <= x; i++) {
            for (int j = z; j >= y; j--) {
                mem[i][j] = 0;
            }
        }

        if (mem[x][z] == 0){

            if ( (x == 1) || (y == z) ) {
                mem[x][z] = 1;

            } else {
                mem[x][z] = recTD( x-1, y, z ) + x * recTD( x, y+1, z );
            }
        }
        return mem[x][z];
    }

    /*********************************************************************************/

    public static int[] ldiff( String u, String v ) {

        if ( u.equals("") || v.equals("") ) {
            return new int[] { u.length(), v.length() };

        } else if ( u.charAt(0) == v.charAt(0) ) {
            return ldiff( u.substring(1), v.substring(1) );

        } else {
            int[] x = ldiff( u.substring(1), v );
            int[] y = ldiff( u, v.substring(1) );

            if ( x[0] < y[0] ) {
                return new int[] { x[0]+1, x[1] };

            } else {
                return new int[] { y[0], y[1]+1 };
            }
        }
    }

    public static int[] ldiffTD( String u, String v ) {

        int m = u.length();
        int n = v.length();
        int[] ao = new int[] {0};

        int[][][] mem = new int[m+1][n+1][];

        for (int i = 0; i <= m; i++){
            for (int j= 0; j <= n; j++) {
                mem[i][j] = ao;
            }
        }

        if (mem[m][n] == ao){

            if ( u.equals("") || v.equals("") ) {
                mem[m][n] = new int[] { u.length(), v.length() };

            } else if ( u.charAt(0) == v.charAt(0) ) {
                mem[m][n] = ldiffTD( u.substring(1), v.substring(1) );

            } else {
                int[] x = ldiffTD( u.substring(1), v );
                int[] y = ldiffTD( u, v.substring(1) );

                if ( x[0] < y[0] ) {
                    mem[m][n] = new int[] { x[0]+1, x[1] };

                } else {
                    mem[m][n] = new int[] { y[0], y[1]+1 };
                }
            }
        }
        return mem[m][n];
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

    public static long fTD (int u, int v, int x, int y) {

        long[][] mem = new long[x+1][y+1];

        for (int i = u; i <= x; i++) {
            for (int j = v; j <= y; j++) {
                mem[i][j] = 0;
            }
        }
        if (mem[x][y] == 0){

            if ((x == u) && (y == v)) {
                mem[x][y] = 0;

            } else if (x == 0) {
                if (u == 0)
                    mem[x][y] = 0;
                else
                    mem[x][y] = 1;

            } else if (y == 0) {
                if (v == 0)
                    mem[x][y] = 0;
                else
                    mem[x][y] = 1;

            } else
                mem[x][y] = fTD(u, v, x-1, y) + fTD(u, v, x, y-1);
        }

        return mem[x][y];
    }

    /*********************************************************************************/

    public static int llis2( int[] s ) { // s[i] > 0 per i ∈ [0,n–1]
        int n = s.length;
        return llisRec( s, n, n, n );
    }

    public static int llisRec( int[] s, int n, int i, int j ) {
        if ( i == 0 ) {
            return 0;
        } else if ( (j < n) && (s[i-1] >= s[j]) ) {
            return llisRec( s, n, i-1, j );
        } else {
            return Math.max( 1+llisRec(s,n,i-1,i-1), llisRec(s,n,i-1,j) );
        }
    }

    public static int llis2BU( int[] s ) { // s[i] > 0 per i ∈ [0,n–1]
        int n = s.length;
        return llisRecBU( s, n, n, n );
    }

    public static int llisRecBU( int[] s, int n, int i, int j ) {

        int[] mem = new int[i+1];

        for (int x = 0; x <= i; x++) {

            if ( i == 0 ) {
                mem[i] = 0;
            } else if ( (j < n) && (s[i-1] >= s[j]) ) {
                mem[i] = llisRecBU( s, n, i-1, j );
            } else {
                mem[i] = Math.max( 1+llisRecBU(s,n,i-1,i-1), llisRecBU(s,n,i-1,j) );
            }
        }
        return mem[i];
    }

    /*********************************************************************************/

    public static String[] lcsx( String u, String v ) {

        if ( u.equals("") || v.equals("") ) {
            return new String[] { u, v };

        } else if ( u.charAt(0) == v.charAt(0) ) {
            return lcsx( u.substring(1), v.substring(1) );

        } else {
            String[] pair1 = lcsx( u.substring(1), v );
            String[] pair2 = lcsx( u, v.substring(1) );

            return better( u.charAt(0), v.charAt(0), pair1, pair2 );
        }
    }

    private static String[] better( char c0, char c1, String[] pair1, String[] pair2 ) {

        int e1 = pair1[0].length() + pair1[1].length();
        int e2 = pair2[0].length() + pair2[1].length();

        if ( e1 < e2 ) {
            return new String[] { c0 + pair1[0], pair1[1] };

        } else if ( e1 > e2 ) {
            return new String[] { pair2[0], c1 + pair2[1] };

        } else if ( Math.random() < 0.5 ) {
            return new String[] { c0 + pair1[0], pair1[1] };

        } else {
            return new String[] { pair2[0], c1 + pair2[1] };
        }
    }

    public static String[] lcsxTD( String u, String v ) {

        int m = u.length();
        int n= v.length();
        String[][][] mem = new String[m+1][n+1][];

        for (int i = 0; i <= m; i++) {
            for (int j = 0; j <= n; j++) {
                mem[i][j] = null;
            }
        }

        if (mem[m][n] == null){

            if ( u.equals("") || v.equals("") ) {
                mem[m][n] = new String[] { u, v };

            } else if ( u.charAt(0) == v.charAt(0) ) {
                mem[m][n] = lcsxTD( u.substring(1), v.substring(1) );

            } else {
                String[] pair1 = lcsxTD( u.substring(1), v );
                String[] pair2 = lcsxTD( u, v.substring(1) );

                mem[m][n] = betterTD( u.charAt(0), v.charAt(0), pair1, pair2 );
            }
        }
        return mem[m][n];
    }

    private static String[] betterTD( char c0, char c1, String[] pair1, String[] pair2 ) {

        int e1 = pair1[0].length() + pair1[1].length();
        int e2 = pair2[0].length() + pair2[1].length();

        if ( e1 < e2 ) {
            return new String[] { c0 + pair1[0], pair1[1] };

        } else if ( e1 > e2 ) {
            return new String[] { pair2[0], c1 + pair2[1] };

        } else if ( Math.random() < 0.5 ) {
            return new String[] { c0 + pair1[0], pair1[1] };

        } else {
            return new String[] { pair2[0], c1 + pair2[1] };
        }
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

    public static long sTD( int n, int k ) { // 1 ≤ k ≤ n

        long[][] mem = new long[n+1][k+1];

        for (int i = 0; i <= n; i++) {
            for (int j = 0; j <= k; j++) {

                if (k == n) {
                    return 1;

                } else {
                    long x = (n - 1) * sTD(n-1, k);

                    if ( k == 1 ) {
                        return x;

                    } else {
                        return x + sTD(n-1, k-1);
                    }
                }
            }
        }
        return mem[n][k];
    }
}
