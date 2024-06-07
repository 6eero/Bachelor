public class Main {
    public static void main(String[] args) {

        ElencoTreni elencoTreni = new ElencoTreni();
        PannelloDiControllo pannelloDiControllo = new PannelloDiControllo();


        Percorso percorso = Percorso.PercorsoBuilder.newBuilder("treno 1")
                .aggiungiFermata(new Fermata("Roma", "13.40"))
                .aggiungiFermata(new Fermata("Terni", "14.00"))
                .aggiungiFermata(new Fermata("Firenze", "14.45"))
                .aggiungiFermata(new Fermata("Baologna", "15.15"))
                .build();

        Train train = pannelloDiControllo.creaTreno(10);
        train.setStato(Stato.Treno.inCorsa);
        pannelloDiControllo.associaPercorso(train, percorso);
        elencoTreni.add(train);


        Percorso percorso2 = Percorso.PercorsoBuilder.newBuilder("treno 1")
                .aggiungiFermata(new Fermata("Napoli", "11.00"))
                .aggiungiFermata(new Fermata("Gubbio", "17.40"))
                .aggiungiFermata(new Fermata("Sappada", "18.45"))
                .build();


        Train train2 = pannelloDiControllo.creaTreno(14);
        train2.setStato(Stato.Treno.inCorsa);
        pannelloDiControllo.associaPercorso(train2, percorso2);
        elencoTreni.add(train2);


        pannelloDiControllo.estraiElencoTreniInArrivo(elencoTreni, "", "18.45");

    }
}







