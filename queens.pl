:- module(queens, _, _).
:- use_module(library(between)).
:- use_module(library(lists)).

queens(N, L) :- integer(N), length(L, N), check_queens(N, L, 0, L).

check_queens(_, _, _, []).
check_queens(N, L, QueenRow, [QueenCol | XS]) :- 
                             between(0, N-1, QueenCol),
                             check_is_attacked(QueenRow, QueenCol, 0, L),
                             Q1 is QueenRow+1,
                             check_queens(N, L, Q1, XS).

check_is_attacked(_, _, _, []).

check_is_attacked(QueenRow, QueenCol, OtherQueenRow, [OtherQueenCol | XS]) :-
                                QueenRow =\= OtherQueenRow,
                                OtherQueenCol  =\= QueenCol, 
                                abs(QueenRow - OtherQueenRow) =\= abs(QueenCol - OtherQueenCol),
                                Q1 is OtherQueenRow + 1,
                                check_is_attacked(QueenRow, QueenCol, Q1, XS).

check_is_attacked(QueenRow, _, QueenRow, _).