public class IntSListTest
{
    public static IntSList range(int inf, int sup){
        
        if (inf > sup)
            return new IntSList();
        
        else
            return range(inf + 1, sup).cons(inf);
    }
    
    public static IntSList ins(int x, IntSList s){
        
        if (s.isNull())
            return (new IntSList()).cons(x);
        
        else if (x < s.car())
            return s.cons(x);
            
        else
            return ins(x, s.cdr()).cons(s.car());
    }
        
    public static void main(String[] args){
        
        IntSList s = range(-5, 5);// new IntSList(); 
        System.out.println(s);
    }
}
