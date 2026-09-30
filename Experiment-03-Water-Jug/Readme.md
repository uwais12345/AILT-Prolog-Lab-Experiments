# Experiment 9 – Water Jug Problem

## Aim

To solve the Water Jug Problem using Prolog.

## Problem

Using a 4-gallon jug and a 3-gallon jug, obtain exactly 2 gallons of water in the 4-gallon jug.

## Algorithm

1. Start with both jugs empty.
2. Represent the state as `(X,Y)`, where `X` is the amount in the 4-gallon jug and `Y` is the amount in the 3-gallon jug.
3. Fill or empty the jugs as required.
4. Pour water from one jug to the other without exceeding its capacity.
5. Continue the state transitions until the goal state `(2,0)` is reached.

## Program

```prolog
move(X,Y,4,Y) :-
    X < 4,
    write('Fill 4: '),
    write((X,Y)),
    write(' --> '),
    write((4,Y)),
    nl.

move(X,Y,X,3) :-
    Y < 3,
    write('Fill 3: '),
    write((X,Y)),
    write(' --> '),
    write((X,3)),
    nl.

move(X,Y,0,Y) :-
    X > 0,
    write('Empty 4: '),
    write((X,Y)),
    write(' --> '),
    write((0,Y)),
    nl.

move(X,Y,X,0) :-
    Y > 0,
    write('Empty 3: '),
    write((X,Y)),
    write(' --> '),
    write((X,0)),
    nl.

move(X,Y,4,Y2) :-
    X + Y >= 4,
    Y > 0,
    Y2 is Y - (4-X),
    write('Pour 3 to 4: '),
    write((X,Y)),
    write(' --> '),
    write((4,Y2)),
    nl.

move(X,Y,X2,3) :-
    X + Y >= 3,
    X > 0,
    X2 is X - (3-Y),
    write('Pour 4 to 3: '),
    write((X,Y)),
    write(' --> '),
    write((X2,3)),
    nl.

solution :-
    move(0,0,4,0),
    move(4,0,4,3),
    move(4,3,0,3),
    move(0,3,3,0),
    move(3,0,3,3),
    move(3,3,4,2),
    move(4,2,0,2),
    move(0,2,2,0).
```

## Query

```prolog
?- solution.
```

## Output

```text
Fill 4: (0,0) --> (4,0)
Fill 3: (4,0) --> (4,3)
Empty 4: (4,3) --> (0,3)
Pour 3 to 4: (0,3) --> (3,0)
Fill 3: (3,0) --> (3,3)
Pour 3 to 4: (3,3) --> (4,2)
Empty 4: (4,2) --> (0,2)
Pour 3 to 4: (0,2) --> (2,0)

true.
```

## State Sequence

```text
(0,0)
→ (4,0)
→ (4,3)
→ (0,3)
→ (3,0)
→ (3,3)
→ (4,2)
→ (0,2)
→ (2,0)
```

## Result

Thus, the Water Jug Problem was successfully implemented and the required 2 gallons were obtained in the 4-gallon jug.
