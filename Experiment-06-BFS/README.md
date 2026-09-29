# Experiment 5 – Breadth First Search (BFS)

## Aim

To implement Breadth First Search (BFS) using Prolog.

## Algorithm

1. Start from the given start node.
2. Store the initial node in a queue.
3. Remove the first path from the queue.
4. Check whether the current node is the goal node.
5. If it is not the goal, find all unvisited connected nodes.
6. Add the new paths to the end of the queue.
7. Continue until the goal node is reached.
8. Display the path obtained.

## Program

prolog
connected(a,b).
connected(a,c).
connected(b,d).
connected(c,d).

bfs(Start,Goal,Path) :-
    bfs_queue([[Start]],Goal,Path).

bfs_queue([[Goal|Path]|_],Goal,[Goal|Path]).

bfs_queue([Path|Paths],Goal,Solution) :-
    Path = [Node|_],
    findall([Next|Path],
        (connected(Node,Next),
         \+ member(Next,Path)),
        NewPaths),
    append(Paths,NewPaths,Queue),
    bfs_queue(Queue,Goal,Solution).


Query
?- bfs(a,d,Path).
Output
Path = [d,b,a] ;
Path = [d,c,a] ;
false.
Result
Thus, Breadth First Search was successfully implemented and verified using Prolog.
