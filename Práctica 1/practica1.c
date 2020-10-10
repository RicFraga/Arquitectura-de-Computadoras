#include <stdio.h>
#include <stdlib.h>
#include <time.h>

int * generar(int cantidad) {

    int *arreglo = malloc(cantidad);

    srand(time(NULL));

    for(int i = 0; i < cantidad; i++) {
        arreglo[i] = rand() % 1000;
    }

    return arreglo;
}

void mostrar(int *arreglo, int longitud) {
    
    for(int i = 0; i < longitud; i++)
        printf("%d ", arreglo[i]);
}

int *ordenar(int *arreglo, int cantidad) {

    int aux;

    for(int i = 0; i < cantidad - 1; i++) {
        for(int j = 0; j < cantidad - 1 - i; j++) {
            if(arreglo[j] > arreglo[j + 1]) {

                aux = arreglo[j];
                arreglo[j] = arreglo[j + 1];
                arreglo[j + 1] = aux;
            }
        }
    }

    return arreglo;
}

int main(void) {
    int cantidad;
    int *arreglo;

    printf("Cantidad de elementos deseados en el arreglo: ");
    scanf("%d", &cantidad);

    arreglo = generar(cantidad);

    printf("Arreglo sin ordenar\n");
    mostrar(arreglo, cantidad);
    printf("\n");

    arreglo = ordenar(arreglo, cantidad);

    printf("Arreglo ordenado\n");
    mostrar(arreglo, cantidad);
    printf("\n");

    return 0;
}