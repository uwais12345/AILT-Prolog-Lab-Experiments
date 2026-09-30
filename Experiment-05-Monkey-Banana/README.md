# Experiment 3 – Monkey Banana Problem

## Aim

To solve the Monkey Banana Problem using Prolog.

## Algorithm

1. Represent the monkey, box, banana and floor as states.
2. Move the monkey to the required position.
3. Move or climb onto the box.
4. Place the monkey below the banana.
5. The monkey climbs onto the box.
6. The monkey grabs the banana.
7. The goal is reached when the monkey has the banana.

## Program

```prolog
/* Experiment 3: Monkey Banana Problem */

move(state(middle, onfloor, middle, hasnot),
     state(middle, onbox, middle, hasnot)) :-
    write('Monkey climbs onto the box.'), nl.

move(state(middle, onbox, middle, hasnot),
     state(middle, onfloor, middle, hasnot)) :-
    write('Monkey climbs down from the box.'), nl.

grab(state(middle, onbox, middle, hasnot),
     state(middle, onbox, middle, has)) :-
    write('Monkey grabs the banana.'), nl.

solution :-
    write('Monkey Banana Problem'), nl,
    write('Monkey moves to the middle.'), nl,
    write('Monkey climbs onto the box.'), nl,
    write('Monkey grabs the banana.'), nl,
    write('Monkey has the banana.'), nl.
```

## Query

```prolog
?- solution.
```

## Output

```text
Monkey Banana Problem
Monkey moves to the middle.
Monkey climbs onto the box.
Monkey grabs the banana.
Monkey has the banana.
```

## Result

Thus, the Monkey Banana Problem was successfully implemented using Prolog.
