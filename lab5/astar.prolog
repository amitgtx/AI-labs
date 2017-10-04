:- dynamic
	succ/3,
	heuristic/3,
	seen/1,
	search_goal/1.


search_wrapper( Src, Goal, Cost, Path ):-
	reset_seen,
	assert( search_goal( Goal )),
	fringe_init( EmptyFringe ),
	fringe_push( EmptyFringe, [state( Src, -, 0)], Fringe ),
	search( Goal, Fringe, solution( Cost, Path )),
	findall(-, was_seen(_), NList), length(NList, Len), writeln( ['Expanded nodes: ', Len] ),
	retractall( search_goal/1 ),!.

search( Goal, Fringe, solution( Cost, Path )):-
	fringe_pop( Fringe, state( Goal, From, Cost ), _IntermediateFringe),
	mark_as_seen( state( Goal, From, Cost )),
	construct_path_from_states( Goal, Path ).

search( Goal, Fringe, Sol ):-
	fringe_pop( Fringe, PoppedState, IntermediateFringe ),
	(
		( was_seen(PoppedState) )->
		(UpdatedFringe = IntermediateFringe);
		(
			findall( Succ, successor_state( PoppedState, Succ ), SuccList ),
			fringe_push(IntermediateFringe, SuccList, UpdatedFringe ),
			mark_as_seen( PoppedState )
		)
	),
	search( Goal, UpdatedFringe, Sol ).

successor_state( state( CurrNode, _PrevNode, CurrCost ), state( SuccNode, CurrNode, SuccCost ) ):-
	succ( CurrNode, SuccNode, EdgeCost ),
	not( was_seen( state( CurrNode, _, _ ))),
	SuccCost is CurrCost + EdgeCost.

fringe_init( EmptyFringe ):-
	empty_heap( EmptyFringe ).

fringe_push( FinalFringe, [], FinalFringe ):-
	heap_to_list( FinalFringe, L ), writeln(['Fringe : ' , L]).

fringe_push( OrigFringe, SuccList, NewFringe ):-
	SuccList = [ SuccState | SuccTail ],
	SuccState = state( CurrState, _PrevState, Dist ),
	search_goal( Goal ),
	heuristic( CurrState, Goal, Heur ),
	Priority is Heur + Dist,
	add_to_heap( OrigFringe, Priority, SuccState, IntermediateFringe ),
	fringe_push( IntermediateFringe, SuccTail, NewFringe ).

fringe_pop( OrigFringe, PoppedState, NewFringe ):-
	get_from_heap( OrigFringe, _Priority, PoppedState, NewFringe ).

construct_path_from_states( -, [] ).

construct_path_from_states( Goal, [Goal | RestOfSol]  ):-
	was_seen( state( Goal, From, _Cost )),
	construct_path_from_states( From, RestOfSol ).

mark_as_seen( S ):-
	assert( seen( S )).

was_seen( S ):-
	seen( S ).

reset_seen:-
	retractall(seen(_)).
