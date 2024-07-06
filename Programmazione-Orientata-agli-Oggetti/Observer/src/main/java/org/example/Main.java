package org.example;

public class Main {
    public static void main(String[] args) {

        ControlPanel controlPanel = new ControlPanel();
        Subscriber subscriber = new Subscriber1();
        Subscriber subscriber2 = new Subscriber2();

        controlPanel.subscribe(subscriber);
        controlPanel.subscribe(subscriber2);

        controlPanel.notifySubscribed("chi sei?");
    }
}