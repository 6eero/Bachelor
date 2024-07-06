package org.example.filtro;

import org.example.automobile.Automobile;

import java.util.Objects;
import java.util.function.Predicate;

public class FiltroModello implements Predicate<Automobile> {

    private final String  s;

    public FiltroModello(String s) { this.s = s;}

    @Override
    public boolean test(Automobile automobile) {
        return Objects.equals(automobile.getModello(), s) && automobile.isDisponibilita();
    }
}
