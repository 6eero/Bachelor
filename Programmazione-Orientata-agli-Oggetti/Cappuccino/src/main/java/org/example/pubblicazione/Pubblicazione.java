package org.example.pubblicazione;

public class Pubblicazione {

    private TipoPubblicazione tipoPubblicazione;
    private Versione versione;
    private String titolo;
    private double costo;

    public Pubblicazione(TipoPubblicazione tipoPubblicazione, Versione versione, String titolo, double costo) {
        this.tipoPubblicazione = tipoPubblicazione;
        this.versione = versione;
        this.titolo = titolo;
        this.costo = costo;
    }

    public double getCosto() {
        return costo;
    }
}
