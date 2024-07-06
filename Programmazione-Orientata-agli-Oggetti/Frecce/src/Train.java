import java.util.ArrayList;
import java.util.List;

public class Train {

    // required parameters
    private Percorso percorso;
    private Stato.Treno stato;
    private final List<Carrozza> listaDiCarrozze;


    // get methods
    public Percorso getPercorso() {
        return percorso;
    }
    public Stato.Treno getStato() {
        return stato;
    }
    public List<Carrozza> getListaDiCarrozze() {
        return listaDiCarrozze;
    }



    // set methods
    public void setPercorso(Percorso percorso) {
        this.percorso = percorso;
    }
    public void setStato(Stato.Treno stato) {
        this.stato = stato;
    }



    // builder method
    private Train(TrainBuilder builder) {
        this.setPercorso(builder.percorso);
        this.setStato(builder.stato);
        this.listaDiCarrozze=builder.listaDiCarrozze;
    }


    // Builder Class
    public static final class TrainBuilder {

        // required parameters
        private String id;
        private Percorso percorso;
        private Stato.Treno stato;
        private final List<Carrozza> listaDiCarrozze = new ArrayList<>();


        public TrainBuilder(String id){
            this.id = id;
        }

        public static TrainBuilder newBuilder(String id) {
            return new TrainBuilder(id);
        }

        public TrainBuilder impostaPercorso(Percorso percorso) {
            this.percorso = percorso;
            return this;
        }

        public TrainBuilder impostaStato(Stato.Treno stato) {
            this.stato = stato;
            return this;
        }

        public TrainBuilder aggiungiCarrozza(Carrozza carrozza) {
            this.listaDiCarrozze.add(carrozza);
            return this;
        }

        public Train build() {
            return new Train(this);
        }

    }

}
