package org.example.abbonamento;

import org.example.pubblicazione.Pubblicazione;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

public class AbbonamentoPeriodici implements Abbonamento {

    private DurataAbbonamento durataAbbonamento;
    private LocalDateTime dataAttivazione;
    private LocalDateTime dataScadenza;
    private final List<Pubblicazione> pubblicazioni = new ArrayList<>();

    public AbbonamentoPeriodici() {
        this.setDurataAbbonamento(DurataAbbonamento.ANNUALE);
        this.setDataAttivazione(LocalDateTime.now());
        this.setDataScadenza(dataAttivazione.plusYears(1));
    }

    public DurataAbbonamento getDurataAbbonamento() {
        return durataAbbonamento;
    }

    public void setDurataAbbonamento(DurataAbbonamento durataAbbonamento) {
        this.durataAbbonamento = durataAbbonamento;
    }

    public LocalDateTime getDataAttivazione() {
        return dataAttivazione;
    }

    public void setDataAttivazione(LocalDateTime dataAttivazione) {
        this.dataAttivazione = dataAttivazione;
    }

    public LocalDateTime getDataScadenza() {
        return dataScadenza;
    }

    public void setDataScadenza(LocalDateTime dataScadenza) {
        this.dataScadenza = dataScadenza;
    }

    @Override
    public int getGiorniRimanenti() {
        return 0; //TODO
    }

    @Override
    public void setPubblicazione(Pubblicazione pubblicazione) {
        pubblicazioni.add(pubblicazione);
    }
}
