public class Josephus{
    
    public static int josephus(int n){
    
        RoundTableDue rt = new RoundTableDue();
        
        while(rt.numberOfKnights() > 1){
            rt.serveNeighbour();
            rt.passJug(); 
        }
        return rt.knightWithJug();
    }
}
