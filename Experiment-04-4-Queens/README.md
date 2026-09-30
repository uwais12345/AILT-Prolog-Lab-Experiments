# Experiment 4 – 4 Queens Problem

## Aim

To solve the 4-Queens Problem using Prolog.

## Problem

Place 4 queens on a 4 × 4 chessboard such that no two queens attack each other.

## Algorithm

1. Generate a list containing the row positions from 1 to N.
2. Generate permutations of the row positions to represent queen placements.
3. Check that no two queens are in the same column.
4. Check that no two queens are on the same diagonal.
5. If all conditions are satisfied, the arrangement is a solution.
6. Display the solution.

## Program

```prolog
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
```

## Query

```prolog
?- nqueens(4, Queens).
```

## Output

```text
Queens = [2,4,1,3] ;
Queens = [3,1,4,2] ;
false.
```

## Result

Thus, the 4-Queens Problem was successfully solved using Prolog.
