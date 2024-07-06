package com.company;

/**
 * Esempi:
 *
 * {50, 3, 10, 7, 40, 80} -> 3 [50, 10, 7]
 * {15, 27, 14, 38, 63, 55, 46, 65, 85} -> 3 [63, 55, 46]
 * {3, 4, 8, 7, 1} -> 3 [8, 7, 1]
 * {8, 4, 12, 2, 10, 6, 14, 1, 9, 5, 13, 3, 11, 7, 15} -> 5 [12, 10, 9, 5, 3]
 */

public class Main {

    public static int[] array = {8, 4, 12, 2, 10, 6, 14, 1, 9, 5, 13, 3, 11, 7, 15};

    public static void main(String[] args) {

        int ris3 = llds.llds(array);
        int ris4 = BottomUpLDS.lldsDP(array);
        int[] ris5 = lds.ldsDP(array);

        System.out.println("");
        System.out.println("-----------------------");
        System.out.println("Risultato ricorsivo: "+ris3);
        System.out.println("-----------------------");

        System.out.println("Risultato memorization: "+ris4);
        System.out.println("-----------------------");

        System.out.println("Risultati lds:");
        for (int i = 0; i < ris5.length; i++){
            System.out.println( ris5[i]+ " ");
        }
        System.out.println("-----------------------");
    }
}

