package com.company;

/**
 *
 * IntQueue q = new IntQueue(c);    // costruttore di una coda vuota di capacità massima c
 *
 * q.size()                         // [int] numero di interi contenuti nella coda
 *
 * q.add(n)                         // costruttore di una coda vuota di capacità massima c
 *
 * q.peek()                         // [int] restituisce l’intero che è stato inserito prima, fra quelli nella coda
 *
 * q.poll()                         // [int] restituisce e rimuove dalla coda l’intero inserito da più tempo
 *
 */

/*
public class IntQueue {

    private final boolean noItem;  // indica se la lista é vuota o no
    private final int c;           // lunghezza massima della lista
    private final int n;           // ultimo elemento aggiunto
    private final int k;           // lunghezza della lista

    public IntQueue(int c) {   // costruttore di una coda vuota di capacità massima c
        noItem = true;
        this.c = c;
        n = 0;
        k = 0;
    }

    public int size() {             // [int] numero di interi contenuti nella coda
        return k;
    }

    public IntQueue add(IntQueue n) {    // [IntQueue] aggiunge l'intero n alla coda se la capacità massima non é superata
        if(noItem)
            return n;
        else
            return new IntQueue(n, ...);
    }

    public int peek() {             // [int] restituisce l’intero che è stato inserito prima, fra quelli nella coda

    }

    public int pool() {             // [int] restituisce e rimuove dalla coda l’intero inserito da più tempo

    }

}

 */
