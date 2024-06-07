package org.example.abbonamento;

import org.example.pubblicazione.Pubblicazione;

import java.time.LocalDateTime;

public interface Abbonamento {

    public DurataAbbonamento getDurataAbbonamento();

    public void setDurataAbbonamento(DurataAbbonamento durataAbbonamento);

    public LocalDateTime getDataAttivazione();

    public void setDataAttivazione(LocalDateTime dataAttivazione);

    public LocalDateTime getDataScadenza();

    public void setDataScadenza(LocalDateTime dataScadenza);

    public int getGiorniRimanenti();

    public void setPubblicazione(Pubblicazione pubblicazione);
}
