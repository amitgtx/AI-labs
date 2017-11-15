% include the helper functions
:- [minimax_helper].

% successor( State, Player, SuccessorState ):-
%	 `SuccessorState` is a state reachable from `State` if `Player` makes a move
successor( State, Player, SuccessorState ):-
	list_replace( -, Player, State, SuccessorState ).



% terminal_state( State, Player, Value ):-
%	`State` is a terminal state with 
%	`Value` is {1 if 
% In the case of a terminal state, `SuccState` = `State` 
%		and SuccVal = {1 if agent wins, 0 if draw, -1 if adversary wins }
terminal_state( State, Player, Value ):-
	other_player(Player, OtherPlayer),

	winning_config(WinningStates, Player),
	winning_config(LosingStates, OtherPlayer),
	(
		( member( State, WinningStates), Value is 1 );  % Win
		( member( State, LosingStates ), Value is -1 ); % Loss
		( 						% Draw
			not( member( State, WinningStates) ),
			not( member( State, LosingStates ) ),
			not( member( -, State ) ),
			Value is 0
		)
	).


% minimax_decision( State, Player, Action, Value ):-
%	( `Player` is the player the agent plays as ) 	
%	`Action` is the 'best' action for `Player` to take from a state `State`
% 	( The action is 'best' according to the minimax principle
%		i.e. it assumes an optimal opponent
%	)
%	`Value` is the value of the state reached on taking action.

minimax_decision( State, Player, Action, Value ):-
	% Action is the action to be taken from State

	% The slide says find a that maximizes min-value( result(a,state) ).
	% This does the same.
	max_value( State, Player, sv(Succ, Value) ),  
	writeln(['Can achieve ', Value, ' from ', Succ ]),
	get_action( State, Succ, Action).



% min_value( State, Player, MinSuccessorSV ).
%	 `MinSuccessorSV` is a structure sv( SuccState, SuccVal ) such that
%		`SuccState` is a state reachable from `State` if the adversary plays
%		`SuccState` has the minimum utility = `SuccVal` 
%			amongst all successors of `State`
%	 Note:
%	 	In the case of a terminal state, `SuccState` = `State` 
%		and SuccVal = {1 if agent wins, 0 if draw, -1 if adversary wins }

% Terminal case
min_value(State, Player, sv(State,V)):-
	terminal_state( State, Player, V).


% Recursive case
min_value(State, Player, MinSuccessorSV):-% sv(State, MinSuccVal)):-
	not( terminal_state(State,Player,_) ), % Just to make sure
	% Find (Successor,Value) with the lowest value
	other_player(Player, OtherPlayer),
	findall(
		sv( Succ, SVal) , 
		(
			successor(State, OtherPlayer, Succ),
			max_value(Succ, Player, sv(_, SVal) )
		), 
		SuccesorSVs
	),
	
	find_min_sv(SuccesorSVs, MinSuccessorSV).


% max_value( State, Player, MaxSuccessorSV ).
%	 `MaxSuccessorSV` is a structure sv( SuccState, SuccVal ) such that
%		`SuccState` is a state reachable from `State` if the agent plays
%		`SuccState` has the maximum utility = `SuccVal` 
%			amongst all successors of `State`
%	 Note:
%	 	In the case of a terminal state, `SuccState` = `State` 
%		and SuccVal = {1 if agent wins, 0 if draw, -1 if adversary wins }

% Terminal case
max_value(State, Player, sv(State,V)):-	
	terminal_state( State, Player, V).

% Recursive case
max_value(State, Player, MaxSuccessorSV):-%, sv(State, MaxSuccVal)):-
	not(terminal_state(State,Player,_)),
	% Find (Successor,Value) with the highest value
	findall(
		sv( Succ, SVal) , 
		(
			successor(State, Player, Succ),
			min_value(Succ, Player, sv(_, SVal) )
		),
		SuccesorSVs
	),

	find_max_sv(SuccesorSVs, MaxSuccessorSV).	% This state gets the value of the max succ



% Testcases:
% minimax_decision( [o,-,x, -,-,-, -,-,-], o, Action, Value).
%	Action = [o,4],
%	Value = 1.
%
% minimax_decision( [-,x,- ,-,o,-, -,-,-], o, S, V).
% 	Action = [o, 1],
%	Value = 1 
%
% minimax_decision( [x,-,- ,-,-,-, -,-,-], o, Action, Value).
%	Action = [o, 1],
%	Value = 1 

