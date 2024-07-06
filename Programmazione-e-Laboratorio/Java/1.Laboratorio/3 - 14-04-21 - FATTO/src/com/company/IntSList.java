package com.company;

/**
 * Classe IntSList: Integer Scheme-like Lists
 *
 * Definizione di una classe in Java per realizzare oggetti
 * assimilabili alle liste in Scheme, limitatamente al caso
 * di liste di interi.
 *
**/

public class IntSList {

    // Variabili di istanza
    private final boolean empty;   // lista vuota
    private final int first;       // primo elemento della lista
    private final IntSList rest;   // resto della lista

    // Costruttore: creazione di una lista vuota (Scheme: null)
    public IntSList() {
        empty = true;
        first = 0;
        rest = null;
    }

    // Costruttore: creazione di una lista non vuota (Scheme: cons)
    public IntSList(int e, IntSList il) {
        empty = false;
        first = e;
        rest = il;
    }

    // Realizzazione alternativa del "cons"
    public IntSList cons( int e ) {

        return new IntSList( e, this );
    }

    // Metodo per verificare se una lista è vuota (Scheme: null?)
    public boolean isNull() {

        return empty;
    }

    // Metodo per acquisire il primo elemento di una lista non vuota (Scheme: car)
    public int car() {

        return first;
    }

    // Metodo per acquisire il resto di una lista non vuota (Scheme: cdr)
    public IntSList cdr() {

        return rest;
    }

    // Ritorna la lunghezza della lista a cui é applicato
    public int length() {

        if (isNull()) {
            return 0;
        } else {
            return (1 + cdr().length());
        }
    }

    // Ritorna l'elemento in posizione i della lista a cui é applicato
    public int listRef(int k) {

        if ( k == 0 ) {
            return car();
        } else {
            return ( cdr().listRef(k-1) );
        }
    }

    // Ritorna true se la lista a cui é applicato é uguale ad un'altra lista data come input
    public boolean equals( IntSList il ) {

        if (isNull() || il.isNull()) {
            return (isNull() && il.isNull());
        } else if (car() == il.car()) {
            return cdr().equals(il.cdr());
        } else {
            return false;
        }
    }

    // Ritorna due liste unite
    public IntSList append(IntSList il) {

        if (isNull()) {
            return il;
        } else {
            return (cdr().append(il)).cons(car());
        }
    }

    // Ritorna una lista con gli elementi inveriti
    public IntSList reverse() {

        return reverseRec(new IntSList());
    }

    // Metodo supplementare
    private IntSList reverseRec( IntSList re ) {

        if ( isNull() ) {
            return re;
        } else {
            return cdr().reverseRec( re.cons(car()) );
        }
    }

    // Rappresentazione testuale (String) di una lista
    public String toString() {

        if (isNull()) {
            return "()";

        } else {
            String rep = "(" + car();
            IntSList r = cdr();

            while (!r.isNull()) {
                rep = rep + ", " + r.car();
                r = r.cdr();
            }
            return (rep + ")");
        }
    }
}
