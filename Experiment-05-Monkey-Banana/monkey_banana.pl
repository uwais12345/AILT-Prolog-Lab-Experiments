/* Experiment 3: Monkey Banana Problem */

move(state(middle, onfloor, middle, hasnot),
     state(middle, onbox, middle, hasnot)) :-
    write('Monkey climbs onto the box.'), nl.

move(state(middle, onbox, middle, hasnot),
     state(middle, onfloor, middle, hasnot)) :-
    write('Monkey climbs down from the box.'), nl.

move(state(P, onfloor, P, hasnot),
     state(P, onfloor, P, hasnot)) :-
    write('Monkey pushes the box.'), nl.

move(state(P, onfloor, P, hasnot),
     state(P, onfloor, P, hasnot)) :-
    write('Monkey moves.'), nl.

grab(state(middle, onbox, middle, hasnot),
     state(middle, onbox, middle, has)) :-
    write('Monkey grabs the banana.'), nl.

solution :-
    write('Monkey Banana Problem'), nl,
    write('Monkey moves to the middle.'), nl,
    write('Monkey climbs onto the box.'), nl,
    write('Monkey grabs the banana.'), nl,
    write('Monkey has the banana.'), nl.
