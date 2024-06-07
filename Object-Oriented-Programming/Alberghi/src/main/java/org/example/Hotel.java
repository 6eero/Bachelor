package org.example;

import org.example.stanze.Camera;
import org.example.stanze.Stanza;

import java.util.ArrayList;
import java.util.List;

public class Hotel {

    // required parameters
    private int numeroDiStelle;
    private Localita localita;
    private List<Stanza> listaDiStanze;
    private List<Camera> listaDiCamere;


    // get methods
    public int getNumeroDiStelle() {
        return numeroDiStelle;
    }
    public Localita getLocalita() {
        return localita;
    }
    public List<Stanza> getListaDiStanze() { return listaDiStanze; }
    public List<Camera> getListaDiCamere() { return listaDiCamere; }


    public void setNumeroDiStelle(int numeroDiStelle) {
        this.numeroDiStelle = numeroDiStelle;
    }
    public void setLocalita(Localita localita) {
        this.localita = localita;
    }

    // builder method
    private Hotel(HotelBuilder builder) {
        this.setNumeroDiStelle(builder.numeroDiStelle);
        this.setLocalita(builder.localita);
        this.listaDiStanze = builder.listaDiStanze;
        this.listaDiCamere = builder.listaDiCamere;
    }

    // Builder Class
    public static class HotelBuilder {

        // required parameters

        private int numeroDiStelle;
        private Localita localita;
        private final List<Stanza> listaDiStanze = new ArrayList<>();
        private List<Camera> listaDiCamere = new ArrayList<>();


        public static HotelBuilder newBuilder() {
            return new HotelBuilder();
        }

        public HotelBuilder numeroDiStelle (int numeroDiStelle) {
            this.numeroDiStelle = numeroDiStelle;
            return this;
        }

        public HotelBuilder localita (Localita localita) {
            this.localita = localita;
            return this;
        }

        public HotelBuilder aggiungiStanza (Stanza stanza) {
            this.listaDiStanze.add(stanza);
            return this;
        }

        public HotelBuilder aggiungiCamera (Camera camera) {
            this.listaDiStanze.add(camera);
            this.listaDiCamere.add(camera);
            return this;
        }

        // method that will return the Object needed by client program
        public Hotel build(){
            return new Hotel(this);
        }
    }
}


