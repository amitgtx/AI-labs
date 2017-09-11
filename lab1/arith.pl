sum(1,1).
sum(N,X):- M is N-1,sum(M,Y),X is N+Y.
% X is the sum of 1st N natural nos


fact(0,1).
fact(X,Y):- M is X-1, M>=0, fact(M,Z),Y is (X*Z).
% Y is the factorial of X
% Error : Out of local Stack. Consider what happens when the second rule is used to answer factorial(0,F).

gcd(0,X,X).
gcd(X,0,X).
gcd(X,Y,Z):- X>=Y, X1 is (X-Y), gcd(X1,Y,Z).
gcd(X,Y,Z):- Y>X, Y1 is (Y-X), gcd(X,Y1,Z).
% gcd(X, Y, Z) succeeds if Z is the gcd of X & Y.

max(X, X, X).
max(X, Y, X) :- X > Y.
max(X, Y, Y) :- Y > X.
% max(X, Y, Z) that succeeds if Z is the maximum of X and Y.

sumlist([ ], 0).
sumlist([H | Rest], Total) :- sumlist(Rest, S), Total is S + H.
%sumlist(List, Total) that succeeds if Total is the sum of the numbers in List.
