package com.company;

public class Towers {

    // Variabili di istanza ...
    private int num;
    private int[] where;
    private String mvs;

    // Costruttore ...
    public Towers(int n){
        num = n;
        where = new int[n+1];
        mvs = "";
    }

    // Metodi ...
    public void put( int disk, int rod ){
        where[disk] = rod;
    }

    public void move( int disk, int dst ){
        mvs = mvs + "" + where[disk]+ "->" + dst;
    }

    public int height(){
        return num;
    }

    public int site( int disk ){
        return where[disk];
    }

    public int transit( int disk, int dst ){
        return (6 - site(disk) - dst);
    }

    public String moves(){
        return mvs;
    }

}
