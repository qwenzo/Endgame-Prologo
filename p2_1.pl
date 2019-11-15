ironman(loc(1, 2), [loc(1,1), loc(2, 1), loc(2, 2), loc(3, 3)],  s0). /* ironman, Y, X, situation zero, number of stones remaining */
thanos(loc(3, 4)).
/*
stone(loc(1, 1), s0).
stone(loc(2, 1), s0).
stone(loc(2, 2), s0).
stone(loc(3, 3), s0).
*/
grid_size(5, 5).


move(down, -1, 0).
move(up, 1, 0).
move(left, 0, 1).
move(right, 0, -1).

snapped(S):-
	thanos(loc(Y, X)), 
	ironman(loc(Y, X), [], S).

call_with_depth(DepthLimit, ExceddedDepth, S):-
	call_with_depth_limit(snapped(S), DepthLimit, ExceddedDepth).

ironman(loc(Y, X), StonesNew, result(A, S)):-
	move(A, SY, SX),
	OY is Y + SY, OX is X+SX,
	allowed(OY, OX),
	check_stones(loc(Y, X), Stones, StonesNew),
	ironman(loc(OY, OX), Stones, S), !.
	
/*
allowed(Y, X),
	move(A, SY, SX),
	OY is Y + SY, OX is X+SX,
	allowed(OY, OX),
	check_stones(loc(OY, OX), Stones, StonesNew),
	ironman(loc(OY, OX), Stones, S), !.
*/
/*

ironman(loc(Y, X), StonesNew, result(A, S)):-
	(A = collect,
	check_stones(loc(Y, X), Stones, StonesNew),
	ironman(loc(Y, X), Stones, S));
	allowed(Y, X),
	move(A, SY, SX),
	OY is Y + SY, OX is X+SX,
	allowed(OY, OX),
	ironman(loc(OY, OX), Stones, S), !.
*/
member(X, [X|_]).
member(X, [_|T]):- member(X, T).

delete_each(X, L, L):-
	\+member(X, L).
delete_each(X, [X|L], L).
delete_each(X, [Y|Ys], [Y|Zs]) :-
	delete_each(X, Ys, Zs).	

check_stones(loc(Y, X), StonesList, ReturnedStones):-
	allowed(Y, X),
	delete_each(loc(Y, X), StonesList, ReturnedStones).
	
allowed(Y, X):-
    grid_size(N, M),
	X >= 0,
	Y >= 0,
	N2 is N-1,
	M2 is M-1,
	X =< N2, Y =< M2.