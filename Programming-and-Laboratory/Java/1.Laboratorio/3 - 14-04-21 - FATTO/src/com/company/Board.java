package com.company;

/**
 *  Protocollo:
 *
 *  Board b = new Board(n);
 *
 *  b.size():            int
 *  b.queensOn():        int
 *  b.underAttack(i, j): boolean
 *  b.arrangement():     String
 *  b.addQueen(i,j):     void
 */

public class Board{

    private static final String ROWS = " 123456789ABCDEF";
    private static final String COLS = " abcdefghijklmno";

    private final int size;
    private int queens;

    private IntSList col;
    private IntSList row;
    private IntSList dgr;
    private IntSList dgl;

    private String config;


    public Board(int n) {

        size = n;      // Dimensione della scacchiera
        queens = 0;    // Numero di regine

        col = new IntSList();
        row = new IntSList();
        dgr = new IntSList();
        dgl = new IntSList();

        config = "";  // Non ci sono regine
    }

    public int size() {  // dimensione della scacchiera (int)

        return size;
    }

    public int queensOn() {  // numero di regine collocate nella scacchiera (int)

        return queens;
    }

    /**
     * Metodo per verificare se una posizione é minacciata o no
     *
     *
     * la posizione (x, y) é minacciata se la casella in esame si trova:
     *
     *  -     (x = i) nella stessa riga della regina
     *  -     (y = j) nella stessa colonna della regina
     *  - (x-y = i-j) sulla stessa diagonale obliqua salendo verso destra
     *  - (x+y = i+j) sulla stessa giagonale obliqua scendendo verso sinistra
     */

    public boolean underAttack(int i, int j) {

        for (int x = 0; x < queens; x++) {
            if ((col.listRef(x) == i) || (row.listRef(x) == j) || (dgr.listRef(x) == i-j) || (dgl.listRef(x) == i+j))
                return true;
        }
        return false;
    }

    public String arrangement() {
        return config;
    }

    public Board addQueen(int i, int j) {

        Board newBoard = new Board(size);

        newBoard.queens = queensOn() + 1;

        newBoard.col = col.cons(i);
        newBoard.row = row.cons(j);
        newBoard.dgr = dgr.cons(i-j);
        newBoard.dgl = dgl.cons(i+j);

        newBoard.config = arrangement() + COLS.charAt(j) + ROWS.charAt(i) + " ";

        return newBoard;
    }

}

