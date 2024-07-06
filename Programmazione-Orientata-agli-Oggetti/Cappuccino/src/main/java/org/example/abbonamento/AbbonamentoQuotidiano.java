package org.example.abbonamento;

import org.example.pubblicazione.Pubblicazione;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

public class AbbonamentoQuotidiano implements Abbonamento {

    private DurataAbbonamento durataAbbonamento;
    private LocalDateTime dataAttivazione;
    private final List<Pubblicazione> pubblicazioni = new ArrayList<>();

    public AbbonamentoQuotidiano(DurataAbbonamento durataAbbonamento) {
        this.setDurataAbbonamento(durataAbbonamento);
    }

    @Override
    public DurataAbbonamento getDurataAbbonamento() {
        return durataAbbonamento;
    }

    @Override
    public void setDurataAbbonamento(DurataAbbonamento durataAbbonamento) {
        this.durataAbbonamento = durataAbbonamento;
    }

    @Override
    public LocalDateTime getDataAttivazione() {
        return dataAttivazione;
    }

    @Override
    public void setDataAttivazione(LocalDateTime dataAttivazione) {
        this.dataAttivazione = dataAttivazione;
    }

    @Override
    public LocalDateTime getDataScadenza() {
        return null; //TODO
    }

    @Override
    public void setDataScadenza(LocalDateTime dataScadenza) {
        //TODO
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
