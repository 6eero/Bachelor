package com.company;
import java.util.Scanner;

/*
Rappresentazione della sequenza "ATTCTACCTTGT"

G -> compare 1 volta
A -> compare 2 volte
C -> compare 3 volte
T -> compare 6 volte

Creazione dell'albero:

<G:1, A:2, C:3, T:6>


<  /\  :1+2=3, C:3, T:6>
  G  A

<  /\  :3+3=6, C:3, T:6>
  /\ C
 G  A

<  /\  :3+3=6, T:6>
  /\ C
 G  A

<  /\  :6+6=12>
  /\ T
 /\ C
G  A

E' stato creato l'albero di Huffman con i caratteri più frequenti in alto
e i meno frequenti in basso procediamo a definire il codice del percorso:

A | 001
T |   1
C |  01
G | 000

Applicazione della rappresentazione compressa

001|1|1|01|1|001|01|01|1|1|000|1
 A  T T  C T  A   C  C T T  G  T

Risultato -> 21 bit anziche 24

 */

public class Main {

    public static void main(String[] args) {

        Scanner scan = new Scanner(System.in);  //Istanzia scanner con standard input

        System.out.println("Fai una scelta: ");
        System.out.println("------------------------------------");
        System.out.println("1 - Per comprimere il documento");
        System.out.println("2 - Per decomprimere il documento");
        System.out.println("------------------------------------");

        int scelta = scan.nextInt();

        if (scelta == 1) {
            Huffman.compress("source.txt", "c.txt");
            System.out.println("Il documento é stato compresso con successo!");

        } else {
            Huffman.decompress("c.txt", "deco.txt");
            System.out.println("Il documento é stato decompresso con successo!");
        }
    }
}
