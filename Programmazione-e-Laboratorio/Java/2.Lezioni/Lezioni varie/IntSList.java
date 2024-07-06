public class IntSList
{
    public static final IntSList NULL_INTSLIST = new IntSList();
    
    private final boolean empty;
    private final int first;
    private final IntSList rest;
    
    // Costruttore: creazione di una lista vuota (scheme: null)
    public IntSList(){
    
        empty = true;
        first = 0;
        rest = null;
    }
    
    // Costruttore: creazione di una lista non vuota (scheme: cons)
    public IntSList(int n, IntSList s){
    
        empty = false;
        first = n;
        rest = s;
    }
    
    public boolean isNull(){
        
        return empty;
    }
    
    // Metodo per acquisire tutto tranne il primo elemento di una lista non vuota (scheme: cddr)
    public IntSList cdr(){

        return rest;
    }
    
    // Metodo per acquisire il primo elemento di una lista non vuota (scheme: car)
    public int car(){
        
        return first;
    }
    
    public IntSList cons(int n){
        
        return new IntSList(n, this);
    }
    
    // Metodo che si applica a liste e le traforma in stringhe
    
    public String toString(){
        
        if (empty)                      // Lista vuota
            return "()";
            
        else if (rest.isNull())         // Lista con un solo elemento
            return "(" + first + ")";
            
        else{                           // Lista con piu di un elemento
            String rep = "(" + first;
            IntSList r = rest;
            while (!r.isNull()){
                rep = rep + ", " + r.car();
                r = r.cdr();
            }
            return (rep + ")");
        } 
    }
    
    // Metodo che definisce la lunghezza di una lista
    public int lenght(){
        
        if (isNull())
            return 0;
        else
            return 1 + cdr().lenght();
    }
    
    // Metodo che definisce l'elemento che si trova alla posizione i-esima
    public int listRef(int i){
    
        if (i == 0)
            return car();
        
        else
            return cdr().listRef(i - 1);
    }
    
    // Metodo che confronta due oggetti di tipo IntSList sono uguali
    public boolean equals(IntSList il){
        
        if (isNull() || il.isNull())
            return (this.isNull() && il.isNull());  
            
        else if (this.car() == il.car())
            return (this.cdr().equals(il.cdr()));  
        
        else
            return false;
    }
   
    // Metodo che usice due liste
    public IntSList append(IntSList il){
        
        if (isNull())
            return il;
            
        else
            return (cdr().append(il)).cons(car());
        
    }
    
    // Metodo che riporta una lista inversa
    public IntSList reverse(){
      
        return reverseTR(NULL_INTSLIST);
    }
    private IntSList reverseTR(IntSList il){
        
        if (isNull())
            return il;
        
        else
            return cdr().reverseTR(il.cons(car()));
    }
}
