public class Jesephus{
    
    public static int josephus(int n){
        
        RoundTable rt = new RoundTable(n);
        
        while (rt.numberOfKnights() > 1){
            
            RoundTable ext = rt.serveNeighbour();
            rt = ext.passJug();
        }
        
        return rt.knightWithJug();
    }
    
}  // class Jesephus
