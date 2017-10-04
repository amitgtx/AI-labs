:- dynamic
	succ/3,
	heuristic/3,
	seen/1,
	astar_goal/1.


:- use_module(library(heaps)).

/* search_wrapper( +Source, +Goal, -Cost, -Path ):-
	Easy wrapper for the search/5
	`Path` is the solution path to reach `Goal` from `Source`.
	`Cost` is the cost of `Path`

Example usage: search( dfs, arad, bucharest, Cost, Path ).
*/

/* search( +Goal, +Fringe, -Solution )
	Intended usage Example: search( bucharest, [ state(0, [arad]) ], Sol ).
	`Solution` is a `state(Cost, Path)`, where
		`Path` is the solution path to reach `Goal` from `Source` .
		`Cost` is the cost of `Path`
*/

/*
successor_state( state( CurrentNode, _PrevNode, CurrentCost ), state( SuccessorNode, CurrentNode, SuccessorCost ) ):-
`SuccessorNode` is a `Successor` of `CurrentNode` ( that is yet unseen ).
*/

/* fringe_init( -InitialFringe):-
	InitialFringe is an initialized empty fringe for use with Algorithm */



/* fringe_push( +OriginalFringe, +SuccessorList, -ResultingFringe ):-
	`ResultingFringe` is the result of adding each element in `SuccessorList` to `OriginalFringe`
*/

/* fringe_pop( +OriginalFringe, -PoppedState, -ResultingFringe ):-
	`PoppedState` is the next element of adding each element in `SuccessorList` to `OriginalFringe`
*/


/* construct_path_from_states( +Goal,, -Solution ):-
	`Solution` is a list of states in to pass through to arrive at `Goal` from the specified source */



/* mark_as_seen( +SeenState ):-
	marks SeenState as seen */

/* was_seen( +State ):-
	true if `State` was marked as seen */

/*	reset_seen/0:-
		Unmarks all states which were marked as seen.*/
