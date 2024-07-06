package com.company;

public class Operazioni {

    public int numX;
    public int numY;

    public Operazioni(int x, int y) {
        numX = x;
        numY = y;
    }

    public int somma() {
        return numX + numY;
    }

    public int sottrazione() {
        return numX - numY;
    }
}
