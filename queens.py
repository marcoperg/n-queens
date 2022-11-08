#!/opt/homebrew/Caskroom/miniconda/base/bin/python

import sys
from tqdm import tqdm


def print_board(board):
    for row in board:
        for i in range(len(board)):
            print('x' if row == i else 'o', end='')
        print()
    print()


def is_attacked(board, i0, j0):
    n = len(board)
    for i in range(n):
        if board[i] == None:
            continue
        if board[i] == j0:
            return True

        if (i - board[i] == i0 - j0) or (i + board[i] == i0 + j0):
            return True

    return False

def rec(n, board, row):
    if row >= n:
        yield board
        return
    for col in range(n):
        if not is_attacked(board, row, col):
            board[row] = col
            yield from rec(n, board, row+1)
            board[row] = None


def n_queens(n):
    board = [None for _ in range(n)]

    yield from rec(n, board, 0)


if __name__ == '__main__':
    if len(sys.argv) != 2:
        print("Please specify n with program args.");
        exit(1)

    gen = n_queens(int(sys.argv[1]))
    leng = 0
    for i in tqdm(iter(gen)):
        print_board(i)
        leng += 1
    print(leng)
