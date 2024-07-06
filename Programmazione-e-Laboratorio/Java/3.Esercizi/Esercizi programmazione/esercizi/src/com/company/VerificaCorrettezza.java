package com.company;

public class VerificaCorrettezza {

    public static int intSqrt( int n ) { // Pre: n ≥ 0

        int q = 0, x = 0, y = 1, z = n-1;
        while ( x <= z ) {                          // Inv: 0 ≤ q ≤ √n , x = q^2, y = 2q+1, y+z = n
                                                    // Term:
            q = q + 1;
            x = x + y;
            y = y + 2;
            z = z - 2;
        }

        return q;                                // Post: valore restituito: ⎣√n ⎦
    }

/**
 *
 * (a) Sostituisco i valori conosciuti all'inizio all'invatiante e semplifico:
 *
 *      0≤q^2≤n,  x=q^2,  y=2q+1,  y+z=n
 *      0≤0≤n,  x=0,  y=0+1,  y+z=n
 *      0≤n,  x=0,  y=1,  y+z=n
 *      0≤n,  x=0,  y=1,  1+z=n
 *      0≤n,  x=0,  y=1,  z=n-1
 *
 * (b) Assumo che valga sia l'invariante che la condizione per entrare nel while:
 *
 *      0≤q^2≤n,  x=q^2,  y=2q+1,  y+z=n,  x<=z
 *      0≤q'^2≤n,  x'=q'^2,  y'=2q'+1,  y'+z'=n,  x'<=z'
 *      0≤(q+1)^2≤n,  (x+A)=(q+1)^2,  (y+2)=2(q+1)+1,  (y+2)+(z-B)=n,  (x+A)<=(z-B)
 *      0≤(q+1)^2≤n,  x+A=(q+1)^2,  y+2=2(q+1)+1,  y+2+z-B=n,  x+A<=z-B
 *
 *      Trovo A e B:
 *
 *          A: x+A=(q+1)^2 -> x+A=q^2+2q+1 -> A=q^2+2q+1 -> A=0+0+1 -> A=1
 *          A: x+A=(q+1)^2 -> A=2q+1 -> A=y
 *          B: y+2+z-B=n -> B=y+2+z-n -> B=1+2+n-1-n -> B=2
 *
 * (c) Assumo che l'invariante valga ma che la condizione per entrare nel while non valga:
 *
 *      0≤q^2≤n,  x=q^2,  y=2q+1,  y+z=n,  x>z
 *
 */
/*
    public static int gFlavio( int n ) { // Pre: n > 0

        int x = n;
        int q = 2;
        int p = 1;

        while (x > 1) {             // Inv: 1≤x≤n, 1≤p≤q, ∃k>0.q=2k , qx+p=2n+1
                                    // Term: x
            p = p + q * xxxx;
            x = x / 2;
            q = 2 * q;
        }
        return xxxx;
    }                              // Post: il valore restituito è gf(n)

    /** NON GIUSTO
     *
     * (a) Sostituisco i valori conosciuti all'inizio all'invatiante e semplifico:
     *
     *      1≤x≤n, 1≤p≤q, ∃k>0.q=2^k, qx+p=2n+1
     *      1≤x≤n, 1≤p≤2, ∃k>0.2=2^k, 2x+p=2n+1
     *      1≤n≤n, 1≤p≤2, ∃k>0.2=2^1, 2n+p=2n+1
     *      1≤n≤n, 1≤p≤2, ∃k>0.2=2^1, p=1
     *
     * (b) Assumo che valga sia l'invariante che la condizione per entrare nel while:
     *
     *      1≤x'≤n, 1≤p'≤q', ∃k>0.q'=2^k, q'x'+p'=2n+1, x'>1
     *      1≤(x/2)≤n, 1≤(p+q*A)≤2q, ∃k>0.2q=2^k, 2q(x/2)+(p+q*A)=2n+1, (x/2)>1
     *
     *      Trovo A:
     *
     *          A: 2q(x/2)+p+q*A=2n+1 -> qx+p+qA=2n+1 -> qA=2n+1-qx-p -> A=(2*n+1-p)/q-x
     *
     * (c) Assumo che l'invariante valga ma che la condizione per entrare nel while non valga:
     *
     *      0≤q^2≤n,  x=q^2,  y=2q+1,  y+z=n,  x>z
     *
     */


    public static int gFlavio1( int n ) {        // Pre: n > 0

        int q = 1, j = 0, p = 1;

        while (q+j<n) {         // Inv: q+j≤n , ∃k.q=2^k, 0≤j<q , p=2j+1
                                // Term: n – q – j
            if (j+1<q) {
                j = j+1;
                p = 2*j+3;  // p = xxxx;

            } else {
                q = 7;  // q = xxxx;
                j = 0;
                p = 1;
            }
        }
        return p;  // Post: p = gf(n)
    }

    /**
     *
     * (a) Sostituisco i valori conosciuti all'inizio all'invatiante e semplifico:
     *
     *      q = 1
     *      j = 0
     *      p = 1
     *
     * (b) Assumo che valga sia l'invariante che la condizione per entrare nel while:
     *
     *      q+j≤n , ∃k.q=2^k, 0≤j<q , p=2j+1, q+j<n
     *
     *      Divido in due casi:
     *
     *          (1) - if (j+1<q):
     *
     *              j' = j+1
     *              p' = 2j'+1 = 2(j+1)+1 = 2j+3
     *
     *          (2) - else:
     *
     *              q' = xxxx;
     *              j' = 0;
     *              p' = 1;
     *
     * (c) Assumo che l'invariante valga ma che la condizione per entrare nel while non valga:
     *
     *      q+j≤n, ∃k.q=2^k, 0≤j<q, p=2j+1, q+j≥n
     *
     *      ne consegue: p=2j+1 = gf(2k+j) = gf(n)
     *      in quanto n = q+j = 2k+j e 0 ≤ j < q = 2k
     *
     */

    public static int pow4( int n ) { // Pre: n > 0
        int x = 0, y = 0;
        int z = 1, u = 1;

        while ( x < u ) {   // Inv: x≤n^2,  y=x^2,  z=2x+1,  u=min(y+z,n^2)
            x = x + 1;
            y = y + z;  //y = y + xxxx;
            z = z + 2;  //z = z + xxxx;

            if (x < n) {
                u = y + z;
            }
        }
        return y;           // Post: y = n^4
    }

    /**
     *
     * (a) Sostituisco i valori conosciuti all'inizio all'invatiante e semplifico:
     *
     *      x = 0
     *      y = x^2 = 0
     *      z = 2x+1 = 1
     *      u = min(y+z,n^2) = min(1,n^2) = 1
     *
     * (b) Assumo che valga sia l'invariante che la condizione per entrare nel while:
     *
     *      x' = x+1
     *      y' = x'^2 = (x+1)^2 = x^2+2x+1 = y+z
     *      z' = 2x'+1 = 2(x+1)+1 = 2x+3
     *      u' = y'+z' = y+z+2x+3
     *
     * (c) Assumo che l'invariante valga ma che la condizione per entrare nel while non valga:
     *
     *       x≤n^2,  y=x^2,  z=2x+1,  u=min(y+z,n^2),  x>=u
     *
     */
}
