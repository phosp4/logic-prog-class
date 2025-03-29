% 0, 1, 1, 2, 3, 5, 8, 13

%%% zakladny pristup - rekurzia

% fib(31, X). je maximum pred stack limit

fib1(0,0).
fib1(1,1).
fib1(N,V):-
    N1 is N-1,
    N2 is N-2,
    fib1(N1,V1),
    fib1(N2,V2),
    V is V1+V2.

%%% fib efektivnejsie - "ruckovanie"

% fib2(N, S1, S2, R):-
%     N>=0,
%     N2 is N-1,
%     S3 is S1+S2,
%     fib2(N2, S2, S3, R),
%     R is S3.

fib2(0,H,_,H). % H tu bude faktorial N-teho prvku, tam to zastane
fib2(N, S1, S2, R):-
    N2 is N-1,
    S3 is S1+S2,
    fib2(N2, S2, S3, R).

fib(N,R):-fib2(N,0,1,R).