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

void rec(int n, int *board, int row, int *total_sols, int verbose) {
    if (row >= n) {
        (*total_sols)++;
        if (verbose)
            print_board(n, board);
    }

    for (int col=0; col<n; col++) {
        if (!is_attacked(n, board, row, col)) {
            board[row] = col;
            rec(n, board, row+1, total_sols, verbose);
            board[row] = -1;
        }
    }
}

int all_n_queens(int n, int verbose) {
    int *board;
    int total_sols = 0;

    board = malloc(sizeof(int)*n);
    memset(board, -1, sizeof(int)*n);
    rec(n, board, 0, &total_sols, verbose);
    return total_sols;
}

int main(int argc, char **argv) {
    int *sol;
    int n;
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
    int i = all_n_queens(n, print);

    printf("%d\n", i);
    return 0;
}