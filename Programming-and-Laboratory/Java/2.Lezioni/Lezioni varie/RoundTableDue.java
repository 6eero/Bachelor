public class RoundTableDue{
    
    // Nessuna variabile dev essere final dato che verrá aggiornata
    
    private int[] knights;
    private int jug;         // Posizione in knight -> mi dice chi ha la brocca
    private int num;
    
    public void RoundTable(int n){
        
        knights = new int[2 * n-1];
        
        for (int k=1; k<=n; k++){
            knights[k-1] = k;    
        }
        
        jug = 0;
        num = n;       
    }
        
    public int numberOfKnights(){
        
    }
    
    public int knightWithJug(){
    
        return knights[jug];
    }
    
    /**
     *    1   2   3   4   5   6   _   _   _ 
     *    ^ : 6
     * 
     *    serveNeighbour
     *    
     *    _   1   3   4   5   6   _   _   _  
     *        ^ : 5
     *
     *    passJug:
     *    
     *    _   _   3   4   5   6   _   _   _  
     *            ^ : 4
     */
    
    public void serveNeighbour(){
        
        knights[jug + num] = knights[jug];
        jug = jug + 1;
        num = num - 1;
    }
    
    public void passJug(){
        
        knights[jug + 1] = knights[jug];
        jug = jug + 1;       
    }
    

    
}
