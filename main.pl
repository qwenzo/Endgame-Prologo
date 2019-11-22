%===============intial sitaution===============%

:- include('kb1').

%===============movements===============%

move(down, -1, 0).
move(up, 1, 0).
move(left, 0, 1).
move(right, 0, -1).

%===============goal test===============%

% this is true, if ironman has all the stones and in he same cell as thanos.
goal(result(A, S)):-
	A = snap,
	thanos(loc(Y, X)),
	locations(L),
	ironman(loc(Y, X), L, S).

%===============succesor state axioms===============%

% this is true, if the new stones list 
% is a result of deleting the current location from the old stones list.	
ironman(loc(Y, X), StonesNew, result(A, S)):-
	A = collect,
	stone(loc(Y, X)),
	member(loc(Y,X), StonesNew),
	delete(loc(Y, X), StonesNew, Stones),
	ironman(loc(Y, X), Stones, S).

% this is true, if the current location is a result of applying a movement on the last sitaution
ironman(loc(Y, X), StonesNew, result(A, S)):-
	move(A, SY, SX),
	OY is Y + SY, OX is X+SX,
	allowed(OY, OX),
	ironman(loc(OY, OX), StonesNew, S).
	
% this is true if the location is part of the grid
allowed(Y, X):-
    grid_size(N, M),
	X >= 0,
	Y >= 0,
	N2 is N-1,
	M2 is M-1,
	X =< M2, Y =< N2.

%===============utils===============%
member(X, [X|_]).
member(X, [_|T]):- member(X, T).

delete(X, [X|L], L).
delete(X, [Y|Ys], [Y|Zs]):-delete(X, Ys, Zs).
