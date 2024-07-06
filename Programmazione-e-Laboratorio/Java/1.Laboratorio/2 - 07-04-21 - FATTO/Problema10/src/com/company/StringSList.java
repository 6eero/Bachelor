package com.company;

public class StringSList {

    private final boolean empty;
    private final String first;
    private final StringSList rest;

    public StringSList() { // null
        empty = true;
        first = null;
        rest = null;
    }

    public StringSList(String e, StringSList sl) { // cons
        empty = false;
        first = e;
        rest = sl;
    }

    public boolean isNull() { // null?
        return empty;
    }

    public String car() { // car
        return first;
    }

    public StringSList cdr() { // cdr
        return rest;
    }

    public StringSList cons(String e) { // cons (modalità alternativa)
        return new StringSList(e, this);
    }

    public int length() { // length
        if (isNull())
            return 0;
        else
            return 1 + cdr().length();
    }

    public String listRef(int k) { // list-ref
        if (k == 1)
            return car();
        else
            return cdr().listRef(k-1);
    }

    public boolean equals(StringSList sl) { // equal?
        if (isNull() == sl.isNull())
            return isNull() && sl.isNull();
        else if (car() == sl.car())
            return cdr().equals(sl.cdr());
        else
            return false;
    }

    public StringSList append(StringSList sl) { // append
        if (isNull())
            return sl;
        else
            return (cdr().append(sl)).cons(car());
    }

    public StringSList reverse() {  // Scheme: reverse -> rovesciamento di una lista
        return reverseRec(new StringSList());
    }

    private StringSList reverseRec(StringSList re ) {  // metodo di supporto: private!
        if (isNull())
            return re;
        else
            return cdr().reverseRec(re.cons(car()));
    }

    /** Rappresentazione testuale (String) di una lista **/

    public String toString() {  // ridefinizione del metodo generale
        if (isNull())
            return "()";
        else {
            String rep = "(" + car();
            StringSList r = cdr();

            while (!r.isNull()) {
                rep = rep + ", " + r.car();
                r = r.cdr();
            }
            return (rep + ")");
        }
    }
}