#include <stdio.h>
#include <stdlib.h>

typedef struct MinHeap MinHeap;

struct MinHeap {
    int* arr;

    // Dimensione attuale della heap
    int size;

    // Massima dimensione della heap
    int capacity;
};

// Ritorna l'indirizzo del genitore
int parent(int i) {
    return (i - 1) / 2;
}

// Ritorna l'indirizzo del figlio sinistro
int left_child(int i) {
    return (2*i + 1);
}

// Ritorna l'indirizzo del figlio destro
int right_child(int i) {
    return (2*i + 2);
}

// Ritorna l'elemento più piccolo nella minheap, ossia
// l'elemento contenuto nella radice
int get_min(MinHeap* heap) {
    return heap->arr[0];
}

// Funzione per inizializzare una nuova minheap
MinHeap* init_minheap(int capacity) {
    MinHeap* minheap = (MinHeap*) calloc (1, sizeof(MinHeap));
    minheap->arr = (int*) calloc (capacity, sizeof(int));
    minheap->capacity = capacity;
    minheap->size = 0;
    return minheap;
}

// Funzione che inserisce un elemento nella minheap
// Inizialmente viene aggiunto nell'ultimo livello
// dell'albero. Se tale elemento è minore rispetto al
// valore del suo genitore lo si scambia con esso
MinHeap* insert_minheap(MinHeap* heap, int element) {

    // Se la heap è gia piena
    if (heap->size == heap->capacity) {
        fprintf(stderr, "Cannot insert %d. Heap is already full!\n", element);
        return heap;
    }
    // Aumenta la dimensione
    heap->size++;

    // Inserisce l'elemento alla fine
    heap->arr[heap->size - 1] = element;

    // Continua a scambiare finche non raggiunge la root
    int curr = heap->size - 1;

    // Finche non si arriva alla radice e finche il genitore
    // dell'ultimo elemento è maggiore di esso
    while (curr > 0 && heap->arr[parent(curr)] > heap->arr[curr]) {

        // Swap
        int temp = heap->arr[parent(curr)];
        heap->arr[parent(curr)] = heap->arr[curr];
        heap->arr[curr] = temp;

        // Aggiorna l'indirizzo dell'elemento corrente
        curr = parent(curr);
    }
    return heap; 
}

// Funzione che riordina la heap per mantenerne le proprieta
MinHeap* heapify(MinHeap* heap, int index) {

    if (heap->size <= 1)
        return heap;
    
    int left = left_child(index); 
    int right = right_child(index); 

    // Variable to get the smallest element of the subtree
    // of an element an index
    int smallest = index; 
    
    // If the left child is smaller than this element, it is
    // the smallest
    if (left < heap->size && heap->arr[left] < heap->arr[index]) 
        smallest = left; 
    
    // Similarly for the right, but we are updating the smallest element
    // so that it will definitely give the least element of the subtree
    if (right < heap->size && heap->arr[right] < heap->arr[smallest]) 
        smallest = right; 

    // Now if the current element is not the smallest,
    // swap with the current element. The min heap property
    // is now satisfied for this subtree. We now need to
    // recursively keep doing this until we reach the root node,
    // the point at which there will be no change!
    if (smallest != index) 
    { 
        int temp = heap->arr[index];
        heap->arr[index] = heap->arr[smallest];
        heap->arr[smallest] = temp;
        heap = heapify(heap, smallest); 
    }

    return heap;
}

// Funzione che elimina il valore minimo contenuto nella heap
// e la riordina per mantenerne le caratteristiche di minheap
MinHeap* delete_minimum(MinHeap* heap) {
    // Deletes the minimum element, at the root
    if (!heap || heap->size == 0)
        return heap;

    int size = heap->size;
    int last_element = heap->arr[size-1];
    
    // Update root value with the last element
    heap->arr[0] = last_element;

    // Now remove the last element, by decreasing the size
    heap->size--;
    size--;

    // We need to call heapify(), to maintain the min-heap
    // property
    heap = heapify(heap, 0);
    return heap;
}

// Funzione che elimina un valore ad un dato indirizzo nella heap
// e la riordina per mantenerne le caratteristiche di minheap
MinHeap* delete_element(MinHeap* heap, int index) {
    
    heap->arr[index] = get_min(heap) - 1;
    
    int curr = index;
    while (curr > 0 && heap->arr[parent(curr)] > heap->arr[curr]) {
        int temp = heap->arr[parent(curr)];
        heap->arr[parent(curr)] = heap->arr[curr];
        heap->arr[curr] = temp;
        curr = parent(curr);
    }

    heap = delete_minimum(heap);
    return heap;
}

// Funzione che stampa la heap
void print_heap(MinHeap* heap) {

    printf("Min Heap: ");
    for (int i=0; i<heap->size; i++) {
        printf("%d ", heap->arr[i]);
    }
    printf("\n");
}

// Funzione che elimina una heap
void free_minheap(MinHeap* heap) {
    if (!heap)
        return;
    free(heap->arr);
    free(heap);
}


void heapSelect(MinHeap* h1, int k){

    MinHeap* h2 = init_minheap(100);
    int hlen = h1->size, figlio_dx, figlio_sx;

    insert_minheap(h2, h1->arr[0]);
    printf("\n");

    // Per i che va da 1 a k−1, l'algoritmo estrae la radice di H2,
    // che corrisponde a un nodo xi in H1, e reinserisce in H2 i
    // nodi successori (figli sinistro e destro) di xi nella heap H1. 
    if ((k <= 0) || (k > hlen)) {
        printf("k invalido\n");

    } else {
        for (int i = 1; i <= k-1; i++) {
            for (int j = 0; j < hlen-1; j++) {

                // Cerca la radice di h2 in h1 e salva i suoi figli
                //print_heap(h1);
                if (h2->arr[0] == h1->arr[j]) {
                    
                    figlio_sx = h1->arr[left_child(j)];
                    figlio_dx = h1->arr[right_child(j)];
                }
            }

            // Estrae il primo elemento di h2
            delete_element(h2, 0); 
            
            // Se esitono in h1 li inserisce in h2
            if (figlio_sx != 0) {
                insert_minheap(h2, figlio_sx);
            }
                        
            if (figlio_dx != 0) { 
                insert_minheap(h2, figlio_dx);
            }  

            print_heap(h2);
        }
        printf("%d", h2->arr[0]);
    }
    
    free_minheap(h1);
    free_minheap(h2);
}

int main() {
    
    MinHeap* h1 = init_minheap(100);;
    char c;
    int k = 14;

    insert_minheap(h1, 1);
    insert_minheap(h1, 2);
    insert_minheap(h1, 7);
    insert_minheap(h1, 6);
    insert_minheap(h1, 5);  
    insert_minheap(h1, 15);
    insert_minheap(h1, 103);
    insert_minheap(h1, 215);
    insert_minheap(h1, 13);
    insert_minheap(h1, 1334);
    insert_minheap(h1, 78);
    insert_minheap(h1, 17);
    insert_minheap(h1, 96);
    insert_minheap(h1, 23);

    printf("\n");
    print_heap(h1);
    printf("k: %d\n", k);

    heapSelect(h1, k);    
    
    return 0;
}