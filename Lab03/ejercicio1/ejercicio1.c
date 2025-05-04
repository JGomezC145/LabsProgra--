#include <stdio.h>

int sumaDiagonales(int matriz[][100], int n) {
    int sumaPrincipal = 0;
    int sumaSecundaria = 0;

    for (int i = 0; i < n; i++) {
        sumaPrincipal += matriz[i][i];
        sumaSecundaria += matriz[i][n - 1 - i];
    }

    return sumaPrincipal + sumaSecundaria;
}

void imprimirMatriz(int matriz[][100], int n) {
    for (int i = 0; i < n; i++) {
        for (int j = 0; j < n; j++) {
            printf("%d ", matriz[i][j]);
        }
        printf("\n");
    }
    printf("\n");
}

int main() {
    int matriz1[100][100] = {
        {1, 2, 3},
        {4, 5, 6},
        {7, 8, 9}
    };

    int matriz2[100][100] = {
        {5, 1},
        {2, 3}
    };

    int matriz3[100][100] = {
        {1, 2, 3, 4},
        {5, 6, 7, 8},
        {9, 10, 11, 12},
        {13, 14, 15, 16}
    };

    int casos[][2] = {{3, 3}, {2, 2}, {4, 4}};
    int* matrices[] = {(int*)matriz1, (int*)matriz2, (int*)matriz3};

    for (int i = 0; i < 3; i++) {
        int n = casos[i][0];
        int (*matriz)[100] = (int(*)[100])matrices[i];

        printf("Matriz %d:\n", i + 1);
        imprimirMatriz(matriz, n);

        int suma = sumaDiagonales(matriz, n);
        printf("Suma de diagonales: %d\n\n", suma);
    }

    return 0;
}
