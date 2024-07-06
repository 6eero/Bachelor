package com.company;
/*
 * Rompicapo delle "n regine"
 *
 * Dato astratto "configurazione della scacchiera":  Board
 *
 * Operazioni:
 *
 *   new Board( int n )           :  costruttore (scacchiera vuota)
 *
 *   size()                       :  int
 *
 *   queensOn()                   :  int
 *
 *   underAttack( int i, int j )  :  boolean
 *
 *   addQueen( int i, int j )     :  Board
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
 *   b.addQueen(i,j)        scacchiera che si ottiene dalla configurazione b
 *                          aggiungendo una nuova regina in posizione <i,j>
 *                          (si assume che la posizione non sia minacciata);
 *   b.arrangement() :      descrizione "esterna" della configurazione
 *                          (convenzioni scacchistiche).
 */


public class Queens {

  public static final SList<Board> NULL_BOARDLIST = new SList<Board>();

  /**
   * Numero di modi diversi in cui si possono disporre n regine
   * in una scacchiera n x n e' dato dal numero di modi diversi in
   * cui si puo' completare la disposizione delle regine a partire
   * da una scacchiera n x n inizialmente vuota
   **/

  public static int numberOfSolutions(int n) {
    return numberOfCompletions(new Board(n));
  }

  /*
   * Il numero di modi in cui si puo' completare la disposizione
   * a partire da una scacchiera b parzialmente configurata
   * dove k regine (0 <= k < n) sono collocate nelle prime k righe
   * di b, si puo' determinare a partire dalle configurazioni
   * che si ottengono aggiungendo una regina nella riga k+1 in tutti
   * i modi possibili (nelle posizioni che non sono gia' minacciate)
   *
   *   for ( int j=1; j<=n; j=j+1 ) {
   *     if ( !b.underAttack(i,j) ) { ... b.addQueen(i,j) ... }
   *   }
   *
   * Calcolando ricorsivamente per ciascuna di queste il numero
   * di modi in cui si puo' completare la disposizione e sommando i
   * valori che ne risultano.
   * Se invece la scacchiera rappresenta una soluzione (q == n)
   * l'unico modo di completare la disposizione é lasciare le cose
   * come stanno
   */

  private static int numberOfCompletions(Board b) {

    int n = b.size();       // n = dimensione della scacchiera
    int q = b.queensOn();   // q = # di regine posizionate (inizialmente zero)

    if (q == n)             // La scacchiera rappresenta una soluzione
      return 1;

    else {
      int i = q + 1;
      int count = 0;

      for ( int j = 1; j <= n; j = j+1) {

        if (!b.underAttack(i, j))                                  // Posizione (i, j) minacciata?
          count = count + numberOfCompletions(b.addQueen(i, j));   // no -> aggiungi una regina e ricorsione
      }
      return count;
    }
  }

  public static SList<Board> listOfAllSolutions(int n) {

    return listOfAllCompletions(new Board(n));
  }


  private static SList<Board> listOfAllCompletions(Board b) {

    int n = b.size();
    int q = b.queensOn();

    if (q == n)
      return (NULL_BOARDLIST.cons(b));

    else {
      int i = q + 1;
      SList<Board> solutions = NULL_BOARDLIST;

      for (int j = 1; j <= n; j = j+1) {

        if (!b.underAttack(i,j))
          solutions = solutions.append(listOfAllCompletions(b.addQueen(i,j)));

      }
      return solutions;
    }
  }
}

