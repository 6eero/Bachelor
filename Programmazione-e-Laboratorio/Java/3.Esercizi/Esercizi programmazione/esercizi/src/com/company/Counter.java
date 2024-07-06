package com.company;

public class Counter {

// Counter c = new Counter(c) -> costruttore per creare un nuovo contatore inizializzato a zero;

// void incr() -> per incrementare di una unità il contatore;

// void add(long n) -> per aggiungere un valore intero non negativo n al contatore;

// void reset() -> per ri-azzerare il contatore;

// long count() -> per acquisire il valore del contatore (il conteggio);

// String toString() -> restituisce la stringa che rappresenta il valore corrente del contatore.


    private long val;

    public Counter() {

        val = 0;
    }

    public void incr() {

        val = val + 1;
    }

    public void add(long n) {

        val = val + n;
    }

    public void reset() {

        val = 0;
    }

    public long count() {

        return val;
    }

    public String toString() {

        return String.valueOf(val);
    }
}
