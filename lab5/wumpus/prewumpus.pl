:-[prewumpus_driver].
% To run the program. Just call
% ?- drive.

% The driver program will call these functions.
% Your job is to find the gold. 
% For a more thorough description of the wumpus world, Read the pdf.
% To start, The driver will call init, record_percept( <starting_location>, Percepts ).
% 	( starting_location is guaranteed to be safe.
%	In the actual wumpus world, The starting location is (1,1). 
%	Today, I take the freedom to start wherever  )
% Then it will call pick_square( Square ) followed by
%	record_percept( Square, Percepts ) with the corresponding percepts.




% To get rid of the warning
% "Warning: The predicates below are not defined. If these are defined
%  Warning: at runtime using assert/1, use :- dynamic Name/Arity. " 
:- dynamic
	visited/1.

% Retract all the dynamically added facts. You don't want stale facts.
init:-
	retractall( visited(_) ),
	% Your code here.
	false.

% Use your own knowledge base to pick which square to explore next.
% `Square` must be of the form [X,Y]. 
%	The X and Y coordinates of the square you want to check.
pick_square( Square  ):-
	% Your code here
	false.

% Use this to add whatever info you gain about the world to your KB.
%	[X,Y] will be the coordinates of the square you last picked.
%	Each Percept variable can take the values `yes` or `no`
%	`Glitter`, and `Scream` have no relevance for today's lab
record_percepts( [X,Y], [Stench,Breeze,Glitter,Bump,Scream] ):-
	% Your code here
	false.

