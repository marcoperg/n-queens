:- module(queens, _, _).
:- use_module(library(between)).
:- use_module(library(write)).
:- use_module(library(streams)).
:- use_module(library(lists)).

queens(N, L) :- integer(N), length(L, N), check_ints(N, L), check_queens(L, 0, L).

check_queens(_, _, []).
check_queens(L, QueenRow, [QueenCol | XS]) :- 
                             Q1 is QueenRow+1,
                             check_is_attacked(QueenRow, QueenCol, 0, L),
                             check_queens(L, Q1, XS).

check_is_attacked(_, _, _, []).

check_is_attacked(QueenRow, QueenCol, OtherQueenRow, [OtherQueenCol | XS]) :-
                                QueenRow =\= OtherQueenRow,
                                OtherQueenCol  =\= QueenCol, 
                                LP1 is OtherQueenRow - OtherQueenCol,
                                LP2 is QueenRow - QueenCol,
                                LP1 =\= LP2,
                                LS1 is OtherQueenRow + OtherQueenCol,
                                LS2 is QueenRow + QueenCol,
                                LS1 =\= LS2,
                                Q1 is OtherQueenRow + 1,
                                check_is_attacked(QueenRow, QueenCol, Q1, XS).

check_is_attacked(QueenRow, QueenCol, OtherQueenRow, [_ | XS]) :- 
                                QueenRow = OtherQueenRow,
                                Q1 is QueenRow + 1,
                                check_is_attacked(QueenRow, QueenCol, Q1, XS).



check_ints(_, []).
check_ints(N, [X | XS]) :- N1 is N-1, between(0, N1, X), check_ints(N, XS).