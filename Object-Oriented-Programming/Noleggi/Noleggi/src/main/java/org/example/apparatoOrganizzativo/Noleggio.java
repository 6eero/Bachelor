package org.example.apparatoOrganizzativo;

import org.example.automobile.Automobile;
import org.example.automobile.ClausolaOpzionale;

import java.time.Duration;
import java.time.LocalDateTime;

public class Noleggio {

    private Automobile automobile;
    private ClausolaOpzionale clausolaOpzionale;
    private LocalDateTime dataInizio;
    private LocalDateTime dataFine;

    private long calcolaNumeroGiorni(LocalDateTime dataInizio, LocalDateTime dataFine) {
        return Duration.between(dataInizio, dataFine).toDays();
    }


}
