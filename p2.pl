at(ironman, 1, 2, s0).
at(thanos, 3, 4).
at(stone, 1, 1, s0).
at(stone, 2, 1, s0).
at(stone, 2, 2, s0).
at(stone, 3, 3, s0).
grid_size(5, 5).
num_stones(4, s0).

	

at(ironman, Y, X, result(A, S)):-
	A = up,
	at(ironman, IY, IX, S),
	Y is IY-1,
	IX = X,
	allowed(Y, X).

at(ironman, Y, X, result(A, S)):-
	A = down,
	at(ironman, IY, IX, S),
	Y is IY+1,
	IX = X,
	allowed(Y, X).
	
at(ironman, Y, X, result(A, S)):-
	A = left,
	at(ironman, IY, IX, S),
	X is IX-1,
	IY = Y,
	allowed(Y, X).
	
at(ironman, Y, X, result(A, S)):-
	A = right,
	at(ironman, IY, IX, S),
	X is IX+1,
	IY = Y,
	allowed(Y, X).
	
num_stones(X, result(A, S)):-
	A \= collect,
	num_stones(NUMS, S),
	X is NUMS.

num_stones(X, result(A, S)):-
	A = collect,
	at(ironman, IY, IX, S),
	at(stone, IY, IX, S),
	num_stones(NUMS, S),
	X is NUMS-1.

at(stone, Y, X, result(A, S)):-
	num_stones(T, result(A, S)),
	Y is -1,
	X is -1.
/*num_stones(X, result(collect, result(down, s0)))*/
/*
at(stone, Y, X, result(A, S)):-
	A = collect,
	at(ironman, IY, IX, S),
	at(stone, SY, SX, S),
	IY = SY,
	SX = SX,
	Y is -1,
	X is -1.
*/

snapped(S).
	


allowed(Y, X):-
    grid_size(N, M), X >= 0, Y >= 0, X =< N, Y =< M.
