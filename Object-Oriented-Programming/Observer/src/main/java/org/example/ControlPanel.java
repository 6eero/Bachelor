package org.example;

import java.util.ArrayList;
import java.util.List;

public class ControlPanel implements Subject {

    private List<Subscriber> listOfObservered = new ArrayList<>();

    @Override
    public void subscribe(Subscriber subscriber) {
        listOfObservered.add(subscriber);
    }

    @Override
    public void unSubscribe(Subscriber subscriber) {
        listOfObservered.remove(subscriber);
    }

    @Override
    public void notifySubscribed(String command) {
        for (Subscriber subscriber : listOfObservered) {
            subscriber.update(command);
        }
    }
}
