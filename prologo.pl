ironman(loc(1, 2), [],  s0).
thanos(loc(3, 4)).
stone(loc(1, 1)).
stone(loc(2, 1)).
stone(loc(2, 2)).
stone(loc(3, 3)).
grid_size(5, 5).

collect(collect, 0,0).
move(down, -1, 0).
move(up, 1, 0).
move(left, 0, 1).
move(right, 0, -1).

snapped(result(A, S)):-
	A = snap,
	thanos(loc(Y, X)),
	ironman(loc(Y, X), [loc(1,1), loc(2, 1), loc(2, 2), loc(3, 3)], S).

call_with_depth(DepthLimit, ExceddedDepth, S):-
	call_with_depth_limit(snapped(S), DepthLimit, ExceddedDepth).
	
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
	
member(X, [X|_]).
member(X, [_|T]):- member(X, T).

delete_each(X, L, L):-
	\+member(X, L).
delete_each(X, [X|L], L).
delete_each(X, [Y|Ys], [Y|Zs]) :-
	member(X, Ys),delete_each(X, Ys, Zs).	

check_stones(loc(Y, X), StonesList, ReturnedStones):-
	delete_each(loc(Y, X), StonesList, ReturnedStones), !.
	
allowed(Y, X):-
    grid_size(N, M),
	X >= 0,
	Y >= 0,
	N2 is N-1,
	M2 is M-1,
	X =< M2, Y =< N2.
