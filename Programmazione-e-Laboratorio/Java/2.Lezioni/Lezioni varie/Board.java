
/*
 * Rompicapo delle "n regine"
 *
 * Ultimo aggiornamento: 23/05/2018
 *
 *
 * Realizzazione del dato astratto "scacchiera"
 * la cui configurazione eveolve aggiungendoe rimuovendo regine
 *
 * Protocollo della classe Board:
 *
 *   new Board( int n )           :  costruttore (scacchiera vuota)
 *
 *   size()                       :  int
 *
 *   queensOn()                   :  int
 *
 *   underAttack( int i, int j )  :  boolean
 *
 *   addQueen( int i, int j )     :  void
 *
 *   arrangement()                :  String
 *
 *
 * Board b;
 *
 *   new Board(n)           costruttore della scacchiera n x n vuota;
 *   b.size()               dimensione n della scacchiera b;
 *   b.queensOn()           numero di regine collocate nella scacchiera b;
 *   b.underAttack(i,j)     la posizione <i,j> e' minacciata?
 *   b.addQueen(i,j)        modifica della configurazione di b
 *                          aggiungendo una nuova regina in posizione <i,j>
 *   b.removeQueen(i,j)     modifica della configurazione di b
 *                          rimuovendo la regina in posizione <i,j>
 *                          (si assume che ci sia una regina in <i,j>)
 *   b.arrangement() :      descrizione "esterna" della configurazione
 *                          (convenzioni scacchistiche).
 */


public class Board {


  // Codifica secondo le convenzioni scacchistiche (massima dimensione: 15 x 15)
  
  private static final String ROWS = " 123456789ABCDEF";
  private static final String COLS = " abcdefghijklmno";
  
  
  // Realizzazione del dato astratto "Scacchiera": stato interno
  
  private final int size;                             // 1) dimensione scacchiera
  private int queens;                                 // 2) numero regine collocate
  
  private int[] rowAttacked;                          // 3) riga, colonna, diagonali
  private int[] colAttacked;                          //    minacciate da ... regine
  private int[] dg1Attacked;
  private int[] dg2Attacked;

  private String config;                              // 4) disposizione delle regine:
                                                      //    rappresentazione testuale
  
  // Costruttore:
  
  public Board( int n ) {                             // scacchiera vuota
  
    size = n;                                         // scacchiera n x n
    queens = 0;                                       // nessuna regina
    
    rowAttacked = new int[ n ];                       // n righe          (i   invariante)
    colAttacked = new int[ n ];                       // n colonne        (j   invariante)
    dg1Attacked = new int[ 2*n-1 ];                   // 2n-1 diagonali / (i-j invariante)
    dg2Attacked = new int[ 2*n-1 ];                   // 2n-1 diagonali \ (i+j invariante)
    
    for ( int k=0; k<n; k=k+1 ) {                     // nessuna regina minaccia...
      rowAttacked[k] = 0;
      colAttacked[k] = 0;
      dg1Attacked[k] = 0;
      dg2Attacked[k] = 0;
    }
    for ( int k=n; k<2*n-1; k=k+1 ) {
      dg1Attacked[k] = 0;
      dg2Attacked[k] = 0;
    }
    config = " ";
  }
  
  
  public int size() {                                 // dimensione della scacchiera
  
    return size;
  }
  
  
  public int queensOn() {                             // numero di regine collocate
  
    return queens;
  }
  
  
  public boolean underAttack( int i, int j ) {        // posizione <i,j> minacciata?
  
    int n = size;
    
    return ( (rowAttacked[i-1] > 0)     ||            // riga        i   minacciata
             (colAttacked[j-1] > 0)     ||            // colonna     j   minacciata
             (dg1Attacked[i-j+n-1] > 0) ||            // diagonale / i-j minacciata
             (dg2Attacked[i+j-2] > 0)                 // diagonale \ i+j minacciata
             );
  }
  
  
  public void addQueen( int i, int j ) {              // nuova configurazione scacchiera
                                                      // con una regina anche in <i,j>
    int n = size;
    queens = queens + 1;                              // nuova regina
    
    rowAttacked[i-1]     = rowAttacked[i-1]     + 1;  // minaccia riga i
    colAttacked[j-1]     = colAttacked[j-1]     + 1;  // minaccia colonna j
    dg1Attacked[i-j+n-1] = dg1Attacked[i-j+n-1] + 1;  // minaccia diagonale / i-j
    dg2Attacked[i+j-2]   = dg2Attacked[i+j-2]   + 1;  // minaccia diagonale \ i+j
    
    config = config + COLS.charAt(j) + ROWS.charAt(i) + " ";
  }
  
  
  public void removeQueen( int i, int j ) {           // nuova configurazione scacchiera
                                                      // con una regina in meno
    int n = size;
    queens = queens - 1;                              // regina rimossa
    
    rowAttacked[i-1]     = rowAttacked[i-1]     - 1;  // una minaccia in meno per...
    colAttacked[j-1]     = colAttacked[j-1]     - 1;
    dg1Attacked[i-j+n-1] = dg1Attacked[i-j+n-1] - 1;
    dg2Attacked[i+j-2]   = dg2Attacked[i+j-2]   - 1;
    
    int k = config.indexOf( COLS.charAt(j) + "" + ROWS.charAt(i) );
    config = config.substring( 0, k ) + config.substring( k+3 );
  }

  
  public String arrangement() {                       // descrizione testuale
  
    return config;
  }
  
  
  public String toString() {                          // rappresentazione standard per Java
  
    return "[" + config + "]";
  }


}  // class Board
