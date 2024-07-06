package org.example;

import org.example.apparatoOrganizzativo.ElencoVeicoli;
import org.example.apparatoOrganizzativo.GestoreDeiNoleggi;
import org.example.automobile.Automobile;
import org.example.automobile.Marca;
import org.example.filtro.FiltroAnno;
import org.example.filtro.FiltroMarca;

public class Main {
    public static void main(String[] args) {

        GestoreDeiNoleggi gestoreDeiNoleggi = new GestoreDeiNoleggi();
        ElencoVeicoli elencoVeiocoli = new ElencoVeicoli();

        Automobile auto1 = new Automobile.AutomobileBuilder(Marca.FIAT, "500", 2016, "AB327CX")
                .setChilometraggio(0)
                .setDisponibilita(true)
                .build();

        Automobile auto2= new Automobile.AutomobileBuilder(Marca.FIAT, "Punto", 2013, "CH218TB")
                .setChilometraggio(120)
                .setDisponibilita(true)
                .build();

        Automobile auto3= new Automobile.AutomobileBuilder(Marca.AUDI, "A3", 2016, "DE562IU")
                .setChilometraggio(30)
                .setDisponibilita(true)
                .build();


        elencoVeiocoli.aggiungi(auto1);
        elencoVeiocoli.aggiungi(auto2);
        elencoVeiocoli.aggiungi(auto3);

        //gestoreDeiNoleggi.memorizzaRataBase(auto1, 150);
        //gestoreDeiNoleggi.memorizzaRiscatto(auto1, 200);

        for (int i = 0; i < elencoVeiocoli.elencoVeicoliFiltrati(new FiltroAnno(2016)).size(); i++)
            System.out.println(elencoVeiocoli.elencoVeicoliFiltrati(new FiltroAnno(2016)).get(i).getModello());

    }
}