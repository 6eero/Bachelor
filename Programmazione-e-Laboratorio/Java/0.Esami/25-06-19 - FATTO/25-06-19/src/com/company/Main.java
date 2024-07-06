package com.company;
import java.util.*;

public class Main {

    public static void main(String args[]) {

        String[] ris1 = esame.diff("atrio", "arto");
        String[] ris2 = esame.diffTD("atrio", "arto");

        System.out.println(Arrays.toString(ris1) + " e " + Arrays.toString(ris2));

        long ris3 = esame.st(8, 5);
        long ris4 = esame.stIter(8, 5);

        System.out.println(ris3 + " e " + ris4);

        int ris5 = esame.intSqrt(16);
        System.out.println(ris5);
    }
}

