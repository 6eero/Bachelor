package com.company;

public class Main {

    public static void main( String args[] ) {  // Stampa le prime 10 soluzioni

        int n = 10;

        System.out.println("");
        System.out.println("*--------------------------------------------------------------*");

        for (int i = 1; i <= n; i++) {
            if (i != 10)
                System.out.println("Dimensione della scacchiera: "+i+"  ->  numero di soluzioni: "+Queens.numberOfSolutions(i));
            else
                System.out.println("Dimensione della scacchiera: "+i+" ->  numero di soluzioni: "+Queens.numberOfSolutions(i));
        }
        System.out.println("*--------------------------------------------------------------*");
    }
}
