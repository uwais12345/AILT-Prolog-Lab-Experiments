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
