#include <stdio.h>
#include <stdlib.h>
#include <time.h>

#define SIZE 6

// Genera matriz binaria aleatoria
void generarMatriz(int matriz[SIZE][SIZE]) {
    srand(time(NULL));
    for (int i = 0; i < SIZE; i++)
        for (int j = 0; j < SIZE; j++)
            matriz[i][j] = rand() % 2;
}

// Imprime la matriz
void imprimirMatriz(int matriz[SIZE][SIZE]) {
    for (int i = 0; i < SIZE; i++) {
        for (int j = 0; j < SIZE; j++)
            printf("%d ", matriz[i][j]);
        printf("\n");
    }
    printf("\n");
}

// Cuenta máximo de 1s consecutivos en una diagonal (↘)
int contarMaxDiagonalPrincipal(int matriz[SIZE][SIZE]) {
    int maxConsec = 0;

    // Diagonales que comienzan en la primera fila
    for (int col = 0; col < SIZE; col++) {
        int i = 0, j = col, count = 0;
        while (i < SIZE && j < SIZE) {
            if (matriz[i][j] == 1)
                count++;
            else
                count = 0;
            if (count > maxConsec) maxConsec = count;
            i++; j++;
        }
    }

    // Diagonales que comienzan en la primera columna (excepto la esquina)
    for (int row = 1; row < SIZE; row++) {
        int i = row, j = 0, count = 0;
        while (i < SIZE && j < SIZE) {
            if (matriz[i][j] == 1)
                count++;
            else
                count = 0;
            if (count > maxConsec) maxConsec = count;
            i++; j++;
        }
    }

    return maxConsec;
}

// Cuenta máximo de 1s consecutivos en diagonal secundaria (↙)
int contarMaxDiagonalSecundaria(int matriz[SIZE][SIZE]) {
    int maxConsec = 0;

    // Diagonales que comienzan en la primera fila
    for (int col = 0; col < SIZE; col++) {
        int i = 0, j = col, count = 0;
        while (i < SIZE && j >= 0) {
            if (matriz[i][j] == 1)
                count++;
            else
                count = 0;
            if (count > maxConsec) maxConsec = count;
            i++; j--;
        }
    }

    // Diagonales que comienzan en la última columna
    for (int row = 1; row < SIZE; row++) {
        int i = row, j = SIZE - 1, count = 0;
        while (i < SIZE && j >= 0) {
            if (matriz[i][j] == 1)
                count++;
            else
                count = 0;
            if (count > maxConsec) maxConsec = count;
            i++; j--;
        }
    }

    return maxConsec;
}

int findLargestLine(int matriz[SIZE][SIZE]) {
    int maxPrincipal = contarMaxDiagonalPrincipal(matriz);
    int maxSecundaria = contarMaxDiagonalSecundaria(matriz);
    return (maxPrincipal > maxSecundaria) ? maxPrincipal : maxSecundaria;
}

int main() {
    int matriz[SIZE][SIZE];

    generarMatriz(matriz);

    printf("La matriz utilizada corresponde a:\n");
    imprimirMatriz(matriz);

    int resultado = findLargestLine(matriz);
    printf("El taman~o de la secuencia en diagonal de 1s mas grande es: %d\n", resultado);

    return 0;
}
