# Experiment 2 – Basics of Prolog

## Aim

To understand the basics of PROLOG and its working environment.

## Algorithm

1. Open the PROLOG interpreter.
2. Familiarize yourself with basic commands and syntax.
3. Write and test simple facts and rules.
4. Execute queries to verify the Prolog program.

## Program

```prolog
/* Program 1: Sum of two numbers */

sum(X,Y) :-
    S is X + Y,
    write(S).

/* Facts */

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
```

## Query 1

```prolog
?- sum(-10,20).
```

## Output

```text
10
true.
```

## Query 2

```prolog
?- father(john,mary).
```

## Output

```text
true.
```

## Result

Thus, the basics of Prolog were installed, implemented, and understood.
