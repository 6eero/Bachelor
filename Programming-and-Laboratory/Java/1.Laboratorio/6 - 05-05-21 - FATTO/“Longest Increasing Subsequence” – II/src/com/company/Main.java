package com.company;

public class Main {

    public static int[] array = {2, 7, 5, 7, 4};

    public static void main(String[] args) {

        int ris = llis.llis(array);
        int ris2 = BottomUpLIS.llisDP(array);

        System.out.println("");
        System.out.println("-----------------------");
        System.out.println("risultato llis: "+ris);
        System.out.println("-----------------------");
        System.out.println("risultato llisDP: "+ris2);

        int[] ris3 = lis.lisDP(array);

        System.out.println("-----------------------");
        System.out.println("Risultati lis:");
        for (int i = 0; i < ris3.length; i++){
            System.out.println( ris3[i]+ " ");
        }
        System.out.println("-----------------------");
    }
}

