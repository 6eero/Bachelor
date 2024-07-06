public class llcsOptimization{
    
    public static int llcs(String u, String v){
        
        int m = u.length();
        int n = v.length();
        
        if((m == 0) || (n == 0))
            return 0;
            
        else if (u.charAt(0) == v.charAt(0))
            return 1 + llcs(u.substring(1), v.substring(1));
            
        else 
            return Math.max(llcs(u.substring(1), v), llcs(u, v.substring(1)));
    }
    
    public static int llcsOpt(String u, String v){
        
        int m = u.length();
        int n = v.length();
        
        int[][] mem = new int [m+1][n+1];
        
        for(int i = 0; i <= m; i++){
            for(int j = 0; j <= n; j++){
                
                if ((i == 0)||(j == 0))
                   mem[i][j] = 0;
                    
                else if (u.charAt(m-i) == v.charAt(n-j))
                    mem[i][j] = 1 + mem[i-1][j-1];
                    
                else 
                    mem[i][j] = Math.max(mem[i-1][j], mem[i][j-1]);
            }
        }
        return mem[m][n];
    }
}
