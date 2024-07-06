package com.company;

public class Main {

    public static void main(String[] args) {

        String btr = "+-";

        StringSList ls = new StringSList();
        StringSList s = ls.cons(btr);

        int n = 10;

        for (int i = 1; i < n; i++) {
            s = s.cons(bitComplement.BtrSucc(s.car()));
        }

        System.out.println("");
        System.out.println("------------------------------------------------------------------------");
        System.out.println("Lista dei "+n+" interi consecutivi in notazione BTR, a partire da "+btr+":");
        System.out.println(s.reverse());
        System.out.println("------------------------------------------------------------------------");
    }
}
