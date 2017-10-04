:- [ samplemap ].

drive:-
	init,
	% Do the initial record percepts call
	starting_location( X,Y ),
	drive_loop( [X,Y], Result ),
	writeln(['RESULT: ', Result] ),
	!.

% Case: Ran into wumpus
drive_loop( [X,Y], failure ):-
	wumpus_location(X,Y),
	writeln(' You ran into the wumpus. You die a painful death.  '),
	!.

% Case: Fell into pit
drive_loop( [X,Y], failure ):-
	pit(X,Y),
	writeln(' You fell into a pit. You die a slow death ' ),
	!.

% Case: You're on the gold
drive_loop( [X,Y], success ):-
	gold( X,Y ),
	writeln(' You\'ve found the pot of gold. Enough to feed your family for years. ' ),
	!.

% Default: We go on.
drive_loop( XY, Result ):-
	collect_percepts( XY, [Stench,Breeze,Glitter,Bump,Scream] ),
	record_percepts( XY, [Stench,Breeze,Glitter,Bump,Scream] ),
	pick_square( X1Y1 ),
	writeln(['Checking', X1Y1]), 	
	drive_loop(X1Y1, Result ).



% Percept generators
collect_percepts( XY, [Stench, Breeze, Glitter, Bump, no] ):-
	got_bump( XY, Bump ),
	got_stench(XY, Stench),
	got_glitter(XY,Glitter),
	got_breeze(XY,Breeze).

got_bump( [X,Y], yes ):-
	wumpus_world_extent(Extent), % You're not allowed to call this btw.
	( X < 1; X> Extent; Y < 1; Y > Extent ),
	!.

got_bump( _, no ).

got_stench( [X,Y], yes ):-
	wumpus_location( WX, WY ),
	(
		( WX is X, ( WY is Y+1 ; WY is Y-1) );
		( WY is Y, ( WX is X+1 ; WX is X-1) )
	),
	!.

got_stench( _, no ).


got_breeze([X,Y], yes ):-
	pit( PX, PY ),
	(
		( PX is X, ( PY is Y+1 ; PY is Y-1) );
		( PY is Y, ( PX is X+1 ; PX is X-1) )
	),
	!.

got_breeze(_,no).

got_glitter([X,Y],yes):-
	gold(X,Y).
got_glitter(_,no).

