/**
 * Codifica di Huffman
 *
 * Classe Huffman: algoritmi di compressione e decompressione
 */

import java.util.*;
import huffman_toolkit.*;

public class Huffman{

    private static final int CHARS = InputTextFile.CHARS;


    //------------------- Compressione -------------------


    // 1.
    // Istogramma delle frequaneze dei caratteri
    // src: nome del documento da comprimere

    public static int[] charFreqs (String src){    // ritorna il # di occorrenze un carattere in un documento src

        InputTextFile in = new InputTextFile(src); // apre il file
        int[] freqs = new int[CHARS];              // CHARS = 128

        for (int i = 0; i < CHARS; i++){  // inizializzo a 0 un array lungo quanti caratteri ci sono in src
            freqs[i] = 0;
        }

        while (in.textAvailable()){   // ogni volta che trova un carattere incrementa una variabile
            char c = in.readChar();   // legge tutti i caratteri
            freqs[c] = freqs[c]+1;    // incremento di 1 il # di occorenze del carattere c
        }

        in.close();   // chiude il file
        return freqs;
    }

    // 2.
    // Albero binario di codifica dei caratteri
    // freq: istogramma delle frequenze


    // 3.
    // Tabella di codifica dei caratteri:
}
