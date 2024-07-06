import java.util.ArrayList;
import java.util.List;

public class Percorso {

    // required parameters

    private final List<Fermata> listaDifermate;


    // get methods

    public List<Fermata> getListaDifermate() {
        return listaDifermate;
    }


    // builder method
    private Percorso(PercorsoBuilder builder) {
        this.listaDifermate = builder.listaDifermate;
    }


    // Builder Class
    public static final class PercorsoBuilder {

        // required parameters
        private String id;
        private final List<Fermata> listaDifermate = new ArrayList<>();


        public PercorsoBuilder(String id) { this.id = id; }

        public static Percorso.PercorsoBuilder newBuilder(String id) {

            return new PercorsoBuilder(id);
        }

        public Percorso.PercorsoBuilder aggiungiFermata(Fermata fermata) {
            this.listaDifermate.add(fermata);
            return this;
        }

        public Percorso build() {
            return new Percorso(this);
        }

    }
}



