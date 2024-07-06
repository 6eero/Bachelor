package org.example;

public interface Subject {

    public void subscribe(Subscriber subscriber);
    public void unSubscribe(Subscriber subscriber);
    public void notifySubscribed(String command);
}
