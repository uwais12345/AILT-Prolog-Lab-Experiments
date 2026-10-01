safe(bonds).
safe(gold).

invests(lingam,stock).

invests(aral,X) :-
    invests(lingam,X).

safe(X) :-
    invests(_,X),
    \+ lost(_,X).

trusts(aral,X) :-
    safe(X).
