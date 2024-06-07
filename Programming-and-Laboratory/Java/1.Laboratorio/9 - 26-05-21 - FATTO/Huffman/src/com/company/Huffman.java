package com.company;

/**
 * Codifica di Huffman
 *
 * Classe Huffman: algoritmi di compressione e decompressione
 *
 * Albero di Huffman:
 *
 *       /\
 *      /\ T
 *     /\ C
 *    G  A
 *
 * Rappresentazione compressa della sequenza: 0 -> un passo a sinistra, 1 -> un passo a destra
 *
 *      A  T T  C T  A   C  C T T  G  T
 *     001|1|1|01|1|001|01|01|1|1|000|1
 *
 */

import huffman_toolkit.*;

public class Huffman{

    public static final int CHARS = InputTextFile.CHARS;


    //------------------- Compressione -------------------

    /** 1.
     * Istogramma delle frequaneze dei caratteri
     * src: nome del documento da comprimere
     */

    public static int[] charHistogram(String src){    // ritorna il # di occorrenze un carattere in un documento src

        InputTextFile in = new InputTextFile(src); // apre il file

        int[] freqs = new int[CHARS];              // CHARS = 128

        for (int c=0; c<CHARS; c=c+1){  // inizializzo a 0 un array lungo quanti caratteri ci sono in src
            freqs[c] = 0;
        }

        while (in.textAvailable()){   // ogni volta che trova un carattere incrementa una variabile
            char c = in.readChar();   // legge tutti i caratteri
            freqs[c] = freqs[c]+1;    // incremento di 1 il # di occorenze del carattere c
        }

        in.close();   // chiude il file
        return freqs;
    }

    /** 2.
     * Albero binario di codifica dei caratteri
     * freq: istogramma delle frequenze
     */

    public static Node huffmanTree(int[] freq){  // dato il numero di occorneze dei caratteri, restituisce l'albero appropriato di huffman

        NodeQueue queue = new NodeQueue();  // creo una coda di prioritá vuota

        // Ogni volta che trovo una occorrenza != 0, costruisce un nodo e lo aggiunge all'albero
        for (int c=0; c<CHARS; c=c+1){

            if (freq[c] > 0) {                            // verifica che il # di occorrenze sia > 0
                Node n = new Node((char) c, freq[c]);     // crea il nodo
                queue.add(n);                              // e lo aggiunge alla coda di prioritá
            }
        }

        // Dalla lista nella forma <G:1, A:2, C:3, T:6> appena creata costruisco l'albero di Huffman
        while (queue.size() > 1){

            Node l = queue.poll();   // pesco dalla coda l'elemento, che non sará piú disponibile nella coda
            Node r = queue.poll();

            Node n = new Node(l, r); // costruisco un nuovo nodo
            queue.add(n);  // inserisco il risultato nell'albero
        }
        return queue.poll();  // restiotutisco l'ultimo elemento della coda, cioé l'albero finale
    }


    /** 3.
     * Tabella di codifica dei caratteri:
     * root: nodo radice dell'albero di Huffman
     */

    public static String[] huffmanCodesTable( Node root ) {

        String[] codes = new String[ CHARS ];                   // tabella dei codici di Huffman

        NodeStack stack = new NodeStack();                      // stack dei sottoalberi da visitare

        stack.push( root );                                     // visita dell'albero di Huffman
        String code = "";                                       // codice associato al nodo in cima allo stack

        do {

            Node n = stack.pop();                                 // prossimo sottoalbero da visitare

            if ( n.isLeaf() ) {

                codes[ n.character() ] = code;                      // nodo foglia: code = codice del carattere

                int k = code.lastIndexOf( '0' );
                if ( k >= 0 ) {
                    code = code.substring( 0, k ) + "1";              // codice associato al nodo in cima allo stack
                }
            } else {

                stack.push( n.right() );                            // nodo intermedio: visita dei sottoalberi
                stack.push( n.left()  );                            // prima (in cima) il sottoalbero sinistro

                code = code + "0";                                  // codice associato al nodo in cima allo stack
            }
        } while ( !stack.empty() );                             // visita da completare

        return codes;
    }
/*
    // Procedura che riempie la tabella ricorsivamente
    private static void fillTab(Node n, String pre, String[] codeTab){

        if (n.isLeaf()){
            char c = n.symbol();
            codeTab[c] = pre;
        } else{
            fillTab(n.left(), pre+"0", codeTab);
            fillTab(n.right(), pre+"1", codeTab);
        }
    }
*/

    /** 4.
     * Codifica lineare dell'albero di Huffman tramite visita ricorsiva
     * root: nodo visionato
     *
     * L'albero sará rappresentato da una stirnga di caratteri in cui se vedo:
     *
     * una '@' -> interpreto come un nodo non terminale (con una sottosequenza che rappresenta
     *            il sottoalbero sx e una sequenza che rappresenta il sottoalbero dx)
     *
     * qualcosa che non é '@' -> lo interpreto come un nodo foglia, quindi associato ad un carattere
     *
     * Esempio:
     *
     * Albero di Huffman:           Rappresentazione con una stringa dell'albero:
     *
     *         /\                   -> @ <sx> <dx>
     *        /\ T                  -> @ @ <sx'> <dx'> <dx>
     *       /\ C                   -> @ @ @ <sx"> <dx"> <dx'> <dx>
     *      G  A                    -> @ @ @ G A <dx'> <dx>
     *                              -> @ @ @ G A C <dx>
     *                              -> @ @ @ G A C T
     */

