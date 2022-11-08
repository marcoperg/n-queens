#include <stdio.h>
#include <stdlib.h>
#include <string.h>

void print_board(int n, int *board) {
    if (board == NULL)
        printf("%s", (char *) board);
    else 
        for (int i=0; i<n; i++) {
            for (int j=0; j<n; j++) {
                if (board[i] == j)
                    printf("x");
                else
                    printf("o");
            }
            printf("\n");
        }
    printf("\n");
}

int is_attacked(int n, int *board, int i0, int j0) {
    for (int i=0; i<n; i++) {
        if (board[i] == -1)
            continue;
        if (board[i] == j0)
            return 1;
        
        if ((i - board[i] == i0 - j0) || (i + board[i] == i0 + j0))
            return 1;
    }
    return 0;
}

int rec(int n, int *board, int row, int *n_sol) {
    if (row >= n) {
        if (*n_sol == 0)
            return 1;
        else {
            (*n_sol)--;
            return 0;
        }
    }

    for (int col=0; col<n; col++) {
        if (!is_attacked(n, board, row, col)) {
            board[row] = col;
            if (rec(n, board, row+1, n_sol))
                return 1;
            board[row] = -1;
        }
    }
    return 0;
}

int *n_queens(int n, int n_sol) {
    int *board;

    board = malloc(sizeof(int)*n);
    memset(board, -1, sizeof(int)*n);
    if (rec(n, board, 0, &n_sol) == 0)
        return NULL;
    return board;
}

int main(int argc, char **argv) {
    int *sol;
    int n;
    int i;
    int print;
    int pos_n;

    if (argc < 2) {
        printf("Usage: program [-v] n\n");
        return 1;
    }

    print = 0;
    if (strcmp(argv[1], "-v") == 0) {
        print = 1;
        pos_n = 2;
    } else
        pos_n = 1;

    if (argc != pos_n + 1) {
        printf("Usage: program [-v] n\n");
        return 1;
    }

    n = atoi(argv[pos_n]);
    i = 0;
    while ((sol = n_queens(n, i))) {
        if (print)
            print_board(n, sol);
        if (sol)
            free(sol);
        i++;
    }
    printf("%d\n", i);
    return 0;
}