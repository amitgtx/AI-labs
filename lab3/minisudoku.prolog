%---------------
%  -  - | -  - |
%  2  3 | -  - |
% --------------
%  -  - | 4  2 |
%  -  - | -  - |
%---------------


% Declare the rows. If you want a different puzzle, Edit this.
row(1, [_,_,_,_] ).
row(2, [2,3,_,_] ).
row(3, [_,_,4,2] ).
row(4, [_,_,_,_] ).


sudoku_goal([R1,R2,R3,R4]):-
	% load the rows from the facts. 
	% You could pass them as an argument, but it would look messy.
	row( 1, R1),
	row( 2, R2),
	row( 3, R3),
	row( 4, R4),


	% You'll need to make columns and boxes from the elements
	R1 = [A1,A2,A3,A4],
	R2 = [B1,B2,B3,B4],
	R3 = [C1,C2,C3,C4],
	R4 = [D1,D2,D3,D4],
	
	% The conditions 'must contain each of [1,2,3,4] exactly once,
	% can be interpreted as: 'is a permutation of [1,2,3,4]
	
	% rows satisfy conditions
	permutation( [A1,A2,A3,A4], [1,2,3,4]),
	permutation( [B1,B2,B3,B4], [1,2,3,4]),
	permutation( [C1,C2,C3,C4], [1,2,3,4]),
	permutation( [D1,D2,D3,D4], [1,2,3,4]),

	% cols satisfy conditions
	permutation( [A1,B1,C1,D1], [1,2,3,4]),
	permutation( [A2,B2,C2,D2], [1,2,3,4]),
	permutation( [A3,B3,C3,D3], [1,2,3,4]),
	permutation( [A4,B4,C4,D4], [1,2,3,4]),

	%boxes satisfy conditions
	permutation( [A1,A2,B1,B2], [1,2,3,4]),
	permutation( [A3,A4,B3,B4], [1,2,3,4]),
	permutation( [C1,C2,D1,D2], [1,2,3,4]),
	permutation( [C3,C4,D3,D4], [1,2,3,4]).

no_of_sol(N):-findall(Y,sudoku_goal(Y),ListY),length(ListY,Z),N is Z.
