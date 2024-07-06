package org.example.apparatoOrganizzativo;

import org.example.automobile.Automobile;

import java.util.ArrayList;
import java.util.List;
import java.util.function.Predicate;

public class ElencoVeicoli {

    private final List<Automobile> automobili = new ArrayList<>();

    public void aggiungi(Automobile automobile) {

        automobili.add(automobile);
    }


    /**
     * Metodo per filtrare una elenco di veicoli
     * @param f != null, rappresenta il parametro filtro
     * @return lista di veicoli disponibili della marca inserito
     */
    public List<Automobile> elencoVeicoliFiltrati(Predicate<Automobile> f) {

        return automobili
                .stream()
                .filter(f)
                .toList();
    }


}
