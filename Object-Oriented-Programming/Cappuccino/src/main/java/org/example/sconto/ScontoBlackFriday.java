package org.example.sconto;

import org.example.sconto.Sconto;

public class ScontoBlackFriday implements Sconto {

    double valoreSconto;

    public ScontoBlackFriday() {
        this.valoreSconto = 15;
    }

    @Override
    public double getSconto() {
        return this.valoreSconto/100;
    }
}
