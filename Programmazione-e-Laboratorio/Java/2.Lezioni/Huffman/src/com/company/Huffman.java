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


package com.company;

import java.util.*;
import huffman_toolkit.*;

public class Huffman{

    private static final int CHARS = InputTextFile.CHARS;


    //------------------- Compressione -------------------

    /** 1.
     * Istogramma delle frequaneze dei caratteri
     * src: nome del documento da comprimere
     */

    public static int[] charFreqs (String src){    // ritorna il # di occorrenze un carattere in un documento src

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

    public static Node huffmanTree(int[] freqs){  // dato il numero di occorneze dei caratteri, restituisce l'albero appropriato di huffman

        PriorityQueue<Node> queue = new PriorityQueue<Node>();  // creo una coda di prioritá vuota

        // Ogni volta che trovo una occorrenza != 0, costruisce un nodo e lo aggiunge all'albero
        for (int c=0; c<CHARS; c=c+1){

            if (freqs[c] > 0) {                            // verifica che il # di occorrenze sia > 0
                Node n = new Node((char) c, freqs[c]);     // crea il nodo
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

    public static String[] huffmanTable (Node root){   // root -> albero di huffman creato prima

        String[] codeTab = new String[CHARS];  // Creazione tabella vuota

        fillTab(root, "", codeTab);  // fillTab(punto dell'albero da analizzare, percorso per raggiungere quel nodo, tabella da compilare)

        return codeTab;
    }

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

    /** 4.
     * Codifica lineare dell'albero di Huffman tramite visita ricorsiva
     * n: nodo visionato
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

    public static String flattenTree(Node n){

        if (n.isLeaf()){

            char c =n.symbol();
            if ((c == '\\') || (c == '@')){
                return "\\" + c;
            } else {
                return "" + c;
            }
        } else {
            String lts = flattenTree(n.left());
            String rts = flattenTree(n.right());

            return "@" + lts + rts;                 // Restituisce la rappresentazione dell'albero
        }
    }

    /** 5.
     * Compressione
     * src: nome del documento digitale
     * dst: nome del documento compresso
     */

    public static void compress(String  src, String dst){

        int[] freqs = charFreqs(src);                // Crea un array contenente le ricorrenze dei caratteri
        Node hroot = huffmanTree(freqs);             // Crea l'albero a partire dal precedente array
        String[] hcode = huffmanTable(hroot);        // Crea la tabella con le ricorrenze

        InputTextFile in = new InputTextFile(src);
        OutputTextFile out = new OutputTextFile(dst);

        int count = hroot.weight();

        String htxt = flattenTree(hroot);  //htxt -> stringa dell' albero di Huffman, vedi punto 4

        out.writeTextLine(""+count);                            // Intestazione
        out.writeTextLine("Albero di Huffman: "+ htxt);         // Intestazione

        for (int i=0; i<count; i=i+1){

            char c = in.readChar();
            String s = hcode[c];
            out.writeCode(s);
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

    public static Node restoreTree(InputTextFile in){

        char c = in.readChar();

        if (c == '@') {
            Node l = restoreTree(in);
            Node r = restoreTree(in);
            return new Node(l, r);
        } else {
            if (c == '\\'){
                c = in.readChar();
            }
            return new Node(c, 0);
        }
    }

    /** 7.
     * Deompressione
     * src: nome del documento compresso
     * dst: nome del documento ripristinato
     *
     * Bisogna avere un riferimento alla radice dell'albero, scendere interpretando il contenuto bit a bit
     * del file del file di input "in" e quando raggiungo la foglia ho trovato un carattere
     */

    public static void decompress(String src, String dst){

        InputTextFile in = new InputTextFile(src);
        OutputTextFile out = new OutputTextFile(dst);

        int count = Integer.parseInt(in.readTextLine());
        Node hroot = restoreTree(in);
        String dummy = in.readTextLine();  // Salta l'a-capo

        for (int i=0; i<count; i=i+1){

            char c = decodeNextChar(hroot, in);
            out.writeChar(c);
        }

        in.close();
        out.close();
    }

    // Decodifica del carattere sucessivo
    private static char decodeNextChar (Node n, InputTextFile in){

        do {
            int bit = in.readBit();
            if (bit == 0){             // bit = 0
                n = n.left();
            } else {                   // bit = 1
                n = n.right();
            }
        } while (! n.isLeaf());        // se non é ina foglia, continua ad iterare

        // Arrivati ad una foglia, la restituisce
        return n.symbol();
    }
}


