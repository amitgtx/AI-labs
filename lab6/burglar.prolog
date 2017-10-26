% Bayesian network 'sensor'
:- [bayesian_network].

% Define the Bayes Net using parent/2
%	Your code here

% Define the conditional probability table using p/2 and p/3 as described in bayesian_network.prolog
/*
	p(Burglary) = 0.001
	p(Lightning) = 0.02
	p(Sensor | Burglary A Lightning) = 0.9
	p(Sensor | Burglary A ~Lightning) = 0.9
	p(Sensor | ~Burglary A Lightning) = 0.1
	p(Sensor | ~Burglary A ~Lightning) = 0.001
	p(Alarm | Sensor) = 0.95
	p{Alarm | ~Sensor) = 0.001
	p(Call | Sensor) = 0.9
	p(Call | ~Sensor) = 0.0
*/
%	Your code here
