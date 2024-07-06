package org.example.apparatoOrganizzativo;

import org.example.automobile.Automobile;
import org.example.automobile.ClausolaOpzionale;

public class GestoreDeiNoleggi {


    /**
     * Metodo per ottenere un preventivo data una determinata automobile, un numero di giorni e le clausole opzionali
     * @param automobile != null, deve essere valida e disponibile
     * @param numeroDiGiorni > 0
     * @param clausolaOpzionale puo essere anche null, in quel caso non verranno aggiunti costi aggiuntivi
     * @return il valore (float) del totale del prelievo
     */
    public float preventivo(Automobile automobile, int numeroDiGiorni, ClausolaOpzionale... clausolaOpzionale) {

        int costoClausoleOccasionali = 0;

        for (ClausolaOpzionale clausolaOpzionale1 : clausolaOpzionale) {
            costoClausoleOccasionali = costoClausoleOccasionali + clausolaOpzionale1.getCosto();
        }

        return automobile.getRataBase() * numeroDiGiorni + costoClausoleOccasionali;
    }


    /**
     * Metodo per assegnare una rata base (da versare ogni mese) ad una specificata automobile
     * @param automobile != null
     * @param rataBase != null
     */
    public void memorizzaRataBase(Automobile automobile, float rataBase) {
        automobile.setRataBase(rataBase);
    }


    /**
     * Metodo per assegnare un riscatto (da versare al momento del noleggio) ad un automobile
     * @param automobile != null
     * @param riscatto != null
     */
    public void memorizzaRiscatto(Automobile automobile, float riscatto) {
        automobile.setValoreRiscatto(riscatto);
    }


    public void memorizzaRataOptional(Automobile automobile, float prezzoMensile, ClausolaOpzionale ... clausoleOpzionale) {

        float costoTotaleRateOptional = 0;

        for (ClausolaOpzionale clausolaOpzionale : clausoleOpzionale) {
            costoTotaleRateOptional = costoTotaleRateOptional + clausolaOpzionale.getCosto();
        }

        automobile.setRataOptional(costoTotaleRateOptional);
    }


    public void calcolaChiusuraNoleggio() {

    }
}
