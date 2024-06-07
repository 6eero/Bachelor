package com.company;

import queens.ChessboardView;
import java.util.Scanner;

public class Main {

    public static void main( String args[] ) {

        // Input grandezza della tavoletta
        Scanner sc = new Scanner(System.in);
        System.out.println("");
        System.out.println("*---------------------------------------------*");
        System.out.println("|  Inserisci la dimensione della scacchiera:  |");
        System.out.println("*---------------------------------------------*");
        System.out.println("");
        int n = sc.nextInt();

        int sol = Queens.numberOfSolutions(n);
        SList<Board> guiQueens = Queens.listOfAllSolutions(n);

        System.out.println("*---------------------------------------------------*");
        System.out.println("Numero di soluzioni -------> " + sol);
        System.out.println("Configurazioni possibili --> " + guiQueens);
        System.out.println("*---------------------------------------------------*");

        for (int i = 0; i < sol; i++) {

            ChessboardView gui = new ChessboardView( n );
            String s = guiQueens.car().toString();

            gui.setQueens( s );
            guiQueens = guiQueens.cdr();
        }
    }
}


