% Simulating a DFA to check whether a binary string is a multiple of 3 or not

%State indicating remainder 0 is the final state
final(q0).

%Make the state transitions (StateX---letter-->StateY)
trans(q0,0,q0).
trans(q0,1,q1).

trans(q1,0,q2).
trans(q1,1,q0).

trans(q2,0,q1).
trans(q2,1,q2).

%Accept empty string
accepts(State,[]):-final(State).

%Accept by reading first symbol
accepts(State,[X | Rest]):-
	trans(State,X,State1),
	accepts(State1,Rest).
