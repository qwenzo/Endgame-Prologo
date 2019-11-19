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


% this is true, if ironman has all the stones and in he same cell as thanos.	
ironman(loc(Y, X), StonesNew, result(A, S)):-
	A = collect,
	stone(loc(Y, X)),
	member(loc(Y,X), StonesNew),
	check_stones(loc(Y, X), StonesNew, Stones),
	ironman(loc(Y, X), Stones, S).
	
ironman(loc(Y, X), StonesNew, result(A, S)):-
	move(A, SY, SX),
	OY is Y + SY, OX is X+SX,
	allowed(OY, OX),
	ironman(loc(OY, OX), StonesNew, S).

check_stones(loc(Y, X), StonesList, ReturnedStones):-
	delete_each(loc(Y, X), StonesList, ReturnedStones).
	
member(X, [X|_]).
member(X, [_|T]):- member(X, T).

delete_each(X, L, L):-
	\+member(X, L).
delete_each(X, [X|L], L).
delete_each(X, [Y|Ys], [Y|Zs]) :-
	delete_each(X, Ys, Zs).	
	
allowed(Y, X):-
    grid_size(N, M),
	X >= 0,
	Y >= 0,
	N2 is N-1,
	M2 is M-1,
	X =< M2, Y =< N2.
