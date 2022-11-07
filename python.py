#!/opt/homebrew/Caskroom/miniconda/base/bin/python

import sys
from tqdm import tqdm


def print_board(board):
    for row in board:
        print(' '.join([str(x) for x in row]))


def is_under_attack(board, i0, j0):
    n = len(board)
    for i in range(n):
        # Check column
        if (i != i0) and board[i][j0] == 1:
            return True

        # Check row
        if (i != j0) and board[i0][i] == 1:
            return True

        # Check main diag
        if i > 0 and (i0-i >= 0 and j0-i >= 0) and board[i0-i][j0-i] == 1:
            return True
        if i > 0 and (i0+i < n and j0+i < n) and board[i0+i][j0+i] == 1:
            return True

        # Check secondary diag
        if i > 0 and (i0-i >= 0 and j0+i < n) and board[i0-i][j0+i] == 1:
            return True
        if i > 0 and (i0+i < n and j0-i >= 0) and board[i0+i][j0-i] == 1:
            return True

    return False


def rec(n, board, row):
    if row >= n:
        yield board
        return
    for col in range(n):
        if not is_under_attack(board, row, col):
            board[row][col] = 1
            yield from rec(n, board, row+1)
            board[row][col] = 0


def n_queens(n):
    board = [[0 for _ in range(n)]
             for _ in range(n)]  # 0 if no queen, 1 if queen

    yield from rec(n, board, 0)


if __name__ == '__main__':
    gen = n_queens(int(sys.argv[1]))
    leng = 0
    for i in tqdm(iter(gen)):
        #print_board(i)
        #print('\n')
        leng += 1
    print(leng)
