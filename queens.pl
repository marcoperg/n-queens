:- module(queens, _, _).

queens(N, L) :- integer(N), check_ints(N, L), check_queens(L, 0, L).

check_queens(_, _, []).
check_queens(L, QueenRow, [QueenCol | XS]) :- 
                             Q1 is QueenRow+1,
                             check_is_attacked(QueenRow, QueenCol, 0, L),
                             check_queens(L, Q1, XS).

check_is_attacked(_, _, _, []).

check_is_attacked(QueenRow, QueenCol, QueenRow, [_ | XS]) :- 
                                Q1 is QueenRow + 1,
                                check_is_attacked(QueenRow, QueenCol, Q1, XS).

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

check_ints(0, []).
check_ints(1, [X]) :- integer(X), X>=0, X<1.
check_ints(N, [X | XS]) :- integer(X), X>=0, X<N, N1 is N-1, check_ints(N1, XS).