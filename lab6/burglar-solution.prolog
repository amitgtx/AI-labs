% Bayesian network 'sensor'
:- [bayesian_network].

% Define the Bayes Net using parent/2
parent(burglary, sensor).
parent(lightning, sensor).
parent(sensor, alarm).
parent(sensor, call).

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
p( burglary, 0.001).
p( lightning, 0.02).
p( sensor, [ burglary, lightning], 0.9).
p( sensor, [ burglary, not lightning], 0.9).
p( sensor, [ not burglary, lightning], 0.1).
p( sensor, [ not burglary, not lightning], 0.001).
p( alarm, [ sensor], 0.95).
p( alarm, [ not sensor], 0.001).
p( call, [ sensor], 0.9).
p( call, [ not sensor], 0.0).

