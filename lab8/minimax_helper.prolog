% Convenience functions
other_player(x,o).
other_player(o,x).

% Finds an occurence of `Find` in `In`, replaces it with `Replace`
% Use this to make successors.
% list_replace( Find, Replace, In, Result).
list_replace( Find, Replace, [Find|Tail], [Replace|Tail]).
list_replace( Find, Replace, [Head|Tail], [Head|ResultTail]):-
	list_replace( Find, Replace, Tail, ResultTail).

% get_action( FromState, ToState, Action ):-
% 	`FromState` becomes `ToState` when an action `Action` is taken
% 	`Action` is of the form [player, position]
% where player is either 'o' or 'x'
% and positions are:
%	|1|2|3|
%	|4|5|6|
%	|7|8|9|
% e.g.: 
%	get_action( [-,-,-, -,-,- ,-,-,-], [-,-,- ,-,o,-, -,-,-], [o,5] ).

get_action( FromState, ToState, Action ):- 
	get_action_rec( FromState, ToState, 1, Action).

% Functions for get_action to work
get_action_rec( [FH|FT], [TH|TT], Pos, Action ):-
	FH = TH,
	NewPos is Pos+1,
	get_action_rec( FT, TT, NewPos, Action).

get_action_rec( [FH|_], [TH|_], Pos, Action ):-
	FH \= TH,
	Action = [TH, Pos].



% find_max_sv(SVList, MaxSV):-
%	`MaxSV` is the structure sv( State, Value ) such that
%		`MaxSV` is the member of SVList that has maximum `Value`
find_max_sv(SVList, MaxSV):-
	member(MaxSV,SVList),
	sv(_, MaxVal) = MaxSV,
	not(	(
			member( sv(_, OtherVal), SVList ),
			OtherVal > MaxVal 	
		)
	).
% find_min_sv(SVList, MinSV):-
%	`MinSV` is the structure sv( State, Value ) such that
%		`MinSV` is the member of SVList that has minimum `Value`
find_min_sv(SVList, MinSV):-
	member(MinSV,SVList),
	sv(_, MinVal) = MinSV,
	not(	(
			member( sv(_, OtherVal), SVList ),
			OtherVal < MinVal 	
		)
	).


% winning_config( WinningStates, Player ):-
% `WinningStates` is a list of all states in which the player `Player` has won
winning_config( [
	[P,P,P,	_,_,_,	_,_,_],
	[_,_,_,	P,P,P,	_,_,_],	
	[_,_,_,	_,_,_,	P,P,P],
	[P,_,_,	P,_,_,	P,_,_],
	[_,P,_,	_,P,_,	_,P,_],
	[_,_,P,	_,_,P,	_,_,P],
	[P,_,_,	_,P,_,	_,_,P],
	[_,_,P,	_,P,_,	P,_,_]
],
P).

