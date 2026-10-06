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
