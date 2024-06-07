package org.example.filtro;

import org.example.automobile.Automobile;
import org.example.automobile.Marca;

import java.util.Objects;
import java.util.function.Predicate;

public class FiltroMarca implements Predicate<Automobile> {

    private final Marca s;

    public FiltroMarca(Marca s) { this.s = s;}

    @Override
    public boolean test(Automobile automobile) {
        return (Objects.equals(automobile.getMarca(), s) && automobile.isDisponibilita());
    }
}