    private static String flattenTree( Node root ) {

        NodeStack stack = new NodeStack();
        String flat = "";

        stack.push( root );                                     // radice dell'albero di Huffman

        do {

            Node n = stack.pop();

            if ( n.isLeaf() ) {                                   // foglia: codifica del carattere

                char c = n.character();

                if ( (c == '\\') || (c == '@') ) {
                    flat = flat + "\\" + c;                           // caratteri speciali: \, @
                } else {
                    flat = flat + c;                                  // altri caratteri
                }
            } else {

                flat = flat + "@";                                  // @

                stack.push( n.right() );                            // codifica del sottoalbero destro
                stack.push( n.left() );                             // dopo la codifica del sottoalbero sinistro
            }
        } while ( !stack.empty() );

        return flat;
    }

    /** 5.
     * Compressione
     * src: nome del documento digitale
     * dst: nome del documento compresso
     */

    public static void compress(String  src, String dst){

        int[] freqs = charHistogram(src);            // Crea un array contenente le ricorrenze dei caratteri
        Node hroot = huffmanTree(freqs);             // Crea l'albero a partire dal precedente array
        int count = hroot.weight();                  // numero complessivo di caratteri
        String[] hcode = huffmanCodesTable(hroot);   // Crea la tabella con le ricorrenze

        InputTextFile in = new InputTextFile(src);      // documento originale
        OutputTextFile out = new OutputTextFile(dst);   // documento compresso

        String htxt = flattenTree(hroot);  //htxt -> stringa dell' albero di Huffman, vedi punto 4

        out.writeTextLine("" + count);         // Intestazione
        out.writeTextLine( flattenTree(hroot) );  // Intestazione

        for ( int j=0; j<count; j=j+1 ) {                       // scansione: codifica dei caratteri

            char c = in.readChar();
            out.writeCode(hcode[c]);
        }

        in.close();
        out.close();

        //return hroot;  // ritorna l'albero, utile per la decompressione
    }

    //------------------- Decompressione -------------------

    /** 6.
     * Ricostruzione
     * in: documento compresso
     *
     * Struttura:
     *
     * - foglia rappresentata dal carattere corrispondnete
     * - albero con piú di un nodo rappresentato dalla linearizzazione dei sottoalberi
     *   sinistro e destro, precedute dal simbolo '@'
     */

    public static Node restoreTree( InputTextFile in ) {

        NodeStack stack = new NodeStack();
        Node n = null;

        do {

            char c = (char) in.readChar();                        // simbolo successivo della codifica dell'albero

            if ( c == '@' ) {                                     // '@' ?

                stack.push( null );                                 // segnaposto per la creazione di un nuovo nodo
                // di cui al momento non si conoscono i figli
            } else {
                // carattere
                if ( c == '\\' ) {
                    c = (char) in.readChar();                         // simbolo speciale (skip)
                }
                n = new Node( c, 0 );                               // il nodo puo' essere creato immediatamente

                while ( !stack.empty() && (stack.peek() != null) ) {

                    n = new Node( stack.pop(), n );                   // costruzione di un nodo per cui sono disponibili
                }                                                   // i figli
                if ( !stack.empty() )  {

                    stack.pop();                                      // rimozione del segnaposto (null)
                    stack.push( n );                                  // n nello stack in attesa del nodo fratello
                }
            }
        } while ( !stack.empty() );

        return n;                                               // radice dell'albero di Huffman
    }

    /** 7.
     * Deompressione
     * src: nome del documento compresso
     * dst: nome del documento ripristinato
     *
     * Bisogna avere un riferimento alla radice dell'albero, scendere interpretando il contenuto bit a bit
     * del file del file di input "in" e quando raggiungo la foglia ho trovato un carattere
     */

    public static void decompress( String src, String dst ) {

        InputTextFile in = new InputTextFile( src );            // documento compresso

        int count = Integer.parseInt( in.readTextLine() );      // decodifica dell'intestazione
        Node root = restoreTree( in );

        String dummy = in.readTextLine();                       // codici caratteri dopo il fine-linea

        OutputTextFile out = new OutputTextFile( dst );         // documento ripristinato

        for ( int j=0; j<count; j=j+1 ) {                       // scansione: decodifica dei caratteri

            char c = decodeNextChar( root, in );
            out.writeChar( c );
        }
        in.close();
        out.close();
    }

    // Decodifica del carattere successivo
    // root: nodo radice dell'albero di Huffman
    // in:   documento compresso

    private static char decodeNextChar( Node root, InputTextFile in ) {

        Node n = root;                      // percorso lungo l'albero di Huffman

        do {
            if ( in.readBit() == 0 ) {
                n = n.left();               // bit 0: figlio sinistro
            } else {
                n = n.right();              // bit 1: figlio destro
            }
        } while ( !n.isLeaf() );            // fino al raggiungimento di una foglia

        return n.character();                  // carattere individuato
    }
}


