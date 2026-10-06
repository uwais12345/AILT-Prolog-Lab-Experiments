# Experiment 8A – Flatten a List

## Aim

To implement list flattening in Prolog.

## Algorithm

1. Start.
2. Define the base rule `flatten([],[])` for an empty list.
3. Separate the list into Head and Tail.
4. Recursively flatten the Head.
5. Recursively flatten the Tail.
6. Combine the flattened Head and Tail using `append`.
7. If the element is not a list, convert it into a single-element list.
8. Display the flattened list.

## Program

```prolog
flatten([], []).

flatten([H|T], FlatList) :-
    flatten(H, NewH),
    flatten(T, NewT),
    append(NewH, NewT, FlatList).

flatten(L, [L]).
```

## Query

```prolog
?- flatten([1,[2,[3,4],5],6], FlatList).
```

## Output

```text
FlatList = [1,2,3,4,5,6].
```

## Result

Thus, the list flattening program was successfully implemented and executed in Prolog, and the nested list was converted into a single flattened list.
