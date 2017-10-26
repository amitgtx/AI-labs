% Reasoning in Bayesian networks
% Bayesian network is represented by relations:
% 	parent( ParentNode, Node)
% 	p( Node, ParentStates, Prob):
% Prob is conditional probability of Node given
% values of parent variables ParentStates, for example: |
% 	p( alarm, [ burglary, not earthquake], 0.99)
% 	p( Node, Prob):
% 		probability of node without parents
% 	prob( Event, Condition, P):
% 		probability of Event, given Cond, is P;
% Event is a variable, its negation, or a list
% of simple events representing their conjunction

% Prefix operator 'not' for easy expression
:- op( 900, fy, not).			


% Probability of conjunction
% We do not have joint probability entries for multiple variables: p(a,b,c)
% We must convert them to a form like:
%	p(a,b,c) = p(a,b|c) * p(c) = p(a|b,c) * p(b|c) * p(c)
% We can do this recursively. A single step is:
% 	p( a,b | c ) = p( a | b,c ) * p(b|c) 

prob( [X | Xs], Cond, P) :- !,
	prob( X, Cond, Px),		% p( b | c )
	prob( Xs, [X | Cond], PRest),	% p( a | b,c )
	P is Px * PRest.		

% Empty conjunction. Also serves as base case above.
prob([],_, 1) :-			% Empty conjunction
	 !.

% p(A | A,B ) = 1
prob( X, Cond, 1) :-			% Cond implies X
	member( X, Cond),
	!.

% p(not A | A,B ) = 0
prob( X, Cond, 0) :-			% Cond implies X is false
	member( not X, Cond),
	 !.

% p( not A | B ) = 1 - p(A | B)
prob( not X, Cond, P) :- 		% Probability of negation
	!,
	prob( X, Cond, P0),
	P is 1 - P0.



% Use Bayes rule if condition involves a descendant of X
% Let Y be the descendent of X.
% p(X|Y,Z) * P(Y|Z) = P( Y | X,Z ) * P(X|Z)
% 	Since  P(X,Y|Z) can be expressed in either of the two ways

prob( X, CondO, P) :-
	delete( Y, CondO, Cond),
	predecessor( X, Y), !,	% Y is a descendant of X
	prob( X, Cond, Px),
	prob( Y, [X | Cond], PyGivenX),
	prob( Y, Cond, Py),
	P is Px * PyGivenX / Py. % Assuming Py > 0
	% Cases when condition does not involve a descendant


% X a root cause - its probability given
% ie, X has no parents

prob( X, Cond, P) :-
	p( X, P), !. 


% In the case where we don't have the certain variables in the
% conditioning set, We must marginalize (sum) over those variable
% If Y is such a variable
% 	P(X) = P(X|Y) * P(Y) + P(X|not Y) * P(Y)

prob( X, Cond, P) :- !,
	findall( (CONDi,Pi), p(X,CONDi,Pi), CPlist),					% Find all entries in the CPT -> All combinations of parental variables	
	sum_probs( CPlist, Cond, P).									% Recursively sum over them




% sum_probs( CondsProbs, Cond, WeightedSum)
% CondsProbs is a list of conditions and corresponding probabilities,
% WeightedSum is weighted sum of probabilities

sum_probs( [], _, 0).



% If C is the conditioning set, C1 is the set to sum over.
% P( X | C ) = Sum_over_C1 P( X | C1,C ) * P(C1 | C)

sum_probs( [ (COND1,P1) | CondsProbs], COND, P):-
	prob( COND1, COND, PC1),
	sum_probs( CondsProbs, COND, PRest),
	P is P1 * PC1 + PRest.



% Common function definitions
predecessor( X, not Y) :- !,
	predecessor( X, Y).

predecessor( X, Y) :-
	parent( X, Y).

predecessor( X, Z) :-
	parent( X, Y),
	predecessor(Y, Z).

member(X, [X | _]).
member( X, [_ | L]) :-
	member( X, L).

delete( X, [X | L], L).
delete( X, [Y | L], [Y | L2]) :-
	delete( X, L, L2).

