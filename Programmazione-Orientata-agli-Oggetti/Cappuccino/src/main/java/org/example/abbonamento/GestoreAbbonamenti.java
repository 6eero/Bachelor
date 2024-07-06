package org.example.abbonamento;

import org.example.pubblicazione.Pubblicazione;
import org.example.pubblicazione.Versione;
import org.example.sconto.*;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.function.Predicate;

public class GestoreAbbonamenti {

    private final List<Abbonamento> abbonamentiAttivi = new ArrayList<>();


    /**
     * Metodo per creare un nuovo abbonamento
     * @param abbonamento != null, rappresenta il nuovo abbonamento
     */
    public void creaAbbonamento(Abbonamento abbonamento, Pubblicazione pubblicazioni) {
        abbonamento.setPubblicazione(pubblicazioni);
        abbonamentiAttivi.add(abbonamento);
        abbonamento.setDataAttivazione(LocalDateTime.now());
    }

    /**
     * Metodo per revocare un abbonamento
     * @param abbonamento != e attivo.
     */
    private void revocaAbbonamento(Abbonamento abbonamento) {
        abbonamentiAttivi.remove(abbonamento);
    }


    /**
     * Metodo per rinnovare un abbonamento periodico
     * @param abbonamento != null e deve essere un abbonamento periodico attivo
     * @param numeroMesi > 0 rappresenta il numero di mesi per il quale si vuole rinnovare
     */
    public void rinnovaAbbonamento(Abbonamento abbonamento, int numeroMesi) {
        abbonamento.setDataAttivazione(LocalDateTime.now());
        abbonamento.setDataScadenza(LocalDateTime.now().plusMonths(numeroMesi));
    }

    /**
     * Metodo per calcolare il costo di un abbonamento
     * @param pubblicazione != null, la pubblicazione della quale si vuole conoscere il costo d'abbonamento
     * @param versione puo essere o "cartacea" o "elettronica", in base a cio il prezzo varia
     * @param numeroDiMesi > 0, rappresenta il numero di mesi per il quale ci si vuole abbonare
     * @param sconto puo anche essere null, é un oggetto che contiene il valore dello socnto ottenibile con .getSconto()
     * @return il costo dell'abbonamento
     */
    public double calcolaCosto(Pubblicazione pubblicazione, Versione versione, double numeroDiMesi, Sconto sconto) {

        double costoPubblicazioneMensile = pubblicazione.getCosto();

        if (versione == Versione.CARTACEA) { costoPubblicazioneMensile = costoPubblicazioneMensile + 2.50; }
        if (sconto == null) { return costoPubblicazioneMensile * numeroDiMesi; }

        return costoPubblicazioneMensile * numeroDiMesi - (costoPubblicazioneMensile * numeroDiMesi * sconto.getSconto());
    }


    /**
     * Metodo che consente d'identificare gli abbonamenti che scadono tra H>=0 giorni
     * @param giorniPrimaDellaScadenza > 0, rapopresenta H della definizone sopra
     * @return una lista di abbonamenti in scadenza nei prossimi giorni
     */
    public List<Abbonamento> elencoAbbonamentiInScandeza (int giorniPrimaDellaScadenza) {
        return getAbbonamentiInScadezna(s -> s.getGiorniRimanenti() > giorniPrimaDellaScadenza);
    }

    private List<Abbonamento> getAbbonamentiInScadezna(Predicate<Abbonamento> f) {
        return abbonamentiAttivi
                .stream()
                .filter(f)
                .toList();
    }
}
