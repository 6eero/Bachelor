package org.example;

import org.example.stanze.*;

public class Main {
    public static void main(String[] args) throws SeiUnCoglioneException {

        PannelloControlloHotel pannelloControlloHotel = new PannelloControlloHotel();

        Hotel hotel1 = Hotel.HotelBuilder.newBuilder()
                .numeroDiStelle(3)
                .localita(Localita.campagna)
                .aggiungiCamera(new Camera(TipoDiCamera.singola, 2, 34.70, true))
                .aggiungiCamera(new Camera(TipoDiCamera.doppia, 3, 45.50, false))
                .aggiungiCamera(new Camera(TipoDiCamera.tripla, 5, 80.00, false))
                .aggiungiStanza(new Ristorante())
                .aggiungiStanza(new Palestra())
                .aggiungiStanza(new Sauna())
                .build();

        Hotel hotel2 = Hotel.HotelBuilder.newBuilder()
                .numeroDiStelle(5)
                .localita(Localita.montagna)
                .aggiungiCamera(new Camera(TipoDiCamera.singola, 2, 17.20, false))
                .aggiungiCamera(new Camera(TipoDiCamera.doppia, 2, 22.80, true))
                .aggiungiCamera(new Camera(TipoDiCamera.doppia, 1, 12.80, false))
                .aggiungiCamera(new Camera(TipoDiCamera.tripla, 3, 35.10, false))
                .aggiungiStanza(new Ristorante())
                .aggiungiStanza(new SalaConvegno())
                .build();

        Hotel hotel3 = Hotel.HotelBuilder.newBuilder()
                .numeroDiStelle(5)
                .localita(Localita.mare)
                .aggiungiCamera(new Camera(TipoDiCamera.singola, 3, 54.80, true))
                .aggiungiCamera(new Camera(TipoDiCamera.doppia, 4, 85.50, true))
                .aggiungiCamera(new Camera(TipoDiCamera.tripla, 7, 120.60, false))
                .aggiungiCamera(new Camera(TipoDiCamera.doppia, 3, 34.80, true))
                .aggiungiCamera(new Camera(TipoDiCamera.doppia, 4, 75.20, true))
                .aggiungiCamera(new Camera(TipoDiCamera.singola, 7, 115.90, false))
                .aggiungiStanza(new Ristorante())
                .aggiungiStanza(new Ristorante())
                .aggiungiStanza(new Palestra())
                .aggiungiStanza(new Sauna())
                .aggiungiStanza(new SalaConvegno())
                .aggiungiStanza(new SalaMassaggi())
                .build();

        pannelloControlloHotel.aggiungi(hotel1);
        pannelloControlloHotel.aggiungi(hotel2);
        pannelloControlloHotel.aggiungi(hotel3);


        //pannelloControlloHotel.cercaAlberghiDisponibili(1, Localita.mare);

        pannelloControlloHotel.ottieniInformazioni();

        pannelloControlloHotel.modificaPrezzo();

        //pannelloControlloHotel.impostaSconti(8);

        //System.out.println(pannelloControlloHotel.ottieniListaDiTutteLeCamere());

        System.out.println(pannelloControlloHotel.ottieniListaDiTutteLeCamereDisponibili());
    }
}