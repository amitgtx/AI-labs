% Learning of simple if-then rules

:- op(300, xfx, <==).

%learn(Class) : collect learning examples into a list, construct and output a description for Class, and assert the corresponding rule about Class

learn(Class):-
	findall(example(ClassX, Obj), example(ClassX, Obj), Examples),		%Collect Examples
	learn(Examples, Class, Description),								%Induce Rule
	nl, write(Class), write('<=='), nl,									%Output Rule
	writelist(Description),
	assert(Class <== Description).										%Assert Rule




%learn(Examples, Class, Desciption) : Description covers exactly the examples of class Class in list Examples
%Description is similar to RULELIST in the covering algorithm
%Conj is similar to RULE in the covering algorithm

learn(Examples, Class, []):-
	not(member(example(Class, _), Examples)).							%No Example to cover

learn(Examples, Class, [Conj | Conjs]):-
	learn_conj(Examples, Class, Conj),
	remove(Examples, Conj, RestExamples),								%Remove examples that match Conj
	learn(RestExamples, Class, Conjs).									%Cover remaining examples




%learn_conj(Examples, Class, Conj) : Conj is a list of attribute values satisfied by some examples of class Class and no other class
%learn_conj(Examples, Class, Conj) is similar to InduceOneRule(Examples) in the covering algorithm

learn_conj(Examples, Class, []):-
	not((member(example(ClassX, _), Examples),							%There is no example
	ClassX \== Class)), !.												%of different class


%Cond is of the form Att = Val

learn_conj(Examples, Class, [Cond | Conds]):-
	choose_cond(Examples, Class, Cond),									%Choose attribute value
	filter(Examples, [Cond], Examples1),
	learn_conj(Examples1, Class, Conds).




%choose_cond(Examples, Class, AttVal):- Returns the best AttVal which can be used for describing Class
%AttVal is of the form Att = Val

choose_cond(Examples, Class, AttVal):-
	findall(AV/Score, score(Examples, Class, AV, Score), AVs),
	best(AVs, AttVal).													%Best score attribute value



%Given a list of AttVal/Score, best(AVs, AttVal) returns an AttVal which has the highest score

best([AttVal/_], AttVal).

best([AV0/S0, AV1/S1 | AVSlist], AttVal):-
	S1 > S0, !,															%AV1 better than AV0
	best([AV1/S1 | AVSlist], AttVal)
	;
	best([AV0/S0 | AVSlist], AttVal).





%filter(Examples, Condition, Examples1) : Examples1 contains elements from Examples that satisfy Condition

filter(Examples, Cond, Examples1):-
	findall(example(Class, Obj),
		(member(example(Class, Obj), Examples), satisfy(Obj, Cond)),
		Examples1).





%remove(Examples, Conj, Examples1) : removing from Examples those examples that are covered by Conj gives Examples1
remove([], _, []).

remove([example(Class, Obj) | Es], Conj, Es1):-
	satisfy(Obj, Conj), !,												%First Example matches Conj
	remove(Es, Conj, Es1).												%Remove it

remove([E | Es], Conj, [E | Es1]):-										%Retain first example
	remove(Es, Conj, Es1).


%satisfy(Object, Conj) : Returns true if all Conds in Conj are satisfied by the Object

satisfy(Object, Conj):-
	not((member(Att = Val, Conj),
	member(Att = ValX, Object),
	ValX \== Val)).


%Assign a heuristic score (Score = No. of positive examples covered by AttVal - No. of negative examples covered by AttVal ) to AttVal based on Examples and Class

score(Examples, Class, AttVal, Score):-
	candidate(Examples, Class, AttVal),									%A suitable attribute value
	filter(Examples, [AttVal], Examples1),								%Examples1 satisfy condition Att = Val
	length(Examples1, N1),												%Number of examples which satisfy AttVal
	count_pos(Examples1, Class, NPos1),									%Number of positive examples
	NPos1 > 0,															%At least one positive example matches AttVal
	Score is 2 * NPos1 - N1.											%Assign a specific score
%	Score is NPos1 / N1.												%Assign a specific score




%Checking the validity of an AttVal

candidate(Examples, Class, Att = Val):-
	attribute(Att, Values),												%An Attribute
	member(Val, Values),												%A value
	suitable(Att = Val, Examples, Class).




%An AttVal is suitable if there is an example which doesn't belong to Class and also doesn't satisfy AttVal

suitable(AttVal, Examples, Class):-										%At least one negative example
	member(example(ClassX, ObjX), Examples),							%must not match AttVal
	ClassX \== Class,													%Negative Value
	not(satisfy(ObjX, [AttVal])), !.									%that does not match




%count_pos(Examples, Class, N) : N is the number of positive examples of Class

count_pos([], _, 0).

count_pos([example(ClassX, _) | Examples], Class, N):-
	count_pos(Examples, Class, N1),
	(ClassX = Class, !, N is N1 + 1; N = N1).



%writelist(List) : Helper method to display the elements of List

writelist([]).

writelist([X | L]):-
	tab(2), write(X), nl,
	writelist(L).


%The rules asserted by learn(Class) can be used to classify new objects.
%Classify an object Object represented as [Att1 = Val1, Att2 = Val2, ...] as Class

classify(Object, Class):-
	Class <== Description,												%Learned rule about Class
	member(Conj, Description),											%A conjunctive condition
	satisfy(Object, Conj).												%Object satisfies Conj


%classify([size = large, shape = compact, holes = 1], X). == nut