%avg(A,B,P):- P is (A+(B/A))/2.

% version 1 - with absolute number of calls
root1(X,D,0,R):- R is (D+(X/D))/2.
root1(X,D,N,R):-
    D2 is (D+(X/D))/2,
    N2 is N-1,
    root1(X,D2,N2,R).

% version 2 - with relative number of calls - with defined variance
root2(X,D,R):- Div is (X/D), (abs(Div - D) =< 0.000000001), R is Div.
root2(X,D,R):-
    D2 is (D+(X/D))/2,
    root2(X,D2,R).