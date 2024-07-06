package org.example.filtro;

import org.example.automobile.Automobile;

import java.util.Objects;
import java.util.function.Predicate;

public class FiltroAnno implements Predicate<Automobile> {

    private final int s;

    public FiltroAnno(int s) { this.s = s;}

    @Override
    public boolean test(Automobile automobile) {
        return Objects.equals(automobile.getAnnoImmatricolazione(), s) && automobile.isDisponibilita();
    }
}
