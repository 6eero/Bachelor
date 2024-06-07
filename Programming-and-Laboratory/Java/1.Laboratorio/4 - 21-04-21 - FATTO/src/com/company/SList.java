package com.company;

/**
 * Classe SList<T>: String Scheme-like Lists
 *
 * Definizione di una classe in Java per realizzare oggetti
 * assimilabili alle liste in Scheme, limitatamente al caso
 * di liste di stringhe.
 *
 **/

public class SList<T> {

    // Variabili di istanza
    private final boolean empty;   // lista vuota
    private final T first;         // primo elemento della lista
    private final SList<T> rest;   // resto della lista
    

    // Costruttore: creazione di una lista vuota (Scheme: null)
    public SList() {

        empty = true;
        first = null;
        rest = null;
    } 
    
    // Costruttore: creazione di una lista non vuota (Scheme: cons)
    public SList( T x, SList<T> s) {

        empty = false;
        first = x;
        rest = s;
    } 

    // Metodo per verificare se una lista è vuota (Scheme: null?)
    public boolean isNull() {

        return empty;
    } 
    
    // Metodo per acquisire il primo elemento di una lista non vuota (Scheme: car)
    public T car() {

        return first;
    } 
    
    // Metodo per acquisire il resto di una lista non vuota (Scheme: cdr)
    public SList<T> cdr() {

        return rest;
    }
    
    // Realizzazione alternativa del "cons"
    public SList<T> cons( T x ) {

        return new SList<T>(x,this);
    }

    // Ritorna la lunghezza della lista a cui é applicato
    public int length() {

        if (isNull())
            return 0;
        else
            return 1 + cdr().length();
    }

    // Ritorna l'elemento in posizione i della lista a cui é applicato
    public T listRef( int i ) {

        if(i == 0)
            return car();
        else
            return cdr().listRef(i-1);
    }

    // Ritorna true se la lista a cui é applicato é uguale ad un'altra lista data come input
    public boolean equals(SList<T> sl) {

        if (this.isNull() || sl.isNull())
            return (this.isNull() && sl.isNull());

        else if (this.car().equals(sl.car()))
            return this.cdr().equals(sl.cdr());

        else
            return false;
    }

    // Ritorna due liste unite
    public SList<T> append( SList<T> sl) {

        if(isNull())
            return sl;

        else
            return (cdr().append(sl)).cons(car());
    }

    // Ritorna una lista con gli elementi inveriti
    public SList<T> reverse() {

        return reverseTR(new SList<T>());
    }

    // Metodo supplementare
    private SList<T> reverseTR(SList<T> sl) {

        if(isNull())
            return sl;

        else
            return cdr().reverseTR( sl.cons(car()) );
    }
    
    
    // Rappresentazione testuale (String) di una lista
    public String toString () {

        if (isNull())
            return "()";
        else {
            String rep = "(" + car();
            SList<T> r = cdr();

            while (!r.isNull()) {
                rep = rep + ", " + r.car();
                r = r.cdr();
            }
            return (rep + ")");
        }
    }
}
