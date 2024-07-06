package org.example;

public class Subscriber2 implements Subscriber{

    @Override
    public void update(String command) {

        switch (command) {
            case "chi sei?" -> System.out.println("sono subscriber 2");
            default -> throw new IllegalArgumentException("Unknown command");
        }
    }
}
