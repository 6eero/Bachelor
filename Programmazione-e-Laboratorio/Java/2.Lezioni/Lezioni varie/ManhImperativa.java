public class ManhImperativa{
    
    public static long manhDP(int i, int j){
    
        long[][] mem = new long[i+1][j+1];  // Creazione matrice
        
        for(int y = 0; y <= j; y++){    // Popolazione riga 1 con soli 1
            mem[0][y] = 1;
        }
        
        for(int x = 0; x <= i; x++){    // Popolazione colonna 1 con soli 1
            mem[x][0] = 1;
        }
        
        for(int x = 1; x <= i; x++){    // Caso "ricorsivo"
            
            for(int y = 1; y <= j; y++){
                mem[x][y] = mem[x-1][y] + mem[x][y-1];
            }
        }
        return mem[i][j];
    }
}
