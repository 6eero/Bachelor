package com.company;

public class Main {

    public static void main(String[] args) {

        int[] array1 = {6, 1, 7, 2, 8, 3, 9, 4, 10, 5, 6} ;
        int[] array2 = {6, 1, 7, 2, 8, 3, 9, 4, 10, 5, 6} ;

        int ris = llis.llis(array1);
        int ris2 = llisExt.llisExt(array2);

        System.out.println("");
        System.out.println("*---------------------------------*");
        System.out.println("|   Risultato llis -------->  " + ris + "   |");
        System.out.println("|   Risultato llisExt: ---->  " + ris2 + "   |");
        System.out.println("*---------------------------------*");
    }

}