myMem(H,[H|T]).
myMem(X,[H|T]):- myMem(X,T).
%member(X,L) means that X is an element of L. (Prolog also has a built-in version of member/2.)

bigger(X,[ ]).
bigger(X,[H|T]):- X>=H,bigger(X,T).
%bigger(X,L) means that X is bigger than every element in L.


myAppend([ ], Y, Y).
myAppend([H | R], Y, [H | New]) :- myAppend(R, Y, New).
%myAppend(X,Y,Z) means that Z is formed by appending X and Y.

swapFirstTwo([X, Y | R], [Y, X | R]).
%swapFirstTwo(List1, List2) that succeeds if List1 and List2 are lists of length at least 2 that are the same except the first two elements of List1 are in reverse %order in List2.

isPrefix([],[]).
isPrefix([],[_|_]).
isPrefix([H|T], [H|Rest]) :- isPrefix(T, Rest).
%isPrefix(Little, Big) that succeeds if Big is a list beginning with all the members of Little, in order.


occursIn(Little, Big) :- isPrefix(Little, Big).
occursIn(Little, [_|T]) :- occursIn(Little, T).
%occursIn(Little, Big) that succeeds if Little is a sublist of Big (this means that the elements of Little appear together, in order, within Big).

myLen([ ],0).
myLen([X],1).
myLen([H|T],M):-myLen([H],X),myLen(T,Y),M is (X+Y).


merge([ ],X,X).
merge(X,[ ],X).
merge([HA|TA],[HB|TB],[HC|TC]):-HA<HB,HC is HA,merge(TA,[HB|TB],TC).
merge([HA|TA],[HB|TB],[HC|TC]):-HB<HA,HC is HB,merge([HA|TA],TB,TC).


myRev([ ],[ ]).
myRev([H|T],X):-myRev(T,Y),append(Y,[H],X).

pal(X):-myRev(X,Y),X=Y.

inBoth(A,B,X):-member(X,A),member(X,B).
%To find an element X that lies in both Lists A and B


setIntersection(A,B,C):- findall(X,inBoth(A,B,X),C).
%C = A intersection B
%Using the inbuilt findall predicate, All the values of a variable that satisfy a rule can be collected into a list.
