/**
Codifica di Huffman

Protocollo:

 Costruttori:

    Node n = new Node(c, w)   ->   nodo non foglia.  c: carattere, w: numero di occorrenze (peso del nodo)
    Node u = new Node(l, r)   ->   nodo foglia.      l: albero sinistro, r: albero destro

 Metodi:

    ... n.symbol() : char     -> restituisce il carattere
    ... n.weight() : int      -> restituisce il peso del carattere (numero di occorrenze)

    ... u.left()   : Node     -> restituisce il figlio sinistro
    ... u.right()  : Node     -> restituisce il figlio destro

    ... n.isLeaf() : boolean  -> restituisce 1 se é una foglia, 0 se é di tipo genitore
 */

public class Node implements Comparable<Node>{  // implementa un confronto tra nodi

    // Oggetti immutabili (final)

    private final char chr;
    private final int wgt;
    private final Node lft;  // Nodo figlio sinistro
    private final Node rgt;  // Nodo figlio destro


    // Costruttori

    public Node(char c, int w){

        chr = c;
        wgt = w;
        lft = null;  // Non ci sono nodi figli
        rgt = null;  // Non ci sono nodi figli
    }

    public Node(Node l, Node r){

        chr = 'a';                      // Carattere non importante
        wgt = l.weight() + r.weight();  // il peso del nodo che stiamo analizzando é la somma del peso dei suoi due sottoalberi discendenti
        lft = l;
        rgt = r;
    }

    // Metodi

    public boolean isLeaf(){

        return (lft == null);
    }

    public char symbol(){

        return chr;
    }

    public int weight(){

        return wgt;
    }

    public Node left(){

        return lft;
    }

    public Node right(){

        return rgt;
    }

    // Confronto dei pesi dei nodi
    // in accordo al;le specifiche per la gestione di una coda di prioritá
    // (protocollo di Comparable<Node>)


    public int compareTo(Node n){

        if (wgt < n.weight())
            return -1;
        else if (wgt == n.weight())
            return 0;
        else                          // wgt > n.weight()
            return +1;
    }
}
