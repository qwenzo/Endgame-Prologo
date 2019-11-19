%===============query===============%

:- [main].

% this holds the intial depth limit of the algorthim.
depth_limit(1).

% this is true, if plan returns a S.
snapped(S):-
    find_solution(S, 0), !.

% this is true, if we can find a solution for the problem at a minume depth limit.
find_solution(S, 0):-
    find_solution(S, 1).

find_solution(S, Depth_Limit):-
    call_with_depth_limit(goal(S), Depth_Limit, Depth),
    Depth \= depth_limit_exceeded.

find_solution(S, Depth_Limit):-
    call_with_depth_limit(goal(S), Depth_Limit, Depth),
    Depth = depth_limit_exceeded,
    New_Limit is Depth_Limit + 1,
    find_solution(S, New_Limit).

    
