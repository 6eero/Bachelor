// 25 marzo 2021

public class RoundTable{
    
    // Istanze: oggetti immutabili (final)
    private final int num;
    private final int jug;
    private final IntSList others;
    
    
    // Costruttori
    public RoundTable(int n){
        
        num = n;                           // n cavalieri in tutto
        jug = 1;                           // 1 cavaliere con la brocca
        others = IntSListTest.range(2, n); // tutti gli altri senza brocca            
    }
    
    private RoundTable(int n, int j, IntSList o){
        
        num = n;
        jug = j;
        others = o;               
    }
    
    
    // Metodi per acquisire informazioni sull'oggetto
    public int numberOfKnights(){
        
        return num;      
    }
    
    public int knightWithJug(){
        
        return jug;       
    }
    
    
    // Metodi per generare nuive configurazioni (nuovi oggetti)
    
    public RoundTable serveNeighbour(){
    
        if (num > 1)                                            // caso in cui a tavola ci sono piu di 1 cavalieri
            return new RoundTable(num - 1, jug, others.cdr());  // si elimina il primo elemento della lista dato che se ne va dalla tavola    
        else
            return this;                                        // caso in cui c'é un solo cavaliere a tavola
    }
    
    public RoundTable passJug(){
        
        if (num > 1){
            IntSList last = IntSList.NULL_INTSLIST.cons(jug);
            IntSList list = (others.cdr()).append(last);
            return new RoundTable(num , others.car(), list);    
        }else
            return this; 
    }
    
}  // class RoundTable
