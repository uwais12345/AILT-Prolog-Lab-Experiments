# Experiment 6 – Depth First Search (DFS)

## Aim

To implement Depth First Search (DFS) using Prolog.

## Algorithm

1. Start from the given start node.
2. Add the start node to the visited list.
3. Check whether the current node is the goal node.
4. If the current node is the goal, return the path.
5. Otherwise, select a connected node that has not been visited.
6. Add the selected node to the visited list.
7. Recursively continue the search.
8. Continue until the goal node is reached.
9. Display the path obtained.

## Program

```prolog
connected(a,b).
connected(a,c).
connected(b,d).
connected(c,d).

dfs(Start,Goal,Path) :-
    dfs_search(Start,Goal,[Start],Path).

dfs_search(Goal,Goal,Visited,Visited).

dfs_search(Node,Goal,Visited,Path) :-
    connected(Node,Next),
    \+ member(Next,Visited),
    dfs_search(Next,Goal,[Next|Visited],Path).
```

## Query

```prolog
?- dfs(a,d,Path).
```

## Output

```text
Path = [d,b,a] ;
Path = [d,c,a] ;
false.
```

## Result

Thus, Depth First Search was successfully implemented and verified using Prolog.
