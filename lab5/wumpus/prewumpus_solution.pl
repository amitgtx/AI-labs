% To run the program. Just call
% ?- drive.

% The driver program will call these functions.
% Your job is to find the gold.
% For a more thorough description of the wumpus world, Read the pdf.
% To start, The driver will call init, record_percept( <starting_location>, Percepts ).
%	( starting_location is guaranteed to be safe.
%	In the actual wumpus world, The starting location is (1,1).
%	Today, I take the freedom to start wherever  )
% Then it will call pick_square( Square ) followed by
%	record_percept( Square, Percepts ) with the corresponding percepts.

:-[prewumpus_driver].

% To get rid of the warning
% "Warning: The predicates below are not defined. If these are defined
%  Warning: at runtime using assert/1, use :- dynamic Name/Arity. "
:- dynamic
	no_pit/1,
	no_wumpus/1,
	visited/1,
	out_of_bunds/1.

init:-
	retractall( no_pit(_) ),
	retractall( no_wumpus(_) ),
	retractall( visited(_) ),
	retractall(out_of_bounds(_)).

% Use your own knowledge base to pick which square to explore next.
% `Square` must be of the form [X,Y].
%	The X and Y coordinates of the square you want to check.
pick_square( Square  ):-
	% Your code here
	no_pit( Square ),
	no_wumpus( Square ),
	not( visited(Square) ),
	not( out_of_bounds(Square)).
%	,writeln( ['Picked Square', Square] ).


% Use this to add whatever info you gain about the world to your KB.
%	`X,Y` will be the coordinates of the square you last picked.
%	Each Percept variable can take the values `yes` or `no`
%	`Glitter`, and `Scream` have no relevance for today's lab
record_percepts([X,Y], [Stench,Breeze,Glitter,Bump,Scream] ):-
	%writeln( ['record_percept', X,Y] ),
	assert( visited( [X,Y] ) ),
	findall( Neighbour, neighbour( [X,Y], Neighbour), Neighbours ),
	% Your code here
	(	Breeze = no,
		findall( _, ( member( N, Neighbours ), assert( no_pit( N ) ) ), _)
		 ; true
	),
	(	Stench = no,
		findall( _, ( member( N, Neighbours ), assert( no_wumpus( N ) ) ), _)
		 ; true
	),
	(	Bump = yes,
		assert( out_of_bounds( [X,Y] ) )
		; true
	)
	.


neighbour( [X,Y], [X1,Y1] ):-
	(X1 is X+1, Y1 is Y);
	(X1 is X-1, Y1 is Y);
	(X1 is X, Y1 is Y+1);
	(X1 is X, Y1 is Y-1).













