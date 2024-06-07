package com.company;

import java.util.Scanner;

public class Main {

    public static void main(String[] args) {

        Scanner scan = new Scanner(System.in);
        System.out.println("Introduci una stringa: ");
        String btr = scan.next();

        //String ris = bitComplement.BtrSucc(btr);
        //String ris = bitComplement.RecursiveOnesComplement(btr);
        String ris = bitComplement.IterativeOnesComplement(btr);

        System.out.println("Il risultato é: " + ris);
    }
}
