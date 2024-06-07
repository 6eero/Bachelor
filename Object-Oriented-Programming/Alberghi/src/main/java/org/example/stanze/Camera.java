package org.example.stanze;

import org.example.TipoDiCamera;

public class Camera implements Stanza {

    private TipoDiCamera tipoDiCamera;
    private int piano;
    private double prezzo;
    private boolean disponibilita;

    public Camera(TipoDiCamera tipoDiCamera, int piano, double prezzo, boolean disponibile) {
        this.tipoDiCamera = tipoDiCamera;
        this.piano = piano;
        this.disponibilita = disponibile;
    }

    public boolean isDisponibile() {
        return disponibilita;
    }


    public void applicaSconto(int sconto) {
        this.prezzo = prezzo*(sconto/100);
    }
}
