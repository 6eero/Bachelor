package org.example;

import org.example.stanze.Camera;

import java.util.ArrayList;
import java.util.List;

public class PannelloControlloHotel {

    private List<Hotel> listaDiHotel = new ArrayList<>();


    public void cercaAlberghiDisponibili(int numeroDiStelle, Localita localita) {


    }

    public void ottieniInformazioni() {
    }

    public void modificaPrezzo() {

    }

    public void impostaSconti(Hotel hotel) {
    }

    public void impostaSconti(Data date) {
    }

    public void impostaSconti(int durataDellaPrenotazione) throws SeiUnCoglioneException {
        if (durataDellaPrenotazione > 7) {
            for (int i = 0; i < ottieniListaDiTutteLeCamereDisponibili().size(); i++) {
                ottieniListaDiTutteLeCamereDisponibili().get(i).applicaSconto(50);
            }
        } else throw new SeiUnCoglioneException("per avere gli sconti devi prenotare per almeno 7 gionri");
    }

    public void aggiungi(Hotel hotel) {
        listaDiHotel.add(hotel);
    }

    public List<Camera> ottieniListaDiTutteLeCamere() {

        List<Camera> listaCamere = new ArrayList<>();

        for (Hotel hotel : listaDiHotel) {
            listaCamere.addAll(hotel.getListaDiCamere());
        }

        return listaCamere;
    }

    public List<Camera> ottieniListaDiTutteLeCamereDisponibili() {

        List<Camera> listaCamereDisponibili = new ArrayList<>();

        for (int i = 0; i < ottieniListaDiTutteLeCamere().size(); i++){
            if (ottieniListaDiTutteLeCamere().get(i).isDisponibile()) {
                listaCamereDisponibili.add(ottieniListaDiTutteLeCamere().get(i));
            }
        }

        return listaCamereDisponibili;
    }
}
