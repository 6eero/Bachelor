package com.company;

public class NodeStack {

    private Node[] stack;
    private int size;
    
    public NodeStack()
    {
        stack = new Node[Huffman.CHARS];
        size = 0;
    }
    
    public boolean empty()
    {
        if(size <= 0)
            return true;
        else
            return false;
    }
    
    public Node peek()
    {
        return stack[0];
    }
    
    public Node pop()
    {
        Node first = stack[0];
        for(int i=0;i<size;i++)
            stack[i] = stack[i+1];
        size--;
        return first;
    }
    
    public void push( Node n )
    {
        size++;
        for(int i=size-1;i>=0;i--)
        {
            stack[i+1] = stack[i];
        }
        stack[0] = n;
    }
}
