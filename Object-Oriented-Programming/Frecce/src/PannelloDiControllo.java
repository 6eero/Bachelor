import org.jetbrains.annotations.NotNull;
import java.util.Objects;

public class PannelloDiControllo {


    /**
     * Metodo per la creazione di un nuovo treno
     * @param capacitaMinimaDiPasseggeri intero che rappresenta il numero minimo di passeggeri trasportabili
     * @return un nuovo treno, sprovvisto di percorso, fermo in una stazione e con una solo carrozza (motrice)
     */
    public Train creaTreno(int capacitaMinimaDiPasseggeri) {
        return Train.TrainBuilder.newBuilder("TRENO")
                //.impostaPercorso(null)
                .impostaStato(Stato.Treno.inUnaStazione)
                .aggiungiCarrozza(new Carrozza(0, Stato.Carrozza.inMuovimento, Carrozza.Tipologia.Motrice ))
                .build();
    }


    /**
     * Metodo per associare un percorso (stazione e orario d'arrivo) a un treno
     * @param treno il treno al quale associare il percorso
     * @param percorso il percorso da associare
     */
    public void associaPercorso(@NotNull Train treno, @NotNull Percorso percorso) {
        treno.setPercorso(percorso);
    }


    /**
     * Metodo per stampare le carrozze equipaggiate a un
     * @param train del quale si vuole conoscere le carrozze
     */
    public void StampaCarrozzeInUnTreno(Train train) {
        for (int i = 0; i < train.getListaDiCarrozze().size(); i++) {
            System.out.println(train.getListaDiCarrozze().get(i));
        }
    }


    /**
     * Metodo che dati dei parametri filtro, trova i viaggi che le soddifano
     * @param elencoTreni elenco dei treni da cui cercare possibili corrispondenze
     * @param stazione parametro di ricerca
     * @param orario parametro di ricerca
     */
    public void estraiElencoTreniInArrivo(ElencoTreni elencoTreni, String stazione, String orario) {

        int n = elencoTreni.getTreniInCorsa().size();

        for (int j = 0; j < n; j++) {
            for (int i = 0; i < elencoTreni.getTreniInCorsa().get(j).getPercorso().getListaDifermate().size(); i++) {

                if (Objects.equals(elencoTreni.getTreniInCorsa().get(j).getPercorso().getListaDifermate().get(i).getLuogo(), stazione)) {
                    System.out.println("Il treno " + elencoTreni.getTreniInCorsa().get(j) + " é in arrivo alla stazione " + stazione +
                            " alle ore " + elencoTreni.getTreniInCorsa().get(j).getPercorso().getListaDifermate().get(i).getOrario());

                } else if (Objects.equals(elencoTreni.getTreniInCorsa().get(j).getPercorso().getListaDifermate().get(i).getOrario(), orario)) {
                    System.out.println("Il treno " + elencoTreni.getTreniInCorsa().get(j) + " é in arrivo alla stazione " +
                            elencoTreni.getTreniInCorsa().get(j).getPercorso().getListaDifermate().get(i).getLuogo() + " alle ore " + orario);

                }
            }
        }
    }
}
