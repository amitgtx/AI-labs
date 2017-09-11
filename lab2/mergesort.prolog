%Define an ordering among the elements
gt(X,Y):- X > Y.


%Empty list is a sorted list
mergesort([],[]).
mergesort([X],[X]).
mergesort(L, R) :- halfhalf(L, A, B), mergesort(A, Asort), mergesort(B, Bsort), merge(Asort, Bsort, R).



splitlist(L, [], L, 0).
splitlist([H|T], [H|A], B, N) :- M is N-1, splitlist(T, A, B, M).

halfhalf(L, A, B) :- length(L, Len), Half is Len//2, splitlist(L, A, B, Half).



merge([ ],X,X).
merge(X,[ ],X).
merge([HA|TA],[HB|TB],[HC|TC]):-HA<HB,HC is HA,merge(TA,[HB|TB],TC).
merge([HA|TA],[HB|TB],[HC|TC]):-HB<HA,HC is HB,merge([HA|TA],TB,TC).
