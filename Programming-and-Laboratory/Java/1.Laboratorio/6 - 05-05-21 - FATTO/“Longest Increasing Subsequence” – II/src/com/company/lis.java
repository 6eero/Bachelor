package com.company;

public class lis {

     /** Longest Increasing Subsequence (LIS): Programmazione dinamica bottom-up **/

     public static int[] lisDP( int[] s ) {

         int n = s.length;
         int[][] mem = new int[ n+1 ][ n+1 ];

        // Replica qui il codice di llisDP che registra nella matrice i valori corrispondenti alle ricorsioni di llisRec
         for (int j=0; j<=n; j=j+1) {
             mem[n][j] = 0;
         }

         for (int i=n-1; i>=0; i=i-1) {
             for (int j=0; j<=n; j=j+1) {

                 if ((j < n) && (s[i] <= s[j])) {
                     mem[i][j] = mem[i + 1][j];    // llisRec(s,i+1,t)

                 } else {
                     mem[i][j] = Math.max(
                             mem[i + 1][i] + 1,    // llisRec(s,i+1,s[i]) + 1
                             mem[i + 1][j]         // llisRec(s,i+1,t)
                     );
                 }
             }
         }

         //  Inserisci di seguito l'elemento della matrice il cui valore corrisponde a llis(s) :
         int[] array = Main.array;
         int m = BottomUpLIS.llisDP(array);  //m = lunghezza sottosequenza piu lunga

         int[] r = new int[m];  // per rappresentare una possibile LIS

         //  Introduci e inizializza qui gli indici per seguire un cammino nella matrice e assegnare gli elementi della sottosequenza r
         int i = 0;  // punto di partenza colonne
         int j = n;  // punto di partenza righe

         int x = 0;

         while (mem[i][j] > 0) {  // ripete il ciclo finche non raggiungo i casi base (mem[5][...])

             int t = (j == n) ? 0 : s[j];

             int a = mem[i][j];
             int b = mem[i+1][i] + 1;

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
         return r;  // r = {2, 5, 7}
     }
}

