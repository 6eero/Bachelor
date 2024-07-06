package com.company;

public class Board {
    /**
     * Protocollo della classe "Board":
     * 
     * Board b = new Board(n);
     * 
     * b.size()                : int
     * 
     * b.queensOn()            : int
     * 
     * b.underAttack(i,j)      : boolean
     * 
     * b.arrangement()         : String
     * 
     * b.addQueen(i,j)         : Board
     */
    private final String ROWS = (" 123456789");
    private final String COLS = (" abcdefghi");

    private final int size;
    private final int queens;

    private final SList<Integer> rows;
    private final SList<Integer> cols;
    private final SList<Integer> rDiag;
    private final SList<Integer> lDiag;

    private final String config;
    
    
    public Board( int n ) {

        size = n;
        queens = 0;
        rows = new SList<Integer>();
        cols = new SList<Integer>();
        rDiag = new SList<Integer>();
        lDiag = new SList<Integer>();
        config = " ";
    }
    
    private Board(int n, int q, SList<Integer> r, SList<Integer> c, SList<Integer> rD, SList<Integer> lD, String cf) {

        size = n;
        queens = q;
        rows = r;
        cols = c;
        rDiag = rD;
        lDiag = lD;
        config = cf;
    }
    
    public int size() {

        return size;
    }
    
    public int queensOn() {

        return queens;
    }
    
    public boolean underAttack( int i, int j )
    {
        SList<Integer> r = rows;
        SList<Integer> c = cols;
        boolean state = false;

        for( int k=0; k<rows.length(); k++) {
            if(i == r.car() ||
                    j == c.car() ||
                    (i+j) == (r.car()+c.car()) ||
                    (i-j) == (r.car()-c.car())
            )
                state = true;
     
            else {
                r = r.cdr();
                c = c.cdr();
            }
        }
        return state;
    }
    
    public String arrangement() {
        return config;
    }
    
    public Board addQueen( int i, int j ) {

        return new Board( 
                        size, 
                        queens+1, 
                        rows.cons(i),
                        cols.cons(j),
                        rDiag.cons(i-j),
                        lDiag.cons(i+j),
                        config  + COLS.charAt(j) + ROWS.charAt(i) + " "
                        );
    }
    
    public String toString() {
        return arrangement();
    }
}
