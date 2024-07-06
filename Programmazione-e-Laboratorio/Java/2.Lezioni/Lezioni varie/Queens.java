public class Queens{
    
     public static int numeroDiSoluzioni(int n){
         
         return numeroDiCompletamenti(new Board(n));
    }
        
    public static int numeroDiCompletamenti(Board b){
         int n = b.size();
         int q = b.queensOn();
         
         if(q == n){
         
             return 1;
             
        } else{
             
             int i = q++;
             int count = 0;
             
             for (int j=1; j<=n; j++){
                 
                 if (! b.underAttack(i, j)){
                     
                     b.addQueen(i, j);
                     count = count + numeroDiCompletamenti(b);
                     b.removeQueen(i, j);
                 }
             }
             return count;
        }
    }
} // class Queens

