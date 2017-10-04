% romania.prolog

% succ because roads are undirected.
succ(X,Y,D):-
	road(X,Y,D);
	road(Y,X,D).

% My facts are declared as roads. But you should use succ() anyway.
road(arad, zerind, 75).
road(arad, sibiu, 140).
road(arad, timisoara, 118).
road(zerind, oradea, 71).
road(oradea, sibiu, 151).
road(sibiu, fagaras, 99).
road(sibiu, rimnicu, 80).
road(fagaras, bucharest, 211).
road(bucharest, giurgiu, 90).
road(bucharest, urziceni, 85).
road(urziceni, hirsova, 98).
road(urziceni, vaslui, 142).
road(hirsova, eforie, 86).
road(vaslui, iasi, 92).
road(iasi, neamt, 87).
road(rimnicu, pitesti, 97).
road(rimnicu, craiova, 146).
road(pitesti, craiova, 138).
road(pitesti, bucharest, 101).
road(timisoara, lugoj, 111).
road(lugoj, mehadia, 70).
road(mehadia, dobreta, 75).
road(dobreta, craiova, 120).



% Heuristics wrt Bucharest
heuristic( A, B, C):-
	crow_flies( A, B, C) ;
	crow_flies( B, A, C).

crow_flies( arad , bucharest, 366 ) :- !.
crow_flies( bucharest , bucharest, 0 ) :- !.
crow_flies( craiova , bucharest, 160 ) :- !.
crow_flies( dobreta , bucharest, 242 ) :- !.
crow_flies( eforie , bucharest, 161 ) :- !.
crow_flies( fagaras , bucharest, 178 ) :- !.
crow_flies( giurgiu , bucharest, 77 ) :- !.
crow_flies( hirsova , bucharest, 151 ) :- !.
crow_flies( iasi , bucharest, 226 ) :- !.
crow_flies( lugoj , bucharest, 244 ) :- !.
crow_flies( mehadia , bucharest, 241 ) :- !.
crow_flies( neamt , bucharest, 234 ) :- !.
crow_flies( oradea , bucharest, 380 ) :- !.
crow_flies( pitesti , bucharest, 98 ) :- !.
crow_flies( rimnicu , bucharest, 193 ) :- !.
crow_flies( sibiu , bucharest, 253 ) :- !.
crow_flies( timisoara , bucharest, 329 ) :- !.
crow_flies( urziceni , bucharest, 80 ) :- !.
crow_flies( vaslui , bucharest, 199 ) :- !.
crow_flies( zerind , bucharest, 374 ) :- !.

crow_flies( _ , _, 0 ) :- !.
