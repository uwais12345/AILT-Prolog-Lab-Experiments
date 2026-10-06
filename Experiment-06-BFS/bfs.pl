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
