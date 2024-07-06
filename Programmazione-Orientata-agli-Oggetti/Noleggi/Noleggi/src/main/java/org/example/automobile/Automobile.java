package org.example.automobile;

public class Automobile {

    // required parameters
    private Marca marca;
    private String modello;
    private int annoImmatricolazione;
    private float chilometraggio;
    private String targa;
    private boolean disponibilita;
    private float rataBase;
    private float valoreRiscatto;
    private float costoTotaleRateOptional;

    // get methods
    public Marca getMarca() {
        return marca;
    }
    public String getModello() {
        return modello;
    }
    public int getAnnoImmatricolazione() {
        return annoImmatricolazione;
    }
    public float getChilometraggio() {
        return chilometraggio;
    }
    public String getTarga() {
        return targa;
    }
    public boolean isDisponibilita() {
        return disponibilita;
    }

    public float getRataBase() {
        return rataBase;
    }

    public void setRataBase(float rataBase) {
        this.rataBase = rataBase;
    }

    public float getValoreRiscatto() {
        return valoreRiscatto;
    }

    public void setValoreRiscatto(float valoreRiscatto) {
        this.valoreRiscatto = valoreRiscatto;
    }

    public void setRataOptional(float costoTotaleRateOptional) {
        this.costoTotaleRateOptional = costoTotaleRateOptional;
    }

    // builder method
    private Automobile(AutomobileBuilder builder) {
        this.marca=builder.marca;
        this.modello=builder.modello;
        this.annoImmatricolazione=builder.annoImmatricolazione;
        this.chilometraggio=builder.chilometraggio;
        this.targa=builder.targa;
        this.disponibilita=builder.disponibilita;
    }


    // Builder Class
    public static class AutomobileBuilder {

        // required parameters
        private Marca marca;
        private String modello;
        private int annoImmatricolazione;
        private float chilometraggio;
        private String targa;
        private boolean disponibilita;

        public AutomobileBuilder(Marca marca, String modello, int annoImmatricolazione, String targa){
            this.marca=marca;
            this.modello=modello;
            this.annoImmatricolazione=annoImmatricolazione;
            this.targa=targa;
        }

        public AutomobileBuilder setChilometraggio(float chilometraggio) {
            this.chilometraggio = chilometraggio;
            return this;
        }

        public AutomobileBuilder setDisponibilita(boolean disponibilita) {
            this.disponibilita = disponibilita;
            return this;
        }


        // method that will return the Object needed by client program
        public Automobile build() {
            return new Automobile(this);
        }
    }
}


