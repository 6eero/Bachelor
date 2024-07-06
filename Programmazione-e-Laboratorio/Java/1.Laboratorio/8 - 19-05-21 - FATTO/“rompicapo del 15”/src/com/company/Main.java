package com.company;

import puzzleboard.PuzzleBoard;
import java.util.Arrays;
import java.util.Collections;
import java.util.List;
import java.util.Scanner;

/*
PuzzleBoard gui = new PuzzleBoard( n ) -> crea la rappresentazione grafica di un tavoletta n x n

gui.setNumber( i,j, k ) ----------------> colloca in posizione <i, j> un tassello con numero k

gui.clear( i,j ) -----------------------> cancella il tassello in posizione <i, j> (in corrispondenza alla quale si crea una lacuna)

gui.display() --------------------------> aggiorna la visualizzazione (i due metodi precedenti non lo fanno automaticamente)

int k = gui.get() ----------------------> restituisce il numero associato al tassello su cui si è agito attraverso un click del mouse (l’esecuzione di get resta sospesa fino a quando l’utente attua una selezione valida con il mouse)
*/

public class Main {

    private final static int UNKNOWN = -1;

    public static void main(String[] args) {


        /** Creazione della tavoletta con tasselli ordinati casualmente **/

        // Input grandezza della tavoletta
        Scanner sc = new Scanner(System.in);
        System.out.println("");
        System.out.println("*---------------------------------------------*");
        System.out.println("|  Inserisci la dimensione della scacchiera:  |");
        System.out.println("*---------------------------------------------*");
        System.out.println("");
        int size = sc.nextInt();

        int x = 0;
        PuzzleBoard gui = new PuzzleBoard(size);
        Board grid = new Board(size);;
        Integer[] intArray = new Integer[size*size];
        List<Integer> intList = Arrays.asList(intArray);

        for (int i = 0; i < size*size; i++) {
            intList.set(i, i);
        }

        Collections.shuffle(intList);
        System.out.println(Arrays.toString(intArray));

        // Creazione della matrice e immissione dei tasselli isulla griglia
        for (int i = 1; i <= size; i++) {
            for (int j = 1; j <= size; j++) {
                grid.array[i-1][j-1] = intList.get(x);
                gui.setNumber(i, j, intList.get(x));
                x++;
            }
        }

        /** Interazione con la tavoletta **/

        boolean state = true;

        int pos_x = 0;
        int pos_y = 0;

        while (state) {
            System.out.println("-------------------------");
            int k = gui.get();
            System.out.println("Tassello premuto = " + k);

            // determina la posizione del tassello cliccato
            for (int i = 0; i < size; i++) {
                for (int j = 0; j < size; j++) {

                    if (grid.array[i][j] == k) {
                        pos_x = i;
                        pos_y = j;
                    }
                }
            }
            System.out.println("Posizione = "+pos_x + " - " + pos_y);

            // determina la posizione del tassello vuoto
            for (int i = 0; i < size; i++) {
                for (int j = 0; j < size; j++) {

                    if (grid.array[i][j] == 0) {
                        grid.xempty = i;
                        grid.yempty = j;
                        System.out.println("Posizione empty = "+grid.xempty + " - " + grid.yempty);
                    }
                }
            }

            // nel caso in cui il tassello cliccato ha uno spazio vicino ed é nella griglia
            if (grid.legalClick(pos_x, pos_y)) {
                System.out.println("Il tassello si puo muovere");
                gui.clear(pos_x+1, pos_y+1);
                gui.setNumber(grid.xempty+1, grid.yempty+1, k);
                gui.display();
                grid.moveTile(pos_x, pos_y);
            }
            else
                System.out.println("Il tassello non si puo muovere");

            if (grid.isOrdered()) {
                state = false;
                System.out.println("-------------------------");
                System.out.println("Vittoria! Gioco terminato!");
            }
        }
    }
}
