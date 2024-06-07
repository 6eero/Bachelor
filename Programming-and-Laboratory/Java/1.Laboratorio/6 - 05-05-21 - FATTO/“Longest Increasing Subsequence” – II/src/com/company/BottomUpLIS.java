package com.company;

public class BottomUpLIS {

 /* Completa il programma preimpostato nel file BottomUpLIS.java, senza modificare le parti già codificate, per
     realizzare la procedura lisDP (metodo statico) applicando una tecnica di programmazione dinamica bottom-up
     completata da un cammino attraverso la matrice in accordo con le indicazioni fornite. Verifica quindi che i risultati
     ottenuti siano coerenti con quanto ci si dovrebbe attendere. */

    public static int llisDP(int[] s) {

        // dichiarazione variabili, quali sono le variabili che nella ricorsione cambiano? qual é il valore massimo che assumono?
        int n = s.length;
        int[][] mem = new int[n + 1][n + 1];

        // Inserisci qui i comandi per registrare i valori corrispondenti ai casi base della ricorsione
        for (int j=0; j<=n; j=j+1) {
            mem[n][j] = 0;
        }

        // Inserisci qui le strutture di controllo appropriate e comandi per registrare i valori dei casi ricorsivi
        for (int i=n-1; i>=0; i=i-1) {
            for (int j=0; j<=n; j=j+1) {

                if ((j < n) && (s[i] <= s[j])) {     // x = s[i] ≤ t : x non può essere scelto
                    mem[i][j] = mem[i + 1][j];

                } else {                        // x > t : x può essere scelto o meno
                    mem[i][j] = Math.max(
                            mem[i + 1][i] + 1,    // llisRec(s,i+1,s[i]) + 1
                            mem[i + 1][j]         // llisRec(s,i+1,t)
                    );
                }
            }
        }

        //  Inserisci di seguito l'elemento della matrice il cui valore corrisponde a llis(s) :
        return mem[0][n];
    }
}