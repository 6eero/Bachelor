package com.company;

public class bitComplement {

    public static String BtrSucc(String btr) {

        int n = btr.length();
        char lsb = btr.charAt(n - 1);         //last character
        String pre = btr.substring(0, n - 1);

        if (n == 1) {
            if (lsb == '+')
                return "+-";
            else
                return "+";
        } else {
            if (lsb == '+')
                return BtrSucc(pre) + "-";
            else if (lsb == '-')
                return pre + ".";
            else
                return pre + "+";
        }
    }
}
