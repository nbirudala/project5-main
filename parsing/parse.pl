%%%%%%%%%%%%%%%%%
% Your code here:
%%%%%%%%%%%%%%%%%

% Main predicate: true if X matches the Lines grammar
parse(X) :-
    lines(X, []).

% Lines → Line ; Lines | Line
lines(X, Rest) :-
    line(X, Rest1),
    (Rest1 = [';' | Rest2] -> lines(Rest2, Rest) ; Rest1 = Rest).

% Line → Num , Line | Num
line(X, Rest) :-
    num(X, Rest1),
    (Rest1 = [',' | Rest2] -> line(Rest2, Rest) ; Rest1 = Rest).

% Num → Digit | Digit Num
num(X, Rest) :-
    digit(X, Rest1),
    (Rest1 = Rest ; num(Rest1, Rest)).

% Digit → 0 | 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 | 9
digit([H | T], T) :-
    member(H, ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9']).

%%%%%%%%%%%%%%%%%
% Example usage:
%%%%%%%%%%%%%%%%%

% Example execution:
% ?- parse(['3', '2', ',', '0', ';', '1', ',', '5', '6', '7', ';', '2']).
% true.
% ?- parse(['3', '2', ',', '0', ';', '1', ',', '5', '6', '7', ';', '2', ',']).
% false.
% ?- parse(['3', '2', ',', ';', '0']).
% false.
