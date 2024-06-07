package org.example;

/*
L’azienda editoriale “Gruppo Cappuccino” gestisce varie pubblicazioni: quotidiani (ad es.
“La Monarchia”) e periodici mensili (ad es. “Il Cappuccino”). Per ciascuna pubblicazione
l’azienda stampa le copie su carta e offre anche la versione elettronica online.

I lettori possono stipulare degli abbonamenti (di durata mensile o annuale) per ciascuno dei
quotidiani, e abbonamenti annuali per i periodici. Un abbonamento può essere relativo a
un singolo individuo o a un cliente aziendale che si compone di n “individui” (ad es.
l’università, con tutte le sue biblioteche). Un abbonamento può essere tale per cui il
contraente (individuo o azienda) può abbonarsi a 1 o più pubblicazioni. L’abbonamento
può riguardare solo la versione online o anche la spedizione delle copie cartacee
all’indirizzo del contraente.

Ogni pubblicazione ha un costo mensile e un costo annuo dell’abbonamento, che dipende
anche se include la versione stampata. Ci sono sconti che vengono applicati nel caso in
cui un contraente stipula abbonamenti per k>1 pubblicazioni, e sconti per clienti aziendali
che stipulano abbonamenti per n > 1 copie della stessa pubblicazione. Entrambi questi tipi
di sconti dipendono dal numero k o n.

Si necessita di un'API che consenta d' implementare queste operazioni principali:

• identificare gli abbonamenti che scadono tra H>=0 giorni
x rinnovare un abbonamento per n mesi/n anni in avanti
x calcolare il costo di un abbonamento (per una certa pubblicazione, la sua versione online o stampata, una certa durata), applicando anche gli sconti
x definire il valore percentuale di uno sconto (per ciascun tipo di sconto, in funzione del suo parametro numerico)

 */

import org.example.abbonamento.Abbonamento;
import org.example.abbonamento.AbbonamentoPeriodici;
import org.example.abbonamento.GestoreAbbonamenti;
import org.example.pubblicazione.Pubblicazione;
import org.example.pubblicazione.TipoPubblicazione;
import org.example.pubblicazione.Versione;
import org.example.sconto.ScontoBlackFriday;

public class Main {
    public static void main(String[] args) {

        GestoreAbbonamenti gestoreAbbonamenti = new GestoreAbbonamenti();

        Abbonamento abbonamento1 = new AbbonamentoPeriodici();

        Pubblicazione pubblicazione1 = new Pubblicazione(
                TipoPubblicazione.PERIODICI_MENSILI,
                Versione.ELETTRONICA,
                "Il Cappuccino",
                5.99);

        Pubblicazione pubblicazione2 = new Pubblicazione(
                TipoPubblicazione.PERIODICI_MENSILI,
                Versione.ELETTRONICA,
                "Il Cappuccino",
                5.99);


        gestoreAbbonamenti.creaAbbonamento(abbonamento1, pubblicazione1);

        gestoreAbbonamenti.rinnovaAbbonamento(abbonamento1, 12);

        gestoreAbbonamenti.calcolaCosto(pubblicazione1, Versione.CARTACEA, 12, new ScontoBlackFriday());

        gestoreAbbonamenti.elencoAbbonamentiInScandeza(10);

    }
}