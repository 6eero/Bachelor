package com.company;

/*
 * Rompicapo del gioco del 15
 *
 * Protocollo della classe Board:
 *
 *   Board(int n)             :  Costruttore -> Creazione griglia vuota e immissione spazio
 *
 *   isOrdered()              :  boolean     -> Un metodo per verificare se i tasselli sono ordinati;
 *
 *   legalClick(int x, int y) :  boolean     -> Ritorna 1 se x,y si trova sulla tavola e vicino allo spazio (puó essere mosso)
 *
 *   toString(???)            :  String      -> Metodo per mostrare in forma testuale (stringa) la configurazione
 *
 *   moveTile (int x, int y)  :  void        -> Scambia la tessera con x,y dello spazio
 */

public class Board {

    public final int size;         // dimensione della griglia
    public int[][] array;
    public int xempty;             // coordinata x dello spazio vuoto
    public int yempty;             // coordinata y dello spazio vuoto

    // Costruttore per istanziare un modello della tavoletta
    Board(int n) {

        size = n;
        array = new int[size][size];

    }

    // Metodo per verificare se i tasselli sono ordinati
    public boolean isOrdered() {

        int x = 1;
        boolean state = false;

        for (int i = 0; i < size; i++) {
            for (int j = 0; j < size; j++) {

                if (array[i][j] == x) {
                    x++;
                    if (x == size*size) {
                        state = true;
                    }
                }
            }
        }
        return state;
    }

    //  Metodo per verificare se un dato tassello può essere spostato
    public boolean legalClick(int i, int j) {

        boolean state = false;

        if (((i+1 < size) && (array[i+1][j] == 0)) ||
                ((i-1 >= 0) && (array[i-1][j] == 0)) ||
                ((j+1 < size) && (array[i][j+1] == 0)) ||
                ((j-1 >= 0) && (array[i][j-1] == 0))) {
            state = true;
        }
        return state;
    }

    // Metodo per mostrare in forma testuale (stringa) la configurazione
    public String toString() {

        String gridprint = " ";

        for (int i = 0; i < size; i++) {
            for (int j = 0; j < size; j++) {
                gridprint = gridprint + array[i][j] + " ";
            }
        }
        return gridprint;
    }

    //  Metodo per spostare un dato tassello
    public void moveTile (int i, int j) {   // Scambia le coordinate della tessera con quelle dello spazio

        //System.out.println("Posizione emptyy = "+xempty + " - " + yempty);

        if (legalClick(i, j)) {
            array[xempty][yempty] = array[i][j];   // assegno allo spazio vuoto il tassello cliccato
            xempty = i;                            // assegno alla coordinata x dello spazio la coordinata x del tassello cliccato
            yempty = j;                            // assegno alla coordinata y dello spazio la coordinata y del tassello cliccato
            array[xempty][yempty] = 0;             // assegno alle vecchie coordinate del tassello lo spazio vuoto
        }
    }
}