import java.util.ArrayList;
import java.util.List;
import java.util.Objects;

public class ElencoTreni {


    private final List<Train> elencoTreni = new ArrayList<>();
    private final List<Train> elencoTreniInCorsa = new ArrayList<>();


    /**
     * Metodo per aggiungere un treno alla lista dei treni (da non usare direttamente)
     * @param treno il treno da aggiungere
     */
    public void add(Train treno) {

        elencoTreni.add(treno);
    }


    /**
     * Metodo che ritorna tutti i treni in corsa
     */
    public List<Train> getTreniInCorsa() {

        for (Train treno : elencoTreni) {
            if (Objects.equals(treno.getStato(), Stato.Treno.inCorsa)) {
                elencoTreniInCorsa.add(treno);
            }
        }
        return elencoTreniInCorsa;
    }

}
