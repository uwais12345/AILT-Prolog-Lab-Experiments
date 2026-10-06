/* Experiment 2: Basics of Prolog */

/* Program 1: Sum of two numbers */

sum(X,Y) :-
    S is X + Y,
    write(S).

/* Program 2: Facts */

male(john).
female(mary).
parent(john, mary).

/* Rules */

father(X,Y) :-
    male(X),
    parent(X,Y).

mother(X,Y) :-
    female(X),
    parent(X,Y).
