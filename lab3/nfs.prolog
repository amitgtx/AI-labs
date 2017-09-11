% Simulating NFA to check whether a binary string contains 2 consecutive 0's or 2 consecutive 1's

final(q3).

trans(q0,0,q0).
trans(q0,1,q0).

trans(q0,0,q1).
trans(q0,1,q2).

trans(q1,0,q3).
trans(q2,1,q3).

trans(q3,0,q3).
trans(q3,1,q3).

%Accept empty string
accepts(State,[]):-final(State).

%Accept by reading first symbol
accepts(State,[X | Rest]):-
	trans(State,X,State1),
	accepts(State1,Rest).
