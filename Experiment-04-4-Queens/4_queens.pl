nqueens(N, Queens) :-
    length(Queens, N),
    numlist(1, N, Rows),
    permutation(Rows, Queens),
    safe(Queens).

safe([]).

safe([Q|Qs]) :-
    safe(Q, Qs, 1),
    safe(Qs).

safe(_, [], _).

safe(Q, [Q2|Qs], D) :-
    Q =\= Q2,
    abs(Q-Q2) =\= D,
    D1 is D + 1,
    safe(Q, Qs, D1).
