package com.company;

public class NodeQueue {

    private Node[] queue;
    private int size;
    
    public NodeQueue() {

        queue = new Node [Huffman.CHARS];
        size = 0;
    }
    
    public int size() {

        return size;
    }
   
    public Node peek() {

        return queue[size-1];
    }

    public Node poll() {

        size--;
        Node lessWeight = queue[size];
        queue[size] = null;
        return lessWeight;
    }
    
    public void add ( Node n ) {

        size++;
        for (int i=size-2;i>=0;i--)

            if( n.weight() > queue[i].weight() ) {
                queue[i+1] = queue[i];
            }

            else {
                queue[i+1] = n;
                return;
            }
        queue[0] = n;
    }
}
