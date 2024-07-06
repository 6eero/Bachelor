package org.example.sconto;

public class ScontoCyberMonday implements Sconto {

    double valoreSconto;

    public ScontoCyberMonday() {
        this.valoreSconto = 10;
    }

    @Override
    public double getSconto() {
        return this.valoreSconto/100;
    }
}
