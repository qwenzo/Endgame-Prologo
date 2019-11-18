%===============query===============%

:- [main].

% this holds the intial depth limit of the algorthim.
depth_limit(16).

% this is true, if plan returns a S.
snapped(S):-
    plan(S).

% this is true, if we can find a solution for the problem at a minume depth limit.
plan(S):-
    depth_limit(Depth_Limit),
    call_with_depth_limit(goal(S), Depth_Limit, Depth),
    Depth \= depth_limit_exceeded.
